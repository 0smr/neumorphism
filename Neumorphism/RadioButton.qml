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
import "Base"

// @disable-check M129
T.RadioButton {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding,
                            implicitIndicatorHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    indicator: RoundedInEffect {
        id: indicatorBack

        implicitWidth:  28
        implicitHeight: 28

        shadow {
            radius: 1.00
            offset: 0.85
            spread: 0.60
        }

        border {
            radius: width / 2.0
        }

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        color: control.palette.button
        /*!
         * TODO: add active and visual focus effect
         * control.visualFocus
         * control.activeFocus
         */

        BoxShadow {
            id: ishade
            x: ibox.x  * 1.1
            y: ibox.y  * 1.1

            width:  control.checked ? parent.width  * 0.90 : 0
            opacity: control.checked ? 1.0 : 0.0
            height: width
            color: '#77000000'

            shadow {
                radius: 1.00
                offset: 0.66
                spread: 0.15
            }

            Behavior on width   {NumberAnimation{ duration: 100 }}
            Behavior on opacity {NumberAnimation{ duration: 100 }}
        }

        AdvancedRectangle {
            id: ibox
            x: (parent.width  - width)/2
            y: x

            width:  control.checked ? parent.width  * 0.75 : 0
            height: width

            radius: 0.5
            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.20); stop: Qt.vector2d(0,0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.05); stop: Qt.vector2d(1,1)}
            ]

            Behavior on width { NumberAnimation{ duration: 100 } }
        }
    }

    contentItem: Text {
        leftPadding:    control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding:   control.indicator &&  control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text:           control.text
        font:           control.font
        color:          control.palette.buttonText
    }
}
