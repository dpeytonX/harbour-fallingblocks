import QtQuick 2.2
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.JS 3.3
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.FallingBlocks.JS 1.0
import harbour.fallingblocks.QmlLogger 2.0


/*!
  \qmltype CreationController

  Uses the BlockFactory to create random blocks on a Timer.
  */
Item {
    property alias interval: timer.interval
    property alias repeat: timer.repeat
    property alias running: timer.running
    property alias triggeredOnStart: timer.triggeredOnStart
    property bool animate: false
    property int speed: 0
    property variant spawnRatio: UIConstants.spawnRatioEasy
    property Item spriteParent

    signal objectCompleted(variant object)
    signal start
    signal stop

    BlockFactory {
        id: factory

        onObjectCompleted: {
            object.animate = animate
            object.x = MathHelper.randomInt(0,
                                            spriteParent.width - object.width)
            object.y = 0
            if (!!speed)
                object.speed = speed * UIConstants.blockSpeedFactors[object.blockType]
            object.yChanged.connect(function () {
                if (object.y > object.parent.height)
                    object.destroy()
            })
            animateChanged.connect(function () {
                object.animate = animate
            })
            parent.objectCompleted(object)
        }
    }

    Timer {
        id: timer

        onTriggered: {
            var index = 0
            var r = Math.random()
            var spawn = 0;
            for (var i = 0; i < spawnRatio.length; i++) {
                spawn += spawnRatio[i]
                if (r <= spawn) {
                    index = i
                    break
                }
            }
            factory.generate(UIConstants.blocks[index], spriteParent, {

                             })
        }
    }

    onStart: timer.start()
    onStop: timer.stop()
}
