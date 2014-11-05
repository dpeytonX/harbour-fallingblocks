import QtQuick 2.0
import QtQml 2.0
import Sailfish.Silica 1.0
import "../Logger.js" as Console
import "game/UIConstants.js" as UIConstants
import "game/objects"

Page {
    backNavigation: !playerControl.pressed
    id: world

    property int appStatus: Qt.application.state
    property bool gameStarted: false

    BlockA {
        animate: gameStarted
        speed: UIConstants.speed
        y: 0
        x: parent.width / 2

        onYChanged: {
            if(y > parent.height) {
                destroy()
            }
        }
    }

    PlayerBlock {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge
        x: (parent.width - width) / 2

        MouseArea {
            id: playerControl
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: world.width - parent.width
            onPressed: {
                Console.debug("World: player pressed")
            }
            onReleased: {
                Console.debug("World: player released")
            }
        }
    }

    onAppStatusChanged: {
        Console.info("World: Application active state is " + appStatus)
        gameStarted = appStatus === Qt.ApplicationActive && status === PageStatus.Active
    }

    onGameStartedChanged: {
        Console.debug("World: Game Status: " + gameStarted)
    }

    onStatusChanged: {
        gameStarted = status === PageStatus.Active
        Console.debug("World: new status is " + status)
    }
}
