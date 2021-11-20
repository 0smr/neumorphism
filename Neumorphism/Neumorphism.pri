# ls -R -1 **/*.qml | sed 's/^/$$PWD\//' | sed 's/$/ \\/'
QML_FILES += \
    $$PWD/Base/AdvancedRectangle.qml \
    $$PWD/Base/Border.qml \
    $$PWD/Base/BoxShadow.qml \
    $$PWD/Base/GradientColor.qml \
    $$PWD/Base/ItemShadow.qml \
    $$PWD/Base/RoundedInEffect.qml \
    $$PWD/Base/RoundedOutEffect.qml \
    $$PWD/Base/Shadow.qml \
    $$PWD/Button.qml \
    $$PWD/CheckBox.qml \
    $$PWD/Label.qml \
    $$PWD/Neumorphism.qml \
    $$PWD/ProgressBar.qml \
    $$PWD/RadioButton.qml \
    $$PWD/RangeSlider.qml \
    $$PWD/Slider.qml \
    $$PWD/SpinBox.qml \
    $$PWD/Switch.qml \
    $$PWD/TextArea.qml \
    $$PWD/TextField.qml \
    $$PWD/Tumbler.qml \
    $$PWD/HorizontalSeprator.qml \
    $$PWD/BusyIndicator.qml \
    $$PWD/SplitView.qml \
    $$PWD/Frame.qml \
    $$PWD/ComboBox.qml \
    $$PWD/SwipeView.qml

HEADERS += \
    $$PWD/gooeyview.h \
    $$PWD/gooeyviewplugin.h

SOURCES += \
    $$PWD/gooeyview.cpp \
    $$PWD/gooeyviewplugin.cpp














