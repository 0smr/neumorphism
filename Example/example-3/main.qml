import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15 as QQC
import QtGraphicalEffects 1.0

import Neumorphism 1.0

QQC.ApplicationWindow {
    id: window

    width: 290
    height: 520
    visible: true
    color: "#eeeeee"

    GooeyView {
        id: gooeyEffect
        width:  parent.width;
        height: width - 0;
        color: '#67A3FF'
        spread: 0.54
        itemList: [
            rect1,
            rect2,
        ]
    }

    Rectangle {
        id: rect1
        x: (parent.width - width)/2; y: x
        width: 50; height: width;
        radius: 50
    }

    Rectangle {
        id: rect2
        x: 50; y: 50
        width: 50; height: width;
        radius: 50

        MouseArea {
            anchors.fill: parent
            drag.target: parent
        }
    }
}
