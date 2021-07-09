extends Node


export (PackedScene) var Box;


# Called when the node enters the scene tree for the first time.
func _ready():
	var box = Box.instance()
	add_child(box)
	box.position = $BoxSpawnPosition1.position
	
	box.connect("startTimer", self, "spawnNewBox")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnNewBox():
	$SpawnTimer.start()


func _on_SpawnTimer_timeout():
	var box = Box.instance()
	add_child(box)
	box.position = randomPosition()
	
	box.connect("startTimer", self, "spawnNewBox")
	
func randomPosition():
	match randi() % 5 +1:
		1:
			return $BoxSpawnPosition1.position
		2:
			return $BoxSpawnPosition2.position
		3:
			return $BoxSpawnPosition3.position
		4:
			return $BoxSpawnPosition4.position
		5:
			return $BoxSpawnPosition5.position
