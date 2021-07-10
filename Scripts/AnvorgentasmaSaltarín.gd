extends KinematicBody2D

#Declare constants
const aceleration = 2500
const max_speed = 250
const friction = .20
const gravity = 1300
const jump_force = 1000
const air_friction = 0.02

#Declare variables
var motion = Vector2.ZERO
onready var sprite = $AnimatedSprite
var x_input = -1
var life = 2
var inmunity = false
export (PackedScene) var Death

func _physics_process(delta):
	#Get the keyboardInput to move x
	if $Side.is_colliding():
		x_input = -x_input
		scale.x = -scale.x
	
	#if you are pressing one key, you move and your walking animation will play
	if x_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$AnimatedSprite.playing = true
	if x_input == 0:
		$AnimatedSprite.playing = false
		$AnimatedSprite.frame = 0
	
	#Put the vector motion y axis in gravity
	motion.y += gravity * delta
	
	#If is touching the floor, and press up, your motion in y will be jump force, if you aren't pressing any key, you'll stop
	if is_on_floor():
		motion.y = -jump_force
	else:
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_friction)
	
	#move the player with motion vector
# warning-ignore:return_value_discarded
	motion = move_and_slide(motion, Vector2.UP)

# warning-ignore:unused_argument
func _on_DamageArea_area_entered(area):
	if life > 1:
		life -= 1
# warning-ignore:integer_division
		motion.y = -jump_force/2
		motion.x = -motion.x
		inmunity = true
		$AnimatedSprite.modulate = Color(0, 0, 1, 1)
		$DamageArea/CollisionShape2D.set_deferred("disabled", true)
		$InmunityTimer.start()
	else:
		var dead = Death.instance()
		get_parent().get_parent().add_child(dead)
		dead.scale.x = scale.x
		dead.global_position.x = global_position.x
		dead.global_position.y = global_position.y - 40
		queue_free()


func _on_InmunityTimer_timeout():
	inmunity = false
	$AnimatedSprite.modulate = Color(1, 1, 1, 1)
	$DamageArea/CollisionShape2D.set_deferred("disabled", false)


# warning-ignore:unused_argument
func _on_FallArea_area_entered(area):
	queue_free()
