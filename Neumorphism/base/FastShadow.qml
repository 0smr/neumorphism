// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://0smr.github.io

import QtQuick 2.12

Item {
    id: rootItem

    property variant source
    property real radius: 28
    property bool transparentBorder: false
    property color color: '#000'
    property bool cached: false

    ShaderEffectSource {
        id: cacheItem
        anchors.fill: shaderItem
        visible: rootItem.cached
        sourceItem: shaderItem
        live: true
        hideSource: visible
        smooth: rootItem.radius > 0
    }

    property string __internalBlurVertexShader: "qrc:/Neumorphism/shaders/fast-shadow-blur.vert.qsb"

    property string __internalBlurFragmentShader: "qrc:/Neumorphism/shaders/fast-shadow-blur.frag.qsb"

    ShaderEffectSource {
        id: proxy
        sourceItem: rootItem.source
        anchors.fill: rootItem
        visible: false
    }

    ShaderEffect {
        id: level0
        property variant source: proxy
        anchors.fill: parent
        visible: false
        smooth: true
    }

    ShaderEffectSource {
        id: level1
        width: Math.ceil(shaderItem.width / 32) * 32
        height: Math.ceil(shaderItem.height / 32) * 32
        sourceItem: level0
        hideSource: rootItem.visible
        sourceRect: transparentBorder ? Qt.rect(-64, -64, shaderItem.width, shaderItem.height) : Qt.rect(0, 0, 0, 0)
        visible: false
        smooth: rootItem.radius > 0
    }

    ShaderEffect {
        id: effect1
        property variant source: level1
        property real yStep: 1/height
        property real xStep: 1/width
        anchors.fill: level2
        visible: false
        smooth: true
        vertexShader: __internalBlurVertexShader
        fragmentShader: __internalBlurFragmentShader
    }

    ShaderEffectSource {
        id: level2
        width: level1.width / 2
        height: level1.height / 2
        sourceItem: effect1
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    ShaderEffect {
        id: effect2
        property variant source: level2
        property real yStep: 1/height
        property real xStep: 1/width
        anchors.fill: level3
        visible: false
        smooth: true
        vertexShader: __internalBlurVertexShader
        fragmentShader: __internalBlurFragmentShader
    }

    ShaderEffectSource {
        id: level3
        width: level2.width / 2
        height: level2.height / 2
        sourceItem: effect2
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    ShaderEffect {
        id: effect3
        property variant source: level3
        property real yStep: 1/height
        property real xStep: 1/width
        anchors.fill: level4
        visible: false
        smooth: true
        vertexShader: __internalBlurVertexShader
        fragmentShader: __internalBlurFragmentShader
    }

    ShaderEffectSource {
        id: level4
        width: level3.width / 2
        height: level3.height / 2
        sourceItem: effect3
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    ShaderEffect {
        id: effect4
        property variant source: level4
        property real yStep: 1/height
        property real xStep: 1/width
        anchors.fill: level5
        visible: false
        smooth: true
        vertexShader: __internalBlurVertexShader
        fragmentShader: __internalBlurFragmentShader
    }

    ShaderEffectSource {
        id: level5
        width: level4.width / 2
        height: level4.height / 2
        sourceItem: effect4
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    ShaderEffect {
        id: effect5
        property variant source: level5
        property real yStep: 1/height
        property real xStep: 1/width
        anchors.fill: level6
        visible: false
        smooth: true
        vertexShader: __internalBlurVertexShader
        fragmentShader: __internalBlurFragmentShader
    }

    ShaderEffectSource {
        id: level6
        width: level5.width / 2
        height: level5.height / 2
        sourceItem: effect5
        hideSource: rootItem.visible
        visible: false
        smooth: true
    }

    Item {
        id: dummysource
        width: 1
        height: 1
        visible: false
    }

    ShaderEffectSource {
        id: dummy
        width: 1
        height: 1
        sourceItem: dummysource
        visible: false
        smooth: false
        live: false
    }

    ShaderEffect {
        id: shaderItem

        property color color: rootItem.color
        property variant source1: level1
        property variant source2: level2
        property variant source3: level3
        property variant source4: level4
        property variant source5: level5
        property variant source6: level6
        property real lod: Math.sqrt(rootItem.radius) * 0.15 - 0.2 // sqrt(rootItem.radius / 64.0) * 1.2 - 0.2
        property real weight1
        property real weight2
        property real weight3
        property real weight4
        property real weight5
        property real weight6

        x: transparentBorder ? -64 : 0
        y: transparentBorder ? -64 : 0
        width: transparentBorder ? parent.width + 128 : parent.width
        height: transparentBorder ? parent.height + 128 : parent.height

        function weight(v) {
            if (v <= 0.0)
                return 1.0
            if (v >= 0.5)
                return 0.0

            return 1.0 - v * 2.0
        }

        function calculateWeights() {

            var w1 = weight(Math.abs(lod - 0.100))
            var w2 = weight(Math.abs(lod - 0.300))
            var w3 = weight(Math.abs(lod - 0.500))
            var w4 = weight(Math.abs(lod - 0.700))
            var w5 = weight(Math.abs(lod - 0.900))
            var w6 = weight(Math.abs(lod - 1.100))

            var sum = w1 + w2 + w3 + w4 + w5 + w6;
            weight1 = w1 / sum;
            weight2 = w2 / sum;
            weight3 = w3 / sum;
            weight4 = w4 / sum;
            weight5 = w5 / sum;
            weight6 = w6 / sum;

            upateSources()
        }

        function upateSources() {
            var sources = Array();
            var weights = Array();

            if (weight1 > 0) {
                sources.push(level1)
                weights.push(weight1)
            }

            if (weight2 > 0) {
                sources.push(level2)
                weights.push(weight2)
            }

            if (weight3 > 0) {
                sources.push(level3)
                weights.push(weight3)
            }

            if (weight4 > 0) {
                sources.push(level4)
                weights.push(weight4)
            }

            if (weight5 > 0) {
                sources.push(level5)
                weights.push(weight5)
            }

            if (weight6 > 0) {
                sources.push(level6)
                weights.push(weight6)
            }

            for (var j = sources.length; j < 6; j++) {
                sources.push(dummy)
                weights.push(0.0)
            }

            source1 = sources[0]
            source2 = sources[1]
            source3 = sources[2]
            source4 = sources[3]
            source5 = sources[4]
            source6 = sources[5]

            weight1 = weights[0]
            weight2 = weights[1]
            weight3 = weights[2]
            weight4 = weights[3]
            weight5 = weights[4]
            weight6 = weights[5]
        }

        Component.onCompleted: calculateWeights()

        onLodChanged: calculateWeights()

        fragmentShader: "qrc:/Neumorphism/shaders/fast-shadow.frag.qsb"
    }
}
