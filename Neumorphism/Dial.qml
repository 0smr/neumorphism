// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import Neumorphism 1.0

T.Dial {
    id: control
    property alias dashRing: dashRing

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    background: RoundedOutEffect {
        implicitWidth: 184
        implicitHeight: 184

        shadow {
            offset: 8
            radius: width
            spread: control.enabled ? 8 : 12
            distance: 1.0
        }
    }

    handle: DashedRing {
        id: dashRing
        x: (control.background.width - width)/2
        y: (control.background.height - height)/2

        width: control.width - 25
        height: control.height - 25
        borderWidth: 2
        dashWidth: 2
        dashCount: 51
        palette.base: Qt.darker(control.palette.button, 1.3)
        rotation: control.angle * 1.07

        Rectangle {
            x: (parent.width - 2)/2 + 0.5
            y: -1
            width: 1; height: 5
            color: parent.palette.base
        }
    }
}
