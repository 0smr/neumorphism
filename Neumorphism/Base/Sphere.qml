// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Control {
    id: control

    property alias dark: shader.dark
    property alias light: shader.light
    property alias dist: shader.dist
    property alias angle: shader.angle

    contentItem: ShaderEffect {
        id: shader
        property color dark: Qt.darker(control.palette.button, 1.5)
        property color light: Qt.lighter(control.palette.button, 1.6)
        property color color: '#fff'
        property size size: Qt.size(width, height)
        property real angle: -45
        property real dist: 2.5

        fragmentShader: "qrc:/Neumorphism/shaders/pseudo-sphere.glsl"
    }
}
