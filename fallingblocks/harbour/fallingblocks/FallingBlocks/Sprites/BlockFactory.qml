import QtQuick 2.2
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.armv7hl.SailfishWidgets.Utilities 3.3
import harbour.fallingblocks.FallingBlocks.JS 1.0

Item {
    signal generate(string objectName, variant parent, variant properties)
    signal objectCompleted(variant object)

    DynamicLoader {
        id: loader
        onObjectCompleted: {
            parent.objectCompleted(object)
        }

        onError: Console.error(
                     "BlockFactory: could not create component " + errorString)
    }

    onGenerate: {
        var position = -1
        for (var i = 0; i < UIConstants.blocks.length; ++i) {
            if (UIConstants.blocks[i] === objectName) {
                position = i
                break
            }
        }

        if (position != -1) {
            var qml = UIConstants.blocks[position] + ".qml"
            var component = Qt.createComponent(qml)
            loader.create(component, parent, properties)
            component.statusChanged.connect(loader.create)
        }
    }
}
