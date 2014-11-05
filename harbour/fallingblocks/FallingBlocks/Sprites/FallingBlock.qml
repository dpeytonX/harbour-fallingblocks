import QtQuick 2.0

Block {
    property bool animate: false
    property real animationRate: 100
    property real speed: 20

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
}
