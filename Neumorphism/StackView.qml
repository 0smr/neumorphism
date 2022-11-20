// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtQuick.Templates 2.15  as T

T.StackView {
    id: control

    pushEnter: Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 700; easing.type: Easing.OutCubic }
    }

    pushExit: Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 700; easing.type: Easing.OutCubic }
    }

    popEnter : Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 700; easing.type: Easing.OutCubic }
    }

    popExit : Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 700; easing.type: Easing.OutCubic }
    }

    replaceEnter : Transition {
        NumberAnimation { property: "opacity"; from: 0; to: 1; duration: 700; easing.type: Easing.OutCubic }
    }

    replaceExit : Transition {
        NumberAnimation { property: "opacity"; from: 1; to: 0; duration: 700; easing.type: Easing.OutCubic }
    }
}
