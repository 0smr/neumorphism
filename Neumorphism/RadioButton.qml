// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

import Neumorphism 1.3

T.RadioButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: Item {
        implicitWidth: 24
        implicitHeight: 24

        y: control.padding
        x: control.text ? (control.mirrored ? control.width - width : control.padding) : 0

        T.Control {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            width: control.checked * parent.width
            height: width

            rightInset: -2
            bottomInset: -2

            Behavior on width {NumberAnimation {duration: 200}}

            contentItem: Sphere {
                dark: Qt.darker(control.palette.button, 1.3)
                light: Qt.lighter(control.palette.button, 1.9 - control.palette.button.hslLightness)
                dist: 3.0
            }

            background: BoxShadow {
                color: Qt.darker(control.palette.button, 1.3)
                spread: width/2 - control.pressed
                radius: width
                visible: control.checked
            }
        }
    }

    background: Item {
        implicitWidth: 28
        implicitHeight: 28

        NeumEffect {
            width: parent.height; height: width

            color: control.palette.button
            dark: Qt.darker(color, 1.5)
            light: Qt.lighter(color, 1.5)

            inward: true; opacity: 1 - color.hslLightness * 0.8
            blend: 20; spread: 15; pad: 10; angle: 45; radius: width
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.implicitIndicatorWidth + control.spacing : 0

        verticalAlignment: Text.AlignVCenter
        color: control.palette.buttonText
        text: control.text
        font: control.font
    }
}
