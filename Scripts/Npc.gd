extends KinematicBody2D

const aceleration = 1500
const max_speed = 150
const friction = .20
const gravity = 1600
const jump_force = 600
const air_friction = 0.02

#Declare variables
var motion = Vector2.ZERO
onready var sprite = $Flip/AnimatedSprite
var x_input = 1
var life = 2
var stop = false
var lastx
export var dialog = ""

func _physics_process(delta):
	#Get the keyboardInput to move x
	if $Flip/Side.is_colliding():
		x_input = -x_input
		$Flip.scale.x = -$Flip.scale.x
	
	#if you are pressing one key, you move and your walking animation will play
	
	if x_input != 0:
		motion.x += x_input * aceleration * delta
		motion.x = clamp(motion.x, -max_speed, max_speed)
		$Flip/AnimatedSprite.playing = true
	if x_input == 0 or !is_on_floor():
		$Flip/AnimatedSprite.playing = false
		$Flip/AnimatedSprite.frame = 0
	
	#Put the vector motion y axis in gravity
	motion.y += gravity * delta
	
	#If is touching the floor, and press up, your motion in y will be jump force, if you aren't pressing any key, you'll stop
	if is_on_floor():
		if x_input == 0:
				motion.x = lerp(motion.x, 0, friction)
		if $Flip/Jumpside.is_colliding() and !$Flip/Jumpup.is_colliding() and stop == false:
			motion.y = -jump_force
		if !$Flip/Cliff.is_colliding() and stop == false:
			x_input = -x_input
			scale.x = -scale.x
	else:
		if x_input == 0:
			motion.x = lerp(motion.x, 0, air_friction)

	#move the player with motion vector
# warning-ignore:return_value_discarded
	motion = move_and_slide(motion, Vector2.UP)
# warning-ignore:unused_argument
func _on_Area2D_body_entered(body):
	stop = true
	lastx = x_input
	x_input = 0
	$Control/AnimationPlayer.play("show")

# warning-ignore:unused_argument
func _on_Area2D_body_exited(body):
	$Control/AnimationPlayer.play("hide")
	stop = false
	x_input = lastx
