import QtQuick 2.0
import harbour.fallingblocks.SailfishWidgets.JS 1.1
import harbour.fallingblocks.SailfishWidgets.Utilities 1.1
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Item {
    property bool animate
    property alias interval: timer.interval
    property alias repeat: timer.repeat
    property alias running: timer.running
    property Item spriteParent
    property string spritePath: "../Sprites/"
    property alias triggeredOnStart: timer.triggeredOnStart
    signal objectCompleted(variant object)
    signal start()
    signal stop();

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            object.animate = animate
            object.x = MathHelper.randomInt(0, spriteParent.width - object.width)
            object.y = 0
            object.yChanged.connect(function() {
                if(object.y > object.parent.height)
                    object.destroy()
            })
            animateChanged.connect(function() {object.animate = animate})
            Console.debug("CreationController: object constructed " + object);
            parent.objectCompleted(object)
        }

        onError: Console.log("CreationController: could not create component " + errorString)
    }

    Timer {
        id: timer

        onTriggered: {
            var blocks = ["EasyBlock", "MediumBlock", "HardBlock", "EvilBlock"];
            var qml = spritePath + blocks[MathHelper.randomInt(0, 4)] + ".qml"
            var component = Qt.createComponent(qml)
            loader.create(component, spriteParent, {})
            component.statusChanged.connect(loader.create)
        }
    }

    onAnimateChanged: Console.debug("CreationController: animation changed to " + animate)
    onStart: timer.start()
    onStop: timer.stop()
}
