extends Node2D

func _ready():
	$Music/Music/MainThemeMusic.play() 

func _on_Back_pressed():
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
