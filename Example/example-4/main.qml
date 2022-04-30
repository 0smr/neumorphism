import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15
import Neumorphism 1.0 as N

ApplicationWindow {
    id: window

    width: 200
    height: 320
    visible: true
    color: "#f0f0f0"

    Column {
        padding: 0
        spacing: 10
        anchors.fill: parent

        N.ComboBox {
            model: ['a', 'b', 'b', 'b', 'b', 'b']
            palette.button: window.color
        }

        ComboBox {
            id: combobox
            model: model
            palette.button: window.color
            displayText: model[highlightedIndex]

            delegate: ItemDelegate {
                width: ListView.view.width
                text: name
                palette.highlightedText: combobox.palette.highlightedText
                hoverEnabled: combobox.hoverEnabled
                background: Rectangle {
                    color: combobox.highlightedIndex === index ? combobox.palette.highlight : combobox.palette.button
                }
            }
        }

        ListModel {
            id: model
            ListElement { name: "A"; family: "A"}
            ListElement { name: "B"; family: "B"}
            ListElement { name: "C"; family: "C"}
        }
    }
}
