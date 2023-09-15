// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15

import Neumorphism 1.3

T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                                implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                                implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.palette.buttonText

    display: AbstractButton.TextOnly

    contentItem: Item {
        Grid {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            spacing: control.display == AbstractButton.TextOnly ||
                     control.display == AbstractButton.IconOnly ? 0 : control.spacing

            rows: control.display == AbstractButton.TextUnderIcon ? 1 : -1
            columns: -rows

            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down || control.checked ? 0.8 : 1.0

            Image {
                visible: control.display != AbstractButton.TextOnly
                source: control.icon.source
                width: control.icon.width
                height: control.icon.height
                cache: control.icon.cache
            }

            Text {
                visible: control.display != AbstractButton.IconOnly
                text: control.text
                font: control.font
                color: control.palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background: NeumEffect {
        id: background
        visible: control.enabled && !control.flat

        implicitWidth:  50
        implicitHeight: 50

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        angle: Math.atan((height - pad)/(width - pad)) * 57.295 + 180
        radius: 5; pad: 5; blend: 15; spread: 7 - 1.5 * control.pressed

        Behavior on spread { NumberAnimation { duration: 50 } }

        Rectangle {
            x: (parent.width - width)/2
            y: (parent.height - height)/2

            width:  parent.width - 10
            height: width

            visible: control.highlighted
            color: 'transparent'
            radius: 6
            opacity: 0.5
            border.color: Qt.tint(control.palette.highlight, "#12ffffff")
        }

        NeumEffect {
            padding: 1
            x: 5; y: x

            width: parent.width - 10; height: parent.height - 10

            color: control.palette.button
            dark: Qt.darker(color, 1.5)
            light: Qt.lighter(color, 1.5)

            visible: spread

            radius: 3
            inward: true
            opacity: 0.3
            angle: parent.angle + 180 - 2
            blend: 8; pad: 5; spread: 4 * control.checked

            Behavior on spread { NumberAnimation { duration: 150 } }
        }
    }
}
