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
T.RangeSlider {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            first.implicitHandleWidth + leftPadding + rightPadding,
                            second.implicitHandleWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             first.implicitHandleHeight + topPadding + bottomPadding,
                             second.implicitHandleHeight + topPadding + bottomPadding)

    padding: 6

    /**
     * FIXME: there are no active focus on click for handles.
     * TODO: move handles to seprate componnent.
     */

    first.handle: T.Control {
        x: control.leftPadding + (control.horizontal ? control.first.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.first.visualPosition * (control.availableHeight - height))

        implicitWidth:   20
        implicitHeight:  20

        width:  implicitWidth * (visualFocus ? 1.0 : 0.8)
        height: width
        focusPolicy: Qt.StrongFocus

        Behavior on width { NumberAnimation{ duration: 200} }

        BoxShadow {
            id: ishade
            x: - width  * 0.05
            y: x

            width:  ibox.width * 1.36
            height: width

            color: '#44000000'
            shadow {
                radius: 1.00
                offset: control.first.pressed  ? 0.64: 0.54
                spread: 0.05
            }

            Behavior on shadow.offset { NumberAnimation{ duration: 100} }
        }

        AdvancedRectangle {
            id: ibox
            width: parent.width
            height: parent.height

            radius: 0.5

            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.3); stop: Qt.vector2d(0,0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.1); stop: Qt.vector2d(1,1)}
            ]
        }
    }

    second.handle: T.Control {
        x: control.leftPadding + (control.horizontal ? control.second.visualPosition * (control.availableWidth - width) : (control.availableWidth - width) / 2)
        y: control.topPadding + (control.horizontal ? (control.availableHeight - height) / 2 : control.second.visualPosition * (control.availableHeight - height))

        implicitWidth:   20
        implicitHeight:  20

        width:  implicitWidth * (ibox2.visualFocus ? 1.0 : 0.8)
        height: width

        Behavior on width { NumberAnimation{ duration: 200} }

        BoxShadow {
            x: - width  * 0.05
            y: x

            width:  ibox2.width * 1.36
            height: width

            color: '#44000000'
            shadow {
                radius: 1.00
                offset: control.second.pressed ? 0.64: 0.54
                spread: 0.05
            }

            Behavior on shadow.offset { NumberAnimation{ duration: 100} }
        }

        AdvancedRectangle {
            id: ibox2
            width: parent.width
            height: parent.height

            radius: 0.5

            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.3); stop: Qt.vector2d(0,0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.1); stop: Qt.vector2d(1,1)}
            ]
        }
    }

    background: RoundedInEffect {
        x: (control.width   - width) / 2
        y: (control.height  - height) / 2

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
            radius: 1.00
            offset: 0.99
            spread: 0.40
            angle:  control.horizontal  ? 0.00 : 90.0
        }

        border { radius: width }
    }
}
