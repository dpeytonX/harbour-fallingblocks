import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Controllers 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    backNavigation: !playerControl.pressed
    id: world

    property int appStatus: !!Qt.application.state ? Qt.application.state :
                                                     (Qt.application.active ? 0 : 1) //VM compat
    property bool gameStarted: false
    property bool initialized: false

    CreationController {
        animate: gameStarted
        id: createLoop
        interval: UIConstants.interval
        repeat: true
        triggeredOnStart: true

        onObjectCompleted: {
            //Create a new collision object
            Console.debug("World: Creating a collision detector for " + object)
            collisionTimer.createTimer(player, object)
        }
    }

    CollisionController {
        id: collisionTimer

        onObjectCompleted: {
            collision.timer.interval = UIConstants.collisionInterval
            collision.timer.repeat = true
            collision.timer.running = true
            collision.timer.triggeredOnStart = true
            collision.collisionDetected.connect(function() {
                Console.debug("World: collision detected " + collision)
                collision.stop()
                collision.target.animate = false
                collision.target.visible = false
                collision.target.destroy()
                collision.destroy()
            })
            gameStartedChanged.connect(function() {if(!!collision && !!collision.timer) collision.timer.running = gameStarted})
        }
    }

    PlayerBlock {
        id: player
        x: (parent.width - width) / 2
        y: parent.height - height - Theme.paddingLarge

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

    onAppStatusChanged: {
        Console.info("World: Application active state is " + appStatus)
        gameStarted = (!!Qt.ApplicationActive && appStatus === Qt.ApplicationActive || appStatus === 0)
                && status === PageStatus.Active
    }

    onGameStartedChanged: {
        Console.debug("World: Game Status: " + gameStarted)
        initialized = initialized ? true : gameStarted
        gameStarted ? createLoop.start() : createLoop.stop()
    }

    onStatusChanged: {
        gameStarted = status === PageStatus.Active
        Console.debug("World: new status is " + status)
    }
}
