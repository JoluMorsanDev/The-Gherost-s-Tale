extends Node

var musicvolume
var sfxvolume
var mainthememusic = AudioStreamPlayer2D.new()
var mainthememusicsound = load("res://Assets/MusicAndSounds/WelcomeToTheCastlebySleider.wav")
var soundingresion = true

func _ready():
	add_child(mainthememusic)
	mainthememusic.stream = mainthememusicsound
	mainthememusic.bus = "Music"

func mainthememusicstart():
	if soundingresion == true:
			mainthememusic.play()
			soundingresion = false

func mainthememusicstop():
	mainthememusic.stop()
