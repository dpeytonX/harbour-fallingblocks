import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import harbour.fallingblocks.QmlLogger 2.0

Timer {
    property bool animate: true
    property int speed: UIConstants.speed
    signal create(Component component)

    onCreate: {
        if(!!component && component.status === Component.Ready) {
            Console.debug("World: creating block");
            var o = component.createObject(parent, {
                                               "animate": animate,
                                               "speed": speed,
                                               "x": this.parent.width / 2,
                                               "y": 0
                                           })
            o.yChanged.connect(function() {
                if(o.y > o.parent.height)
                    destroy()
            })
        } else {
            Console.log("Error loading component:" + component.errorString())
        }
    }

    onTriggered: {
        var component = Qt.createComponent("../Sprites/BlockA.qml")
        create(component)
        component.statusChanged.connect(create)
    }
}
