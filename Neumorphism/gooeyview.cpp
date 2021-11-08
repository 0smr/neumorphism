#include "gooeyview.h"

#include <qsgsimplematerial.h>
#include <qsggeometry.h>
#include <qsgnode.h>

struct State
{
    int mCount;
    float mSpread;
    QColor mColors;

    QVector2D mSizeList[50];
    QVector2D mPositionList[50];

    float mRotationList[50];
    float mRadiusList[50];

    template <class T>
    constexpr int compare(T left, T right) const {
        return -(left < right) + (left > right);
    }

    int compare(const State *other) const {
        int flag = 0;

        flag = compare(mCount, other->mCount);
        flag = flag != 0 ? flag : compare(mColors.rgba(), other->mColors.rgba());
        flag = flag != 0 ? flag : compare(mSpread, other->mSpread);

        for(int i = 0 ; i < mCount && flag == 0; ++i) {
            flag = compare(mSizeList[i].length(), other->mSizeList[i].length());
            flag = flag != 0 ? flag : compare(mPositionList[i].length(), other->mPositionList[i].length());
            flag = flag != 0 ? flag : compare(mRadiusList[i], other->mRadiusList[i]);
            flag = flag != 0 ? flag : compare(mRotationList[i], other->mRotationList[i]);
        }
        return flag;
    }
};

class Shader : public QSGSimpleMaterialShader<State>
{
    QSG_DECLARE_SIMPLE_COMPARABLE_SHADER(Shader, State);
public:
    Shader() {
        shaderFragment = R"(
            #version 330
            uniform lowp  float qt_Opacity;
            varying highp vec2  qt_TexCoord0;
            uniform highp float spread;
            uniform highp float radiusList[50];
            uniform lowp  float rotationList[50];
            uniform lowp  vec2  sizeList[50];
            uniform lowp  vec2  positionList[50];
            uniform lowp  vec4  color;
            uniform lowp  int   count;

            highp float createRect(vec2 coord, vec2 pos, vec2 size, float rot, float rad, float spread) {
                coord -= pos;
                coord = coord * mat2(cos(rot), -sin(rot), sin(rot), cos(rot));
                coord /= size;

                highp float _dist = length(max(abs(coord) - 0.5 + rad, 0.0)) - rad;
                return smoothstep(0.0, spread, - _dist + 0.001) * qt_Opacity;
            }

            void main () {
                gl_FragColor = vec4(color.rgb, 0.0);
                for(int i = 0 ; i < count ; ++i) {
                    gl_FragColor.a += createRect(qt_TexCoord0,
                                                 positionList[i],
                                                 sizeList[i],
                                                 rotationList[i],
                                                 radiusList[i],
                                                 spread);
                }
                // create contrast
                gl_FragColor.a = smoothstep(0.0, 0.05, gl_FragColor.a - 0.5) * qt_Opacity;
            }
        )";
    }

    const char *vertexShader() const override {
        return R"(
                    attribute highp vec4 aVertex;
                    attribute highp vec2 aTexCoord;
                    uniform highp mat4 qt_Matrix;
                    varying highp vec2 qt_TexCoord0;
                    void main() {
                        gl_Position = qt_Matrix * aVertex;
                        qt_TexCoord0 = aTexCoord;
                    }
                )";
    }

    const char *fragmentShader() const override {
        return  shaderFragment.data();
    }

    QList<QByteArray> attributes() const override {
        return QList<QByteArray>() << "aVertex" << "aTexCoord";
    }

    void updateState(const State *state, const State *) override {
        program()->setUniformValue(mColorId, state->mColors);
        program()->setUniformValue(mCountId, state->mCount);
        program()->setUniformValue(mSpreadId, state->mSpread);
        program()->setUniformValueArray(mSizesId, state->mSizeList, state->mCount);
        program()->setUniformValueArray(mPositionsId, state->mPositionList, state->mCount);
        program()->setUniformValueArray(mRotationsId, state->mRotationList, state->mCount, 1);
        program()->setUniformValueArray(mRadiusesId, state->mRadiusList, state->mCount, 1);
    }

    void resolveUniforms() override {
        mColorId = program()->uniformLocation("color");
        mCountId = program()->uniformLocation("count");
        mSizesId = program()->uniformLocation("sizeList");
        mSpreadId = program()->uniformLocation("spread");
        mRadiusesId = program()->uniformLocation("radiusList");
        mPositionsId = program()->uniformLocation("positionList");
        mRotationsId = program()->uniformLocation("rotationList");
    }

