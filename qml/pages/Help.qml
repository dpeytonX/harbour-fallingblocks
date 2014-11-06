import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.Components 1.1
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0

Dialog {
    id: dialog

    Column {
        width: parent.width - Theme.paddingLarge * 2
        x: Theme.paddingLarge

        PageHeader {
            title: qsTr("Help");
        }

        Heading {text: qsTr("How to play")}

        DescriptiveLabel {
            text: qsTr("It's simple! Catch as many blocks as you can while avoiding the mysterious 'evil block'.")
        }

        DescriptiveLabel {
            text: qsTr("Move your player by pressing and holding the stationary block at the bottom of the screen. You may move left and right in order to align yourself to the falling block above. Upon successful alignment you will increase your score. However, touching the 'evil block' will descrease your score and the number of lives you have. The game ends once all lives are depleted.")
        }

        Heading {text: qsTr("Scoring")}

        Grid {
            columns: 2
            spacing: Theme.paddingSmall

            EasyBlock {}
            InformationalLabel {text: qsTr("Slowest block") + "+" + UIConstants.pointsEasy}

            MediumBlock {}
            InformationalLabel {text: qsTr("Slightly faster") + "+" + UIConstants.pointsMedium}

            HardBlock {}
            InformationalLabel {text: qsTr("Fastest") + "+" + UIConstants.pointsHard}

            EvilBlock {}
            InformationalLabel {text: qsTr("Takes a life") + "-" + UIConstants.pointsEvil}
        }
    }
}
