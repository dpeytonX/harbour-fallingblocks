import QtQuick 2.2
import harbour.fallingblocks.FallingBlocks.JS 1.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.JS 3.3

FallingBlock {
    blockType: 4
    color: "yellow"
    objectName: UIConstants.blockNameStar
    points: UIConstants.pointsStar
    speed: UIConstants.speedStar

    onYChanged: starTimer.start()
    onCollisionDetected: starTimer.stop()

    Timer {
        id: starTimer
        repeat: true
        interval: UIConstants.invincibilityInterval
        onTriggered: color = ["gold","yellow","purple","white"][MathHelper.randomInt(0,4)]
    }
}
