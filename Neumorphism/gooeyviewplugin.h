#ifndef GOOEYVIEWPLUGIN_H
#define GOOEYVIEWPLUGIN_H

#include <QQmlExtensionPlugin>
#include <qqml.h>
#include "gooeyview.h"

class GooeyViewPlugin : public QQmlExtensionPlugin {
    Q_OBJECT
    Q_PLUGIN_METADATA(IID QQmlExtensionInterface_iid)

public:
    void registerTypes(const char *uri) override;
};

#endif // GOOEYVIEWPLUGIN_H
