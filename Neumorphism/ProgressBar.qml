// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int orientation: Qt.Horizontal
    padding: 2
    leftPadding: 5; rightPadding: 5

    QtObject {
        id: orientation
        property bool vertical: control.orientation == Qt.Vertical
        property bool horizontal: control.orientation == Qt.Horizontal
    }

    contentItem: T.Control {
        x: control.leftPadding
        y: control.topPadding  + (control.availableHeight - height) / 2

        implicitWidth: background.implicitWidth
        implicitHeight: 18

        padding: 5
        leftInset: 5; topInset: 2

        width: orientation.horizontal ? control.availableWidth * control.position : 0
        height: Math.min(implicitHeight, width)

        contentItem: Rectangle {
            radius: width
            border.color: Qt.rgba(1,1,1,(1 - control.palette.button.hslLightness)/4)

            gradient: Gradient {
                GradientStop{ color: Qt.lighter(control.palette.button, 1.18); position: 0 }
                GradientStop{ color: Qt.darker(control.palette.button, 1.3); position: 1 }
            }
        }

        background: BoxShadow {
            color: Qt.darker(control.palette.button, 1.2)
            padding: 2
            radius: height
            spread: height/2
        }
    }

    background: NeumEffect { /// Rounded-In {
        implicitWidth: 200
        implicitHeight: 28

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        radius: height
        inward: true

        opacity: 1 - color.hslLightness * 0.8

        pad: 15
        angle: Math.atan((availableHeight - pad)/(availableWidth - pad)) * 57.295
        blend: spread
        spread: availableHeight/3
    }
}
