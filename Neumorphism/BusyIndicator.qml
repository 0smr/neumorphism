// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15 as T

T.BusyIndicator {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    padding: 6
    running: false

    contentItem: Item {
        implicitWidth: 100
        implicitHeight: 100

        width: control.width
        height: control.height

        Wave { running: control.running; width: parent.width; height: parent.height; duration: 4000; maxDelay:800 ;startDelay: 0 }
        Wave { running: control.running; width: parent.width; height: parent.height; duration: 4000; maxDelay:800 ;startDelay: 400 }
        Wave { running: control.running; width: parent.width; height: parent.height; duration: 4000; maxDelay:800 ;startDelay: 800 }
    }
}
