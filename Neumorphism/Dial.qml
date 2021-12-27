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
import QtQuick.Controls 2.15
import Neumorphism 1.0

T.Dial {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)
    palette.base: '#aaa'

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
        x: (control.background.width - width)/2
        y: (control.background.height - height)/2

        width: control.width * 0.85
        height: control.height * 0.85
        borderWidth: 2.5
        dashWidth: 2
        dashCount: 51
        palette.base: control.palette.base
        rotation: control.angle * 1.07

        Rectangle {
            x: (parent.width - 2)/2
            y: - 2
            width: 2; height: 5
            color: parent.palette.base
        }
    }
}
