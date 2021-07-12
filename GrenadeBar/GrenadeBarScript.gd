extends Node

onready var nade = $GrenadeBar
onready var ammotween = $AmmoTween


func _assignAmmo():
	nade.max_value = 2
	nade.value = 2
	
func NadeUpdate():
	var currentNades = get_parent().get_node("Gun").grenades
	nade.value = currentNades

func Reload():
	var currentNades = get_parent().get_node("Gun").grenades
	nade.value = currentNades
	

# Called when the node enters the scene tree for the first time.
func _ready():
	_assignAmmo()


