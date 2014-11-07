# NOTICE:
#
# Application name defined in TARGET has a corresponding QML filename.
# If name defined in TARGET is changed, the following needs to be done
# to match new name:
#   - corresponding QML filename must be changed
#   - desktop icon filename must be changed
#   - desktop filename must be changed
#   - icon definition filename in desktop file must be changed
#   - translation filenames have to be changed

# The name of your application
TARGET = harbour-fallingblocks

CONFIG += sailfishapp

SOURCES += src/harbour-fallingblocks.cpp

OTHER_FILES += qml/* \
    qml/cover/*.qml \
    qml/pages/* \
    harbour/fallingblocks/* \
    rpm/harbour-fallingblocks.changes.in \
    rpm/harbour-fallingblocks.spec \
    rpm/harbour-fallingblocks.yaml \
    translations/*.ts \
    harbour-fallingblocks.desktop

QML_IMPORT_PATH = .
fallingblocks.files = harbour
fallingblocks.path = /usr/share/$${TARGET}
INSTALLS += fallingblocks

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-fallingblocks-de.ts \
                translations/harbour-fallingblocks-ja.ts

RESOURCES += \
    images.qrc

