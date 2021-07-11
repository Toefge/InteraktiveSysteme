extends Node2D


export (PackedScene) var spikeBall;
var direction = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("Fliegen")

func _on_SpawnSpikeBallTimer_timeout():
	$SpawnSpikeBallTimer.wait_time = randomTime()
	var ball = spikeBall.instance()
	ball.position = $AnimatedSprite.position
	ball.direction = direction
	add_child(ball)
	
func changeDirection():
	if(direction == 1):
		direction = -1
	else:
		direction = 1
	print(direction)

func randomTime():
	return (randi() % 5 + 4)
