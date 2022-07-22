TEMPLATE = lib
QT += qml quick quickcontrols2
CONFIG += qt plugin

include(Neumorphism.pri)

qmltypes.target = qmltypes
qmltypes.commands = $$[QT_INSTALL_BINS]/qmlplugindump Neumorphism 1.0 $$PWD/.. > $$PWD/neumorphism.qmltypes
qmltypes.depends = $$PWD

QMAKE_EXTRA_TARGETS += qmltypes
