extends RigidBody2D


signal startTimer()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	if (body.name == "player1") || (body.name == "player2"):
		body.emit_signal("reload")
		emit_signal("startTimer")
		queue_free()
		
		
