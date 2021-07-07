extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Hearts/Heart1Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()
	$Hearts/Heart2Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()
	$Hearts/Heart3Base/Damage.stop()
	$Hearts/Heart1Base/Damage.hide()


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
