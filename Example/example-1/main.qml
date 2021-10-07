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
    color: "#78b6ca" // #78ca85

    FontLoader {
        id:     icoFont
        name:   "icoFont"
        source: "qrc:/resources/icofont.ttf"
    }

    Column {
        padding: 25
        spacing: 7
        Row {
            spacing: 10
            Button {
                width: 60; height: 60
                text: "Btn 1"
                palette.button: window.color
                palette.buttonText: Qt.darker(window.color, 1.5)
                font { family: icoFont.name; weight: Font.DemiBold; }
                onClicked: colorPickerW.visible = true
            }

            Button {
                width: 60; height: 60
                text: "Btn 2"
                palette.button: window.color
                palette.buttonText: Qt.darker(window.color, 1.5)
                highlighted: true
                font { family: icoFont.name; weight: Font.DemiBold; }
            }

            Button {
                width: 60; height: 60
                text: "Btn 3"
                palette.button: window.color
                palette.buttonText: Qt.darker(window.color, 1.5)
                checkable: true
                font { family: icoFont.name; weight: Font.DemiBold; }
            }
        }

        Row {
            CheckBox {
                text: "Check\nbox"
                palette.button: window.color
                palette.buttonText: Qt.darker(window.color, 1.5)
                font { family: icoFont.name; weight: Font.DemiBold; }
            }

            CheckBox {
                text: "Check\nbox"
                palette.button: window.color
                palette.buttonText: Qt.darker(window.color, 1.5)
                tristate: true
                font { family: icoFont.name; weight: Font.DemiBold; }
            }
        }

        RadioButton {
            text: "Check\nbox"
            palette.button: window.color
            palette.buttonText: Qt.darker(window.color, 1.5)
            font { family: icoFont.name; weight: Font.DemiBold; }
        }

        RadioButton {
            text: "Check\nbox"
            palette.button: window.color
            palette.buttonText: Qt.darker(window.color, 1.5)
            font { family: icoFont.name; weight: Font.DemiBold; }
        }

        ProgressBar {
            width: 180;
            palette.button: window.color
            value: slider1.value
        }

        Slider {
            id: slider1
            width: 180;
            palette.button: window.color
        }

        RangeSlider {
            width: 180;
            palette.button: window.color
        }

        SpinBox {
            palette.button: window.color
            font { family: icoFont.name; weight: Font.DemiBold; }
            palette.text: Qt.darker(window.color, 1.5)
        }

        Row {
            spacing: 10
            TextArea {
                width: 100
                palette.base: window.color
                text: 'text\narea'
                font { family: icoFont.name; weight: Font.DemiBold; }
                palette.text: Qt.darker(window.color, 1.5)
            }

            TextField {
                width: 100
                palette.base: window.color
                text: 'text field'
                font { family: icoFont.name; weight: Font.DemiBold; }
                palette.text: Qt.darker(window.color, 1.5)
            }
        }

        AdvancedRectangle {
            width:  50; height: 50
            color: Qt.darker(window.color, 1.5)
            radius: Qt.vector4d(0.0,0.3,0.1,0.5)
        }
    }

    Window {
        id: colorPickerW
        ColorPicker { id: colorPicker; onSelectedColorChanged: window.color = selectedColor }
        title: ''; flags: Qt.Tool;
        minimumWidth:   colorPicker.width; minimumHeight:  200
    }
}
