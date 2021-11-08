TEMPLATE    = lib
QT          += qml quick quickcontrols2
CONFIG      += qt plugin
TARGET      = gooeyviewplugin

include(Neumorphism.pri)

OTHER_FILES += \
        $$QML_FILES

qmlFiles.files = \
        qmldir \
        neumorphism.qmltypes

qmltypes.target = qmltypes
qmltypes.commands = $$[QT_INSTALL_BINS]/qmlplugindump Neumorphism 1.0 $$QMAKE_RESOLVED_TARGET > $$PWD/neumorphism.qmltypes
qmltypes.depends = $$QMAKE_RESOLVED_TARGET

QMAKE_EXTRA_TARGETS += qmltypes

InstallPath = $$PWD/../../Install/Neumorphism/
qmlFiles.path = $$InstallPath
target.path = $$InstallPath

INSTALLS += target qmlFiles
#load(qml_plugin)
