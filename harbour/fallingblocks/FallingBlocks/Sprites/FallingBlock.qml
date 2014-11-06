import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.QmlLogger 2.0

Block {
    border.color: "white"
    border.width: 1

    property bool animate: false
    property real animationRate: UIConstants.animationRate
    property alias collision: collisionDetector
    property int points
    property real speed
    signal collisionDetected(Item source, Item target)

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

    CollisionDetector {
        id: collisionDetector
        target: parent

        onCollisionDetected: parent.collisionDetected(source, target)
    }

    onAnimateChanged: {
        Console.verbose("FallingBlock: animation state is " + animate)
        if(collisionDetector.target)
            animate ? collisionDetector.start() : collisionDetector.stop()
    }

    onCollisionDetected: Console.trace("FallingBlock: collision detected " + this)

    Component.onDestruction: {
        Console.trace("LoggingBlock: block destroyed")
    }
}
