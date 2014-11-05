import QtQuick 2.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0
import "../../../Logger.js" as Console

FallingBlock {
    color: "red"

    Component.onDestruction: {
        Console.trace("World: block destroyed")
    }
}
