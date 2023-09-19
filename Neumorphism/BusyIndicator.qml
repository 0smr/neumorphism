// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    running: false

    contentItem: T.Control {
        implicitWidth: 100
        implicitHeight: 100

        contentItem: ShaderEffect {
            Timer {
                repeat: true
                running: control.running
                interval: 1000/40
                onTriggered: parent.seed += 0.01
            }

            property real seed: 0
            property real _min: Math.min(width, height)
            property size size: Qt.size(width, height)
            property color color: control.palette.button
            property color light: Qt.lighter(color, 1.15)
            property color dark: Qt.darker(color, 1.5 - color.hslLightness/2)
            property vector4d attrs: Qt.vector4d(30/width, -135 * 0.017453, 0.1, width/15);
            fragmentShader: "qrc:/Neumorphism/shaders/wave.glsl"
        }
    }
}
