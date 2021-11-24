import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: control
    property alias  slider: slider
    property alias  val:    slider.value
    property alias  label:  label.text

    width: row.width
    height: 18;

    Row {
        id: row
        leftPadding: 5
        spacing: 3

        width: childrenRect.width

        Text {text: slider.from;font.pixelSize: 9}

        Slider {
            id: slider
            padding: 0
            width:  120;
            height: 15;

            from:   0;
            to:     1.0;
            value:  to/2;

            ToolTip.text:       value.toFixed(2);
            ToolTip.visible:    pressed;

            handle.width:   15
            handle.height:  15

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.NoButton
                onWheel: {
                    slider.value -= wheel.angleDelta.y / 120 * slider.stepSize
                }
            }
        }
        Text        {text: slider.value.toFixed(2);font.pixelSize: 9}
        Rectangle   {width:1; height: parent.height; color: 'gray'}
        Text        {text: slider.from; font.pixelSize: 9}
        Text {id: label; font.pixelSize: 9}
    }
}


