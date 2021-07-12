extends Node2D

# Called when the node enters the scene tree for the first time.
func _ready():
	$PortadaByMaetschl/AnimationPlayer.play("Normal")
	MusicSingletone.mainthememusicstart()
	if LevelsSingleton.firsttimeplaying == true:
		$PortadaByMaetschl/Label.text = "tutorial"
	else:
		if LevelsSingleton.levelsunlocked == 0:
			$PortadaByMaetschl/Label.text = "level 1"
		elif LevelsSingleton.levelsunlocked == 1:
			$PortadaByMaetschl/Label.text = "level 2"
		elif LevelsSingleton.levelsunlocked == 2:
			$PortadaByMaetschl/Label.text = "level 3"

func _on_Play_pressed():
	MusicSingletone.buttonsfxplay()
	MusicSingletone.mainthememusicstop()
	MusicSingletone.soundingresion = true
	if LevelsSingleton.firsttimeplaying == true:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://Scenes/Levels/Tuto.tscn")
	else:
		if LevelsSingleton.levelsunlocked == 0:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Level1.tscn")
		elif LevelsSingleton.levelsunlocked == 1:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/Level2.tscn")
		elif LevelsSingleton.levelsunlocked == 2:
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/Levels/Level3.tscn")

func _on_Exit_pressed():
	MusicSingletone.buttonsfxplay()
	get_tree().quit()

func _on_Credits_pressed():
	MusicSingletone.buttonsfxplay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Credits.tscn")

func _on_Settings_pressed():
	MusicSingletone.buttonsfxplay()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Settings.tscn")
