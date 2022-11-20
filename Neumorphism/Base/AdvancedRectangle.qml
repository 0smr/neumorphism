// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import Neumorphism 1.0

Item {
    id: control

    property color color: '#aaa'
    property list<GradientColor> gradient
    property var radius: undefined

    ShaderEffect {
        id: effect
        width: control.width;
        height: control.height;

        readonly property bool hasGradient: gradient.length > 1;
        readonly property color color: control.color
        readonly property color c0: hasGradient ? gradient[0].color: "#fff";
        readonly property color c1: hasGradient ? gradient[1].color: "#fff";
        readonly property vector2d s0: hasGradient ? gradient[0].stop : Qt.vector2d(0,0);
        readonly property vector2d s1: hasGradient ? gradient[1].stop : Qt.vector2d(0,0);
        readonly property vector2d ratio: Qt.vector2d(width / Math.max(width, height),
                                                      height/ Math.max(width, height));
        readonly property vector4d radius: {
            let whMin = Math.min(ratio.x, ratio.y)/2;
            if(typeof control.radius == "number"){
                let rad = 0;
                rad = Math.min(Math.max(control.radius, 0.01), whMin);
                return Qt.vector4d(rad, rad, rad, rad);
            }
            else if(typeof control.radius == "object" && whMin > 0) {
                /*!
                 * I made advanced rectangle in order to make a rectangle with changeable radiuses and a basic gradient.
                 * radius points,  0 <= x,y,z,w <= 0.5
                 * - vector4d(x, y, z, w):
                 *  ╭───┬───╮
                 *  │ X │ Y │
                 *  ├───┼───┤
                 *  │ W │ Z │
                 *  ╰───┴───╯
                 *  ╭┐ ┌╮ ┌┐ ┌┐
                 *  └┘ └┘ └╯ ╰┘
                 *   X  Y  Z  W
                 */
                return Qt.vector4d(Math.min(Math.max(control.radius.x, 0.01), whMin),
                                    Math.min(Math.max(control.radius.y, 0.01), whMin),
                                    Math.min(Math.max(control.radius.z, 0.01), whMin),
                                    Math.min(Math.max(control.radius.w, 0.01), whMin));
            }
            else {
                return Qt.vector4d(0.0,0.0,0.0,0.0);
            }
        }
        /**
         * TODO: Allow radius variants to be more than 0.5, To do so, tie Y to the radius center point.
         *  ╭───┬─┐
         *  │ Y │ │
         *  ├───┼─┤
         *  └───┴─┘
         * BUG: I'm not sure why, but GLSL works without the "mod" function in this code "lowp int area = int(mod(-atan(", and I'm not sure why?!
         * Isn't there any overflow here?
         */

        fragmentShader: "
            uniform highp float qt_Opacity;
            varying highp vec2 qt_TexCoord0;
            uniform highp vec2 ratio;
            uniform lowp bool hasGradient;
            uniform highp vec4 radius;
            uniform highp vec4 color;
            uniform highp vec4 c0;
            uniform highp vec4 c1;
            uniform highp vec2 s0;
            uniform highp vec2 s1;

            void main() {
                // TextCoord is normalized based on item size.
                highp vec2 center = ratio / 2.0;
                highp vec2 coord = ratio * qt_TexCoord0;
                highp vec2 s0 = s0 * ratio;
                highp vec2 s1 = s1 * ratio;
                // This part sets the gradient color if one exists; otherwise, it just sets the color.
                if(hasGradient) {
                    highp float d = distance(s0,s1);
                    highp float angle = (s0.x - s1.x)/((s1.y - s0.y) == 0.0 ? 0.001 : s1.y - s0.y);
                    highp float line = angle * (coord.x - (s0.x+s1.x) / 2 ) + (s0.y + s1.y) / 2.0 - coord.y;
                    highp float dist = line / sqrt(angle * angle + 1.0);
                    highp float rotflag = (s0.y > s1.y) ? -1.0 : 1.0;
                    gl_FragColor = mix(c1, c0, smoothstep(0.0, 2.0 * d, rotflag * dist + d));
                } else {
                    gl_FragColor = color ;
                }
                // Create border radius.
                highp float radius[4] = float[4](radius.x, radius.y, radius.z, radius.w);
                highp int area = int(mod(-atan(coord.x - center.x, coord.y - center.y) * 0.636 + 3, 4.0));
                highp float dist = length(max(abs(center - coord) - center + radius[area], 0.0)) - radius[area];
                gl_FragColor = gl_FragColor * smoothstep(0.0, 0.01, - dist + 0.001) * qt_Opacity;
            }"
    }
}
