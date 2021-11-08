#include "gooeyviewplugin.h"

void GooeyViewPlugin::registerTypes(const char *uri) {
    qmlRegisterType<GooeyView>(uri, 1, 0,"GooeyView");
}
