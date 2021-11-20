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

// @disable-check M129
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

    background: RoundedInEffect {
        implicitWidth: 200
        implicitHeight: 40

        color: control.palette.base
        /*!
         * TODO: add active and visual focus effect
         * control.visualFocus
         * control.activeFocus
         */
        shadow {
            distance: 0.5
            offset: 5
            radius: 5
            spread: 10
            angle: 25
        }
    }
}
