// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

pragma Singleton
import QtQuick 2.15

QtObject {
    function blend(color1, color2, alpha) {
        var color = color1;
        color.r = (color.r + color2.r) / 2;
        color.g = (color.g + color2.g) / 2;
        color.b = (color.b + color2.b) / 2;
        color.a = alpha;

        return color;
    }

    function clamp(x, a, b) {
        return Math.min(Math.max(x, a), b);
    }

    function remap(value, low1, high1, low2, high2) {
        return low2 + (high2 - low2) * (value - low1) / (high1 - low1);
    }

    function invertColor(color) {
        return Qt.rgba(1.0 - color.r, 1.0 - color.g, 1.0 - color.b, 1.0);
    }

    function alpha(color: color, alpha: real) {
        const {r,g,b} = color;
        return Qt.rgba(r, g, b, alpha);
    }
}
