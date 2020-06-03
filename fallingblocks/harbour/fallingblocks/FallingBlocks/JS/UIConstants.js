.pragma library

var appName="harbour-fallingblocks"
var appIcon = "qrc:///images/desktop.png"
var appTitle = "Falling Blocks"
var appAuthors = ["Dametrious Peyton"]
var appCopyright = "Dametrious Peyton"
var appLicense = ["GPLv3"]
var appProjectInfo = ["https://github.com/prplmnky/harbour-fallingblocks",
                      "https://www.transifex.com/projects/p/harbour-fallingblocks",
                      "https://github.com/prplmnky/sailfish-widgets"]
var appVersion = "1.4.0"
var appYear = "2020"

// Animation rate controls the frame rate
var animationRate = 150
var animationEasy = animationRate
var animationMedium = animationRate - 10
var animationHard = animationRate - 50
var animationSuper = animationRate - 60

// Block constants for dynamic object creation (object name)
var blockNameEasy = "EasyBlock"
var blockNameMedium = "MediumBlock"
var blockNameHard = "HardBlock"
var blockNameEvil = "EvilBlock"
var blocks = [blockNameEasy, blockNameMedium, blockNameHard, blockNameEvil]

// Collision controls when to check blocks for collisions
// It should be some int value < animationRate
var collisionInterval = animationRate / 2

// Points
var pointsEasy = 100
var pointsMedium = 500
var pointsHard = 1000
var pointsEvil = -500

// Lives
var settingsLivesDefault = 0
var settingsLivesEasy = 1
var settingsLivesInfinite = 2
var livesDefault = 3
var livesEasy = 5
var livesInfinite = -1
var lives = [livesDefault, livesEasy, livesInfinite]

// Level Constants
var levelEasy = 0
var levelMedium = 1
var levelHard = 2
var levelExtreme = 3
var levelSuper = 4
// Speed changes on level
var levelEasySpeed = 10
var levelMediumSpeed = 20
var levelHardSpeed = 30
var levelExtremeSpeed = 35
var levelSuperSpeed = 40
var levelSpeeds = [levelEasySpeed, levelMediumSpeed, levelHardSpeed, levelExtremeSpeed, levelSuperSpeed]
// Block Speed (or delta y)
var blockEasySpeedFactor = 1
var blockMediumSpeedFactor = 2
var blockHardSpeedFactor = 3
var blockEvilSpeedFactor = 3
var blockSpeedFactors = [blockEasySpeedFactor, blockMediumSpeedFactor, blockHardSpeedFactor, blockEvilSpeedFactor]
// Interval is the spawning rate (in ms)
var intervalEasy = 1200
var intervalMedium = 1000
var intervalHard = 500
var intervalExtreme = 400
var intervalSuper = 300
var interval = intervalEasy
var intervals = [intervalEasy, intervalMedium, intervalHard, intervalExtreme, intervalSuper]
var spawnRatioEasy = [0.4, 0.3, 0.3, 0]
var spawnRatioMedium = [0.25, 0.25, 0.25, 0.25]
var spawnRatioHard = [0.1, 0.25, 0.15, 0.5]
var spawnRatioExtreme = [0.1, 0.25, 0.15, 0.5]
var spawnRatioSuper = [0.05, 0.15, 0.2, 0.6]
var spawnRatios = [spawnRatioEasy, spawnRatioMedium, spawnRatioHard, spawnRatioExtreme, spawnRatioSuper]

var speed = levelEasySpeed
var speedEasy = speed * blockEasySpeedFactor
var speedMedium = speed * blockMediumSpeedFactor
var speedHard = speed * blockHardSpeedFactor
var speedEvil = speed * blockEvilSpeedFactor


// Scoring
var scoreEasy = 0
var scoreMedium = 5000
var scoreHard = 20000
var scoreExtreme = 50000
var scoreSuper = 100000
var scoreInfinite = -100000
