import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Components 1.2
import harbour.fallingblocks.SailfishWidgets.Settings 1.2
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Controllers 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Page {
    property int appStatus: !!Qt.application.state ? Qt.application.state :
                                                     (Qt.application.active ? 1 : 0) //VM compat
    property bool gameStarted: ((!!Qt.ApplicationActive && appStatus === Qt.ApplicationActive) || appStatus === 1)
                               && status === PageStatus.Active && !gameEnded
    property bool initialized: false
    property bool gameEnded: false
    property int score: 0
    property int lives
    property ApplicationSettings settings

    signal settingsLivesChanged();

    backNavigation: !playerControl.pressed
    id: world

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
            text: (lives == UIConstants.livesInfinite ? qsTr("∞") : lives) + "  " + qsTr("Lives")
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
            initialized = true
            //Create a new collision object
            Console.debug("World: Creating a collision detector for " + object)
            object.collision.interval = UIConstants.collisionInterval
            object.collision.repeat = true
            object.collision.triggeredOnStart = true
            object.collision.source = player
            object.collisionDetected.connect(function() {
                Console.debug("World: collision detected " + object)
                score += object.points
                if(lives != UIConstants.livesInfinite)
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

    LevelController {
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
        if(!gameEnded && !gameStarted && pageStack.currentPage === world) {
            console.debug("World: navigating to title")
            pageStack.navigateBack()
        }
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

    onSettingsChanged: {
        Console.info("World: settings changed")
        if(settings == undefined || settings.lives == undefined) {
            return
        }
        settingsLivesChanged() //initialize lives
        settings.livesChanged.connect(settingsLivesChanged)
    }

    onSettingsLivesChanged: {
        Console.info("World: settingsLivesChanged")
        Console.debug("World: settingsLives initialized " + initialized)
        //Ignore if game's already in progress
        if(initialized) return

        Console.debug("World: settingsLives settings " + settings)

        if(!!settings)
          Console.debug("World: settingsLives settings.lives " + settings.lives)

        if(settings == undefined || settings.lives == undefined) {
            lives = UIConstants.livesDefault
            return
        }

        var settingsLives = settings.lives
        Console.trace("World: settingsLives JS " + settingsLives)
        if(settingsLives == UIConstants.settingsLivesDefault) {
            Console.trace("World: settingsLives " + UIConstants.livesDefault)
            lives = UIConstants.livesDefault
        } else if(settingsLives == UIConstants.settingsLivesEasy) {
            Console.trace("World: settingsLives " + UIConstants.livesEasy)
            lives = UIConstants.livesEasy
        } else if(settingsLives == UIConstants.settingsLivesInfinite) {
            Console.trace("World: settingsLives " + UIConstants.livesInfinite)
            lives = UIConstants.livesInfinite
        }

        Console.debug("World: settingsLives lives " + lives)
    }

    Component.onCompleted: Console.debug("World: created")
    Component.onDestruction: Console.debug("World: destroyed")
}
