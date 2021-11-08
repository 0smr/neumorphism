#ifndef GOOEYVIEW_H
#define GOOEYVIEW_H

#include <QQuickItem>

class GooeyView : public QQuickItem
{
    Q_OBJECT
    Q_PROPERTY(QColor color  READ color WRITE setColor NOTIFY colorChanged)
    Q_PROPERTY(double spread READ spread WRITE setSpread NOTIFY spreadChanged)
    Q_PROPERTY(QList<QQuickItem *> itemList READ itemList WRITE setItemList NOTIFY itemChanged)
    Q_PROPERTY(std::string fragmentShader READ fragmentShader WRITE setFragmentShader NOTIFY fragmentShaderChanged)
    QML_ELEMENT

public:
    GooeyView(QQuickItem * parent = nullptr): QQuickItem(parent), mSpread(0.44) { setFlag(ItemHasContents, true); }
    QSGNode *updatePaintNode(QSGNode *node, UpdatePaintNodeData *) override;

    const QColor &color() const;
    const QList<QQuickItem *> &itemList() const;
    const std::string &fragmentShader() const;
    float spread() const;

    void setColor(const QColor &newColor);
    void setItemList(const QList<QQuickItem *> &newItemList);
    void setFragmentShader(const std::string &newFragmentShader);
    void setSpread(float newSpread);


signals:
    void colorChanged();
    void itemChanged();
    void fragmentShaderChanged();
    void spreadChanged();

private:
    float mSpread;
    QColor mColor;
    QList<QQuickItem *> mItemList;
    std::string mFragmentShader;
};

Q_DECLARE_METATYPE(GooeyView *)

#endif // GOOEYVIEW_H
