// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtGraphicalEffects 1.0
import Neumorphism 1.0

Item {
    id: control

    property alias shadow: shadowEffect.shadow
    property color color: Neumorphism.color

    implicitWidth: 50
    implicitHeight: 50

    ShaderEffect {
        id: shadowEffect

        implicitWidth: parent.width
        implicitHeight: parent.height

        property Shadow shadow: Shadow {
            offset: 0; radius: 0; spread: 0; angle: 45; distance: 0.45
            color1: Qt.darker(control.color, 1.15);
            color2: Qt.lighter(control.color, 1.20);
        }

        readonly property vector2d ratio: Qt.vector2d(width / whmax, height / whmax)
        readonly property color color1: shadow.color1
        readonly property color color2: shadow.color2
        readonly property real whmax: Math.max(width, height)
        readonly property real spread: shadow.spread / whmax
        readonly property real offset: shadow.offset / whmax
        // Converts the angle of a shadow to a radian.
        readonly property real angle: shadow.angle * 0.0174533
        readonly property real shdiff: shadow.distance
        readonly property real smoothstp: 2 / whmax
        readonly property real radius: {
            const min = Math.min(width, height);
            return Math.min(Math.max(shadow.radius, spread), min/2) / whmax;
        }

        fragmentShader: "
            uniform highp float qt_Opacity;
            varying highp vec2 qt_TexCoord0;
            uniform highp vec2 ratio;
            uniform highp float shdiff;
            uniform highp float angle;
            uniform highp float offset;
            uniform highp float spread;
            uniform highp float radius;
            uniform highp float smoothstp;
            uniform highp vec4 color1;
            uniform highp vec4 color2;

            void main() {
                // Normalize the coordinates qt_TexCoord0
                highp vec2 center = ratio / 2.0;
                highp vec2 coord = qt_TexCoord0 * ratio;
                // Normalize the coordinates to the center of the scene
                highp vec2 ncoord = coord - center;
                // Set shadow gradient.
                highp float slop = tan(angle);
                highp float mult = 1.57079 < angle && angle < 4.7123 ? -1.0 : 1.0;
                highp float ratio = smoothstep(0.0, shdiff, mult * (slop * ncoord.x + ncoord.y)/sqrt(slop * slop + 1.0) + shdiff/2.0);
                gl_FragColor = mix(color1, color2, ratio);
                // Creating shadow based on shadow offset and shadow spreads.
                highp float dist = length(max(abs(center - coord) - center + radius, 0.0)) - radius;
                gl_FragColor = gl_FragColor * smoothstep(0.0, spread, dist + offset) * qt_Opacity;
                // Clipping the scene to the circular region in the center.
                gl_FragColor = gl_FragColor * smoothstep(0.0, smoothstp, - dist + 0.005) * qt_Opacity;
            }"
    }
}
