import QtQuick 2.2
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.JS 3.3

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

        if(MathHelper.isIntersectRect(source, target))
            collisionDetected(source, target)
    }
}
