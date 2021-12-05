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
