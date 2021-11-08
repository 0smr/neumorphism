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

    AdvancedRectangle {
        id: aRect
        width:  100; height: 100
        anchors.centerIn: parent

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

    function toRange(v, a, b) {
        return b[0] + (Math.abs(v - a[0]) / Math.abs(a[0] - a[1])) * (b[1] - b[0]);
    }
}
