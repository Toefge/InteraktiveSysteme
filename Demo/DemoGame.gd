extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func _on_Button_pressed():
	queue_free()
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Button_mouse_entered():
	$Buttonsound.play()
	pass # Replace with function body.
