extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$PortadaByMaetschl/AnimationPlayer.play("Normal")
	MusicSingletone.mainthememusicstart()

func _on_Play_pressed():
	MusicSingletone.mainthememusicstop()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Level1.tscn")
	MusicSingletone.soundingresion = true

func _on_Exit_pressed():
	get_tree().quit()

func _on_Credits_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_Settings_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Settings.tscn")
