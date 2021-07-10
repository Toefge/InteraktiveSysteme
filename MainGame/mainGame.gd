extends Node


func _ready():
	randomize()

func _on_Button_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
	get_tree().change_scene("res://Menu/Menu.tscn")


func _on_Button_mouse_entered():
	$ButtonHover.play()