private:
    int mColorId;
    int mCountId;
    int mSizesId;
    int mSpreadId;
    int mPositionsId;
    int mRotationsId;
    int mRadiusesId;

    std::string preShadeCode;
    std::string shaderFragment;
};

class ColorNode : public QSGGeometryNode
{
public:
    ColorNode()
        : m_geometry(QSGGeometry::defaultAttributes_TexturedPoint2D(), 4) {
        setGeometry(&m_geometry);

        QSGSimpleMaterial<State> *material = Shader::createMaterial();
        material->setFlag(QSGMaterial::Blending);
        setMaterial(material);
        setFlag(OwnsMaterial);
    }

    QSGGeometry m_geometry;
};

QSGNode *GooeyView::updatePaintNode(QSGNode *node, QQuickItem::UpdatePaintNodeData *) {
    ColorNode *colorNode = static_cast<ColorNode *>(node);
    if (!node) {
        colorNode = new ColorNode();
    }

    QSGGeometry::updateTexturedRectGeometry(colorNode->geometry(), boundingRect(), QRectF(0, 0, 1, 1));
    State * state = static_cast<QSGSimpleMaterial<State>*>(colorNode->material())->state();

    state->mColors = mColor;
    state->mCount  = mItemList.size();
    state->mSpread = mSpread;
    for(int i{0}; i < mItemList.size(); ++i) {
        const auto ratio  = std::max(width(), height());
        const auto pos    = mItemList[i]->position()/ratio;
        const auto size   = QVector2D(mItemList[i]->size().width(), mItemList[i]->size().height());
        const auto nsize  = size / ratio;
        const auto iRatio = std::max(size.x(), size.y());
        const auto radius = mItemList[i]->property("radius").value<float>();

        state->mSizeList[i]     = nsize + QVector2D(mSpread, mSpread)/2;
        state->mPositionList[i] = QVector2D(pos) + nsize/2;
        state->mRotationList[i] = mItemList[i]->rotation();
        state->mRadiusList [i]  = std::min({std::max(radius, mSpread * iRatio), size.x()/2, size.y()/2})/iRatio;
    }

    colorNode->markDirty(QSGNode::DirtyGeometry | QSGNode::DirtyMaterial);
    return colorNode;
}

const QColor &GooeyView::color() const {
    return mColor;
}

void GooeyView::setColor(const QColor &newColor) {
    if (mColor == newColor)
        return;
    mColor = newColor;
    emit colorChanged();
    update();
}

const QList<QQuickItem *> &GooeyView::itemList() const {
    return mItemList;
}

void GooeyView::setItemList(const QList<QQuickItem *> &newItemList) {
    for(const auto &newItem : newItemList) {
        if(mItemList.indexOf(newItem) == -1) {
            connect(newItem, &QQuickItem::rotationChanged, this, &QQuickItem::update);
            connect(newItem, &QQuickItem::widthChanged,  this, &QQuickItem::update);
            connect(newItem, &QQuickItem::heightChanged, this, &QQuickItem::update);
            connect(newItem, &QQuickItem::xChanged, this, &QQuickItem::update);
            connect(newItem, &QQuickItem::yChanged, this, &QQuickItem::update);
            QObject::connect(newItem, SIGNAL(radiusChanged()), this, SLOT(update()));
        }
    }

    mItemList = newItemList;
    emit itemChanged();
    update();
}

const std::string &GooeyView::fragmentShader() const {
    return mFragmentShader;
}

void GooeyView::setFragmentShader(const std::string &newFragmentShader) {
    if (mFragmentShader == newFragmentShader)
        return;
    mFragmentShader = newFragmentShader;
    emit fragmentShaderChanged();
}

float GooeyView::spread() const {
    return mSpread;
}

void GooeyView::setSpread(float newSpread)
{
    if (qFuzzyCompare(mSpread, newSpread))
        return;
    mSpread = newSpread;
    emit spreadChanged();
    update();
}
