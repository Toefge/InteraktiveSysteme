extends Control


func _ready():
	pass


func _on_ButtonStart_pressed():
	get_tree().change_scene("res://MainGame/mainGame.tscn")

	
func _on_ButtonExit_pressed():
	get_tree().quit()
	

func _on_ButtonDemo_pressed():
	get_tree().change_scene("res://Demo/DemoGame.tscn")
