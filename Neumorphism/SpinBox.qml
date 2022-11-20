// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io


import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.SpinBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            contentItem.implicitWidth + 2 * padding +
                            up.implicitIndicatorWidth +
                            down.implicitIndicatorWidth)
    implicitHeight: Math.max(implicitContentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight,
                             up.implicitIndicatorHeight,
                             down.implicitIndicatorHeight)

    padding: 6
    leftPadding: padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
    rightPadding: padding + (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

    validator: IntValidator {
        locale: control.locale.name
        bottom: Math.min(control.from, control.to)
        top: Math.max(control.from, control.to)
    }

    contentItem: TextInput {
        z: 2
        text: control.displayText

        font: control.font
        color: control.palette.text
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        readOnly: !control.editable
        validator: control.validator
        inputMethodHints: control.inputMethodHints
    }

    up.indicator: Text {
        x: control.mirrored ? 0 : parent.width - width
        width: 30; height: parent.height

        font.pointSize: 10
        font.bold: true

        text: "+";
        opacity: !enabled ? 0.2 :
                  control.up.pressed ? 0.4 : 0.6
        color: control.palette.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    down.indicator: Text {
        x: control.mirrored ? parent.width - width : 0
        width: 30; height: parent.height

        font.pointSize: 10
        font.bold: true

        text: "-";
        opacity: !enabled ? 0.2 :
                  control.down.pressed ? 0.4 : 0.6
        color: control.palette.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }


    background: Rectangle {
        id: background
        implicitWidth: 80
        implicitHeight: 30

        radius: width
        color: 'transparent'

        BoxShadow {
            x: (parent.width - width) /2 + 1
            y: (parent.height - height) /2 + 1
            width: contentItem.implicitWidth + 20
            height: parent.height
            shadow.radius: width
            shadow.spread: 25
        }

        AdvancedRectangle {
            x: (parent.width - width) /2
            y: (parent.height - height) /2
            width: contentItem.implicitWidth + 15
            height: parent.height * 0.8
            radius: 0.5

            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.1); stop: Qt.vector2d(0,0)},
                GradientColor{color: control.palette.button; stop: Qt.vector2d(0.6,0.5)}
            ]

            Behavior on x {
                enabled: !control.down
                NumberAnimation{ duration: 80 }
            }
        }
    }
}
