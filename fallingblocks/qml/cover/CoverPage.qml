import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Components 3.3
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.JS 3.3

StandardCover {
    coverTitle: qsTr("Falling Blocks")
    imageSource: "qrc:///images/desktop.png"

    property variant app
    property bool inProgress
    signal startNewGame()

    Subtext {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: label.top
        anchors.bottomMargin: Theme.paddingSmall
        text: inProgress ? qsTr("In Progress") : ""
    }

    Subtext {
        id: score
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: label.bottom
        anchors.topMargin: Theme.paddingSmall
        font.pixelSize: app.currentWorld != null && Math.abs(app.currentWorld.scores) > 99999 ? Theme.fontSizeExtraSmall : Theme.fontSizeSmall
        visible: inProgress
        text: qsTr("Score") + ": " + app.currentWorld.scores
    }

    Subtext {
        id: lives
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: score.bottom
        anchors.topMargin: Theme.paddingSmall
        visible: inProgress
        text: qsTr("Lives") + ": " + app.currentWorld.lives
    }

    CoverActionList {
        CoverAction {
            iconSource: IconThemes.iconCoverRefresh
            onTriggered: {
                Console.debug("CoverPage: new game action")
                startNewGame()
            }
        }
    }
}
