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
    palette.text: "#fff"

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
                onClicked: colorAnimation.running = true;
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

        HorizontalSeprator {
            height: 50
            width: 180
            a: 0.1
            spread: 0.8
            palette.base: Qt.lighter(window.color, 1.1)
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
    }

    Window {
        id: colorPickerW
        ColorPicker { id: colorPicker; onSelectedColorChanged: window.color = selectedColor }
        title: ''; flags: Qt.Tool;
        minimumWidth:   colorPicker.width; minimumHeight:  200
    }

    SequentialAnimation on color {
        id: colorAnimation
        running: false
        ColorAnimation { to: "#e7e7e7"; duration: 1000}
        PauseAnimation { duration: 500 }
        ColorAnimation { to: "#dc9797"; duration: 1000}
        PauseAnimation { duration: 500 }
        ColorAnimation { to: "#d297dc"; duration: 1000}
        PauseAnimation { duration: 500 }
        ColorAnimation { to: "#dbc19a"; duration: 1000}
        PauseAnimation { duration: 500 }
        ColorAnimation { to: "#78ca85"; duration: 1000}
        PauseAnimation { duration: 500 }
        ColorAnimation { to: "#78b6ca"; duration: 1000}
    }
}
