extends Control

var nonsound = load("res://Assets/Sprites/Buttons/Button14.png")
var midsound = load("res://Assets/Sprites/Buttons/Button15.png")
var fullsound = load("res://Assets/Sprites/Buttons/Button16.png")
var nonsfx = load("res://Assets/Sprites/Buttons/Button4.png")
var midsfx = load("res://Assets/Sprites/Buttons/Button5.png")
var fullsfx = load("res://Assets/Sprites/Buttons/Button6.png")

signal changesound
signal changesfx
signal home

# Called when the node enters the scene tree for the first time.
func _ready():
	$Hearts/Heart1Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()
	$Hearts/Heart2Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()
	$Hearts/Heart3Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()
	$Pause/Coins.rect_position.y = 150
	$Pause/EnemiesLeft.rect_position.y = 150
	$Pause.rect_position.x = 0
	$Pause/SoundButton/HSlider.hide()
	$PauseBackground.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Damage_animation_finished():
	$Hearts/Heart1Base/Damage.hide()
	$Hearts/Heart1Base/Damage.stop()
	$Hearts/Heart1Base/Damage.frame = 0

func _on_Damage_animation_finished2():
	$Hearts/Heart2Base/Damage.hide()
	$Hearts/Heart2Base/Damage.stop()
	$Hearts/Heart2Base/Damage.frame = 0

func _on_Damage_animation_finished3():
	$Hearts/Heart3Base/Damage.hide()
	$Hearts/Heart3Base/Damage.stop()
	$Hearts/Heart3Base/Damage.frame = 0


# warning-ignore:unused_argument
func _on_PausePlay_toggled(button_pressed):
	MusicSingletone.buttonsfxplay()
	if $Buttons/PausePlay.pressed == true:
		$Pause/AnimationPlayer.play("Pause")
		get_tree().paused = true
	else:
		$Pause/AnimationPlayer.play("Play")
		get_tree().paused = false
	$Buttons/PausePlay.disabled = true

# warning-ignore:unused_argument
func _on_AnimationPlayer_animation_finished(anim_name):
	$Buttons/PausePlay.disabled = false

# warning-ignore:unused_argument
func _on_SoundButton_toggled(button_pressed):
	MusicSingletone.buttonsfxplay()
	if $Pause/SoundButton.pressed == true:
		$Pause/SoundButton/AnimationPlayer.play("Show")
	else:
		$Pause/SoundButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_HSlider_value_changed(value):
	emit_signal("changesound")
	if $Pause/SoundButton/HSlider.value == 0:
		$Pause/SoundButton.texture_normal = fullsound
	elif $Pause/SoundButton/HSlider.value < 0 and $Pause/SoundButton/HSlider.value > -24:
		$Pause/SoundButton.texture_normal = midsound
	elif $Pause/SoundButton/HSlider.value == -24:
		$Pause/SoundButton.texture_normal = nonsound

# warning-ignore:unused_argument
func _on_SfxButton_toggled(button_pressed):
	MusicSingletone.buttonsfxplay()
	if $Pause/SfxButton.pressed == true:
		$Pause/SfxButton/AnimationPlayer.play("Show")
	else:
		$Pause/SfxButton/AnimationPlayer.play("Hide")

# warning-ignore:unused_argument
func _on_HSlider_value_changedsfx(value):
	emit_signal("changesfx")
	if $Pause/SfxButton/HSlider.value == 0:
		$Pause/SfxButton.texture_normal = fullsfx
	elif $Pause/SfxButton/HSlider.value < 0 and $Pause/SfxButton/HSlider.value > -24:
		$Pause/SfxButton.texture_normal = midsfx
	elif $Pause/SfxButton/HSlider.value == -24:
		$Pause/SfxButton.texture_normal = nonsfx

func _on_Home_pressed():
	MusicSingletone.buttonsfxplay()
	emit_signal("home")
