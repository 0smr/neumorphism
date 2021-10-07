TEMPLATE    = subdirs
SUBDIRS     = \
        Neumorphism \
        Tests       \
        Example

Tests.depends   = Neumorphism
Example.depends = Neumorphism
