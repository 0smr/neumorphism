// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.ProgressBar {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    property int orientation: Qt.Horizontal
    padding: 2

    QtObject {
        id: orientation
        property bool vertical: control.orientation == Qt.Vertical
        property bool horizontal: control.orientation == Qt.Horizontal
    }

    contentItem: Item {
        implicitWidth: background.implicitWidth
        implicitHeight: background.implicitHeight

        Rectangle {
            anchors.centerIn: parent
            width: parent.width
            height: parent.height
            color: 'transparent'
            clip: true
            Repeater {
                model: 3
                Wave {
                    anchors.centerIn: parent
                    width: Math.max(parent.width, parent.height)
                    height: width
                    duration: 4000
                    maxDelay: 1600
                    startDelay: index * 800
                    running: control.visible && control.indeterminate
                    gap: width * 0.1
                    shadow.angle: 90
                }
            }
        }

        BoxShadow {
            id: ishade
            anchors.bottom: ibox.bottom
            anchors.left: ibox.left
            anchors.bottomMargin: -5
            visible: control.position > 0.01 && !control.indeterminate

            width:  ibox.width  * (orientation.horizontal ? control.position : 1) + control.padding + 2
            height: ibox.height * (orientation.vertical ? control.position : 1) + control.padding + 2
            color:  '#77000000'

            shadow { radius: width; spread: 18 }
        }

        AdvancedRectangle {
            id: ibox

            width: parent.width
            height: parent.height

            /**
             * TODO: add indeterminate mode.
             * TODO: add mirrored mode.
             *
             * scale: control.mirrored ? -1 : 1
             */

            radius: 1.0;
            visible: false

            gradient: [
                GradientColor{
                    color: Qt.lighter(control.palette.button, 1.1)
                    stop: orientation.vertical ? Qt.vector2d(0.5,0.0) : Qt.vector2d(0.0, 1.0)
                },
                GradientColor{
                    color: control.palette.button
                    stop: orientation.vertical ? Qt.vector2d(0.5,0.5) : Qt.vector2d(0.5, 0.0)
                }
            ]
        }

        ShaderEffectSource {
            id: iboxClip
            x: 0; y: orientation.vertical ? clipHeight: 0

            width:  ibox.width - clipWidth
            height: ibox.height

            visible: control.visible && !control.indeterminate

            property real clipHeight: orientation.vertical ? ibox.height * (1.0 - control.position) : 0
            property real clipWidth: orientation.horizontal ? ibox.width * (1.0 - control.position) : 0

            sourceItem: ibox
            sourceRect: orientation.horizontal ? Qt.rect(0, 0, width, height) : Qt.rect(0, clipHeight, width, height)
        }
    }

    background: RoundedInEffect {
        implicitWidth:  orientation.vertical? 18 : 200
        implicitHeight: orientation.vertical? 200 : 16

        color: control.palette.button

        shadow {
            radius: width
            offset: 7
            spread: 10
            distance: 0.2
            angle:  orientation.vertical ? 90.0 : 0.00
        }
    }
}
