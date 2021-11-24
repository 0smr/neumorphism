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
import QtQuick.Controls 2.15

Control {
    id: control

    property real dashCount: 2
    property real dashWidth: 2
    property real borderWidth: 2

    ShaderEffect {
            id: effect
            width: parent.width;
            height: width;
            readonly property real count: 360 / control.dashCount
            readonly property real dashWidth: control.dashWidth / 2
            readonly property real borderWidth: control.borderWidth / width / 2
            readonly property color color: control.palette.base;

            fragmentShader: "
                #version 330
                varying highp vec2 qt_TexCoord0;
                uniform highp float qt_Opacity;
                uniform highp float count;
                uniform highp float dashWidth;
                uniform highp float borderWidth;
                uniform highp vec4 color;

                void main() {
                    highp vec2 normal = qt_TexCoord0 - vec2(0.5);
                    gl_FragColor = color;
                    highp float ticks = smoothstep(0,0.5 / count, -abs(fract(atan(normal.x, normal.y) * 57.2958 / count) - 0.5) + dashWidth / count);
                    highp float ring = smoothstep(0,0.005, -abs(length(normal) - 0.5 + borderWidth) + borderWidth);
                    gl_FragColor = gl_FragColor * ring * ticks;
                }"
        }
}
