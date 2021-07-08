extends Area2D

var direction = -1
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
# warning-ignore:unused_argument
func _process(delta):
	position.x += 20 * direction

# warning-ignore:unused_argument
func _on_Quesontasma_body_entered(body):
	queue_free()

func _on_Timer_timeout():
	queue_free()
