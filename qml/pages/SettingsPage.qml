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

        Heading {text: qsTr("Mechanics")}

        ComboBox {
            id: livesSelect
            label: qsTr("Starting Lives")
            menu: ContextMenu {
                Repeater {
                    model: [qsTr("3"), qsTr("5"), qsTr("Infinite")]
                    StandardMenuItem {text: modelData}
                }
            }
            width: settingsPage.width //workaround for menu item display being cut

            onCurrentIndexChanged: {
                Console.info("Settings: lives index set to " + currentIndex)
                settings.lives = currentIndex
            }
        }

        Heading {text: qsTr("Miscellaneous")}

        TextSwitch {
            id: swipe
            text: qsTr("Disable Page Navigation in Game")

            onCheckedChanged: {
                Console.info("Settings: disable swipe set to " + checked)
                settings.disableSwipeToHome = checked
            }
        }
    }

    onSettingsChanged: {
        livesSelect.currentIndex = settings.lives
        swipe.checked = settings.disableSwipeToHome
    }
}
