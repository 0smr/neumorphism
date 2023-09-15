// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io


import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls  2.15 as QQC

T.RangeSlider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            first.implicitHandleWidth + leftPadding + rightPadding,
                            second.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             first.implicitHandleHeight + topPadding + bottomPadding,
                             second.implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    component Handle: T.Control {
        property real pos: 0

        x: control.leftPadding + (control.horizontal ? pos * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding  + (control.horizontal ? (control.availableHeight - height) / 2 : pos * (control.availableHeight - height))

        implicitWidth: 20
        implicitHeight: 20

        width: implicitWidth; height: width

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
            spread: width/2
        }
    }

    first.handle: Handle { pos: control.first.visualPosition }
    second.handle: Handle { pos: control.second.visualPosition }

    background: NeumEffect {
        implicitWidth: 200
        implicitHeight: 30

        padding: 3

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        radius: height
        inward: true

        opacity: 1 - color.hslLightness * 0.8

        pad: 15
        angle: Math.atan((availableHeight - pad)/(availableWidth - pad)) * 57.295
        blend: spread
        spread: availableHeight/2
    }
}
