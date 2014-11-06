import QtQuick 2.0
import harbour.fallingblocks.QmlLogger 2.0

Item {
    property Item source
    property Item target
    property alias timer: timer
    signal collisionDetected(Item source, Item target)
    signal createTimer(Item sourceComponent, Item targetComponent)
    signal create(Component collision, Item sourceComponent, Item targetComponent)
    signal objectCompleted(variant collision)
    signal stop()

    Timer {
        id: timer

        onTriggered: {
            // Kill this object if bounds do not exist
            if(source == null || target == null) {
                destroy();
                return;
            }

            Console.verbose("CollisionController: source " + source + ", target " + target)
            var sx = source.x
            var sy = source.y
            var sh = source.height + sy
            var sw = source.width + sx
            var tx = target.x
            var ty = target.y
            var th = target.height + ty
            var tw = target.width + tx
            Console.verbose("World: collision detector " +
                            "(" + sx + "," + sy + ")" +
                            "(" + sw + "," + sh + ")" +
                            "(" + tx + "," + ty + ")" +
                            "(" + tw + "," + th + ")")
            if(tx <= sx && sx <= tw || tx <= sw && sw <= tw)
                if(ty <= sy && sy <= th || ty <= sh && sh <= th)
                    collisionDetected(source, target)
        }
    }

    onStop: timer.stop()

    onCreate: {
        if(!!collision && collision.status === Component.Ready) {
            var o = collision.createObject(parent)
            Console.debug("CollisionController: creating detector " + o);
            o.source = sourceComponent
            o.target = targetComponent
            objectCompleted(o)
        } else {
            Console.log("CollisionController: Error loading component " + collision.errorString())
        }
    }

    onCreateTimer: {
        var collision = Qt.createComponent("CollisionController.qml")
        create(collision, sourceComponent, targetComponent)
        collision.statusChanged.connect(create)
    }
}
