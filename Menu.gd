extends Control


func _ready():
	pass


func _on_ButtonStart_pressed():
	get_tree().change_scene("res://game.tscn")

	
	
	

func _on_ButtonExit_pressed():
	get_tree().quit()
	