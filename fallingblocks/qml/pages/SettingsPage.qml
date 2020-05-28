import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Components 3.3
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Language 3.3
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Settings 3.3
import harbour.fallingblocks.FallingBlocks.JS 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    id: settingsPage

    ApplicationSettings {
        id: settings
        applicationName: "harbour-fallingblocks"
        fileName: "settings"

        property int lives: UIConstants.settingsLivesDefault
        property bool disableSwipeToHome: false
        property string locale: ""

    }

    InstalledLocales {
        id: installedLocales
        includeAppDefault: true
        appName: UIConstants.appName
        applicationDefaultText: qsTr("Application Default")
    }

    PageColumn {
        title: qsTr("Settings")

        Heading {
            text: qsTr("Mechanics")
        }

        ComboBox {
            currentIndex: settings.lives
            id: livesSelect
            label: qsTr("Starting Lives")
            menu: ContextMenu {
                Repeater {
                    model: [qsTr("3"), qsTr("5"), qsTr("Infinite")]
                    StandardMenuItem {
                        text: modelData
                    }
                }
            }
            width: settingsPage.width //workaround for menu item display being cut

            onCurrentIndexChanged: settings.lives = currentIndex
        }

        Heading {
            text: qsTr("Miscellaneous")
        }

        TextSwitch {
            checked: settings.disableSwipeToHome
            id: swipe
            text: qsTr("Disable Page Navigation in Game")

            onCheckedChanged: settings.disableSwipeToHome = checked
        }

        ComboBox {
            id: languageCombo
            description: qsTr("Switching languages requires an application restart")
            label: qsTr("Language")
            width: settingsPage.width

            menu: ContextMenu {
                Repeater {
                    model: installedLocales.locales
                    StandardMenuItem {
                        text: modelData.pretty
                        onClicked: settings.locale = modelData.locale
                    }
                }
            }
        }
    }

    onStatusChanged: {
        if(status == PageStatus.Active) {
            languageCombo.currentIndex = installedLocales.findLocale(settings.locale) == -1 ? 0 : installedLocales.findLocale(settings.locale)
        }
    }

}
