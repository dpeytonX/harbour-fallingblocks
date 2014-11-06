import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.SailfishWidgets.Utilities 1.1
import harbour.fallingblocks.QmlLogger 2.0
import "pages"


ApplicationWindow
{
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    initialPage: Component { Main {} }

    property variant currentWorld
    property bool gameEnded: false
    signal pushWorld()
    signal restart()

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            object.gameEndedChanged.connect(function() {
                gameEnded = object.gameEnded
            })
            currentWorld = object
            Console.debug("app: world completed " + currentWorld)
            pageStack.pushAttached(currentWorld)
            pageStack.busyChanged.connect(restart)
        }

        onError: Console.log("app: could not create component " + errorString)
    }

    onRestart: {
        if(!pageStack.busy && pageStack.currentPage !== currentWorld && gameEnded) {
            gameEnded = false
            pageStack.popAttached(pageStack.currentPage, PageStackAction.Animated)
            currentWorld.destroy()
            pushWorld()
        }
    }

    onPushWorld: {
        var component = Qt.createComponent("pages/World.qml")
        loader.create(component, parent, {})
        component.statusChanged.connect(loader.create)
    }

    Component.onCompleted:  {
        Console.LOG_PRIORITY = Console.TRACE
        pushWorld()
    }
}
