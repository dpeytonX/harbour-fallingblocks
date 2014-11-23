import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.2
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Controllers 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    backNavigation: !playerControl.pressed
    id: world

    property int appStatus: !!Qt.application.state ? Qt.application.state :
                                                     (Qt.application.active ? 1 : 0) //VM compat
    property bool gameStarted: ((!!Qt.ApplicationActive && appStatus === Qt.ApplicationActive) || appStatus === 1)
                               && status === PageStatus.Active && !gameEnded
    property bool gameEnded: false
    property int score: 0
    property int lives: 3 //This should eventually come from application settings

    Column {
        width: parent.width - Theme.paddingLarge * 2
        y: Theme.paddingLarge
        x: Theme.paddingLarge
        z: 1000

        InformationalLabel {
            anchors.right: parent.right
            text: score + "  " + qsTr("Score")
        }

        InformationalLabel {
            anchors.right: parent.right
            text: lives + "  " + qsTr("Lives")
        }
    }

    CreationController {
        animate: gameStarted
        id: createLoop
        interval: UIConstants.interval
        repeat: true
        spriteParent: world
        triggeredOnStart: true

        onObjectCompleted: {
            //Create a new collision object
            Console.debug("World: Creating a collision detector for " + object)
            object.collision.interval = UIConstants.collisionInterval
            object.collision.repeat = true
            object.collision.triggeredOnStart = true
            object.collision.source = player
            object.collisionDetected.connect(function() {
                Console.debug("World: collision detected " + object)
                score += object.points
                lives -= object.objectName === UIConstants.blockNameEvil? 1 : 0
                object.animate = false
                object.visible = false
                object.destroy()
            })
            object.collision.start()
        }
    }

    Heading {
        anchors.centerIn: parent
        id: gameOver
        text: qsTr("Game Over")
        visible: gameEnded
        z: 1000
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
            enabled: !gameEnded
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
        Console.info("World: Application active state is " + appStatus +
                     ", Qt.ApplicationActive " + Qt.ApplicationActive +
                     ", Qt.application.state " + Qt.application.state)
    }

    onGameStartedChanged: {
        Console.debug("World: Game Status: " + gameStarted)
        gameStarted ? createLoop.start() : createLoop.stop()
    }

    onLivesChanged: {
        Console.debug("World: Lives " + lives)
        if(!lives) {
            // Game Over
            gameStarted = false
            gameEnded = true
        }
    }

    Component.onCompleted: Console.debug("World: created")
    Component.onDestruction: Console.debug("World: destroyed")
}
