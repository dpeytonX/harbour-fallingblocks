import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Utilities 1.1
import harbour.fallingblocks.SailfishWidgets.Settings 1.1
import harbour.fallingblocks.QmlLogger 2.0
import "cover"
import "pages"

ApplicationWindow
{
    cover: CoverPage {
        inProgress: main.inProgress
        onStartNewGame: {
            Console.debug("app: received new world request from cover")
            if(pageStack.find(function(page) {return page === currentWorld}))
                pageStack.popAttached()
            main.startNewGame(false)
        }
    }

    initialPage: Main {
        id: main
        onStartNewGame: {
            Console.debug("app: starting new world with automatic push " + immediate)
            userInitiated = immediate
            gameEnded = true
            restart()
        }

        onGoToWorld: userInitiated = false
    }

    property variant currentWorld
    property bool gameEnded: false
    property bool userInitiated: false
    signal pushWorld()
    signal restart()

    ApplicationSettings {
        id: settings
        applicationName: "harbour-fallingblocks"
        fileName: "settings"

        property string dummy: "welcome"
    }

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            object.gameEndedChanged.connect(function() {
                gameEnded = object.gameEnded
            })
            currentWorld = object
            Console.debug("app: world completed " + currentWorld)
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
        Console.LOG_PRIORITY = Console.CRITICAL
        pushWorld()
        pageStack.busyChanged.connect(restart)
    }
}
