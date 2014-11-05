import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import "../../../Logger.js" as Console

FallingBlock {
    Component.onDestruction: {
        Console.trace("LoggingBlock: block destroyed")
    }
}
