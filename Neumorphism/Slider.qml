// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    handle: T.Control {
        x: control.leftPadding + control.visualPosition * (control.availableWidth - width)
        y: control.topPadding  + (control.availableHeight - height) / 2

        implicitWidth: 20
        implicitHeight: 20

        padding: !control.activeFocus - control.pressed
        width: implicitWidth
        height: width

        rightInset: -2
        bottomInset: -2

        Behavior on padding { NumberAnimation{ duration: 100} }

        contentItem: Sphere {
            dark: Qt.darker(control.palette.button, 1.3)
            light: Qt.lighter(control.palette.button, 1.9 - control.palette.button.hslLightness)
            dist: 2.5
        }

        background: BoxShadow {
            color: Qt.darker(control.palette.button, 1.3)
            radius: width
            spread: width/2 - control.pressed
        }
    }

    background: NeumEffect {
        topPadding: control.topInset + control.topPadding
        bottomPadding: control.bottomInset + control.bottomPadding
        leftPadding: control.leftInset + control.leftPadding
        rightPadding: control.rightInset + control.rightPadding

        implicitWidth: 200
        implicitHeight: 30

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        radius: height
        inward: true

        opacity: 1 - color.hslLightness * 0.8

        pad: 10
        angle: Math.atan((availableHeight - pad)/(availableWidth - pad)) * 57.295
        blend: spread
        spread: availableHeight/2
    }
}
