extends Node

var musicvolume
var sfxvolume
var mainthememusic = AudioStreamPlayer.new()
var mainthememusicsound = load("res://Assets/MusicAndSounds/MainThemebySleider.wav")
var cutscenemusic = AudioStreamPlayer.new()
var cutscenemusicsound = load("res://Assets/MusicAndSounds/IntroCutscenebyRiobruto.wav")
var coinsfx = AudioStreamPlayer.new()
var coinsfxsound = load("res://Assets/MusicAndSounds/coin.wav")
var buttonsfx = AudioStreamPlayer.new()
var buttonsfxsound = load("res://Assets/MusicAndSounds/button.wav")
var soundingresion = true
var soundingresion2 = true
var volumemusicfile = "user://volumemusic.save"
var volumesfxfile = "user://volumesfx.save"

func _ready():
	load_music_volume()
	load_sfx_volume()
	add_child(mainthememusic)
	add_child(cutscenemusic)
	add_child(coinsfx)
	add_child(buttonsfx)
	mainthememusic.stream = mainthememusicsound
	cutscenemusic.stream = cutscenemusicsound
	coinsfx.stream = coinsfxsound
	buttonsfx.stream = buttonsfxsound
	mainthememusic.bus = "Music"
	cutscenemusic.bus = "Music"
	coinsfx.bus = "Sfx"
	buttonsfx.bus = "Sfx"

func mainthememusicstart():
	if soundingresion == true:
			mainthememusic.play()
			soundingresion = false

func mainthememusicstop():
	mainthememusic.stop()

func cutscenemusicstart():
	if soundingresion2 == true:
			cutscenemusic.play()
			soundingresion2 = false

func cutscenethememusicstop():
	cutscenemusic.stop()

func coinsfxplay():
	coinsfx.play()

func buttonsfxplay():
	buttonsfx.play()

func change_music_volume():
	if musicvolume > -24:
		AudioServer.set_bus_volume_db(1, musicvolume)
		AudioServer.set_bus_mute(1, false)
	elif musicvolume == -24:
		AudioServer.set_bus_mute(1, true)
	save_music_volume()

func change_sfx_volume():
	if sfxvolume > -24:
		AudioServer.set_bus_volume_db(2, sfxvolume)
		AudioServer.set_bus_mute(2, false)
	elif sfxvolume == -24:
		AudioServer.set_bus_mute(2, true)
	save_sfx_volume()

func save_music_volume():
	var file = File.new()
	file.open(volumemusicfile, File.WRITE)
	file.store_var(musicvolume)
	file.close()

func save_sfx_volume():
	var file = File.new()
	file.open(volumesfxfile, File.WRITE)
	file.store_var(sfxvolume)
	file.close()

func load_music_volume():
	var file = File.new()
	if file.file_exists(volumemusicfile):
		file.open(volumemusicfile, File.READ)
		musicvolume = file.get_var()
		file.close()
	else:
		musicvolume = 0

func load_sfx_volume():
	var file = File.new()
	if file.file_exists(volumesfxfile):
		file.open(volumesfxfile, File.READ)
		sfxvolume = file.get_var()
		file.close()
	else:
		sfxvolume = 0

func earse_data():
	var file = File.new()
	file.open(volumemusicfile, File.WRITE)
	file.store_var(0)
	file.close()
	var file2 = File.new()
	file2.open(volumesfxfile, File.WRITE)
	file2.store_var(0)
	file2.close()
