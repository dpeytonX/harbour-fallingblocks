import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.2
import harbour.fallingblocks.SailfishWidgets.Settings 1.2

//TODO: change page header text on game status
Page {
    property bool inProgress: false
    property ApplicationSettings settings
    signal startNewGame(bool immediate)
    signal goToWorld()

    SilicaListView {
        anchors.fill: parent

        PullDownMenu {
            StandardMenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(settingsPage, {"settings": settings})
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

        Heading {
            anchors.centerIn: parent
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
