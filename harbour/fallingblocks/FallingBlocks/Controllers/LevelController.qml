import QtQuick 2.0
import Sailfish.Silica 1.0
import harbour.fallingblocks.FallingBlocks 1.0

/*!
  \qmltype LevelController

  Handles the level determination
  */
Item {
    property bool autoDetermine: true
    property int score
    property int level

    onScoreChanged: {
        if(!autoDetermine) return

        if(score < UIConstants.scoreMedium) {
            level = 0
            return
        }
        if(score < UIConstants.scoreHard) {
            level = 1
            return
        }
        if(score < UIConstants.scoreSuper) {
            level = 2
            return
        }
        level = 3
    }
}
