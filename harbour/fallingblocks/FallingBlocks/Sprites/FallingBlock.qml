import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.QmlLogger 2.0

Block {
    border.color: "white"
    border.width: 1

    property bool animate: false
    property real animationRate: UIConstants.animationRate
    property real speed

    Timer {
        id: fallingTimer
        running: animate
        repeat: true
        triggeredOnStart: true
        interval: animationRate
        onTriggered: {
            y += speed
        }
    }

    onAnimateChanged: Console.verbose("FallingBlock: animation state is " + animate)

    Component.onDestruction: {
        Console.trace("LoggingBlock: block destroyed")
    }
}
