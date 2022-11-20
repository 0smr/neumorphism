// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.Control {
    id: control

    property real value: 0
    property real pwidth: parent.width

    signal handlerValueChanged(var handler)
    signal removed(var handler)

    implicitWidth: 10
    implicitHeight: 15

    opacity: 1 - y / height

    onXChanged: value = (x + width/2) / parent.width
    onPwidthChanged: x = value * pwidth - width/2

    onValueChanged: handlerValueChanged(this)
    Component.onDestruction: { deleted }

    contentItem: Item {
        Rectangle {
            width: parent.width; height: width
            color: Qt.darker(control.palette.button)
            radius: width/2
        }

        Rectangle {
            x: (parent.width - width)/2
            width: 2; height: parent.height; radius: 2
            color: Qt.darker(control.palette.button)
            visible: control.y <= 0
        }
    }

    Behavior on y { NumberAnimation {duration: 100} }
    NumberAnimation on y { from: height; to: 0; duration: 100 }

    MouseArea {
        anchors.fill: parent;
        drag {
            target: parent;
            minimumX: -width/2; maximumX: parent.pwidth - width/2;
            axis: Drag.XAxis; threshold: 0;
        }
        onMouseYChanged: parent.y = mouseY + parent.y > height ? height : 0
        onReleased: if(mouseY > height) { parent.destroy(); }
    }
}
