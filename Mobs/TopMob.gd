extends Node2D


#const IDLE_Duration = 0.5

export var move_to = Vector2.RIGHT * 100
export var speed = 3.0

var follow = Vector2.ZERO

onready var platform = $Platform
onready var tween = $MoveTween

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_tween()
	
func _init_tween():
	var duration = move_to.length() / speed
	tween.interpolate_property(self, "follow", Vector2.ZERO, move_to, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, 0)
	tween.interpolate_property(self, "follow", move_to, Vector2.ZERO, duration, Tween.TRANS_LINEAR, Tween.EASE_IN, duration)
	tween.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	platform.position = platform.position.linear_interpolate(follow, 0.075)
