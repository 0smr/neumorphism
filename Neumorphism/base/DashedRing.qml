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

            fragmentShader: "qrc:/Neumorphism/shaders/dashed-ring.frag.qsb"
        }
}
