// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

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

        property Shadow shadow: Shadow { radius: width; spread: 10 }

        readonly property vector2d ratio: Qt.vector2d(width / whmax, height / whmax);
        readonly property real whmax: Math.max(width, height);
        readonly property real spread: shadow.spread / whmax;
        readonly property color color: control.color;
        readonly property real radius: {
            const min = Math.min(width, height);
            return Math.min(Math.max(shadow.radius, spread), min/2) / whmax;
        }

        fragmentShader: "
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float radius;
            uniform highp float spread;
            uniform highp vec2 ratio;
            uniform highp vec4 color;

            void main() {
                // TextCoord is normalized based on item size.
                highp vec2 center = ratio / 2.0;
                highp vec2 coord = qt_TexCoord0 * ratio;
                // Initial color value.
                gl_FragColor = color ;
                // Creating shadow based on shadow offset and shadow spreads.
                highp float dist = length(max(abs(center - coord) - center + radius, 0.0)) - radius;
                gl_FragColor = gl_FragColor * smoothstep(0.0, spread, - dist + 0.001) * qt_Opacity;
            }"
    }
}
