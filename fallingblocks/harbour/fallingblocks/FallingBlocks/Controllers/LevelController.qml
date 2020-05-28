import QtQuick 2.2
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
            level = UIConstants.levelEasy
            return
        }
        if(score < UIConstants.scoreHard) {
            level = UIConstants.levelMedium
            return
        }
        if(score < UIConstants.scoreExtreme) {
            level = UIConstants.levelHard
            return
        }
        if(score < UIConstants.scoreSuper) {
            level = UIConstants.levelExtreme
            return
        }
        level = UIConstants.levelSuper
    }
}
