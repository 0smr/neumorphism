/****************************************************************************
** Copyright (C) 2021 smr.
** Contact: http://s-m-r.ir
**
** This file is part of the SMR Neumorphism Toolkit.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**
** Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
****************************************************************************/
import QtQuick 2.15
import Neumorphism 1.0

Item {
    id: control

    property color color: '#aaa'
    property list<GradientColor> gradient
    property var radius: undefined

    ShaderEffect {
        id: effect
        width: control.width;
        height: control.height;

        readonly property bool hasgrd: gradient.length > 1;
        readonly property color color: control.color
        readonly property color c0: hasgrd ? gradient[0].color: "#fff";
        readonly property color c1: hasgrd ? gradient[1].color: "#fff";
        readonly property vector2d s0: hasgrd ? gradient[0].stop : Qt.vector2d(0,0);
        readonly property vector2d s1: hasgrd ? gradient[1].stop : Qt.vector2d(0,0);
        readonly property vector2d ratio: Qt.vector2d(width / Math.max(width, height),
                                                      height/ Math.max(width, height));
        readonly property vector4d radius: {
            let whMin = Math.min(ratio.x, ratio.y)/2;
            if(typeof control.radius == "number"){
                let rad = 0;
                rad = Math.min(Math.max(control.radius, 0.01), whMin);
                return Qt.vector4d(rad, rad, rad, rad);
            }
            else if(typeof control.radius == "object" && whMin > 0) {
                /*!
                 * radius points,  0 <= x,y,z,w <= 0.5
                 * - vector4d(x, y, z, w):
                 *  ╭───┬───╮
                 *  │ X │ Y │
                 *  ├───┼───┤
                 *  │ W │ Z │
                 *  ╰───┴───╯
                 *  ╭┐ ┌╮ ┌┐ ┌┐
                 *  └┘ └┘ └╯ ╰┘
                 *   X  Y  Z  W
                 */
                return Qt.vector4d(
                            Math.min(Math.max(control.radius.x, 0.01), whMin),
                            Math.min(Math.max(control.radius.y, 0.01), whMin),
                            Math.min(Math.max(control.radius.z, 0.01), whMin),
                            Math.min(Math.max(control.radius.w, 0.01), whMin),
                        );
            }
            else {
                return Qt.vector4d(0.0,0.0,0.0,0.0);
            }
        }
        /**
         * TODO: allow variant radiuses tobe more than 0.5.
         * NOTE: to doing this, must bind Y to radius center point.
         *  ╭───┬─┐
         *  │ Y │ │
         *  ├───┼─┤
         *  └───┴─┘
         * NOTE: GLSL work without "mod" function in at this code "lowp int area = int(mod(-atan(", and I don't know why?!
         * there is no overflow here?
         */

        fragmentShader: "
            #version 330
            uniform highp float qt_Opacity;
            varying highp vec2 qt_TexCoord0;
            uniform highp vec2 ratio;
            uniform mediump bool hasgrd;
            uniform highp vec4 radius;
            uniform highp vec4 color;
            uniform highp vec4 c0;
            uniform highp vec4 c1;
            uniform highp vec2 s0;
            uniform highp vec2 s1;

            void main() {
                // ---------------- normalized size and coordinate ----------------
                highp vec2 center = ratio / 2.0;
                highp vec2 coord = ratio * qt_TexCoord0;
                highp vec2 s0 = s0 * ratio;
                highp vec2 s1 = s1 * ratio;

                // ------------------------ color gradient ------------------------
                if(hasgrd) {
                    highp float d = distance(s0,s1);
                    highp float angle = (s0.x - s1.x)/((s1.y - s0.y) == 0.0 ? 0.001 : s1.y - s0.y);
                    highp float line = angle * (coord.x - (s0.x+s1.x) / 2 ) + (s0.y + s1.y) / 2 - coord.y;
                    highp float dist = line / sqrt(angle * angle + 1.0);
                    highp float rotflag = (s0.y > s1.y) ? -1.0 : 1.0;
                    gl_FragColor = mix(c1, c0, smoothstep(0.0, 2 * d, rotflag * dist + d));
                } else {
                    gl_FragColor = color ;
                }

                // ------------------------- border radius -------------------------
                highp float radius[4] = float[4](radius.x, radius.y, radius.z, radius.w);
                highp int area = int(mod(-atan(coord.x - center.x, coord.y - center.y) * 0.636 + 3,4));
                highp float dist = length(max(abs(center - coord) - center + radius[area], 0.0)) - radius[area];
                gl_FragColor = gl_FragColor * smoothstep(0.0, 0.01, - dist + 0.001) * qt_Opacity;
            }"
    }
}
