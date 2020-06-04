import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Components 3.3
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Utilities 3.3
import harbour.fallingblocks.FallingBlocks.JS 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    property bool inProgress: false
    signal startNewGame(bool immediate)
    signal quitGame
    signal goToWorld()

    SilicaListView {
        anchors.fill: parent

        PullDownMenu {
            StandardMenuItem {
                text: qsTr("Settings")
                onClicked: pageStack.push(settingsPage)
            }

            StandardMenuItem {
                text: qsTr("Quit Game")
                onClicked: quitGame()
                enabled: inProgress
            }
        }

        PushUpMenu {
            StandardMenuItem {
                text: qsTr("Help")
                onClicked: help.open()
            }

            StandardMenuItem {
                text: qsTr("About")
                onClicked: pageStack.push(aboutDialog)
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

        AboutPage {
            id: aboutDialog
            description: qsTr("Catch as many falling blocks as possible") +
            " BTC 3NeDGutmC7hc5Dv2cUX8YcvPWaUXZm3KAF"
            icon: UIConstants.appIcon
            application: UIConstants.appTitle + " " + UIConstants.appVersion
            copyrightHolder: UIConstants.appCopyright
            copyrightYear: UIConstants.appYear
            contributors: UIConstants.appAuthors
            licenses: UIConstants.appLicense
            pageTitle: UIConstants.appTitle
            projectLinks: UIConstants.appProjectInfo
        }
    }

    onGoToWorld: pageStack.navigateForward()
}
