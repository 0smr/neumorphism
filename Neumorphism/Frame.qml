// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.Frame {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             contentHeight + topPadding + bottomPadding)

    padding: 12

    background: NeumEffect { /// Rounded Out {
        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        angle: Math.atan((height - pad)/(width - pad)) * 57.295 + 180
        radius: 5; pad: 5; blend: 15; spread: 10 + control.pressed * -2
    }
}
