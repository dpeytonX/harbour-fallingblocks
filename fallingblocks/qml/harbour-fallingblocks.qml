import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Utilities 3.3
import harbour.fallingblocks.QmlLogger 2.0
import "cover"
import "pages"

ApplicationWindow {
    id: app
    property variant currentWorld
    property bool gameEnded: false
    property bool userInitiated: false
    signal pushWorld
    signal restart
    signal quit

    cover: CoverPage {
        app: app
        inProgress: main.inProgress
        onStartNewGame: {
            if (pageStack.find(function (page) {
                return page === currentWorld
            }))
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

        onQuitGame: {
            userInitiated = false
            gameEnded = true
            quit()
        }

        onGoToWorld: userInitiated = false
    }

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            object.gameStatus.gameEndedChanged.connect(function () {
                gameEnded = object.gameStatus.gameEnded
            })
            currentWorld = object
            pageStack.pushAttached(currentWorld)
            main.inProgress = false
            if (userInitiated)
                main.goToWorld()
        }

        onError: Console.error("app: could not create component " + errorString)
    }

    onRestart: {
        if (!pageStack.busy) {
            if (pageStack.currentPage !== currentWorld) {
                if (gameEnded) {
                    gameEnded = false
                    if (pageStack.find(function (page) {
                        return page === currentWorld
                    }))
                        pageStack.popAttached()
                    currentWorld.destroy()
                    pushWorld()
                }
            } else {
                main.inProgress = true
            }
        }
    }

    onQuit: {
        if (!pageStack.busy) {
            if (pageStack.currentPage !== currentWorld) {
                if (gameEnded) {
                    gameEnded = false
                    if (pageStack.find(function (page) {
                        return page === currentWorld
                    }))
                        pageStack.popAttached()

                    if(currentWorld != null)
                      currentWorld.destroy()

                    pushWorld()
                }
            } else {
                main.inProgress = false
            }
        }
    }

    onPushWorld: {
        var component = Qt.createComponent("pages/World.qml")
        loader.create(component, parent, {

                      })
        component.statusChanged.connect(loader.create)
    }

    Component.onCompleted: {
        Console.LOG_PRIORITY = Console.ERROR
        pushWorld()
        pageStack.busyChanged.connect(restart)
    }
}
