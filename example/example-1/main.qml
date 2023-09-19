import QtQuick 2.15
import QtQuick.Window 2.15
import QtQuick.Controls 2.15
import Qt.labs.settings 1.1

import Neumorphism 1.3

ApplicationWindow {
    id: window

    width: 260
    height: 450
    visible: true

    palette {
        base: '#333'
        button: '#333'
        window: '#333'
        highlight: '#23a7f2'


        text: '#abb'
        windowText: '#abb'
        buttonText: '#abb'
        highlightedText: '#abb'
    }

    component ColorBtn: Button {
        width: 30; height: width; text: '-'
        highlighted: true
        onClicked: {
            window.palette.base = palette.highlight
            window.palette.button = palette.highlight
            window.palette.window = palette.highlight

            window.palette.text = palette.buttonText
            window.palette.buttonText = palette.buttonText
            window.palette.windowText = palette.buttonText
        }
    }

    component VGrid: Grid {
        spacing: 10
        columns: 1; rows: -1
        horizontalItemAlignment: Qt.AlignHCenter
        Item {width: parent.width; height: 1}
    }

    Settings {
        id: settings
        fileName: 'config.conf'
        property alias wcolor: window.palette.window
        property alias wtcolor: window.palette.windowText
        property alias bcolor: window.palette.button
        property alias btcolor: window.palette.buttonText
        property alias cindex: swipView.currentIndex
    }

    Control {
        x: 5; y: window.height - height - 5; z: 3
        padding: 5
        contentItem: Row {
            ColorBtn { palette{highlight: '#a3d4d6';buttonText: '#515253'}}
            ColorBtn { palette{highlight: '#b0d0e9';buttonText: '#515253'}}
            ColorBtn { palette{highlight: '#06d6a0';buttonText: '#515253'}}
            ColorBtn { palette{highlight: '#d5b9ff';buttonText: '#515253'}}
            ColorBtn { palette{highlight: '#515255';buttonText: '#a4a5a6'}}
            ColorBtn { palette{highlight: '#edc9aa';buttonText: '#515253'}}
            ColorBtn { palette{highlight: '#d1d2d3';buttonText: '#545556'}}
            ColorBtn { palette{highlight: '#313233';buttonText: '#a4a5a6'}}
        }
    }

    SwipeView {
        id: swipView
        currentIndex: 0
        width: parent.width
        height: parent.height

        VGrid {
            spacing: 15

            Frame {
                Grid {
                    columns: 3
                    spacing: 10
                    Button {
                        width: 55
                        height: width
                        text: "Normal"
                    }

                    Button {
                        width: 55
                        height: width
                        text: "High\n-light"
                        highlighted: true
                    }

                    Button {
                        width: 55
                        height: width
                        text: "Check\n-able"
                        checkable: true
                    }

                    Button {
                        width: 55
                        height: width
                        text: "Flat Btn"
                        flat: true
                    }

                    Button {
                        width: 40
                        height: width
                        text: "Disabled\nBtn"
                        enabled: false
                    }

                    Button {
                        width: 40
                        height: width
                        text: "Small"
                    }
                }
            }

            Button {
                width: parent.width - 20
                height: 45
                text: "Wide Checkable Button"
                checkable: true
                font.family: 'carlito'
            }

            Row {
                CheckBox {
                    text: "Check\nbox"
                    tristate: true
                    font.family: 'carlito'
                }

                Switch {
                    text: "Switch"
                    font.family: 'carlito'
                }
            }

            Row {
                RadioButton {
                    text: "Radio 1"
                    font.family: 'carlito'
                }

                RadioButton {
                    text: "Radio 2"
                    font.family: 'carlito'
                }
            }

            Row {
                spacing: 5

                Text {
                    height: parent.height
                    text: "Busy Indicator \u2192"
                    color: window.palette.windowText
                    verticalAlignment: Text.AlignVCenter
                    font { family: 'carlito' }
                }

                Control {
                    width: 50; height: 50

                    contentItem: BusyIndicator {
                        running: false
                        TapHandler { onTapped: parent.running ^= true }
                    }

                    background: Rectangle {
                        color: 'transparent'
                        border.color: window.palette.buttonText
                        opacity: 0.5
                        radius: 5
                    }
                }
            }
        }

        VGrid {
            spacing: 5

            Label { text: "Progress Bar" }
            ProgressBar {
                width: parent.width
                value: slider1.value
            }

            Label { text: "Slider" }
            Slider {
                id: slider1
                width: parent.width
                value: 0.3
            }

            Label { text: "RangeSlider" }
            RangeSlider { width: parent.width }

            Label { text: "SpinBox" }
            SpinBox { to: 10 }

            Label { text: "TextArea" }
            TextArea {
                width: parent.width - 20
                text: 'Simple example of \nTextArea.'
            }

            Label { text: "TextField" }
            TextField {
                width: parent.width - 20
                text: 'Example text field.'
            }
        }

        VGrid {
            Label { text: "Dial" }

            Dial {
                width: 100
                height: 100
            }

            Label { text: "Tumbler" }

            Tumbler {
                model: 40
                height: 75
                visibleItemCount: 3
            }

            Label { text: "ComboBox" }

            ComboBox {
                id: comboBox
                model: 40
                editable: true
            }
        }

        VGrid {
            Label { text: "Dial" }

            NeumorphismView {
                contentItem: TextEdit {
                    rightPadding: 5; leftPadding: 5
                    text: 'Made\nBy\nSMR'

                    font.pixelSize: 85
                    font.bold: true
                    font.letterSpacing: -0

                    color: window.palette.button

                    cursorDelegate: Component {
                        Item {
                            Rectangle {
                                y: parent.height - 10
                                width: 5; height: 5; radius: 5
                                color: window.palette.button
                            }
                        }
                    }
                }
            }
        }
    }
}
