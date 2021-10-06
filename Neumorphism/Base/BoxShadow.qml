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

    property color color: '#000'
    property alias shadow: effect.shadow

    ShaderEffect {
        id: effect

        width:  control.width;
        height: control.height;

        property Shadow shadow: Shadow {
            offset:   0.8
            radius:   0.8
            spread:   0.7
        }

        readonly property real _shradius: {
            const min = Math.min(_width, _height);
            return Math.max(Math.min(shadow.radius, min + _offset*2), 0.0);// radius must be greater than zero
        }

        readonly property real  _width:  width  / Math.max(width, height);
        readonly property real  _height: height / Math.max(width, height);
        readonly property real  _spread: shadow.spread * 0.499999;
        readonly property real  _offset: shadow.offset/2 - 0.5;
        readonly property color _color:  control.color;

        fragmentShader: "
            #version 330
            varying highp   vec2    qt_TexCoord0;
            uniform highp   float   qt_Opacity;
            uniform mediump float   _width;
            uniform mediump float   _height;
            uniform mediump float   _shradius;
            uniform mediump float   _spread;
            uniform mediump float   _offset;
            uniform lowp    vec4    _color;

            highp float linearstep(in highp float e0, in highp float e1, in highp float x) {
                return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
            }

            void main() {
                // ---------------- normalized center and coordinate ----------------
                highp vec2 center = vec2(_width, _height)/2.0;
                highp vec2 coord  = vec2(qt_TexCoord0.x * _width, qt_TexCoord0.y * _height);
                highp vec2 offset = center + _offset + _shradius / 2.0;

                // ----------------- shadow spread and offset -----------------
                lowp float shadowAlpha =
                    smoothstep(0.0, _shradius, offset.x - abs(center.x - coord.x)) *
                    smoothstep(0.0, _shradius, offset.y - abs(center.y - coord.y));

                highp float spreadMulti     = linearstep(_spread, 1.0 - _spread, shadowAlpha);
                highp float alpha           = qt_Opacity * spreadMulti * spreadMulti;
                gl_FragColor                = _color * alpha;
            }"
    }
}
