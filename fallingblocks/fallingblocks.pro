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
#CONFIG += c++11
#QMAKE_CXXFLAGS += "-std=c++0x"

PLATFORM = armv7hl
SSH_TARGET_NAME = $(MER_SSH_TARGET_NAME)
message ( "mer target is " $$SSH_TARGET_NAME )
contains( SSH_TARGET_NAME, armv7hl ) {
  message ( "compiling for Phone" )
  PLATFORM = armv7hl
}
message ( "platform is " $$PLATFORM )

LIBS += -L$$_PRO_FILE_PWD_/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings \
        -L$$_PRO_FILE_PWD_/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Core \
        -L$$_PRO_FILE_PWD_/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Language


INCLUDEPATH += ../thirdparty/SailfishWidgets/include

SOURCES += src/$${TARGET}.cpp

OTHER_FILES += qml/* \
    qml/cover/*.qml \
    qml/pages/* \
    rpm/harbour-fallingblocks.changes.in \
    rpm/harbour-fallingblocks.spec \
    rpm/harbour-fallingblocks.yaml \
    translations/*.ts \
    ../thirdparty/QmlLogger/* \
    ../thirdparty/SailfishWidgets/$${PLATFORM}/* \
    harbour-fallingblocks.desktop

QML_IMPORT_PATH = .
fallingblocks.files = harbour
fallingblocks.path = /usr/share/$${TARGET}
INSTALLS += fallingblocks

swl.files = ../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets
swl.path = /usr/share/$${TARGET}/harbour/fallingblocks
INSTALLS += swl

### Rename QML modules for Harbour store
swlc.path = /usr/share/$${TARGET}/harbour/fallingblocks
swlc.commands = find /home/deploy/installroot$$swl.path -name 'qmldir' -exec sed -i \"s/module Sail/module harbour.fallingblocks.Sail/\" \\{} \;;
swlc.commands += find /home/deploy/installroot$$swl.path -name '*.qmltypes' -exec sed -i \"s/SailfishWidgets/harbour\/fallingblocks\/SailfishWidgets/\" \\{} \;
INSTALLS += swlc

qmllogger.files = ../thirdparty/QmlLogger/qmldir ../thirdparty/QmlLogger/Logger.js
qmllogger.path = /usr/share/$${TARGET}/harbour/fallingblocks/QmlLogger
INSTALLS += qmllogger

#nemosynelibs.files = ../thirdparty/sailfish-widgets/src/qml/SailfishWidgets/Settings/libapplicationsettings* \
fallingblockslibs.files = $$OUT_PWD/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Core/libcore.so.1 \
    $$OUT_PWD/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings/libapplicationsettings.so \
    $$OUT_PWD/../thirdparty/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Language/liblanguage.so
fallingblockslibs.path = /usr/share/$${TARGET}/lib
#fallingblockslibs.commands = "pushd /home/deploy/installroot/usr/share/$${TARGET}/lib; ln -s ../harbour/fallingblocks/SailfishWidgets/Settings/libapplicationsettings.so .;  ln -s ../harbour/fallingblocks/SailfishWidgets/Core/libcore.so.1 .; ln -s ../harbour/fallingblocks/SailfishWidgets/Language/liblanguage.so .; popd"
fallingblockslibs.commands = "pushd /home/deploy/installroot/usr/share/$${TARGET}/lib; cp ../harbour/fallingblocks/SailfishWidgets/Settings/libapplicationsettings.so .;  cp ../harbour/fallingblocks/SailfishWidgets/Core/libcore.so.1 .; cp ../harbour/fallingblocks/SailfishWidgets/Language/liblanguage.so .; chmod 755 *; popd"
INSTALLS += fallingblockslibs

#nemosynelibs.files = ../thirdparty/sailfish-widgets/src/qml/SailfishWidgets/Settings/libapplicationsettings* \
#nemosynelibs.files = $$OUT_PWD/../thirdparty/sailfish-widgets/src/lib/core/libcore.so.1
#nemosynelibs.path = /usr/share/$${TARGET}/lib
#nemosynelibs.commands = "pushd /home/deploy/installroot/usr/share/$${TARGET}/lib; ln -s ../harbour/nemosyne/SailfishWidgets/Settings/libapplicationsettings.so ."
#INSTALLS += nemosynelibs

# Linker instructions--The order of -L and -l is important
LIBS += -lapplicationsettings \
        -lcore \
        -llanguage

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-fallingblocks-de.ts \
                translations/harbour-fallingblocks-ja.ts

RESOURCES += \
    images.qrc

DISTFILES +=


