// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property bool inward: false
    property alias color: effect.color
    property alias light: effect.light
    property alias dark: effect.dark

    property real spread
    property real angle
    property real pad
    property real blend

    property var radius: NaN

    contentItem: ShaderEffect {
        id: effect

        implicitWidth: 100
        implicitHeight: 100

        property real _min: Math.min(width, height)
        property size size: Qt.size(width, height)

        property real style: control.inward

        property color color: control.palette.button
        property color light: Qt.hsla(0, 0, color.hslLightness + 0.3, 1)
        property color dark: Qt.hsla(0, 0, color.hslLightness - 0.3, 1)

        property vector4d attrs: Qt.vector4d(control.spread / _min, control.angle * 0.017453,
                                             control.pad / _min, control.blend / _min);
        property vector4d radius: {
            if(Number.isFinite(control.radius)) {
                const r = control.radius/_min;
                return Qt.vector4d(r,r,r,r);
            } else {
                const {x,y,z,w} = control.radius;
                return Qt.vector4d(x,y,z ?? x,w ?? y);
            }
        }

        fragmentShader: "qrc:/Neumorphism/shaders/neum.glsl"
    }
}
