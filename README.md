# QML Neumorphism (soft UI) QtQuick style.
<p><img src="https://img.shields.io/github/v/tag/0smr/neumorphism?sort=semver&label=version&labelColor=0bd&color=07b" alt="version tag">
<img src="https://img.shields.io/github/license/0smr/neumorphism?color=36b245" alt="license">
<a href="https://www.blockchain.com/bch/address/bitcoincash:qrnwtxsk79kv6mt2hv8zdxy3phkqpkmcxgjzqktwa3">
<img src="https://img.shields.io/badge/BCH-Donate-f0992e?logo=BitcoinCash&logoColor=f0992e" alt="BCH donate"></a></p>

Start developing *Neumorphic QtQuick* applications using Neumorphism UI.<br>
The Neumorphic design concept has been applied to most of the components.

### What is Neumorphism?
[Wikipedia](https://en.wikipedia.org/wiki/Neumorphism)
> **Neumorphism** is a *design style* used in *graphical user interfaces*. It is commonly identified by a soft and light look (for which it is sometimes referred to as **soft UI**) with elements that appear to protrude from or dent into the background rather than float on top of it.

<!-- ## Preview
<div align="center">
</div> -->

## How to use

> **NOTE**<br>
> Using shaders in `Qt 6` requires compiling shaders to [`SPIR-V`](https://www.khronos.org/spir), which is quite different from the way it was done in `Qt 5`.<br>
> Therefore, shaders are currently not compatible with `Qt 6`.

## Contribution

Contributions are welcome.

Also if you are a designer with a better design idea, you can create an [issue](https://github.com/0smr/neumorphism) and let us discuss your idea.

### Usage

+ Clone the repository first.
    ```bash
    git clone "https://github.com/0smr/neumorphism.git"
    ```
+ Then add `neumorphism` to your makefile.
    * **QMake**: <sub>[example-1](example/example-1/example-1.pro#L7)</sub>
        ```make
        include("path/to/Neumorphism.pri")
        ```
    * **CMake**: <sub>[example-2](example/example-2/CMakeLists.txt#L30..L32)</sub>
        ```cmake
        add_subdirectory(path/to/Neumorphism/)
        target_link_libraries(${target-name} neumorphism)
        ```
+ Add `qrc:/` to the engine's import path.
    <sub>[example-1](example/example-1/main.cpp#L12)</sub>
    ```cpp
    engine.addImportPath("qrc:/");
    ```
+ Import the `Neumorphism` module.
    <sub>[example-1](example/example-1/main.qml#L6)</sub>
    ```qml
    import Neumorphism 1.3
    ```

If you are confused, please refer to [Example-1](Example/example-1/) for a clearer understanding of what you should do.

## Components

- Button
- Radio Button
- CheckBox
- Slider
- TextArea
- TextField
- ProgressBar
- RadioButton
- Switch
- RangeSlider
- SpinBox
- Tumbler
- Dial
- BusyIndicator
- SplitView
- StackView
- ComboBox
---
- NeumorphismView

## Issues

Please file an issue on [issues](https://github.com/0smr/neumorphism) if you have any problems.

## Documentation

no document provided yet.
