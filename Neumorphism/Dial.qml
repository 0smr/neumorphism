// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import Neumorphism 1.3

T.Dial {
    id: control
    property alias dashRing: dashRing

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    handle: DashedRing {
        id: dashRing
        x: (control.background.width - width)/2
        y: (control.background.height - height)/2

        width: control.width - 25
        height: control.height - 25
        borderWidth: 2
        dashWidth: 2
        dashCount: 51
        palette.base: control.palette.buttonText
        rotation: control.angle * 1.07

        Rectangle {
            x: (parent.width - 2)/2 + 0.5
            y: -1
            width: 1; height: 5
            color: parent.palette.base
        }
    }

    background: NeumEffect { /// Rounded Out {
        implicitWidth: 184
        implicitHeight: 184

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        opacity: 1 - color.hslLightness * 0.8
        blend: 35; spread: 8; pad: 10; angle: 225; radius: width
    }
}
