// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io


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
        text: control.displayText

        font: control.font
        color: control.palette.buttonText
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


    background: T.Control {
        implicitWidth: 80
        implicitHeight: 30

        contentItem: NeumEffect {
            padding: -1
            color: 'transparent'
            dark: Qt.darker(control.palette.button, 1.1)
            light: Qt.lighter(control.palette.button, 1.1)

            visible: spread

            radius: width
            inward: true
            angle: Math.atan((height - pad)/(width - pad)) * 57.295 + 181
            blend: 10; pad: 5; spread: 6

            background: Rectangle { color: control.palette.button; radius: width }
        }

        background: BoxShadow {
            color: Qt.darker(control.palette.button, 2.0)
            padding: -4; topPadding: -2; leftPadding: -2
            radius: width
            spread: 10
        }
    }
}
