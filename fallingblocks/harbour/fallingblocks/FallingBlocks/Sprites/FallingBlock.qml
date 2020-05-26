import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.QmlLogger 2.0

Block {
    property bool animate: false
    property real animationRate: UIConstants.animationRate
    property alias collision: collisionDetector
    property int points
    property int speed
    property int blockType
    signal collisionDetected(Item source, Item target)

    border.color: "white"
    border.width: 1

    Behavior on y {
        PropertyAnimation {
            duration: animationRate
            easing.type: Easing.Linear
        }
    }

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

    onAnimateChanged: !!(collisionDetector.target) && animate ? collisionDetector.start() : collisionDetector.stop()

}
