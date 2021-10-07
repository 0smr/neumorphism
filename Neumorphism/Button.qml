/****************************************************************************
**
** Copyright (C) 2021 smr.
** Contact: http://s-m-r.ir
**
** This file is part of the SMR Neumorphism Toolkit.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file. Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
****************************************************************************/

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import Neumorphism 1.0

// @disable-check M129
T.Button {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    spacing: 6

    icon.width: 24
    icon.height: 24
    icon.color: control.palette.buttonText

    display: AbstractButton.TextOnly

    palette.buttonText: 'gray'

    contentItem: Item {
        Grid {
            anchors.centerIn: parent
            spacing: control.display == AbstractButton.TextOnly ||
                     control.display == AbstractButton.IconOnly ? 0 : control.spacing

            flow: control.display == AbstractButton.TextUnderIcon ?
                      Grid.TopToBottom : Grid.LeftToRight
            layoutDirection: control.mirrored ? Qt.RightToLeft : Qt.LeftToRight

            opacity: control.down || control.checked ? 0.8 : 1.0

            Image {
                visible: control.display != AbstractButton.TextOnly
                source:  control.icon.source
                width:   control.icon.width
                height:  control.icon.height
                cache:   control.icon.cache
            }

            Text {
                visible: control.display != AbstractButton.IconOnly
                text:    control.text
                font:    control.font
                color:   control.palette.buttonText
                horizontalAlignment: Text.AlignHCenter
            }
        }
    }

    background:
        RoundedOutEffect {
            id: background
            visible: control.enabled && !control.flat

            implicitWidth:  50
            implicitHeight: 50

            color: control.palette.button

            border { radius: width; margin: width * 0.1 }

            shadow {
                radius:     1.00;
                offset:     control.down ? 0.68 :
                            control.checked ? 0.72 : 0.75;
                spread:     !control.enabled ? 0.70: 0.48;
                distance:   0.40;
                angle:      45.0;
                color1:     Qt.lighter(background.color, 1.30);
                color2:     Qt.darker (background.color, 1.20);
            }

            Behavior on shadow.offset {
                NumberAnimation { duration: 100 }
            }

            Rectangle {
                anchors.centerIn: parent
                width:  parent.width * 0.7
                height: width

                visible: control.highlighted
                color: 'transparent'
                radius: width/2
                opacity: 0.5
                border.color: Qt.tint(control.palette.highlight, "#12ffffff")
                border.width: width * 0.05
            }

            RoundedInEffect {
                x: parent.border.margin * 1.25
                y: x

                width:  parent.width - parent.border.margin * 2.5
                height: width
                color: control.palette.button

                shadow {
                    radius: 1.00
                    spread: control.checked? 0.92 : 1.00
                    offset: 1.0
                }

                Behavior on shadow.spread {
                    NumberAnimation{ duration: 100 }
                }
            }
        }
}
