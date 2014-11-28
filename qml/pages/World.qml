import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.2
import harbour.fallingblocks.SailfishWidgets.Settings 1.2
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Controllers 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    property alias gameStatus: game
    property alias lives: player.lives
    property bool forceBackNavigation: false
    property bool initialized: false

    backNavigation: forceBackNavigation || (!playerControl.pressed && (!!settings ? !settings.disableSwipeToHome : true))
    id: world

    ApplicationSettings {
        id: settings
        applicationName: "harbour-fallingblocks"
        fileName: "settings"

        property int lives: UIConstants.settingsLivesDefault
        property bool disableSwipeToHome: false

        signal updatedSettings()

        onSettingsPropertyUpdated: updatedSettings()
        onSettingsInitialized: updatedSettings()

        onUpdatedSettings: {
            Console.info("World: settingsDisableSwipeChanged")
            if(settings.disableSwipeToHome == undefined) {
                playerControl.parent = player
            }

            Console.debug("World: settingsDisableSwipeChanged, disable is " + settings.disableSwipeToHome)

            playerControl.parent = settings.disableSwipeToHome ? world : player

            ////////
            Console.info("World: settingsLivesChanged")
            Console.debug("World: settingsLives initialized " + initialized)
            //Ignore if game's already in progress
            if(initialized) return

            Console.debug("World: settingsLives settings " + settings)

            if(settings.lives == undefined) {
                player.lives = UIConstants.livesDefault
                return
            }

            var settingsLives = settings.lives
            Console.debug("World: settingsLives JS " + settingsLives)
            if(settingsLives == UIConstants.settingsLivesDefault) {
                Console.trace("World: settingsLives " + UIConstants.livesDefault)
                player.lives = UIConstants.livesDefault
            } else if(settingsLives == UIConstants.settingsLivesEasy) {
                Console.trace("World: settingsLives " + UIConstants.livesEasy)
                player.lives = UIConstants.livesEasy
            } else if(settingsLives == UIConstants.settingsLivesInfinite) {
                Console.trace("World: settingsLives " + UIConstants.livesInfinite)
                player.lives = UIConstants.livesInfinite
            }

            Console.debug("World: settingsLives lives " + player.lives)
        }
    }

    Column {
        width: parent.width - Theme.paddingLarge * 2
        y: Theme.paddingLarge
        x: Theme.paddingLarge
        z: 1000

        InformationalLabel {
            anchors.right: parent.right
            text: levelStatus.score + "  " + qsTr("Score")
        }

        InformationalLabel {
            anchors.right: parent.right
            text: (lives == UIConstants.livesInfinite ? qsTr("∞") : lives) + "  " + qsTr("Lives")
        }
    }

    CreationController {
        animate: game.gameStarted
        id: createLoop
        interval: UIConstants.interval
        repeat: true
        spriteParent: world
        triggeredOnStart: true

        onObjectCompleted: {
            initialized = true
            //Create a new collision object
            Console.debug("World: Creating a collision detector for " + object)
            object.collision.interval = UIConstants.collisionInterval
            object.collision.repeat = true
            object.collision.triggeredOnStart = true
            object.collision.source = player
            object.collisionDetected.connect(function() {
                Console.debug("World: collision detected " + object)
                levelStatus.score += object.points
                if(lives != UIConstants.livesInfinite)
                  lives -= object.objectName === UIConstants.blockNameEvil? 1 : 0
                object.animate = false
                object.visible = false
                object.destroy()
            })
            object.collision.start()
        }
    }

    GameController {
        id: game
        onAppStatusChanged: {
            Console.info("World: Application active state is " + appStatus +
                         ", Qt.ApplicationActive " + Qt.ApplicationActive +
                         ", Qt.application.state " + Qt.application.state)
            if(!gameEnded && !gameStarted && pageStack.currentPage === world) {
                console.debug("World: navigating to title")
                forceBackNavigation = true
                pageStack.navigateBack()
                forceBackNavigation = false
            }
        }

        onGameStartedChanged: {
            Console.debug("World: Game Status: " + gameStarted)
            gameStarted ? createLoop.start() : createLoop.stop()
        }
    }

    Heading {
        anchors.centerIn: parent
        id: gameOver
        text: qsTr("Game Over")
        visible: gameEnded
        z: 1000
    }

    LevelController {
        id: levelStatus

        onLevelChanged: {
            Console.debug("World: levelStatus changed: " + level)
        }
    }


    MouseArea {
        anchors.fill: parent
        drag.target: player
        drag.axis: Drag.XAxis
        drag.minimumX: 0
        drag.maximumX: world.width - player.width
        enabled: !gameEnded
        id: playerControl

        onPressed: {
            Console.debug("World: player pressed")
        }
        onReleased: {
            Console.debug("World: player released")
        }
    }

    PlayerBlock {
        property int lives

        id: player
        x: (parent.width - width) / 2
        y: parent.height - height - Theme.paddingLarge

        onLivesChanged: {
            Console.debug("World: Lives " + lives)
            if(!lives) {
                game.endGame()
            }
        }
    }

    Component.onCompleted: Console.debug("World: created")
    Component.onDestruction: Console.debug("World: destroyed")
}
