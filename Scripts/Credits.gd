extends Node2D

func _on_Back_pressed():
	MusicSingletone.buttonsfxplay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
