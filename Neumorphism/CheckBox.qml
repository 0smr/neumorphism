// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import Neumorphism 1.0

T.CheckBox {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding,
                             indicator.height + topPadding + bottomPadding)
    property alias shadow: indicatorBackground.shadow
    palette.buttonText: 'gray'

    padding: 6
    spacing: 6

    indicator: RoundedInEffect {
        id: indicatorBackground

        implicitWidth:  28
        implicitHeight: 28

        shadow {
            offset: 5
            radius: 7
            spread: 8
            distance: 1.0
        }

        x: control.text ?
               (control.mirrored ?
                    control.width - width - control.rightPadding :
                    control.leftPadding) :
               control.leftPadding + (control.availableWidth - width) / 2

        y: control.topPadding + (control.availableHeight - height) / 2

        color: control.palette.button
        /*!
         * TODO: add active and visual focus effect
         * control.visualFocus
         * control.activeFocus
         */

        BoxShadow {
            id: ishade

            width: ibox.width + 6
            height: ibox.height + 6
            visible: ibox.width > 0
            color: '#44000000'
            anchors.centerIn: ibox
            shadow { radius: 10; spread: 10 }
        }

        AdvancedRectangle {
            id: ibox
            x: (parent.width - width) / 2
            y: (parent.height - height) / 2

            radius: 0.25
            gradient: [
                GradientColor{color: Qt.lighter(control.palette.button, 1.1); stop: Qt.vector2d(0.0,0.0)},
                GradientColor{color: control.palette.button; stop: Qt.vector2d(0.5,0.5)}
            ]
        }

        /*!
         * TODO: write a cleaner code.
         */
        states:[
            State {
                when: control.checkState === Qt.Checked
                PropertyChanges {
                    target: ibox
                    width: indicatorBackground.width * 0.75
                    height: indicatorBackground.height * 0.75
                }
            },
            State {
                when: control.checkState === Qt.Unchecked
                PropertyChanges { target: ibox; width: 0; height: 0 }
            },
            State {
                when: control.checkState === Qt.PartiallyChecked
                PropertyChanges {
                    target: ibox
                    width: indicatorBackground.width * 0.75
                    height: indicatorBackground.height * 0.20
                }
            }
        ]

        transitions: [
            Transition {
                from: "*"
                to: "*"
                NumberAnimation { properties: "width, height"; duration: 100 }
            }
        ]
    }

    contentItem: Text {
        leftPadding: control.indicator && !control.mirrored ? control.indicator.width + control.spacing : 0
        rightPadding: control.indicator && control.mirrored ? control.indicator.width + control.spacing : 0
        verticalAlignment: Text.AlignVCenter
        text: control.text
        font: control.font
        color: control.palette.buttonText
    }
}
