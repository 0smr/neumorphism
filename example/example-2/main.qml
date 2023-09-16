import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import Neumorphism 1.3

ApplicationWindow {
    id: window
    width: 200
    height: 200
    visible: true

    palette {
        base: "#456"
        button: "#456"
        window: '#456'

        text: "#def"
        windowText: "#def"
        buttonText: "#abc"

        highlight: "#abc"
        highlightedText: "#cde"
    }

    Column {
        anchors.centerIn: parent

        Button {
            width: 80
            checkable: true
            text: 'Test Button'
        }

        Button {
            width: 80
            highlighted: true
            text: 'Highlight'
        }
    }
}
