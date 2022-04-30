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
    color: "#eeeeee"
    title: 'example-2'

    function toRange(v, a, b) {
        return b[0] + (Math.abs(v - a[0]) / Math.abs(a[0] - a[1])) * (b[1] - b[0]);
    }

    Text {
        width: parent.width
        topPadding: 10
        color: 'gray'
        text: 'Advanced rectangle playground.'
        horizontalAlignment: Qt.AlignHCenter
    }

    Column {
        spacing: 10
        anchors.centerIn: parent

        AdvancedRectangle {
            id: aRect
            width:  100; height: 100

            color: Qt.darker(window.color, 1.5)
            radius: Qt.vector4d(
                            toRange(tla.x, [tlma.drag.minimumX, tlma.drag.maximumX], [0, 0.5]),
                            toRange(tra.x, [trma.drag.minimumX, trma.drag.maximumX], [0.5, 0]),
                            toRange(bra.x, [brma.drag.minimumX, brma.drag.maximumX], [0.5, 0]),
                            toRange(bla.x, [blma.drag.minimumX, blma.drag.maximumX], [0, 0.5]))

            Rectangle {
                id: tla
                y: x
                width: 5; height: 5; radius: 5;
                color: '#66000000'
                MouseArea {
                    id: tlma
                    anchors.fill: parent
                    drag {
                        target: parent; threshold: 0; axis: "XAxis"
                        minimumX: 0
                        maximumX: aRect.width/2 - width/2
                    }
                }
            }

            Rectangle {
                id: tra
                x: aRect.width - width
                y: aRect.width - width - x
                width: 5; height: 5; radius: 5;
                color: '#66000000'
                MouseArea {
                    id: trma
                    anchors.fill: parent
                    drag {
                        target: parent; threshold: 0; axis: "XAxis"
                        minimumX: aRect.width/2 - width/2
                        maximumX: aRect.width - width
                    }
                }
            }

            Rectangle {
                id: bla
                y: aRect.height - x - height
                width: 5; height: 5; radius: 5;
                color: '#66000000'
                MouseArea {
                    id: blma
                    anchors.fill: parent
                    drag {
                        target: parent; threshold: 0; axis: "XAxis"
                        minimumX: 0
                        maximumX: aRect.width/2 - width/2
                    }
                }
            }

            Rectangle {
                id: bra
                x: aRect.width - width
                y: x
                width: 5; height: 5; radius: 5;
                color: '#66000000'

                MouseArea {
                    id: brma
                    anchors.fill: parent
                    drag {
                        target: parent; threshold: 0; axis: "XAxis"
                        minimumX: aRect.width/2 - width/2
                        maximumX: aRect.width - width
                    }
                }
            }
        }

        AdvancedRectangle {
            width:  100; height: 100

            color: Qt.darker(window.color, 1.5)
            radius: vec4

            property vector4d vec4

            NumberAnimation on rotation {
                from: 0; to: 360
                loops: -1
                duration: 3333
            }

            Component.onCompleted: {
                radiusAnimation.createObject(this, {})
                vec4.x = 0.5
                vec4.y = 0.5
                vec4.z = 0.5
                vec4.w = 0.5
            }
        }
    }

    Component {
        id: radiusAnimation
        SequentialAnimation {
            property real expandDuration: 1500
            property real collapseDuration: 1500
            property Item target
            property string property
            loops: -1
            NumberAnimation {
                target: parent.target
                property: parent.property
                from: 0.3; to: 0.6
                duration: parent.expandDuration
            }
            NumberAnimation {
                target: parent.target
                property: parent.property
                from: 0.6; to: 0.3
                duration: parent.collapseDuration
            }
        }
    }
}
