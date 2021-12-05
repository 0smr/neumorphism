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

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            leftPadding + rightPadding,
                            leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                            topPadding + bottomPadding,
                            topPadding + bottomPadding)
    leftPadding: 6
    rightPadding: 6

    property var handlers: []
    property real from: 0
    property real to: 1
    property real stepSize: 0.1

    signal handlerValueChanged(var handler)
    signal handlerCreated(var handler)
    signal handlerRemoved(var handler)

    function handlerAt(index) {
        return 0 <= index && index <= handlers.length ? handlers[index] : undefined;
    }

    function valueAt(index) {
        return handlerAt(index).value * (to - from) + from;
    }

    function increment(index) {
        let val = handlerAt(index).value;
        handlerAt(index).value = Neumorphism.clamp(val + control.stepSize * Math.abs(to - from), 0, 1);
    }

    function decrement(index) {
        let val = handlerAt(index).value;
        handlerAt(index).value = Neumorphism.clamp(val + control.stepSize * Math.abs(to - from), 0, 1);
    }

    function clearAll() {
        for(let handler of handlers)
            handler.destroy();
    }

    Component {
        id: handlerComponennt
        Handler{}
    }

    contentItem: Item {
        MouseArea {
            id: mouseArea
            width: parent.width; height: parent.height/2
            onPressed: {
                const obj = handlerComponennt.createObject(parent, {x: mouseX - 5});
                obj.handlerValueChanged.connect(control.handlerValueChanged);
                obj.removed.connect(handlerRemoved)
                control.handlers.push(obj);
            }
        }
    }

    Component.onDestruction: {}

    background: Item {
        implicitWidth: 100
        implicitHeight: 30

        DashedRect {
            y: (parent.height - height)
            x: control.leftPadding - dashWidth

            width: parent.width - control.leftPadding - control.rightPadding + dashWidth * 2
            height: parent.height * 0.4

            dashCount: (width / 3).toFixed()
            dashWidth: 1.5

            palette.base: Qt.darker(control.palette.button)
        }
    }
}
