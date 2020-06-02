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

CONFIG(release, debug|release) {
 DEFINES += QT_NO_DEBUG_OUTPUT
}

PLATFORM = armv7hl

SSH_TARGET_NAME = $(MER_SSH_TARGET_NAME)
message ( "mer target is " $$SSH_TARGET_NAME )

QMAKE_LFLAGS += -Wl,-rpath,\\$${LITERAL_DOLLAR}$${LITERAL_DOLLAR}ORIGIN/../share/$${TARGET}/lib

LIBS += -L$$_PRO_FILE_PWD_/lib

INCLUDEPATH += harbour/fallingblocks/SailfishWidgets/include

SOURCES += src/$${TARGET}.cpp

OTHER_FILES += rpm/harbour-fallingblocks.changes.in \
    rpm/harbour-fallingblocks.spec \
    rpm/harbour-fallingblocks.yaml \
    translations/*.ts \
    harbour-fallingblocks.desktop \
    lib/libapplicationsettings.so \
    lib/libcore.so.1 \
    lib/liblanguage.so

QML_IMPORT_PATH = .
QML2_IMPORT_PATH += $$_PRO_FILE_PWD_/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings

# install exec
target.path = /usr/bin/
INSTALLS += target

# install lib
fallingblocks.files = harbour lib
fallingblocks.path = /usr/share/$${TARGET}
INSTALLS += fallingblocks

### Rename QML modules for Harbour store
swlc.path = /usr/share/$${TARGET}/harbour/fallingblocks
swlc.commands = find /home/deploy/installroot$$swl.path -name 'qmldir' -exec sed -i \"s/module SailfishWidgets/module harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets/\" \\{} \;;
swlc.commands += find /home/deploy/installroot$$swl.path -name '*.qmltypes' -exec sed -i \"s/SailfishWidgets/harbour\/fallingblocks\/SailfishWidgets\/armv7hl\/SailfishWidgets/\" \\{} \;;
#swlc.commands += rm -fr /home/deploy/installroot$$swl.path/SailfishWidgets/$${NOT_PLATFORM}
INSTALLS += swlc

# Linker instructions--The order of -L and -l is important
LIBS += -lsailfishapp \
        -lapplicationsettings \
        -lcore \
        -llanguage

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-fallingblocks.ts \
                translations/harbour-fallingblocks-ja.ts

RESOURCES += \
    images.qrc



