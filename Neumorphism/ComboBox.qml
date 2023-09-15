// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Templates 2.15  as T

T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    topPadding: padding + 7
    bottomPadding: padding + 7
    leftPadding: padding + 7
    rightPadding: padding + 25

    delegate: ItemDelegate {
        id: idelegate

        required property int index
        required property int modelData
        readonly property bool isCurrent: control.currentIndex === index

        padding: 0; leftPadding: 5
        width: ListView.view.width
        text: !control.textRole ? modelData :
            (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole])

        hoverEnabled: control.hoverEnabled

        palette.text: control.palette.buttonText

        background: T.Control {
            implicitHeight: 30

            contentItem: Rectangle {
                border.color: isCurrent ? Neumorphism.alpha(control.palette.highlight, 0.5)
                                        : Qt.tint(color, '#22ffffff')
                color: control.palette.button
                radius: 5
            }

            background: BoxShadow {
                color: Qt.darker(control.palette.button, 1.2)
                padding: -5; topPadding: -3;
                spread: 10 + 3 * !idelegate.hovered
                radius: 0

                Behavior on spread {NumberAnimation{ duration: 100 }}
            }
        }
    }

    indicator: Text {
        x: control.mirrored ? control.padding : control.width - control.rightPadding + 5
        y: control.topPadding + (control.availableHeight - height)/2
        color: control.palette.buttonText
        text: "\u2261"
        font.pixelSize: 12
        font.bold: true
        opacity: enabled ? 1 : 0.3
    }

    contentItem: T.TextField {
        leftPadding: 5
        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        selectByMouse: control.selectTextByMouse

        font: control.font
        color: control.palette.buttonText
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        verticalAlignment: Text.AlignVCenter

        opacity: 0.7 + 0.3 * control.editable

        background: Rectangle {
            visible: control.enabled && control.editable && !control.flat

            border.color: control.palette.buttonText
            color: 'transparent'
            opacity: 0.2
            radius: 3
        }
    }

    background: NeumEffect {
        implicitWidth: 140
        implicitHeight: 40

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        angle: Math.atan((height - pad)/(width - pad)) * 57.295 + 180
        radius: 5; pad: 5; blend: 15; spread: 7 - 1.5 * control.pressed

        Behavior on spread {NumberAnimation{ duration: 50 }}
    }

    popup: T.Popup {
        x: control.leftPadding - padding
        y: control.height
        padding: 5
        clip: true

        width: control.availableWidth + padding
        height: {
            const globalPos = mapToItem(control.Window.contentItem, Qt.point(0,0)).y;
            Math.min(contentItem.implicitHeight, control.Window.height - globalPos - y, globalPos)
        }

        contentItem: ListView {
            spacing: 4
            implicitHeight: contentHeight

            opacity: parent.visible

            model: control.delegateModel

            currentIndex: control.highlightedIndex

            highlightMoveDuration: 0
            T.ScrollIndicator.vertical: null;

            Behavior on opacity {NumberAnimation {}}
        }
    }
}
