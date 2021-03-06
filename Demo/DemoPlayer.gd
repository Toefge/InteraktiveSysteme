extends KinematicBody2D

signal health_updated(health)
signal killed()

var move = Vector2()
export var speed: = Vector2(10.0, 10.0)
export var gravity: = 1000.0
export var fall_speed = 0.5
var _velocity: = Vector2.ZERO

export var wallJumpPush = 2000
export var wallJumpHeight = 1000

const FLOOR_NORMAL: = Vector2.UP

var moveDirection = Vector2.ZERO
var directionLeft = false

#Hp
export (float) var max_health = 100;
onready var health = max_health setget _set_health
#onready var invulnerability_timer = $InvulnerabilityTimer
onready var Hitbox = $Hitbox

var dead = false
var jumping = false

#HealthBar
var healthBar = preload("res://HealthBar/HealthBarScript.gd")
	
func _ready():
	$AnimatedSprite.flip_h = true
	$Gun.demo = true
	$Gun.flipGun(true)
	$Gun.bulletColor = Color.blue
	

func _physics_process(delta):
	
	if (!dead):
		
		if(position.x >= get_node("/root/game/ChangeDirectionRight").position.x or
		 position.x <= get_node("/root/game/ChangeDirectionLeft").position.x):
			_on_DemoPlayerChangeDirection()
			if(randi() % 2):
				_on_DemoPlayerJump()
		
		if(nextToWall() and !jumping):
			_on_DemoPlayerJump()
			
		if(jumping and !nextToWall()):
			jumping = !jumping
		
		_velocity = calculate_move_velocity(_velocity, moveDirection, speed)
		_velocity = move_and_slide(_velocity)
		
		#Changing Sprites for left and right
		"""
		if Input.is_action_just_pressed(left):
			$AnimatedSprite.flip_h = true
		elif Input.is_action_just_pressed(right):
			$AnimatedSprite.flip_h = false
		"""
	
func calculate_move_velocity(
	linear_velocity: Vector2,
	direction: Vector2,
	speed: Vector2) -> Vector2:
		var move: = linear_velocity
		move.x = speed.x * direction.x
		move.y += gravity * get_physics_process_delta_time()  #Maybe play with gravity for a gamemode?
		if direction.y == -1.0:
			move.y = speed.y * direction.y

		"""
		if (Input.is_action_just_pressed(up) 
		and not is_on_floor() 
		and nextToWall() 
		and position.y > get_node("/root/game/MaxWalljumpHeight").position.y):
			if not is_on_floor() and nextToRightWall():
				move.x = direction.x * speed.x - wallJumpPush
				move.y = speed.y * direction.y - wallJumpHeight
			if not is_on_floor() and nextToLeftWall():
				move.x = direction.x * speed.x + wallJumpPush
				move.y = speed.y * direction.y - wallJumpHeight
		"""
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
	$AnimatedSprite.hide()
	$Gun.hide()
	if ($AnimatedSprite.flip_h):
		$DeadPlayer.flip_h = true
		$DeadPlayer.show()
		$DeadPlayer.play("death")
	else:
		$DeadPlayer.show()
		$DeadPlayer.play("death")
		
	yield(get_tree().create_timer(1), "timeout")
	respawn()
	
func respawn():
	dead = false
	health = max_health
	if(self.name == "player1"):
		self.position = get_node("/root/game/SpawnPosition1").position
	else:
		self.position = get_node("/root/game/SpawnPosition2").position
	$DeadPlayer.hide()
	$HealthBar._on_health_updated()
	$AnimatedSprite.show()
	$Gun.show()
	
func _set_health(value):
	var prev_health = health
	health = clamp(value, 0, max_health)
	if health != prev_health:
		emit_signal("health_updated", health)
		$HealthBar._on_health_updated()
		if health == 0:
			kill()
			emit_signal("killed")


func _on_DemoPlayerChangeDirection():

	directionLeft = !directionLeft
	if(directionLeft):
		moveDirection.x = -0.4
	else:
		moveDirection.x = 0.4
	

func _on_DemoPlayerJump():
	if(!jumping):
		jumping = !jumping
		moveDirection.y = -1.0
		yield(get_tree().create_timer(0.07), "timeout")
		moveDirection.y = 0.0
			
func _on_ShootTimer_timeout():
	get_node("Gun").emit_signal("demoShoot")



func _on_JumpTimer_timeout():
	if(randi() % 2):
		_on_DemoPlayerJump()
		
