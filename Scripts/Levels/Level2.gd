extends Node2D

var life = 3
var death = false
var wining = false
var coins = 0
var shaking = false
var hshaking = false

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node_or_null("Player").global_position = $SpawnPos.position
	$Camera2D/MessageScreen/Message.text = "Level 2"
	$Music/Music/LevelMusic.play()
	$Camera2D/Uingame/Pause/SfxButton/HSlider.value = MusicSingletone.sfxvolume
	$Camera2D/Uingame/Pause/SoundButton/HSlider.value = MusicSingletone.musicvolume
	$Camera2D/Uingame/Pause/EnemiesLeft/Label.text = str($Enemies.get_child_count())
	$Camera2D/Uingame/Pause/LevelMessage.text = "Lvl 2"
	show_level()

# warning-ignore:unused_argument
func _process(delta):
	if $Enemies.get_child_count() > 0:
		$Camera2D/Uingame/Pause/EnemiesLeft/Label.text = str($Enemies.get_child_count())
	if $Enemies.get_child_count() == 0:
		if wining == false and life > 0:
			$Camera2D/Uingame/Pause/EnemiesLeft/Label.text = str($Enemies.get_child_count())
			wining = true
			get_node_or_null("Player").movement_block_win()
			yield(get_tree().create_timer(1),"timeout")
			win()
	if get_node_or_null("Player").global_position.x > 640 and get_node_or_null("Player").global_position.x < 5900:
		$Camera2D.global_position.x = get_node_or_null("Player").global_position.x
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
		if death == false and wining == false:
			LevelsSingleton.levelsunlocked = 0
			LevelsSingleton.save_levels_unlocked()
			$Music/Music/LevelMusic.stop()
			death = true
			get_node_or_null("Player").movement_block_loss()
			yield(get_tree().create_timer(1),"timeout")
			game_over()
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
		$HealShakeTimer.start()
		hshaking = true
		heartdown()

func _on_Player_coin():
	coins += 1
	$Camera2D/Uingame/Pause/Coins/Label.text = str(coins)
	$Music/Sfx/CoinSfx.play()
	MusicSingletone.coinsfxplay()

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
	$CanvasModulate.color = Color(.20, .36, .50, 1)

func _on_Uingame_changesound():
	MusicSingletone.musicvolume =$Camera2D/Uingame/Pause/SoundButton/HSlider.value 
	MusicSingletone.change_music_volume()

func _on_Uingame_changesfx():
	MusicSingletone.sfxvolume =$Camera2D/Uingame/Pause/SfxButton/HSlider.value
	MusicSingletone.change_sfx_volume()

func _on_Uingame_home():
	$Music/Music/LevelMusic.stop()
	death = true
	$Camera2D/Uingame/Pause/AnimationPlayer.play("Play")
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")


func _on_Player_fall():
	if wining == false and death == false:
		LevelsSingleton.levelsunlocked = 0
		LevelsSingleton.save_levels_unlocked()
		get_node_or_null("Player").movement_block()
		$Music/Sfx/HurtSfx.play()
		$Music/Music/LevelMusic.stop()
		shaking = true
		cameradown()
		$CanvasModulate.color = Color(.9, .15, .15, 1)
		death = true
		yield(get_tree().create_timer(0.533),"timeout")
		shaking = false
		$Camera2D.global_position.y = 360
		$Camera2D.global_rotation_degrees = 0
		$CanvasModulate.color = Color(.20, .36, .50, 1)
		yield(get_tree().create_timer(0.467),"timeout")
		game_over()

func game_over():
	$Music/Music/LevelMusic.stop()
	$Music/Music/GameOverMusic.play()
	$Camera2D/MessageScreen.rect_scale.x = 1
	$Camera2D/MessageScreen/Message.text = "Game\nover"
	$Camera2D/MessageScreen/AnimationPlayer.play("show")
	get_tree().paused = true
	yield(get_tree().create_timer(5),"timeout")
	get_tree().paused = false
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/MainMenu.tscn")

func win():
	$Music/Music/LevelMusic.stop()
	$Music/Music/WinMusic.play()
	$Camera2D/MessageScreen.rect_scale.x = 1
	$Camera2D/MessageScreen/Message.text = "Level\nwon"
	$Camera2D/MessageScreen/AnimationPlayer.play("show")
	get_tree().paused = true
	yield(get_tree().create_timer(3),"timeout")
	get_tree().paused = false
	LevelsSingleton.levelsunlocked = 2
	LevelsSingleton.save_levels_unlocked()
# warning-ignore:return_value_discarded
	get_tree().change_scene("res://Scenes/Levels/Level3.tscn")

func show_level():
	get_tree().paused = true
	yield(get_tree().create_timer(1),"timeout")
	get_tree().paused = false
	$Camera2D/MessageScreen/AnimationPlayer.play("hide")
	yield(get_tree().create_timer(1),"timeout")
	$Camera2D/MessageScreen.rect_scale.x = 0

func heartup():
	if hshaking == true:
		$Camera2D/Uingame/Hearts.global_position.y = 2
		$Camera2D/Uingame/Hearts.global_rotation_degrees = .5
		yield(get_tree().create_timer(0.1),"timeout")
		heartdown()

func heartdown():
	if hshaking == true:
		$Camera2D/Uingame/Hearts.global_position.y = -2
		$Camera2D/Uingame/Hearts.global_rotation_degrees = -.5
		yield(get_tree().create_timer(0.1),"timeout")
		heartup()

func _on_HealShakeTimer_timeout():
	hshaking = false
	$Camera2D/Uingame/Hearts.global_position.y = 0
	$Camera2D/Uingame/Hearts.global_rotation_degrees = 0
