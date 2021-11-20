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

    implicitWidth: 50
    implicitHeight: 50

    property color color: '#000'
    property alias shadow: effect.shadow

    ShaderEffect {
        id: effect

        width: control.width;
        height: control.height;

        property Shadow shadow: Shadow {
            radius: 0
            spread: 0
        }

        readonly property vector2d ratio: Qt.vector2d(width / whmax, height / whmax);
        readonly property real whmax: Math.max(width, height);
        readonly property real spread: shadow.spread / whmax;
        readonly property color color: control.color;
        readonly property real radius: {
            const min = Math.min(width, height);
            return Math.min(Math.max(shadow.radius, spread), min/2) / whmax;
        }

        fragmentShader: "
            #version 330
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float radius;
            uniform highp float spread;
            uniform highp vec2 ratio;
            uniform highp vec4 color;

            void main() {
                // ---------------- normalized center and coordinate ----------------
                highp vec2 center = ratio / 2.0;
                highp vec2 coord = qt_TexCoord0 * ratio;
                // ------------------------- color assignment -----------------------
                gl_FragColor = color ;
                // ---------------------- shadow spread and radius ------------------
                highp float dist = length(max(abs(center - coord) - center + radius, 0.0)) - radius;
                gl_FragColor = gl_FragColor * smoothstep(0.0, spread, - dist + 0.001) * qt_Opacity;
            }"
    }
}
