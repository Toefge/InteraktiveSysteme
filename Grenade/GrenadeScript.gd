extends KinematicBody2D

const THROW_VELOCITY = Vector2(800, -400)

var velocity = Vector2.ZERO
var gravity = 3000
var can_throw = true

var nade_instance = self

signal timeStart

func _ready():
	#set_physics_process(false)
	$Boom.hide()
	
func _physics_process(delta):	
	velocity.y += gravity * delta 
	var collision = move_and_collide(velocity * delta)
	if collision != null:
		_on_impact(collision.normal)

#launch() sets the speed at which the nade will fly off and saves its position in a temp variable so it doesnt 
#stick to the character
func launch(direction):
	var temp = global_transform
	var scene = get_tree().current_scene
	#get_parent().remove_child(self)
	scene.add_child(self)
	global_transform = temp
	velocity = THROW_VELOCITY *  Vector2(direction, 1)
	set_physics_process(true)
	#$NadeTimer.start()
			
#this funciton allows the grenade to bounce after colliding
func _on_impact(normal: Vector2):
	velocity = velocity.bounce(normal)
	velocity *= 0.5 + rand_range(-0.10, 0.10) # 0.5 defines how much will the projectile bounce, rand_range gives it a random extra or less bounce


func _on_NadeTimer_timeout():
	print("Timer reached 0")
	$Boom.show()
	yield(get_tree().create_timer(0.7), "timeout")
	get_parent().remove_child(nade_instance)

#func _on_Grenade_timeStart():
#	$NadeTimer.start(5)
