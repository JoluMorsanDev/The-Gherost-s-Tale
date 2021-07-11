extends Node2D

var start = false

func _ready():
	$AnimationPlayer.play("Nueva Animación")
	MusicSingletone.change_music_volume()
	MusicSingletone.change_sfx_volume()
	MusicSingletone.cutscenemusicstart()
	

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	MusicSingletone.cutscenethememusicstop()

# warning-ignore:unused_argument
func _process(delta):
	if Input.is_action_pressed("claws"):
		MusicSingletone.buttonsfxplay()
		exit()

func exit():
	$AnimationPlayer.stop()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
	MusicSingletone.cutscenethememusicstop()
