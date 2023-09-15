// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.12
import QtQuick.Controls 2.12

Control {
    id: control

    property Shadow shadow: Shadow {
        angle: 25
        radius: 10
        color1: Qt.darker(control.palette.base, 1.3)
        color2: Qt.lighter(control.palette.base, 1.6)
    }

    QtObject {
        id: innerVars
        readonly property real radianAngle: control.shadow.angle / 57.2958
    }

    width: contentItem.implicitWidth
    height: contentItem.implicitHeight

    background: Item {

        width: control.implicitContentWidth
        height: control.implicitContentHeight

        FastShadow {
            // http://blog.ivank.net/fastest-gaussian-blur.html
            x: Math.cos(innerVars.radianAngle); y: Math.sin(innerVars.radianAngle)
            width: parent.width; height: parent.height
            radius: control.shadow.radius
            source: contentItem
            color: control.shadow.color1
        }

        FastShadow {
            x: 1.5 * Math.cos(innerVars.radianAngle + 3.14)
            y: 1.5 * Math.sin(innerVars.radianAngle + 3.14)
            width: parent.width; height: parent.height
            radius: control.shadow.radius
            source: contentItem
            color: control.shadow.color2
        }
    }

    contentItem: Item {}
}
