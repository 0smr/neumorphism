import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15 as QQC

import Neumorphism 1.1

QQC.ApplicationWindow {
    id: window

    width: 590
    height: 350
    visible: true
    color: "#e7eff9" // #78ca85

    palette.base: color
    palette.button: color
    palette.text: "#fff"
    palette.buttonText: "gray"
    palette.highlight: "#ff7a70"

    FontLoader {
        id: carlito
        source: "resources/Carlito-Regular.ttf"
    }

    Grid {
        flow: Grid.LeftToRight

        rows: flow == Grid.LeftToRight ? 1 : -1
        columns: flow == Grid.LeftToRight ? -1 : 1

        padding: 25
        spacing: 25

        Column {
            spacing: 10
            Row {
                spacing: 10
                Button {
                    width: 60; height: 60
                    text: "Color\npicker"
                    font.family: carlito.name
                    onClicked: colorPickerW.visible = true
                }

                Button {
                    width: 60; height: 60
                    text: "Btn 2"
                    highlighted: true
                    font { family: carlito.name; weight: Font.Medium; }
                }

                Button {
                    width: 60; height: 60
                    text: "Btn 3"
                    checkable: true
                    font.family: carlito.name
                }
            }

            Row {
                CheckBox {
                    text: "Check\nbox"
                    font.family: carlito.name
                }

                CheckBox {
                    text: "Check\nbox"
                    tristate: true
                    font.family: carlito.name
                }
            }

            Row {
                Switch {
                    text: "Check\nbox"
                    font.family: carlito.name
                }

                Switch {
                    text: "Check\nbox"
                    font.family: carlito.name
                }
            }

            Row {
                RadioButton {
                    text: "Radio Btn"
                    font.family: carlito.name
                }

                RadioButton {
                    text: "Radio Btn"
                    font.family: carlito.name
                }
            }

            Row {
                spacing: 5
                Text {
                    height: parent.height
                    text: "Busy Indicator \u2192"
                    color: window.palette.buttonText
                    verticalAlignment: Text.AlignVCenter
                    font { family: carlito.name }
                }

                BusyIndicator {
                    width: 100
                    height: 100
                    running: true

                    Rectangle {
                        anchors.fill: parent
                        color: 'transparent'
                        radius: 6
                        border.width: 1
                        border.color: Qt.darker(window.palette.base, 1.1)
                    }
                }
            }
        }

        Rectangle {
            width: 1
            height: window.height - 45
            color: '#000'
            opacity: 0.1
        }

        Column {
            spacing: 7
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
                font.family: carlito.name
                palette.text: Qt.darker(window.color, 1.5)
            }

            Column {
                spacing: 10
                TextArea {
                    width: 180
                    palette.base: window.color
                    text: 'Example of how TextArea works on\nqml neumorphism style.'
                    font.family: carlito.name
                    palette.text: Qt.darker(window.color, 1.5)
                }

                TextField {
                    width: 180
                    palette.base: window.color
                    text: 'neumorphism text field.'
                    font.family: carlito.name
                    palette.text: Qt.darker(window.color, 1.5)
                }
            }
        }

        Rectangle {
            width: 1
            height: window.height - 45
            color: '#000'
            opacity: 0.1
        }

        Column {
            Text {
                width: parent.width
                text: "Dial"
                color: window.palette.buttonText
                horizontalAlignment: Text.AlignHCenter
                font.family: carlito.name
            }

            Dial {
                width: 100
                height: 100
            }
        }
    }

    Window {
        id: colorPickerW
        ColorPicker { id: colorPicker; onSelectedColorChanged: window.color = selectedColor }
        title: ''; flags: Qt.Tool;
        minimumWidth:   colorPicker.width; minimumHeight:  200
    }
}
