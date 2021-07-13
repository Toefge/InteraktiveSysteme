extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Button_mouse_entered():
	$ButtonHover.play()
