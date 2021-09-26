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
import QtGraphicalEffects 1.0
import Neumorphism 1.0

Item {
    id: control

    property color color: Neumorphism.color;
    property alias shadow: shadowEffect.shadow
    property alias border: shadowEffect.border

    implicitWidth:  50
    implicitHeight: 50

    ShaderEffect {
        id: shadowEffect

        implicitWidth:  parent.width
        implicitHeight: parent.height

        property Shadow shadow: Shadow {
                offset:   0.8
                angle:    45
                distance: 0.4
                radius:   0.8
                spread:   0.7
                color1:   Qt.lighter(control.color, 1.30);
                color2:   Qt.darker (control.color, 1.15);
            }

        property Border border: Border {
                radius: width/2
                margin: width * 0.1
            }

        property color _color: control.color;

        readonly property real _shradius: Math.min(shadow.radius, _offset)
        readonly property color color1: shadow.color1;
        readonly property color color2: shadow.color2;
        readonly property real _spread: shadow.spread * 0.99999 - 0.5
        readonly property real _width:  width / Math.max(width, height)
        readonly property real _height: height / Math.max(width, height)
        readonly property real _offset: shadow.offset
        readonly property real _angle:  shadow.angle
        readonly property real _shdiff: shadow.distance
        readonly property real _margin: border.margin / Math.max(width, height);
        readonly property real _radius: {
            const min = Math.min(width, height) - 2 * border.margin;
            return Math.min(border.radius, min / 2) / Math.max(width, height);
        }

        fragmentShader: "
            uniform highp   float   qt_Opacity;
            varying highp   vec2    qt_TexCoord0;
            uniform mediump float   _shradius;
            uniform mediump float   _width;
            uniform mediump float   _height;
            uniform lowp    float   _shdiff;
            uniform lowp    float   _angle;
            uniform lowp    float   _offset;
            uniform lowp    float   _spread;
            uniform lowp    float   _radius;
            uniform lowp    float   _margin;
            uniform lowp    vec4    color1;
            uniform lowp    vec4    color2;
            uniform lowp    vec4    _color;

            highp float linearstep(in highp float e0, in highp float e1, in highp float x) {
                return clamp((x - e0) / (e1 - e0), 0.0, 1.0);
            }

            void main() {
                // ---------------- normalized size and coordinate ----------------
                highp vec2  size = vec2(_width,_height)/2.0;
                highp vec2 coord = vec2(qt_TexCoord0.x * _width, qt_TexCoord0.y * _height);

                // ----------------- inner shadow spread and size -----------------
                lowp float shadowAlpha =
                    smoothstep(0.0, _shradius, _offset * _width  - abs(size.x - coord.x)) *
                    smoothstep(0.0, _shradius, _offset * _height - abs(size.y - coord.y));

                highp float spreadMulti     = linearstep(_spread, 1.0 - _spread, shadowAlpha);
                highp float alpha           = qt_Opacity * spreadMulti * spreadMulti;

                // ---------------- color 1 and color 2 divisiveness ----------------
                lowp float a                = tan(_angle * 0.01745);
                lowp float x0               = a * (qt_TexCoord0.x - 0.5) - 0.5;
                lowp float line             = abs(x0 + qt_TexCoord0.y);
                lowp float coordDist        = line/sqrt(a*a+1.0);
                bool colorSwitch            = (x0 < -qt_TexCoord0.y) ^^ (90.0 < _angle && _angle <= 270.0);
                gl_FragColor                = mix(color2, color1, float(colorSwitch)) * alpha;

                if(coordDist <= _shdiff) {
                    coordDist               = mix(-coordDist, coordDist, float(colorSwitch));
                    gl_FragColor            = mix(color2, color1, smoothstep(0., _shdiff * 2.0 , coordDist + _shdiff)) * alpha ;
                }

                // ------------------ plate size and border radius ------------------
                size -= _margin; coord -= _margin;
                highp float distance 		= length(max(abs(coord - size) - size + _radius, 0.0)) - _radius;
                highp float smoothedAlpha   = smoothstep(0.0, 0.0, distance);
                gl_FragColor                = mix(_color, gl_FragColor, smoothedAlpha);
            }"
    }
}
