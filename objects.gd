extends KinematicBody2D

var move = Vector2()
var speed = 200
var jump_speed = -400
var gravity = 10
var lastdirection = 1

func _physics_process(delta):
	move.y += gravity
	move.x = (Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left") )* speed
	if sign(move.x) == 0:
		$Sprite.flip_h = lastdirection == -1
	elif sign(move.x) == -1:
		lastdirection = -1
		$Sprite.flip_h = true
	else:
		lastdirection = 1
		$Sprite.flip_h = false
	if move.y < 0: $Sprite.play("jump")
	if move.x !=0: $Sprite.play("run")
	else: $Sprite.play("idle")
	if Input.is_action_pressed("ui_up") and is_on_floor():
		move.y =  jump_speed	
	move_and_slide(move, Vector2.UP)	



