extends Node

var musicvolume
var sfxvolume
var mainthememusic = AudioStreamPlayer2D.new()
var mainthememusicsound = load("res://Assets/MusicAndSounds/WelcomeToTheCastlebySleider.wav")

func _ready():
	mainthememusic.stream = mainthememusicsound
	mainthememusic.bus = "Music"

func mainthememusicstart():
	mainthememusic.play()

func mainthememusicstop():
	mainthememusic.stop()
