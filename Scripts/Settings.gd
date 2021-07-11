extends Node2D

var nonsound = load("res://Assets/Sprites/Buttons/Button14.png")
var midsound = load("res://Assets/Sprites/Buttons/Button15.png")
var fullsound = load("res://Assets/Sprites/Buttons/Button16.png")
var nonsfx = load("res://Assets/Sprites/Buttons/Button4.png")
var midsfx = load("res://Assets/Sprites/Buttons/Button5.png")
var fullsfx = load("res://Assets/Sprites/Buttons/Button6.png")

func _ready():
	$Buttons/SoundButton/HSlider.value = MusicSingletone.musicvolume
	$Buttons/SfxButton/HSlider.value = MusicSingletone.sfxvolume

func _on_Back_pressed():
	MusicSingletone.buttonsfxplay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

# warning-ignore:unused_argument
func _on_SoundButton_toggled(button_pressed):
	MusicSingletone.buttonsfxplay()
	if $Buttons/SoundButton.pressed == true:
		$Buttons/SoundButton/AnimationPlayer.play("Show")
	else:
		$Buttons/SoundButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_SfxButton_toggled(button_pressed):
	MusicSingletone.buttonsfxplay()
	if $Buttons/SfxButton.pressed == true:
		$Buttons/SfxButton/AnimationPlayer.play("Show")
	else:
		$Buttons/SfxButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_HSlider_value_changed(value):
	if $Buttons/SoundButton/HSlider.value == 0:
		$Buttons/SoundButton.texture_normal = fullsound
	elif $Buttons/SoundButton/HSlider.value < 0 and $Buttons/SoundButton/HSlider.value > -24:
		$Buttons/SoundButton.texture_normal = midsound
	elif $Buttons/SoundButton/HSlider.value == -24:
		$Buttons/SoundButton.texture_normal = nonsound
	MusicSingletone.musicvolume = $Buttons/SoundButton/HSlider.value
	MusicSingletone.change_music_volume()

# warning-ignore:unused_argument
func _on_HSlider_value_changedsfx(value):
	if $Buttons/SfxButton/HSlider.value == 0:
		$Buttons/SfxButton.texture_normal = fullsfx
	elif $Buttons/SfxButton/HSlider.value < 0 and $Buttons/SfxButton/HSlider.value > -24:
		$Buttons/SfxButton.texture_normal = midsfx
	elif $Buttons/SfxButton/HSlider.value == -24:
		$Buttons/SfxButton.texture_normal = nonsfx
	MusicSingletone.sfxvolume = $Buttons/SfxButton/HSlider.value
	MusicSingletone.change_sfx_volume()


func _on_DeleteDataButton_pressed():
	MusicSingletone.buttonsfxplay()
	MusicSingletone.earse_data()
	LevelsSingleton.earse_data()
	get_tree().quit()
