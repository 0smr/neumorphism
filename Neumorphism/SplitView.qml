// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.SplitView {
    id: control
    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    handle: NeumEffect { /// Rounded Out {
        implicitWidth: control.orientation === Qt.Horizontal ? 6 : control.width
        implicitHeight: control.orientation === Qt.Horizontal ? control.height : 6

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        inward: true; opacity: 1 - color.hslLightness * 0.8
        blend: 15; spread: 5; pad: 7; angle: 45; radius: 5
    }
}
