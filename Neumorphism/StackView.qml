/****************************************************************************
** Copyright (C) 2021 smr.
** Contact: http://s-m-r.ir
**
** This file is part of the SMR Neumorphism Toolkit.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 3 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPLv3 included in the
** packaging of this file.
**
** This program is distributed in the hope that it will be useful,
** but WITHOUT ANY WARRANTY; without even the implied warranty of
** MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
**
** Please review the following information to
** ensure the GNU Lesser General Public License version 3 requirements
** will be met: https://www.gnu.org/licenses/lgpl.html.
**
****************************************************************************/

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
