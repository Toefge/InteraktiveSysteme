extends Sprite



var can_fire = true
var bullet = preload("res://bullet.tscn")

func _ready():
	set_as_toplevel(true)
	
func _physics_process(delta):
	position.x = lerp(position.x, get_parent().position.x, 0.5)
	position.y = lerp(position.y, get_parent().position.y+5, 0.5)
	if Input.is_action_just_pressed("left"):
		look_at(Vector2(position.x * -1 , position.y))
	if Input.is_action_just_pressed("right"):
		look_at(Vector2(100000,position.y))
	#var mouse_pos = get_global_mouse_position()
	#look_at(mouse_pos)
	
	if Input.is_action_pressed("fire 2") and can_fire:
		var bullet_instance = bullet.instance()
		bullet_instance.rotation = rotation
		bullet_instance.global_position = $muzzle.global_position
		get_parent().add_child(bullet_instance)
		can_fire = false
		yield(get_tree().create_timer(0.2), "timeout")
		can_fire = true
