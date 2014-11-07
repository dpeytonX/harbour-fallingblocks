import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.1

//TODO: change page header text on game status
Page {
    property bool inProgress: false
    signal startNewGame(bool immediate)
    signal goToWorld()

    SilicaListView {
        anchors.fill: parent

        PullDownMenu {
            StandardMenuItem {
                text: qsTr("New Game")
                onClicked: startNewGame(true)
            }

            StandardMenuItem {
                text: qsTr("Help")
                onClicked: help.open()
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
    }

    onGoToWorld: pageStack.navigateForward()
}
