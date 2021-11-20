import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property real a: 0.22;
    property real b: 1.75;
    property bool topShade: true;
    property real spread: 1;

    ShaderEffect {
        id: effect

        width:  parent.width;
        height: parent.height;

        readonly property color color: control.palette.base;
        readonly property real a: control.a;
        readonly property real b: control.b;
        readonly property real dir: control.topShade ? 1 : -1;
        readonly property real spread: control.spread;

        readonly property vector2d ratio:  {
            const max = Math.max(width, height);
            return Qt.vector2d(width/max, height/max)
        }

        fragmentShader: "
            #version 330
            varying highp vec2  qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float a;
            uniform highp float b;
            uniform highp float dir;
            uniform highp float spread;
            uniform highp vec2  ratio;
            uniform highp vec4  color;

            void main() {
                highp vec2 coord = (qt_TexCoord0 - vec2(0.5)) * ratio;
                highp float bx = b * coord.x;
                highp float slop = a * b/(1 + bx * bx);
                highp float coordDist = (slop * coord.x + coord.y)/sqrt(slop * slop + 1);

                highp float edges = smoothstep(0, 0.20, - abs(coord.x) + 0.48);
                highp float shade = smoothstep(0, 0.01, - dir * coordDist) * (spread + dir *  10 * coordDist);

                gl_FragColor = color * edges * shade * qt_Opacity;
            }"
    }
}
