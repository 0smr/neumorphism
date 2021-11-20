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
T.Slider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitHandleHeight + topPadding + bottomPadding)
    padding: 6

    handle: Item {
        x: control.leftPadding + (control.horizontal ? control.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding  + (control.horizontal ? (control.availableHeight - height) / 2 : control.visualPosition * (control.availableHeight - height))

        implicitWidth:   20
        implicitHeight:  20

        width:  implicitWidth * (control.activeFocus ? 1.0 : 0.8)
        height: width

        Behavior on width { NumberAnimation{ duration: 100} }

        BoxShadow {
            id: ishade
            x: -width * 0.1
            y: x

            property real offset: control.height * (control.pressed ? 0.30 : 0.25)

            width:  ibox.width + offset
            height: width

            color: '#66000000'
            shadow {
                radius: width
                spread: 16
            }

            Behavior on offset { NumberAnimation{ duration: 100} }
        }

        AdvancedRectangle {
            id: ibox
            width:  parent.width
            height: parent.height

            radius: 0.5

            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.3); stop: Qt.vector2d(0,0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.1); stop: Qt.vector2d(1,1)}
            ]
        }
    }

    background: RoundedInEffect {
        x: (control.width  - width) / 2
        y: (control.height - height) / 2

        implicitWidth:  control.horizontal ? 200 : 10
        implicitHeight: control.horizontal ? 10 : 200

        color: control.palette.button

        /*!
         * FIXME: binding loop error when use implicitHeight to feed height.
         * TODO: add mirror state.
         */
        width:  control.horizontal ? control.availableWidth : implicitWidth
        height: control.horizontal ? 10 : control.availableHeight

        shadow {
            radius: width
            offset: 6
            spread: 10
            distance: 0.05
            angle:  control.horizontal  ? 0.00 : 90.0
        }
    }
}
