// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Controls 2.15

Control {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    enabled: running
    visible: running

    property real startDelay: 0
    property real maxDelay: 100
    property real duration: 1000
    property real gap: 10
    property bool running: false

    property Shadow shadow: Shadow {
        radius: width; offset: 7
        spread: 15; distance: 1.0
        angle: 20.0

    }

    contentItem: Item {
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
                running: control.running && control.visible
                loops: Animation.Infinite
                PauseAnimation { duration: control.startDelay }
                NumberAnimation { id: anim; from: 0; to: control.width; duration: 4000 }
                PauseAnimation { duration: control.maxDelay - control.startDelay }
            }
        }
    }

    onWidthChanged: anim.to = control.width
}

