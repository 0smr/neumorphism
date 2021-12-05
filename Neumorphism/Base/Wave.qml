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
import QtQuick.Controls 2.15

Control {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property real startDelay: 0
    property real maxDelay: 100
    property real duration: 1000
    property real gap: 10
    property bool running: true

    property Shadow shadow: Shadow {
        radius: width; offset: 4
        spread: 10; distance: 1.0
        angle: 20.0
    }

    contentItem:
        Item {
            RoundedOutEffect {
                id: effect
                x: (control.availableWidth - width)/2
                y: (control.availableHeight - height)/2

                width: 0; height: width
                opacity: 2 * (1.0 - width / control.width)
                color: control.palette.button
                shadow {
                    distance: control.shadow.distance
                    radius: control.shadow.radius
                    offset: control.shadow.offset
                    spread: control.shadow.spread
                    angle: control.shadow.angle
                }

                RoundedInEffect {
                    anchors.centerIn: parent
                    width: parent.width - gap; height: width
                    color: control.palette.button
                    shadow {
                        distance: control.shadow.distance
                        radius: control.shadow.radius
                        offset: control.shadow.offset
                        spread: control.shadow.spread
                        angle: control.shadow.angle
                    }
                }

                SequentialAnimation on width {
                    id: anim
                    running: !control.running
                    loops: Animation.Infinite
                    PauseAnimation { duration: control.startDelay }
                    NumberAnimation { from: 0; to: control.width; duration: 4000 }
                    PauseAnimation { duration: control.maxDelay - control.startDelay }
                }
            }
            onWidthChanged: { anim.restart(); effect.width = 0}
        }
}

