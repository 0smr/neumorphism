// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

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
            readonly property real smoothstp: 0.5 / width
            readonly property color color: control.palette.base;

            fragmentShader: "
                varying highp vec2 qt_TexCoord0;
                uniform highp float qt_Opacity;
                uniform highp float count;
                uniform highp float dashWidth;
                uniform highp float borderWidth;
                uniform highp float smoothstp;
                uniform highp vec4 color;

                void main() {
                    highp vec2 normal = qt_TexCoord0 - vec2(0.5);
                    gl_FragColor = color;
                    highp float ticks = smoothstep(0.0, 20 * smoothstp / count, -abs(fract(atan(normal.x, normal.y) * 57.2958 / count) - 0.5) + dashWidth / count);
                    highp float ring = smoothstep(0.0, smoothstp, -abs(length(normal) - 0.5 + borderWidth) + borderWidth);
                    gl_FragColor = gl_FragColor * ring * ticks;
                }"
        }
}
