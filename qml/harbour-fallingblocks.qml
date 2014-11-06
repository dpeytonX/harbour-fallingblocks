import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import "pages"


ApplicationWindow
{
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    initialPage: Component { Main {} }

    property variant currentWorld
    property bool gameEnded: false
    signal pushWorld()
    signal createWorld(Component world)
    signal worldCompleted(variant world)
    signal restart()

    onRestart: {
        if(!pageStack.busy && pageStack.currentPage !== currentWorld && gameEnded) {
            gameEnded = false
            pageStack.popAttached(pageStack.currentPage, PageStackAction.Animated)
            currentWorld.destroy()
            pushWorld()
        }
    }

    onCreateWorld: {
        if(!!world && world.status === Component.Ready) {
            var o = world.createObject(parent)
            o.gameEndedChanged.connect(function() {
                gameEnded = o.gameEnded
            })
            Console.debug("app: creating world " + o);
            worldCompleted(o)
        } else {
            Console.log("app: Error loading component " + world.errorString())
        }
    }

    onPushWorld: {
        var component = Qt.createComponent("pages/World.qml")
        createWorld(component)
        component.statusChanged.connect(createWorld)
    }

    onWorldCompleted: {
        Console.debug("app: world completed " + world)
        currentWorld = world
        pageStack.pushAttached(world)
        pageStack.busyChanged.connect(restart)
    }

    Component.onCompleted:  {
        Console.LOG_PRIORITY = Console.TRACE
        pushWorld()
    }
}
