import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Components 3.3
import harbour.fallingblocks.QmlLogger 2.0

//TODO: change page header text on game status
Page {
    property bool inProgress: false
    signal startNewGame(bool immediate)
    signal goToWorld()

    SilicaListView {
        anchors.fill: parent

        PullDownMenu {
            StandardMenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(settingsPage)
            }

            StandardMenuItem {
                text: qsTr("Help")
                onClicked: help.open()
            }

            StandardMenuItem {
                text: qsTr("New Game")
                onClicked: startNewGame(true)
            }
        }

        header: PageHeader { title: inProgress ? qsTr("In Progress") : qsTr("Start") }

        Label {
            anchors.centerIn: parent
            font.pixelSize: Theme.fontSizeLarge
            color: palette.highlightColor
            text: qsTr("Falling blocks")
        }

        Help {
            id: help
        }

        SettingsPage {
            id: settingsPage
        }
    }

    onGoToWorld: pageStack.navigateForward()
}
