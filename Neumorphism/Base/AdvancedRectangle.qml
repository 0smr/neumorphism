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

    property color                  color: '#aaa'
    property list<GradientColor>    gradient
    property var                    radius: undefined

    ShaderEffect {
        id: effect
        width:  control.width;
        height: control.height;

        readonly property color      _color:    control.color
        readonly property color      _c0:       _hasgrd ? gradient[0].color: "#fff";
        readonly property color      _c1:       _hasgrd ? gradient[1].color: "#fff";
        readonly property vector2d   _s0:       _hasgrd ? gradient[0].stop : Qt.vector2d(0,0);
        readonly property vector2d   _s1:       _hasgrd ? gradient[1].stop : Qt.vector2d(0,0);

        readonly property real      _width:     width  / Math.max(width, height);
        readonly property real      _height:    height / Math.max(width, height);

        readonly property bool      _hasgrd:    gradient.length > 1;
        readonly property vector4d  _vrrad:     {
            let whMin = Math.min(_width,_height)/2;
            if(typeof control.radius == "number"){
                let rad = 0;
                rad = Math.min(control.radius, whMin);
                return Qt.vector4d(rad,rad,rad,rad);
            }
            else if(typeof control.radius == "object" && whMin > 0) {
                /*!
                 * radius points,  0 <= x,y,z,w <= 0.5
                 * - vector4d(x, y, z, w):
                 *  ╭───┬───╮
                 *  │ Y │ Z │
                 *  ├───┼───┤
                 *  │ X │ W │
                 *  ╰───┴───╯
                 *  ┌┐ ╭┐ ┌╮ ┌┐
                 *  ╰┘ └┘ └┘ └╯
                 *   X  Y  Z  W
                 */
                return Qt.vector4d(
                            Math.min(control.radius.x, whMin),
                            Math.min(control.radius.y, whMin),
                            Math.min(control.radius.z, whMin),
                            Math.min(control.radius.w, whMin),
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
         */

        fragmentShader: "
            #version 330
            uniform highp   float   qt_Opacity;
            varying highp   vec2    qt_TexCoord0;

            uniform mediump bool    _hasgrd;

            uniform mediump float   _width;
            uniform mediump float   _height;
            uniform lowp    vec4    _vrrad;
            uniform lowp    vec4    _color;

            uniform lowp    vec4    _c0;
            uniform lowp    vec4    _c1;
            uniform lowp    vec2    _s0;
            uniform lowp    vec2    _s1;

            void main() {
                // ---------------- normalized size and coordinate ----------------
                highp vec2 center           = vec2(_width, _height) / 2.0;
                highp vec2 coord            = vec2(qt_TexCoord0.x * _width, qt_TexCoord0.y * _height);

                lowp vec2 s0 = _s0 * vec2(_width, _height);
                lowp vec2 s1 = _s1 * vec2(_width, _height);

                // ------------------------ color gradient ------------------------
                if(_hasgrd) {
                    lowp float _d               = distance(s0,s1);
                    lowp float angle            = (s0.x - s1.x)/((s1.y - s0.y) == 0.0 ? 0.001 : s1.y - s0.y);
                    lowp float line             = angle * (coord.x - (s0.x+s1.x) / 2 ) + (s0.y + s1.y) / 2 - coord.y;
                    lowp float dist             = line / sqrt(angle * angle + 1.0);
                    lowp float rotflag          = (s0.y > s1.y) ? -1.0 : 1.0;
                    gl_FragColor                = mix(_c1, _c0, smoothstep(0.0, 2 * _d, rotflag * dist + _d));
                } else {
                    gl_FragColor                = _color ;
                }

                // ------------------------- border radius -------------------------
                lowp    float   radius[4]   = float[4](_vrrad.x,_vrrad.y,_vrrad.z,_vrrad.w);
                lowp    int     area        = int(floor((atan(coord.x - center.x, coord.y - center.y) + 3.1415) * 0.636));
                highp   float   _dist       = length(max(abs(center - coord) - center + radius[area], 0.0)) - radius[area];
                gl_FragColor                = gl_FragColor * smoothstep(0.0, 0.001, - _dist + 0.001) * qt_Opacity;
            }"
    }
}
