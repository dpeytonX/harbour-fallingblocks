import QtQuick 2.2
import Sailfish.Silica 1.0
import harbour.fallingblocks.QmlLogger 2.0
import harbour.fallingblocks.SailfishWidgets.Components 3.3
import harbour.fallingblocks.FallingBlocks 1.0
import harbour.fallingblocks.FallingBlocks.Sprites 1.0

Dialog {
    PageColumn {
        title: qsTr("Scoring")

        Grid {
            columns: 2
            spacing: Theme.paddingSmall

            EasyBlock {}
            InformationalLabel {text: qsTr("Slowest block") + " +" + UIConstants.pointsEasy}

            MediumBlock {}
            InformationalLabel {text: qsTr("Slightly faster") + " +" + UIConstants.pointsMedium}

            HardBlock {}
            InformationalLabel {text: qsTr("Fastest") + " +" + UIConstants.pointsHard}

            EvilBlock {}
            InformationalLabel {text: qsTr("Takes a life") + " " + UIConstants.pointsEvil}
        }
    }
}
