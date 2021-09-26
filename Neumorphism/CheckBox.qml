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
import Neumorphism 1.0

// @disable-check M129
T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: RoundedInEffect {
        implicitWidth:  28
        implicitHeight: 28

        shadow {
            offset: 0.50
            radius: 0.30 * shadow.offset * 2.0
            spread: 0.70
        }

        border {
            radius: width * 0.30
        }

        x: control.text ? (control.mirrored ? control.width - width - control.rightPadding : control.leftPadding) : control.leftPadding + (control.availableWidth - width) / 2
        y: control.topPadding + (control.availableHeight - height) / 2

        color: control.palette.button
//        color: control.down ? control.palette.light : control.palette.base
        // border.width: control.visualFocus ? 2 : 1
        // border.color: control.visualFocus ? control.palette.highlight : control.palette.mid


//            visible: control.checkState === Qt.PartiallyChecked

        BoxShadow {
            x: (parent.width - width * 0.90) / 2
            y: (parent.height - height * 0.90) / 2

            width:  parent.width  * 0.90
            visible: control.checkState === Qt.Checked
            height: width
            color: '#77000000'

            shadow {
                radius: 0.45
                offset: 0.60
                spread: 0.40
            }
        }

        AdvancedRectangle {
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2
            width:  parent.width  * 0.75
            height: width

            visible: control.checkState === Qt.Checked

            radius: 0.2
            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.2); stop: Qt.vector2d(0,0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.05); stop: Qt.vector2d(1,1)}
            ]

            Behavior on width {
                NumberAnimation { duration: 50 }
            }
        }
    }

    contentItem: Text {
        leftPadding:    control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding:   control.indicator &&  control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text:           control.text
        font:           control.font
        color:          control.palette.windowText
    }
}
