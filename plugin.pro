TEMPLATE    = subdirs
SUBDIRS     = \
  Neumorphism   \
  example       \
  test

example.depends = Neumorphism
test.depends    = Neumorphism
