// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property real dashCount: 2
    property real dashWidth: 2

    palette.base: 'black'

    ShaderEffect {
            id: effect
            width: control.width;
            height: control.height;
            readonly property real count: control.dashCount
            readonly property real dashWidth: control.dashWidth / width / 2
            readonly property color color: control.palette.base;

            fragmentShader: "
                #version 330
                varying highp vec2 qt_TexCoord0;
                uniform highp float qt_Opacity;
                uniform highp float count;
                uniform highp float dashWidth;
                uniform highp vec4 color;

                void main() {
                    highp vec2 normal = qt_TexCoord0 - vec2(0.5);
                    gl_FragColor = color;
                    highp float ticks = smoothstep(0,0.001 * count, -abs(fract(qt_TexCoord0.x * count) - 0.5) + dashWidth * count);
                    gl_FragColor = gl_FragColor * ticks;
                }"
        }
}
