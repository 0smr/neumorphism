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
    title: 'example-3'

    Text {
        anchors.centerIn: parent
        text: 'There is no example here.'
    }
}
