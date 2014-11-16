.pragma library

var animationRate = 100 // Changes how fast blocks fall
var blockNameEasy = "EasyBlock"
var blockNameMedium = "MediumBlock"
var blockNameHard = "HardBlock"
var blockNameEvil = "EvilBlock"
var blocks = [blockNameEasy, blockNameMedium, blockNameHard, blockNameEvil]
var collisionInterval = 50
var intervalEasy = animationRate
var intervalMedium = animationRate - 10
var intervalHard = animationRate - 50
var intervalSuper = animationRate - 60
var interval = intervalEasy
var pointsEasy = 100
var pointsMedium = 500
var pointsHard = 1000
var pointsEvil = -500
var speed = 10
var speedEasy = speed
var speedMedium = speed * 2
var speedHard = speed * 3
var speedEvil = speed * 3
