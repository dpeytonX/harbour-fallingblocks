import QtQuick 2.2
import Sailfish.Silica 1.0

Item {
    property int appStatus: !!Qt.application.state ? Qt.application.state :
                                                     (Qt.application.active ? 1 : 0) //VM compat
    property bool gameStarted: ((!!Qt.ApplicationActive && appStatus === Qt.ApplicationActive) || appStatus === 1)
                               && parent.status === PageStatus.Active && !gameEnded
    property bool gameEnded: false

    signal endGame()

    onEndGame: {
        // Game Over
        gameStarted = false
        gameEnded = true
    }
}
