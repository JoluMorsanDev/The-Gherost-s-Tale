extends Node2D

var life = 3
var death = false
var coins = 0
var shaking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.global_position = $SpawnPos.position
	$Music/Music/LevelMusic.play()

# warning-ignore:unused_argument
func _process(delta):
	if $Player.global_position.x > 640:
		$Camera2D.global_position.x = $Player.global_position.x
	if life == 3:
		$Camera2D/Uingame/Hearts/Heart1Base/Heart.show()
		$Camera2D/Uingame/Hearts/Heart2Base/Heart.show()
		$Camera2D/Uingame/Hearts/Heart3Base/Heart.show()
	elif life == 2:
		$Camera2D/Uingame/Hearts/Heart1Base/Heart.show()
		$Camera2D/Uingame/Hearts/Heart2Base/Heart.show()
		$Camera2D/Uingame/Hearts/Heart3Base/Heart.hide()
	elif life == 1:
		$Camera2D/Uingame/Hearts/Heart1Base/Heart.show()
		$Camera2D/Uingame/Hearts/Heart2Base/Heart.hide()
		$Camera2D/Uingame/Hearts/Heart3Base/Heart.hide()
	elif life <= 0:
		$Camera2D/Uingame/Hearts/Heart1Base/Heart.hide()
		$Camera2D/Uingame/Hearts/Heart2Base/Heart.hide()
		$Camera2D/Uingame/Hearts/Heart3Base/Heart.hide()
		if death == false:
			$Music/Music/LevelMusic.stop()
			death = true
			yield(get_tree().create_timer(1),"timeout")
			$Camera2D/Uingame/Pause/AnimationPlayer.play("Play")
			get_tree().paused = false
# warning-ignore:return_value_discarded
			get_tree().change_scene("res://Scenes/MainMenu.tscn")
	elif life > 3:
		life = 3

func _on_Player_hit():
	if life == 3:
		$Camera2D/Uingame/Hearts/Heart3Base/Damage.play()
		$Camera2D/Uingame/Hearts/Heart3Base/Damage.show()
		life = 2
	elif life == 2:
		$Camera2D/Uingame/Hearts/Heart2Base/Damage.play()
		$Camera2D/Uingame/Hearts/Heart2Base/Damage.show()
		life = 1
	elif life == 1:
		$Camera2D/Uingame/Hearts/Heart1Base/Damage.play()
		$Camera2D/Uingame/Hearts/Heart1Base/Damage.show()
		life = 0
	$Music/Sfx/HurtSfx.play()
	$ScreenShakeTimer.start()
	shaking = true
	cameradown()
	$CanvasModulate.color = Color(.9, .15, .15, 1)

func _on_Player_heal():
	if life < 3 and life > 0:
		life += 1
		$Music/Sfx/HealSfx.play()

func _on_Player_coin():
	coins += 1
	$Camera2D/Uingame/Pause/Coins/Label.text = str(coins)

func cameraup():
	if shaking == true:
		$Camera2D.global_position.y = 365
		$Camera2D.global_rotation_degrees = 2
		yield(get_tree().create_timer(0.1),"timeout")
		cameradown()

func cameradown():
	if shaking == true:
		$Camera2D.global_position.y = 355
		$Camera2D.global_rotation_degrees = -2
		yield(get_tree().create_timer(0.1),"timeout")
		cameraup()

func _on_ScreenShakeTimer_timeout():
	shaking = false
	$Camera2D.global_position.y = 360
	$Camera2D.global_rotation_degrees = 0
	$CanvasModulate.color = Color(.03, .17, .29, 1)

func _on_Uingame_changesound():
	if $Camera2D/Uingame/Pause/SoundButton/HSlider.value > -24:
		AudioServer.set_bus_volume_db(1, $Camera2D/Uingame/Pause/SoundButton/HSlider.value)
		AudioServer.set_bus_mute(1, false)
	elif $Camera2D/Uingame/Pause/SoundButton/HSlider.value == -24:
		AudioServer.set_bus_mute(1, true)

func _on_Uingame_changesfx():
	if $Camera2D/Uingame/Pause/SfxButton/HSlider.value > -24:
		AudioServer.set_bus_volume_db(2, $Camera2D/Uingame/Pause/SfxButton/HSlider.value)
		AudioServer.set_bus_mute(2, false)
	elif $Camera2D/Uingame/Pause/SfxButton/HSlider.value == -24:
		AudioServer.set_bus_mute(2, true)

func _on_Uingame_home():
	$Music/Music/LevelMusic.stop()
	death = true
	$Camera2D/Uingame/Pause/AnimationPlayer.play("Play")
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Player_fall():
	$Music/Sfx/HurtSfx.play()
	$Music/Music/LevelMusic.stop()
	death = true
	yield(get_tree().create_timer(1),"timeout")
	$Camera2D/Uingame/Pause/AnimationPlayer.play("Play")
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")
