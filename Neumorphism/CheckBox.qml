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
                             implicitIndicatorHeight + topPadding + bottomPadding,
                             indicator.height + topPadding + bottomPadding)
    property alias shade: ishade.shadow
    property point xy
    palette.buttonText: 'gray'

    padding: 6
    spacing: 6

    indicator: RoundedInEffect {
        id: indicatorBack

        implicitWidth:  28
        implicitHeight: 28

        shadow {
            offset: 0.8
            radius: 0.5
            spread: 0.6
        }

        border {
            radius: width * 0.2
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
            x: ibox.x * 0.88
            y: ibox.y * 0.88

            width:  ibox.width * 1.24
            height: ibox.height* 1.24
            color: '#21000000'

            shadow {
                radius: 0.37
                offset: 0.74
                spread: 0.10
            }
        }

        AdvancedRectangle {
            id: ibox
            x: (parent.width  - width) / 2
            y: (parent.height - height) / 2

            width:  parent.width  * 0.75
            height: width

            radius: 0.20
            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.1);  stop: Qt.vector2d(0.0,0.0)},
                GradientColor{color: Qt.darker (control.palette.button, 1.02);  stop: Qt.vector2d(0.6,0.6)}
            ]
        }

        /*!
         * TODO: write a cleaner code.
         */
        states:[
            State {
                when: control.checkState === Qt.Unchecked
                PropertyChanges { target: ishade; width: 0;} // It also make height = 0
                PropertyChanges { target: ibox;   width: 0;}
            },
            State {
                when: control.checkState === Qt.PartiallyChecked
                PropertyChanges { target: ishade; height: control.indicator.height * 0.40}
                PropertyChanges { target: ibox;   height: control.indicator.height * 0.20}
            }
        ]

        transitions: [
            Transition {
                from:   "*"
                to:     "*"
                NumberAnimation { properties: "width, height"; duration: 100 }
            }
        ]
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
