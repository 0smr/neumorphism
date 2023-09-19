// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.TextArea {
    id: control

    implicitWidth: Math.max(contentWidth + leftPadding + rightPadding,
                            implicitBackgroundWidth + leftInset + rightInset,
                            placeholder.implicitWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(contentHeight + topPadding + bottomPadding,
                             implicitBackgroundHeight + topInset + bottomInset,
                             placeholder.implicitHeight + topPadding + bottomPadding)

    padding: 6
    leftPadding: padding + 4

    color: control.palette.text
    placeholderTextColor: palette.mid
    selectionColor: control.palette.highlight
    selectedTextColor: control.palette.highlightedText

    Text {
        id: placeholder
        x: control.leftPadding
        y: control.topPadding
        width: control.width    - (control.leftPadding  + control.rightPadding)
        height: control.height  - (control.topPadding   + control.bottomPadding)

        text: control.placeholderText
        font: control.font

        color: control.placeholderTextColor

//        verticalAlignment: control.verticalAlignment
        visible: !control.length && !control.preeditText && (!control.activeFocus || control.horizontalAlignment !== Qt.AlignHCenter)
        elide:   Text.ElideRight
        renderType: control.renderType
    }

    background: NeumEffect {
        implicitWidth: 200
        implicitHeight: 40

        color: control.palette.button
        dark: Qt.darker(color, 1.5)
        light: Qt.lighter(color, 1.5)

        radius: 2
        inward: true

        opacity: 1 - color.hslLightness * 0.8

        angle: Math.atan((availableHeight - pad)/(availableWidth - pad)) * 57.295
        blend: spread; pad: 5; spread: 5

        background: Rectangle { color: control.palette.button }

        /*!
         * TODO: add active and visual focus effect
         * control.visualFocus
         * control.activeFocus
         */
    }
}
