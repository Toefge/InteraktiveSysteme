extends KinematicBody2D

signal health_updated(health)
signal killed()

var move = Vector2()
export var speed: = Vector2(300.0, 1000.0)
export var gravity: = 3000.0
export var fall_speed = 1.0
var _velocity: = Vector2.ZERO

export var wallJumpPush = 2000
export var wallJumpHeight = 1000

const FLOOR_NORMAL: = Vector2.UP

export var left = "left"
export var right = "right"
export var up = "up"
export var shoot = "fire"
export var orientationLeft = false

#Hp
export (float) var max_health = 100;
onready var health = max_health setget _set_health
#onready var invulnerability_timer = $InvulnerabilityTimer
onready var Hitbox = $Hitbox

var dead = false

#HealthBar
var healthBar = preload("res://HealthBar/HealthBarScript.gd")
	
func _ready():
	$AnimatedSprite.flip_h = orientationLeft
	$Gun.flipGun(orientationLeft)
	$Gun.shoot = shoot
	$Gun.left = left
	$Gun.right = right
	$Gun.bulletColor = Color.blue
	

func _physics_process(delta):
	
	if (!dead):
		#Check if the player let go of the jump button
		var is_jump_interrupted: = Input.is_action_just_released(up) and _velocity.y < 0.0
		var direction: = get_direction()
		_velocity = calculate_move_velocity(_velocity, direction, speed, is_jump_interrupted)
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		
		#Changing Sprites for left and right
		if Input.is_action_just_pressed(left):
			$AnimatedSprite.flip_h = true
		elif Input.is_action_just_pressed(right):
			$AnimatedSprite.flip_h = false

#Check which keys the player is pressing to move
func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength(right) - Input.get_action_strength(left), 
		-1.0 if Input.is_action_pressed(up) and is_on_floor() else 0.0
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
			
		if Input.is_action_just_pressed(up) and not is_on_floor() and nextToWall():
			if not is_on_floor() and nextToRightWall():
				move.x = direction.x * speed.x - wallJumpPush
				move.y = speed.y * direction.y - wallJumpHeight
			if not is_on_floor() and nextToLeftWall():
				move.x = direction.x * speed.x + wallJumpPush
				move.y = speed.y * direction.y - wallJumpHeight
			
			
		#Sprites for jumping and running
		if move.y < 0: $AnimatedSprite.play("jump")
		if move.x !=0: $AnimatedSprite.play("run")
		else: $AnimatedSprite.play("idle")
		
		return move
		
		
		
func nextToWall():
	return nextToRightWall() or nextToLeftWall()
	
func nextToRightWall():
	return $RightWall.is_colliding() 

func nextToLeftWall():
	return  $LeftWall.is_colliding() 


func damage(amount):
	#if invulnerability_timer.is_stopped():
	#	invulnerability_timer.start()
	_set_health(health - amount)
	print("damaged")
	
func kill():
	dead = true
	print("dead")
	$AnimatedSprite.hide()
	$Gun.hide()
	if ($AnimatedSprite.flip_h):
		$DeadPlayerLeft.show()
	else:
		$DeadPlayerRight.show()
	yield(get_tree().create_timer(3), "timeout")
	get_tree().change_scene("res://Menu/Menu.tscn")
	
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		$HealthBar._on_health_updated()
		if health == 0:
			kill()
			emit_signal("killed")

