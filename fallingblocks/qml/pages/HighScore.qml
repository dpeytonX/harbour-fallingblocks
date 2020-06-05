import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Components 3.3
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Settings 3.3
import harbour.fallingblocks.FallingBlocks.JS 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0

Page {
    ApplicationSettings {
        id: settings
        applicationName: "harbour-fallingblocks"
        fileName: "settings"

        property int highScore1
        property int highScore2
        property int highScore3
        property int highScore4
        property int highScore5
    }

    SilicaFlickable {
        anchors.fill: parent
        contentHeight: column.height

    PullDownMenu {
        StandardMenuItem {
            text: qsTr("Reset")
            onClicked: {
                settings.highScore1 = 0
                settings.highScore2 = 0
                settings.highScore3 = 0
                settings.highScore4 = 0
                settings.highScore5 = 0
            }

        }

    }

    Column {
        id: column
        width: parent.width

        PageHeader {
            title: qsTr("High Scores")
        }

        Heading {
            text: qsTr("1.")
            font.pixelSize: Theme.fontSizeExtraLarge
        }
        InformationalLabel {
            text: settings.highScore1
            x: Theme.paddingMedium
        }
        Heading {
            text: qsTr("2.")
            font.pixelSize: Theme.fontSizeExtraLarge
        }
        InformationalLabel {
            text: settings.highScore2
            x: Theme.paddingMedium
        }
        Heading {
            text: qsTr("3.")
            font.pixelSize: Theme.fontSizeExtraLarge
        }
        InformationalLabel {
            text: settings.highScore3
            x: Theme.paddingMedium
        }
        Heading {
            text: qsTr("4.")
            font.pixelSize: Theme.fontSizeExtraLarge
        }
        InformationalLabel {
            text: settings.highScore4
            x: Theme.paddingMedium
        }
        Heading {
            text: qsTr("5.")
            font.pixelSize: Theme.fontSizeExtraLarge
        }
        InformationalLabel {
            text: settings.highScore5
            x: Theme.paddingMedium
        }
    }
    }
}
