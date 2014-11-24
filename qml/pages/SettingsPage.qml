import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.2
import harbour.fallingblocks.SailfishWidgets.Settings 1.2
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    id: settingsPage

    property ApplicationSettings settings

    PageColumn {
        title: qsTr("Settings")

        Subtext {text: qsTr("Starting Lives")}

        ComboBox {
            id: livesSelect
            label: qsTr("Lives")
            menu: ContextMenu {
                Repeater {
                    model: [qsTr("3"), qsTr("5"), qsTr("Infinite")]
                    StandardMenuItem {text: modelData}

                    Component.onCompleted: {
                        livesSelect.currentIndex = !!settings ? settings.lives : livesSelect.currentIndex
                    }
                }
            }
            width: settingsPage.width //workaround for menu item display being cut

            onCurrentIndexChanged: {
                Console.info("Settings: lives index set to " + currentIndex)
                settings.lives = currentIndex
            }
        }
    }

    onSettingsChanged: livesSelect.currentIndex = settings.lives
}
