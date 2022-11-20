import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: control
    property color selectedColor: '#f5f5f5'
    implicitWidth: 150

    function setColor (value, saturation) {
        value = value < 0 ? 0 : value > 1 ? 1 : value;
        saturation = saturation < 0 ? 0 : saturation > 1 ? 1 : saturation;
        control.selectedColor.hsvHue        = slider.value;
        control.selectedColor.hsvValue      = value;
        control.selectedColor.hsvSaturation = saturation;
    }

    Column {
        width: parent.width
        Rectangle {
            id: colorRect
            width: parent.width
            height: width

            gradient: Gradient {
                orientation: Gradient.Horizontal
                GradientStop { position: 0.0; color: "white" }
                GradientStop { position: 1.0; color: Qt.hsva(selectedColor.hsvHue,1,1,1) }
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "black" }
                }
            }

            Rectangle {
                anchors.fill: parent
                gradient: Gradient {
                    GradientStop { position: 0.0; color: "transparent" }
                    GradientStop { position: 1.0; color: "black" }
                }
            }

            MouseArea {
                anchors.fill: colorRect

                onPositionChanged: control.setColor(1 - mouseY/height, mouseX/width);
                onPressed: control.setColor(1 - mouseY/height, mouseX/width);
            }
        }

        Slider {
            id: slider
            width: 150;
            handle.width: 15;
            handle.height: 15;
            from: 0; to: 1;
            stepSize: 0.01;

            background: Rectangle {
                height: 5
                width: slider.width - (2 * x)
                x: slider.padding + slider.handle.width/2
                y: slider.height/2 - height/2
                color: control.selectedColor
                radius: height/2


                gradient: Gradient {
                    orientation: Gradient.Horizontal
                    GradientStop { position: 0.0; color: Qt.hsva(0.0,1,1,1) }
                    GradientStop { position: 0.1; color: Qt.hsva(0.1,1,1,1) }
                    GradientStop { position: 0.2; color: Qt.hsva(0.2,1,1,1) }
                    GradientStop { position: 0.3; color: Qt.hsva(0.3,1,1,1) }
                    GradientStop { position: 0.4; color: Qt.hsva(0.4,1,1,1) }
                    GradientStop { position: 0.5; color: Qt.hsva(0.5,1,1,1) }
                    GradientStop { position: 0.6; color: Qt.hsva(0.6,1,1,1) }
                    GradientStop { position: 0.7; color: Qt.hsva(0.7,1,1,1) }
                    GradientStop { position: 0.8; color: Qt.hsva(0.8,1,1,1) }
                    GradientStop { position: 0.9; color: Qt.hsva(0.9,1,1,1) }
                    GradientStop { position: 1.0; color: Qt.hsva(1.0,1,1,1) }
                }
            }

            onValueChanged: {
                control.selectedColor.hsvHue = value
            }
        }
    }
}
