import QtQuick 2.0
import harbour.fallingblocks.SailfishWidgets.JS 1.2
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Item {
    property bool animate
    property alias interval: timer.interval
    property alias repeat: timer.repeat
    property alias running: timer.running
    property Item spriteParent
    property alias triggeredOnStart: timer.triggeredOnStart
    signal objectCompleted(variant object)
    signal start()
    signal stop();

    BlockFactory {
        id: factory

        onObjectCompleted: {
            object.animate = animate
            object.x = MathHelper.randomInt(0, spriteParent.width - object.width)
            object.y = 0
            object.yChanged.connect(function() {
                if(object.y > object.parent.height)
                    object.destroy()
            })
            animateChanged.connect(function() {object.animate = animate})
            Console.debug("CreationController: initialized object " + object)
            parent.objectCompleted(object)
        }
    }

    Timer {
        id: timer

        onTriggered: {
            var index = MathHelper.randomInt(0, UIConstants.blocks.length)
            Console.debug("CreationController: create block type " + index)
            factory.generate(UIConstants.blocks[index], spriteParent, {})
        }
    }

    onAnimateChanged: Console.debug("CreationController: animation changed to " + animate)
    onStart: timer.start()
    onStop: timer.stop()
}
