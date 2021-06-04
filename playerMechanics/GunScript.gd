extends Sprite

var can_fire = true
var bullet = preload("res://Bullet/bullet.tscn")
var left = "left"
var right = "right"
var shoot = "fire"
var bulletColor = Color.blue

var ammo = preload("res://Ammo/AmmoScript.gd")
var shots = 6

signal demoShoot()
var demo = false

func _ready():
	set_as_toplevel(true)
		
	
func _count_Shots():    #As the name says
	if shots > 0:
		can_fire = true
	if shots <= 0:
		can_fire = false
	
func _reload():
	shots = 6
	get_parent().get_node("Ammo").Reload()
	can_fire = true
	
	
func _physics_process(delta):
	position.x = lerp(position.x, get_parent().position.x, 0.5)
	position.y = lerp(position.y, get_parent().position.y+5, 0.5)
	if(!demo):
		if Input.is_action_just_pressed(left):
			look_at(Vector2(position.x * -1 , position.y))
		if Input.is_action_just_pressed(right):
			look_at(Vector2(100000,position.y))
		#var mouse_pos = get_global_mouse_position()
		#look_at(mouse_pos)
	
		if Input.is_action_pressed(shoot) and can_fire:
			var bullet_instance = bullet.instance()
			bullet_instance.modulate = bulletColor
			bullet_instance.rotation = rotation
			bullet_instance.global_position = $muzzle.global_position
			get_parent().add_child(bullet_instance)
			shots -= 1
			print("bullets left: ", shots)
			can_fire = false
			get_parent().get_node("Ammo").AmmoUpdate()
			#decides how often can the player shoot
			yield(get_tree().create_timer(0.2), "timeout")
			_count_Shots()
			
		if Input.is_action_just_pressed("Reload"):
			if can_fire == false:
				_reload()
		
		#can_fire = true
		
func flipGun(flip):
	if (flip):
		#Die 3 ist ein ausprobierter Wert!!! Sollte sich die größe der Map ändern
		#dann muss der Wert ggf angepasst werden!
		look_at(Vector2( 0, 3))
		

func _on_player_reload():
	_reload()

func _on_Gun_demoShoot():
	var bullet_instance = bullet.instance()
	bullet_instance.rotation = rotation
	bullet_instance.global_position = $muzzle.global_position
	get_parent().add_child(bullet_instance)
	shots -= 1
	print("bullets left: ", shots)
	can_fire = false
	if(shots == 0):
		shots = 6
		can_fire = true
	get_parent().get_node("Ammo").AmmoUpdate()
	#decides how often can the player shoot
	yield(get_tree().create_timer(0.2), "timeout")
	_count_Shots()
