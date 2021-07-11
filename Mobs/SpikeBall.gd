extends RigidBody2D

var init = true;
var direction = 1;

func _ready():
	contacts_reported = 1

func _physics_process(delta):
	if (init):
		apply_central_impulse(Vector2(direction * 7, 0))
	angular_velocity = direction * 5
	#apply_impulse(Vector2(1, 0) ,Vector2(10, 0))

func _on_DeleteTimer_timeout():
	queue_free()

func _on_SpikeBall_body_entered(body):
	init = false
	if(body.name == "player1" || body.name == "player2"):
		body.damage(10)
	#contacts_reported = 0
