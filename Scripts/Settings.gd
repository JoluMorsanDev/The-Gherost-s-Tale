extends Node2D

var nonsound = load("res://Assets/Sprites/Buttons/Button14.png")
var midsound = load("res://Assets/Sprites/Buttons/Button15.png")
var fullsound = load("res://Assets/Sprites/Buttons/Button16.png")
var nonsfx = load("res://Assets/Sprites/Buttons/Button4.png")
var midsfx = load("res://Assets/Sprites/Buttons/Button5.png")
var fullsfx = load("res://Assets/Sprites/Buttons/Button6.png")

signal changesound
signal changesfx

func _on_Back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

# warning-ignore:unused_argument
func _on_SoundButton_toggled(button_pressed):
	if $Buttons/SoundButton.pressed == true:
		$Buttons/SoundButton/AnimationPlayer.play("Show")
	else:
		$Buttons/SoundButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_SfxButton_toggled(button_pressed):
	if $Buttons/SfxButton.pressed == true:
		$Buttons/SfxButton/AnimationPlayer.play("Show")
	else:
		$Buttons/SfxButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_HSlider_value_changed(value):
	if $Buttons/SoundButton/HSlider.value == 0:
		$Buttons/SoundButton.texture_normal = fullsound
	emit_signal("changesound")

# warning-ignore:unused_argument
func _on_HSlider_value_changedsfx(value):
	emit_signal("changesfx")
