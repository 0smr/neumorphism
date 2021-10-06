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
import QtGraphicalEffects 1.0 as QGE10

// @disable-check M129
T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            implicitContentHeight + topPadding + bottomPadding)

    contentItem: Item {
        implicitWidth:  200
        implicitHeight: background.implicitHeight

        /*!
         * FIXME: my custom box shadow doesn't working fine here.
         * width changes effect height too.
         *
         * BoxShadow {
         *     id: ishade
         *     x: ibox.x
         *     y: ibox.y
         *
         *     width:  ibox.width  * 1.0
         *     height: ibox.height * 1.5
         *     color:  '#77000000'
         *
         *     shadow {
         *         radius: 1.0
         *         offset: 0.70
         *         spread: 0.20
         *     }
         * }
         */
        QGE10.RectangularGlow {
            x: ibox.x * 1.7
            y: ibox.y * 3.0

            width:  ibox.width  - x * 0.8
            height: ibox.height * 0.2

            color: '#77000000'
            spread: 0.0
            glowRadius: 4
        }

        AdvancedRectangle {
            id: ibox
            x: parent.height * 0.20
            y: x

            width:  (parent.width - 2.0 * y) * control.position
            height: parent.height - 2.0 * y

            /**
             * TODO: add indeterminate mode.
             * TODO: add mirrored mode.
             *
             * scale: control.mirrored ? -1 : 1
             * indeterminate: control.visible && control.indeterminate
             */

            radius: {
                let tailRad = Math.max(0.5 - width * (1.0 - control.position), 0.0);
                return Qt.vector4d(1.0 ,1.0 ,tailRad ,tailRad);
            }

            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.20); stop: Qt.vector2d(0.5,0.1)},
                GradientColor{color: Qt.darker (control.palette.button, 1.05); stop: Qt.vector2d(0.5,0.9)}
            ]
        }
    }

    background: RoundedInEffect {
        y: (control.height - height) / 2

        implicitWidth:  200
        implicitHeight: 16

        color: control.palette.button

        shadow {
            offset: 1.00
            radius: 1.00
            spread: 0.40
            angle:  0.00
        }

        border {
            radius: width * 0.5
        }
    }
}
