// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.12
import QtQuick.Controls 2.12

Control {
    id: control

    property real angle: 25
    property real radius: 15
    property color light: Qt.lighter(palette.button, 0.85 + priv.lightness/3)
    property color dark: Qt.darker(palette.button, 1.8 - priv.lightness/2)

    QtObject {
        id: priv
        property real lightness: control.palette.button.hslLightness
        property real radianAngle: control.angle / 57.2958
        property point center:  Qt.point(control.availableWidth/2, control.availableHeight/2)
    }

    implicitWidth: implicitContentWidth
    implicitHeight: implicitContentHeight

    background: Item {
        implicitWidth: control.implicitContentWidth
        implicitHeight: control.implicitContentHeight

        FastShadow {
            // http://blog.ivank.net/fastest-gaussian-blur.html
            x: 1.5 * Math.cos(priv.radianAngle)
            y: 1.5 * Math.sin(priv.radianAngle)
            width: parent.width; height: parent.height
            radius: control.radius
            source: contentItem
            color: control.dark
        }

        FastShadow {
            x: 1.5 * Math.cos(priv.radianAngle + 3.14)
            y: 1.5 * Math.sin(priv.radianAngle + 3.14)
            width: parent.width; height: parent.height
            radius: control.radius
            source: contentItem
            color: control.light
        }
    }

    contentItem: Item {}
}
