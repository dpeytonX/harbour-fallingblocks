import QtQuick 2.0
import Sailfish.Silica 1.0
import "../Logger.js" as Console

Page {
    property bool gameStarted: false

    onStatusChanged: {
        gameStarted = status === PageStatus.Active
        Console.debug("World: new status is " + status)
        Console.debug("World: Game Status: " + gameStarted)
    }
}
