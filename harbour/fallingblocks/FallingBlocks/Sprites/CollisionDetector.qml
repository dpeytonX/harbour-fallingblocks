import QtQuick 2.0
import harbour.fallingblocks.QmlLogger 2.0

Timer {
    property Item source
    property Item target
    property alias timer: timer
    signal collisionDetected(Item source, Item target)

    id: timer

    onTriggered: {
        // Kill this object if bounds do not exist
        if(source == null || target == null) {
            destroy();
            return;
        }

        Console.verbose("CollisionDetector: source " + source + ", target " + target)
        var sx = source.x
        var sy = source.y
        var sh = source.height + sy
        var sw = source.width + sx
        var tx = target.x
        var ty = target.y
        var th = target.height + ty
        var tw = target.width + tx
        Console.verbose("CollisionDetector: collision detector " +
                        "(" + sx + "," + sy + ")" +
                        "(" + sw + "," + sh + ")" +
                        "(" + tx + "," + ty + ")" +
                        "(" + tw + "," + th + ")")
        if(tx <= sx && sx <= tw || tx <= sw && sw <= tw)
            if(ty <= sy && sy <= th || ty <= sh && sh <= th)
                collisionDetected(source, target)
    }

    onCollisionDetected: Console.trace("CollisionDetector: made contact " + this)

    Component.onDestruction: Console.trace("CollisionDetector: detroyed " + this)
}
