import QtQuick 2.0
import harbour.fallingblocks.SailfishWidgets.JS 1.1
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Timer {
    property bool animate
    property string spritePath: "../Sprites/"
    signal create(Component component)
    signal objectCompleted(variant object)

    onAnimateChanged: Console.debug("CreationController: animation changed to " + animate)

    onCreate: {
        if(!!component && component.status === Component.Ready) {
            var o = component.createObject(parent)
            o.animate = animate
            o.x = MathHelper.randomInt(0, parent.width - o.width)
            o.y = 0
            o.yChanged.connect(function() {
                if(o.y > o.parent.height)
                    o.destroy()
            })
            animateChanged.connect(function() {o.animate = animate})
            Console.debug("CreationController: creating block " + o);
            objectCompleted(o)
        } else {
            Console.log("CreationController: Error loading component " + component.errorString())
        }
    }

    onObjectCompleted: Console.debug("CreationController: object completed " + object)

    onTriggered: {
        var blocks = ["EasyBlock", "MediumBlock", "HardBlock", "EvilBlock"];
        var component = Qt.createComponent(spritePath +
                                           blocks[MathHelper.randomInt(0, 4)] +
                                           ".qml")
        create(component)
        component.statusChanged.connect(create)
    }
}
