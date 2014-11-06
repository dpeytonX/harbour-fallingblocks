import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import "pages"


ApplicationWindow
{
    property bool gameStatus: false
    cover: Qt.resolvedUrl("cover/CoverPage.qml")
    initialPage: Component { Main {} }

    Component.onCompleted:  {
        Console.LOG_PRIORITY = Console.DEBUG
        pageStack.pushAttached(Qt.resolvedUrl("pages/World.qml"))
    }
}
