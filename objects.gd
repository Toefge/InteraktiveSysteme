extends KinematicBody2D

var move = Vector2()
export var speed: = Vector2(300.0, 1000.0)
#var jump_speed = -400
export var gravity: = 3000.0
export var fall_speed = 1.0
#var lastdirection = 1
var _velocity: = Vector2.ZERO
const FLOOR_NORMAL: = Vector2.UP


	
	
func _physics_process(delta:float ) -> void:
	
	#Check if the player let go of the jump button
	var is_jump_interrupted: = Input.is_action_just_released("ui_up") and _velocity.y < 0.0
	var direction: = get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	#Changing Sprites for left and right
	if Input.is_action_just_pressed("ui_left"):
		$Sprite.flip_h = true
	elif Input.is_action_just_pressed("ui_right"):
		$Sprite.flip_h = false

#Check which keys the player is pressing to move
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"), 
		-1.0 if Input.is_action_just_pressed("ui_up") and is_on_floor() else 0.0
	)
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2,
	is_jump_interrupted: bool) -> Vector2:
		var move: = linear_velocity
		move.x = speed.x * direction.x
		move.y += gravity * get_physics_process_delta_time()  #Maybe play with gravity for a gamemode?
		if direction.y == -1.0:
			move.y = speed.y * direction.y
		if is_jump_interrupted:
			move.y = fall_speed
			
		#Sprites for jumping and running
		if move.y > 0: $Sprite.play("jump")
		if move.x !=0: $Sprite.play("run")
		else: $Sprite.play("idle")
		
		return move

