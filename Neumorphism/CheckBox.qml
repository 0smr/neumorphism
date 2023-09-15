// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import Neumorphism 1.3

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitContentWidth + implicitBackgroundWidth, implicitContentWidth)
    implicitHeight: Math.max(implicitBackgroundHeight, implicitIndicatorHeight)

    padding: 6
    spacing: 6

    indicator: Item {
        implicitWidth: 22
        implicitHeight: 22

        width:  [22, 0, 22][control.checkState]
        height: [22, 0, 10][control.checkState]

        x: control.text ? (control.mirrored ? control.width - width : (control.height - width) / 2) :
                          (control.availableWidth - width) / 2
        y: (control.height - height) / 2;

        BoxShadow {
            width: parent.width; height: parent.height
            visible: width

            padding: -4; leftPadding: -2; topPadding: -2
            color: '#55000000'
            spread: 10
        }

        Rectangle {
            width: parent.width; height: parent.height

            border.color: '#22ffffff'
            radius: 5

            gradient: Gradient {
                GradientStop{ color: Qt.lighter(palette.button, 1.2); position: 0 }
                GradientStop{ color: Qt.darker(palette.button, 1.3); position: 1 }
            }
        }

        Behavior on width {NumberAnimation {duration: 200}}
        Behavior on height {NumberAnimation {duration: 200}}
    }

    background: Item {
        implicitWidth: 28
        implicitHeight: 28

        NeumEffect {
            padding: -pad/3

            width: parent.height; height: 28

            color: control.palette.button
            dark: Qt.darker(color, 1.5)
            light: Qt.lighter(color, 1.5)

            inward: true; opacity: 1 - color.hslLightness * 0.8
            blend: 15; spread: 5; pad: 7; angle: 45; radius: 5
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.implicitIndicatorWidth + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.implicitIndicatorWidth + control.spacing : 0

        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.palette.buttonText
    }
}
