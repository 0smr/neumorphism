/****************************************************************************
**
** Copyright (C) 2017 The Qt Company Ltd.
** Contact: http://www.qt.io/licensing/
**
** This file is part of the Qt Quick Controls 2 module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL3$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see http://www.qt.io/terms-conditions. For further
** information use the contact form at http://www.qt.io/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 2.0 or later as published by the Free
** Software Foundation and appearing in the file LICENSE.GPL included in
** the packaging of this file. Please review the following information to
** ensure the GNU General Public License version 2.0 requirements will be
** met: http://www.gnu.org/licenses/gpl-2.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/

import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15
import QtQuick.Templates 2.15  as T

// @disable-check M129
T.ComboBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)
    leftPadding: padding + (!control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)
    rightPadding: padding + (control.mirrored || !indicator || !indicator.visible ? 0 : indicator.width + spacing)

    delegate: ItemDelegate {
        width: ListView.view.width
        text: control.textRole ? (Array.isArray(control.model) ? modelData[control.textRole] : model[control.textRole]) : modelData
        palette.text: control.palette.text
        palette.highlightedText: control.palette.highlightedText
        hoverEnabled: control.hoverEnabled

        background: Item {
            BoxShadow {
                width: parent.width
                height: parent.height
                color: '#22000000'
                opacity: control.highlightedIndex === index ? 1 : 0
                shadow { offset: 5; radius: 8; spread: 12 }
                Behavior on opacity { NumberAnimation { duration: 200 } }
            }

            Rectangle {
                x: 4; y: x
                width: parent.width - 2 * x
                height: parent.height - 2 * y
                radius: 3
                color: control.palette.button
                border.width: 0.5
                border.color: Qt.darker(color, 1.05)
            }

            Rectangle {
                x: parent.width - 3 * width
                y: (parent.height - height)/2
                width: 5; height: 5; radius: 5
                color: 'black'
                opacity: 0.1
                visible: control.currentIndex === index
            }
        }
    }

    indicator: Text {
        x: control.mirrored ? control.padding : control.availableWidth - width
        y: control.topPadding + (control.availableHeight - height)/2
        color: control.palette.dark
        text: "\u2261"
        font.pixelSize: 12
        font.bold: true
        opacity: enabled ? 1 : 0.3
    }

    contentItem: T.TextField {
        leftPadding: !control.mirrored ? 12 : 13
        rightPadding: control.mirrored ? 12 : 13
        leftInset: 7; topInset: 7; bottomInset: 7; rightInset: 13
        text: control.editable ? control.editText : control.displayText

        enabled: control.editable
        autoScroll: control.editable
        readOnly: control.down
        inputMethodHints: control.inputMethodHints
        validator: control.validator
        selectByMouse: control.selectTextByMouse

        font: control.font
        color: control.editable ? control.palette.text : control.palette.buttonText
        selectionColor: control.palette.highlight
        selectedTextColor: control.palette.highlightedText
        verticalAlignment: Text.AlignVCenter

        background: RoundedInEffect {
            visible: control.enabled && control.editable && !control.flat
            color: control.palette.button
            shadow {
                offset: 4; radius: 5; angle: 10
                spread: 7
                distance: 0.1
            }
            opacity: parent.activeFocus ? 1.0 : 0.7
            Behavior on opacity { NumberAnimation { duration: 100 } }
        }
    }

    background: RoundedOutEffect {
        implicitWidth: 140
        implicitHeight: 40

        visible: !control.flat || control.down
        color: control.palette.button
        opacity: control.down ? 0.8 : 1.0
        shadow {
            offset: 5; radius: 5
            spread: 10; angle: 13
            distance: 0.1
        }

        Behavior on opacity { NumberAnimation { duration: 100 } }
    }

    popup: T.Popup {
        y: control.height
        width: control.width
        height: Math.min(contentItem.implicitHeight, control.Window.height - y - control.y)

        contentItem: ListView {
            clip: true
            implicitHeight: contentHeight
            model: control.delegateModel
            currentIndex: control.highlightedIndex
            highlightMoveDuration: 0
            T.ScrollIndicator.vertical: ScrollIndicator { }
        }
    }
}
