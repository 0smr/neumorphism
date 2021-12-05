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
T.Tumbler {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding)

    font {
        bold: true
        pixelSize: 12
    }

    palette.text: "gray"

    property real xrad: gapsize / 2 + 0.18 ;
    property real gapsize: implicitContentWidth / control.width;

    delegate: Text {
        text: modelData
        color: control.visualFocus ? control.palette.highlight : control.palette.text
        font: control.font
        opacity: Math.abs(Tumbler.displacement) / (control.visibleItemCount)
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }

    contentItem: PathView {
        id: pathView
        implicitWidth: 60
        implicitHeight: 200
        clip: true
        model: control.model
        delegate: control.delegate
        pathItemCount: control.visibleItemCount + 1
        path: Path {
            startX: control.contentItem.width / 2
            startY: -control.contentItem.delegateHeight / 2
            PathLine {
                x: control.contentItem.width / 2
                y: (control.visibleItemCount + 1) * control.contentItem.delegateHeight - control.contentItem.delegateHeight / 2
            }
        }
        property real delegateHeight: control.availableHeight / control.visibleItemCount
    }

    background: ShaderEffect {
        id: effect

        width:  parent.width;
        height: parent.height;

        readonly property color _shade: Qt.darker(control.palette.button, 1.1)
        readonly property color _highlight: Qt.lighter(control.palette.button, 1.1)
        readonly property real _xrad: control.xrad;
        readonly property real _gapsize: control.gapsize/2;

        fragmentShader: "
            #version 330
            varying highp vec2 qt_TexCoord0;
            uniform highp float qt_Opacity;
            uniform highp float _xrad;
            uniform highp float _gapsize;
            uniform highp vec2 ratio;
            uniform mediump vec4 _shade;
            uniform mediump vec4 _highlight;

            void main() {
                highp vec2 coord = qt_TexCoord0 - vec2(0.5);
                highp float h = smoothstep(0, 0.20, -abs(coord.x) + _xrad);
                highp float v = smoothstep(0, 0.50, -abs(coord.y) + 0.58);
                highp float gap = smoothstep(0, 0.01, abs(coord.x) - _gapsize);
                highp vec4 color = qt_TexCoord0.x > 0.5 ? _shade : _highlight;
                gl_FragColor = color * h * v * gap * qt_Opacity;
            }"
    }
}
