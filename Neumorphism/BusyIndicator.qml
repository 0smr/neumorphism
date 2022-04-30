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
