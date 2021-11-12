import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property color color: "#ffffff";
    property real a: 0.22;
    property real b: 1.75;
    property bool topShade: true;
    property real spread: 1;

    ShaderEffect {
        id: effect

        width:  parent.width;
        height: parent.height;

        readonly property color _color: control.color;
        readonly property real _a: control.a;
        readonly property real _b: control.b;
        readonly property real _dir: control.topShade ? 1 : -1;
        readonly property real _spread: control.spread;
        readonly property real _tmargin: {
            const min = Math.min(_a * Math.atan(-_b/4), _a * Math.atan( _b/4));
            return min + 0.45 - (_spread * 10)/height
        }

        readonly property vector2d ratio:  {
            const max = Math.max(width, height);
            return Qt.vector2d(width/max, height/max)
        }

        fragmentShader: "
            #version 330
            varying highp   vec2  qt_TexCoord0;
            uniform highp   float qt_Opacity;
            uniform highp   float _a;
            uniform highp   float _b;
            uniform highp   float _dir;
            uniform highp   float _spread;
            uniform highp   float _tmargin;
            uniform highp   vec2  ratio;
            uniform mediump vec4  _color;

            void main() {
                highp vec2 coord = (qt_TexCoord0 - vec2(0.5)) * ratio;
                highp float bx = _b * coord.x;
                highp float slop = _a * _b/(1 + bx * bx);
                highp float coordDist = (slop * coord.x + coord.y)/sqrt(slop * slop + 1);

                highp float edges = smoothstep(0, 0.20, - abs(coord.x) + 0.48);
                highp float shade = smoothstep(0, 0.01, - _dir * coordDist) * (_spread + _dir *  10 * coordDist);

                gl_FragColor = _color * edges * shade * qt_Opacity;
            }"
    }
}
