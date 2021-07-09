extends Node2D

var start = false

func _ready():
	$AnimationPlayer.play("Nueva Animación")

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

# warning-ignore:unused_argument
func _process(delta):
	if Input.action_press("claws"):
		exit()

func exit():
	$AnimationPlayer.stop()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
