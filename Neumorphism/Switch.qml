// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io


import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Switch {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 0

    indicator: Item {
        implicitWidth: 48
        implicitHeight: 22

        x: control.text ? (control.mirrored ? control.width - width : 0) :
                          (control.availableWidth - width) / 2
        y: (control.height - height) / 2;

        T.Control {
            x: Neumorphism.clamp(control.visualPosition * parent.width - width/2, parent.y,
                                 parent.width - width - parent.y)

            width: parent.height; height: width
            padding: -control.down

            Behavior on padding {NumberAnimation{}}

            Behavior on x {
                enabled: !control.down
                NumberAnimation{ duration: 100 }
            }

            rightInset: -2
            bottomInset: -2

            contentItem: Sphere {
                width: 20
                height: 20
                dark: Qt.darker(control.palette.button, 1.3)
                light: Qt.lighter(control.palette.button, 1.9 - control.palette.button.hslLightness)
                dist: 2.5 + control.down * 0.5
            }

            background: BoxShadow {
                color: Qt.darker(control.palette.button, 1.3)
                spread: width/2 - control.pressed
                radius: width
            }
        }
    }

    background: Item {
        implicitWidth: 48
        implicitHeight: 28

        NeumEffect {
            width: control.indicator.width; height: parent.height

            color: control.palette.button
            dark: Qt.darker(color, 1.5)
            light: Qt.lighter(color, 1.5)

            inward: true; opacity: 1 - color.hslLightness * 0.8
            blend: 15; spread: 15; pad: 10; angle: 45; radius: 10
        }
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator &&  control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.palette.buttonText
    }
}
