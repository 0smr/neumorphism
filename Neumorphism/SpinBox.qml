/****************************************************************************
** Copyright (C) 2021 smr.
** Contact: http://s-m-r.ir
**
** This file is part of the SMR Neumorphism Toolkit.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**
** Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
****************************************************************************/


import QtQuick 2.15
import QtQuick.Templates 2.15 as T

// @disable-check M129
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
    leftPadding:    padding + (control.mirrored ? (up.indicator ? up.indicator.width : 0) : (down.indicator ? down.indicator.width : 0))
    rightPadding:   padding + (control.mirrored ? (down.indicator ? down.indicator.width : 0) : (up.indicator ? up.indicator.width : 0))

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
        width:  40; height: parent.height
        font {
            pixelSize: width/3
            bold: true
        }
        text: "+";
        opacity: enabled ? 0.4 : 0.2
        color: control.palette.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    down.indicator: Text {
        x: control.mirrored ? parent.width - width : 0
        width:  40; height: parent.height
        font {
            pixelSize: width/3
            bold: true
        }
        text: "-";
        opacity: enabled ? 0.4 : 0.2
        color: control.palette.buttonText
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }


    background: RoundedOutEffect {
        id: background
        implicitWidth: 120

        color: control.palette.button

        border { radius: width; margin: height * 0.1 }

        shadow {
            offset:     0.88;
            radius:     1.00;
            spread:     control.enabled ? 0.40 : 0.70;
            distance:   0.30;
            angle:      45.0;
            color1:     Qt.lighter(background.color, 1.30);
            color2:     Qt.darker (background.color, 1.20);
        }

        AdvancedRectangle {
            x: (parent.width - width)   /2
            y: (parent.height - height) /2
            width: parent.width - parent.border.margin * 3.0
            height: parent.height - parent.border.margin * 3.0
            radius: 0.5

            gradient: [
                GradientColor{color: Qt.darker(control.palette.button, control.down.pressed ? 1.02 : 1.00); stop: Qt.vector2d(0.4,0.5)},
                GradientColor{color: Qt.darker(control.palette.button, control.up.pressed   ? 1.02 : 1.00); stop: Qt.vector2d(0.6,0.5)}
            ]

            Behavior on x {
                enabled: !control.down
                NumberAnimation{ duration: 80 }
            }
        }

        RoundedInEffect {
            id: innerShade

            x: (parent.width - width)   /2
            y: (parent.height - height) /2

            width:  control.implicitWidth * 0.45
            height: (parent.height - parent.border.margin * 2.0) * 0.7

            color: control.palette.button
            border.radius: height * 0.3
            shadow {
                radius: 0.30
                spread: 0.80
                offset: control.activeFocus ? 0.95 : 0.99
            }

            Behavior on shadow.offset {NumberAnimation{duration: 100}}
        }
    }
}
