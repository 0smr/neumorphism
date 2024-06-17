// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    property real a: 0.22;
    property real b: 1.75;
    property bool topShade: true;
    property real spread: 1;

    ShaderEffect {
        id: effect

        width:  parent.width;
        height: parent.height;

        readonly property color color: control.palette.base;
        readonly property real a: control.a;
        readonly property real b: control.b;
        readonly property real dir: control.topShade ? 1 : -1;
        readonly property real spread: control.spread;

        readonly property vector2d ratio:  {
            const max = Math.max(width, height);
            return Qt.vector2d(width/max, height/max)
        }

        fragmentShader: "qrc:/Neumorphism/shaders/horizontal-separator.frag.qsb"
    }
}
