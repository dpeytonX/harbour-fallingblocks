import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.Components 3.3
import harbour.fallingblocks.SailfishWidgets.JS 3.3

StandardCover {
    coverTitle: qsTr("Falling Blocks")
    imageSource: "qrc:///images/desktop.png"

    property bool inProgress
    signal startNewGame()

    Subtext {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: label.top
        anchors.bottomMargin: Theme.paddingSmall
        text: inProgress ? qsTr("In Progress") : ""
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
