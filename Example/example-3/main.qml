import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15 as QQC

import Neumorphism 1.0

QQC.ApplicationWindow {
    id: window

    width: 290
    height: 520
    visible: true
    color: "#eeeeee"
    title: 'example-3'

    Column {
        anchors.centerIn: parent

        width: parent.width

        Button {
            x: (parent.width - width)/2
            checkable: true
            checked: true
        }

        Text {
            text: '\u2191\nCheckable button'
            width: parent.width
            horizontalAlignment: Text.AlignHCenter
            color: 'gray'
        }

        Item {
            width: 1
            height: 25
        }

        Text {
            padding: 5
            width: parent.width
            wrapMode: Text.WordWrap
            textFormat: Text.RichText
            horizontalAlignment: Text.AlignHCenter
            text: "There's nothing to see here.<br>
                  This example demonstrates how to include these components into your project.<br>
                  Include <code>Neumorphism.pri</code> in your <code>.pro</code> file,
                  then add <code>engine.addImportPath(\"qrc:/\");</code> into your <code>main.cpp</code> file."
        }
    }
}
