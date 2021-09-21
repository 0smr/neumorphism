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

Item {
    id: control

    property color                      color: 'white'
    default property list<GradientColor>    gradient
    property real                       radius
    property vector4d                   radius2


    ShaderEffect {
        id: effect
        width:  window.width * 0.8;
        height: width;

        readonly property color      _c0:       _hasgrd ? gradient[0].color: null;
        readonly property color      _c1:       _hasgrd ? gradient[1].color: null;
        readonly property vector2d   _s0:       _hasgrd ? gradient[0].stop : null;
        readonly property vector2d   _s1:       _hasgrd ? gradient[1].stop : null;

        readonly property real      _width:     width  / Math.max(width, height);
        readonly property real      _height:    height / Math.max(width, height);

        readonly property bool      _hasgrd:    gradient.length() > 1;
        readonly property vector4d  _vrrad:     control.varientRadius;

        function rb(rad) {
            const min   = Math.min(width, height);
            const max   = Math.max(width, height);
            return Math.min(min / 2, rad) / max;
        }

        fragmentShader: "
            #version 330
            uniform highp   float   qt_Opacity;
            varying highp   vec2    qt_TexCoord0;

            uniform mediump float   _width;
            uniform mediump float   _height;
            uniform lowp    vec4    _vrrad;

            uniform lowp    vec4    _c0;
            uniform lowp    vec4    _c1;
            uniform lowp    vec2    _s0;
            uniform lowp    vec2    _s1;

            void main() {
                // ---------------- normalized size and coordinate ----------------
                highp vec2 center           = vec2(_width,_height)/2.0;
                highp vec2 coord            = vec2(qt_TexCoord0.x * _width, qt_TexCoord0.y * _height);

                // ------------------------ color gradient ------------------------
                lowp float _d               = distance(_s0,_s1);
                lowp float angle            = (_s0.x - _s1.x)/((_s1.y - _s0.y) == 0.0 ? 0.001 : _s1.y - _s0.y);
                lowp float line             = angle * (coord.x - (_s0.x+_s1.x) / 2 ) + (_s0.y + _s1.y) / 2 - coord.y;
                lowp float dist             = line / sqrt(angle * angle + 1.0);
                lowp float rotflag          = (_s0.y > _s1.y) ? -1.0 : 1.0;
                gl_FragColor                = mix(_c0, _c1, smoothstep(0.0, 2 * _d, rotflag * dist + _d));

                // ------------------ plate size and border radius ------------------
                lowp    float   radius[4]   = float[4](_vrrad.x,_vrrad.y,_vrrad.z,_vrrad.w);
                lowp    int     area        = int(floor((atan(coord.x - 0.5, coord.y - 0.5) + 3.1415) * 0.636));
                highp   float   _dist       = length(max(abs(center - coord) - center + radius[area], 0.0)) - radius[area];
                gl_FragColor                = gl_FragColor * smoothstep(0.0, 0.001, - _dist + 0.001);
            }"
    }
}
