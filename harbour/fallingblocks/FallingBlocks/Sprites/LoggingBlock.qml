import QtQuick 2.0
import harbour.fallingblocks.QmlLogger 2.0

FallingBlock {
    Component.onDestruction: {
        Console.trace("LoggingBlock: block destroyed")
    }
}
