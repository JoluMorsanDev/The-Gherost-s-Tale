extends Node2D

var life = 3


# Called when the node enters the scene tree for the first time.
func _ready():
	$Player.global_position = $SpawnPos.position

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
		yield(get_tree().create_timer(1),"timeout")
		life = 3
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
