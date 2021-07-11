extends Node


export (PackedScene) var Box;

var position1;
var position2;


# Called when the node enters the scene tree for the first time.
func _ready():
	var box1 = Box.instance()
	var box2 = Box.instance()
	
	position1 = randomPosition()
	position2 = randomPosition()
	
	box1.position = position1
	while(position1 == position2):
		position2 = randomPosition()
	
	box2.position = position2
	
	add_child(box1)
	add_child(box2)
	box1.connect("startTimer", self, "spawnNewBox1")	
	box2.connect("startTimer", self, "spawnNewBox2")	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func spawnNewBox1():
	$SpawnTimer1.start()
	
func spawnNewBox2():
	$SpawnTimer2.start()



func _on_SpawnTimer1_timeout():
	var box1 = Box.instance()
	
	position1 = randomPosition()
	while(position1 == position2):
		position1 = randomPosition()
	
	box1.position = position1
	box1.connect("startTimer", self, "spawnNewBox1")
		
	add_child(box1)

func _on_SpawnTimer2_timeout():
	var box2 = Box.instance()
	
	position2 = randomPosition()
	while(position1 == position2):
		position2 = randomPosition()
	
	box2.position = position2
	box2.connect("startTimer", self, "spawnNewBox2")
		
	add_child(box2)

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
