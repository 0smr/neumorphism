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
import QtQuick.Templates 2.15  as T

// @disable-check M129
T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int orientation: Qt.Horizontal
    padding: 5

    QtObject {
        id: vars
        property bool vertical:     control.orientation == Qt.Vertical
        property bool horizontal:   control.orientation == Qt.Horizontal
    }

    contentItem: Item {
        implicitWidth:  background.implicitWidth
        implicitHeight: background.implicitHeight

        BoxShadow {
            id: ishade
            anchors.bottom: ibox.bottom
            anchors.left:   ibox.left
            anchors.bottomMargin: -5
            visible:        control.position > 0.01

            width:  ibox.width  * (vars.horizontal ? control.position : 1) + control.padding
            height: ibox.height * (vars.vertical   ? control.position : 1) + control.padding
            color:  '#77000000'

            shadow {
                radius: 1.00
                spread: 0.30 * 50
            }
        }

        AdvancedRectangle {
            id: ibox

            width:  parent.width
            height: parent.height

            /**
             * TODO: add indeterminate mode.
             * TODO: add mirrored mode.
             *
             * scale: control.mirrored ? -1 : 1
             * indeterminate: control.visible && control.indeterminate
             */

            radius:     1.0;
            visible:    false

            gradient: [
                GradientColor{
                    color: Qt.lighter(control.palette.button, 1.20);
                    stop: vars.vertical ? Qt.vector2d(-.1,0.5) : Qt.vector2d(0.5,0.1)
                },
                GradientColor{
                    color: Qt.darker (control.palette.button, 1.05);
                    stop: vars.vertical ? Qt.vector2d(1.1,0.5) : Qt.vector2d(0.5,0.9)
                }
            ]
        }

        ShaderEffectSource {
            id: iboxClip
            x: 0;
            y: vars.vertical   ? clipHeight: 0

            width:  ibox.width - clipWidth;
            height: ibox.height

            property real clipHeight: vars.vertical   ? ibox.height * (1.0 - control.position) : 0
            property real clipWidth:  vars.horizontal ? ibox.width  * (1.0 - control.position) : 0

            sourceItem: ibox
            sourceRect: vars.horizontal ? Qt.rect(0, 0, width, height) :
                                          Qt.rect(0, clipHeight, width, height)
        }
    }

    background: RoundedInEffect {
        implicitWidth:  vars.vertical? 18 : 200
        implicitHeight: vars.vertical? 200 : 16

        color: control.palette.button

        shadow {
            offset: 1.00
            radius: 1.00
            spread: vars.vertical ? 0.45 : 0.40
            angle:  vars.vertical ? 90.0 : 0.00
        }

        border {
            radius: width
        }
    }
}
