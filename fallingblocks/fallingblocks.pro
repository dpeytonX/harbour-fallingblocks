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

PLATFORM = armv7hl

SSH_TARGET_NAME = $(MER_SSH_TARGET_NAME)
message ( "mer target is " $$SSH_TARGET_NAME )
#contains( SSH_TARGET_NAME, armv7hl ) {
#  message ( "compiling for Phone" )
#  PLATFORM = armv7hl
#}
message ( "platform is " $$PLATFORM )

LIBS += -L$$_PRO_FILE_PWD_/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings \
        -L$$_PRO_FILE_PWD_/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Core \
        -L$$_PRO_FILE_PWD_/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Language

INCLUDEPATH += harbour/fallingblocks/SailfishWidgets/include

SOURCES += src/$${TARGET}.cpp

OTHER_FILES += rpm/harbour-fallingblocks.changes.in \
    rpm/harbour-fallingblocks.spec \
    rpm/harbour-fallingblocks.yaml \
    translations/*.ts \
    harbour-fallingblocks.desktop

QML_IMPORT_PATH = .
QML2_IMPORT_PATH += $$_PRO_FILE_PWD_/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings

fallingblocks.files = harbour
fallingblocks.path = /usr/share/$${TARGET}
INSTALLS += fallingblocks


### Rename QML modules for Harbour store
swlc.path = /usr/share/$${TARGET}/harbour/fallingblocks
swlc.commands = find /home/deploy/installroot$$swl.path -name 'qmldir' -exec sed -i \"s/module SailfishWidgets/module harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets/\" \\{} \;;
swlc.commands += find /home/deploy/installroot$$swl.path -name '*.qmltypes' -exec sed -i \"s/SailfishWidgets/harbour\/fallingblocks\/SailfishWidgets\/armv7hl\/SailfishWidgets/\" \\{} \;;
#swlc.commands += rm -fr /home/deploy/installroot$$swl.path/SailfishWidgets/$${NOT_PLATFORM}
INSTALLS += swlc

fallingblockslibs.files = $$OUT_PWD/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Core/libcore.so.1 \
    $$OUT_PWD/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings/libapplicationsettings.so \
    $$OUT_PWD/harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Language/liblanguage.so
fallingblockslibs.path = /usr/share/$${TARGET}/lib
fallingblockslibs.commands = pushd /home/deploy/installroot/usr/share/$${TARGET}/lib;
fallingblockslibs.commands += ls ../harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings/;
fallingblockslibs.commands += cp ../harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Settings/libapplicationsettings.so .;
fallingblockslibs.commands += cp ../harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Core/libcore.so.1 .;
fallingblockslibs.commands += cp ../harbour/fallingblocks/SailfishWidgets/$${PLATFORM}/SailfishWidgets/Language/liblanguage.so .;
fallingblockslibs.commands += chmod 755 *;
fallingblockslibs.commands += popd;
INSTALLS += fallingblockslibs

# Linker instructions--The order of -L and -l is important
LIBS += -lapplicationsettings \
        -lcore \
        -llanguage

# to disable building translations every time, comment out the
# following CONFIG line
CONFIG += sailfishapp_i18n
TRANSLATIONS += translations/harbour-fallingblocks.ts \
                translations/harbour-fallingblocks-de.ts \
                translations/harbour-fallingblocks-ja.ts

RESOURCES += \
    images.qrc



