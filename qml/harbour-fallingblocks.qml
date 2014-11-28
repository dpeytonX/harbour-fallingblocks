import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Utilities 1.2
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.FallingBlocks 1.0
import "cover"
import "pages"

ApplicationWindow
{
    property variant currentWorld
    property bool gameEnded: false
    property bool userInitiated: false
    signal pushWorld()
    signal restart()

    cover: CoverPage {
        inProgress: main.inProgress
        onStartNewGame: {
            if(pageStack.find(function(page) {return page === currentWorld}))
                pageStack.popAttached()
            main.startNewGame(false)
        }
    }

    initialPage: Main {
        id: main
        onStartNewGame: {
            userInitiated = immediate
            gameEnded = true
            restart()
        }

        onGoToWorld: userInitiated = false
    }

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            object.gameStatus.gameEndedChanged.connect(function() {
                gameEnded = object.gameStatus.gameEnded
            })
            currentWorld = object
            pageStack.pushAttached(currentWorld)
            main.inProgress = false
            if(userInitiated) main.goToWorld()
        }

        onError: Console.error("app: could not create component " + errorString)
    }

    onRestart: {
        if(!pageStack.busy) {
            if(pageStack.currentPage !== currentWorld) {
                if(gameEnded) {
                    gameEnded = false
                    if(pageStack.find(function(page) {return page === currentWorld}))
                        pageStack.popAttached()
                    currentWorld.destroy()
                    pushWorld()
                }
            } else {
                main.inProgress = true
            }
        }
    }

    onPushWorld: {
        var component = Qt.createComponent("pages/World.qml")
        loader.create(component, parent, {})
        component.statusChanged.connect(loader.create)
    }

    Component.onCompleted:  {
        Console.LOG_PRIORITY = Console.ERROR
        pushWorld()
        pageStack.busyChanged.connect(restart)
    }
}
