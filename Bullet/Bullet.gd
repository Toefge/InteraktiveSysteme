extends Area2D

export var speed = 500

func _ready():
	set_as_toplevel(true)
	
func _process(delta):
	position += (Vector2.RIGHT*speed).rotated(rotation) * delta
	Vector2(1,0)

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

func _on_bullet_body_entered(body):
	queue_free()
