import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Controllers 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    backNavigation: !playerControl.pressed
    id: world

    property int appStatus: Qt.application.state
    property bool gameStarted: false

    PlayerBlock {
        anchors.bottom: parent.bottom
        anchors.bottomMargin: Theme.paddingLarge
        x: (parent.width - width) / 2

        MouseArea {
            anchors.fill: parent
            drag.target: parent
            drag.axis: Drag.XAxis
            drag.minimumX: 0
            drag.maximumX: world.width - parent.width
            id: playerControl
            onPressed: {
                Console.debug("World: player pressed")
            }
            onReleased: {
                Console.debug("World: player released")
            }
        }
    }

    CreationController {
        animate: gameStarted
        interval: UIConstants.interval
        speed: UIConstants.speed
        running: gameStarted
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
