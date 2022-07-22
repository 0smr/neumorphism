import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

import Neumorphism 1.2

ApplicationWindow {
    id: window

    width: 420
    height: 300
    visible: true
    color: "#f0f0f0"
    title: 'example-4'

    Column {
        padding: 0
        spacing: 10
        anchors.centerIn: parent

        NeumorphismView {
            id: neumorphismView

            shadow.angle: 65

            contentItem: Text {
                text: 'Neum'
                font.pixelSize: 85
                font.bold: true
                color: '#eee'
            }
        }

        Text {
            id: combobox
            text: 'neumorphism view will create two shadows behind\n' +
                  'the any Items which placed in contentItem to create a neumprphism effect.';
            width: parent.width
            color: '#666'
            horizontalAlignment: Text.AlignHCenter
        }
    }
}
