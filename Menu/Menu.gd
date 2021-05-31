extends Control


func _ready():
	pass


func _on_ButtonStart_pressed():
	get_tree().change_scene("res://MainGame/mainGame.tscn")

	
func _on_ButtonExit_pressed():
	get_tree().quit()
	

func _on_ButtonDemo_pressed():
	get_tree().change_scene("res://Demo/DemoGame.tscn")


func _on_ButtonOption_pressed():
	var options_menu = load("res://Menu/OptionMenu.tscn").instance()
	add_child(options_menu)
	get_node("OptionMenu").connect("CloseOptionMenu", self, "CloseOptionMenu")
	
func CloseOptionMenu():
	get_node("OptionMenu").queue_free()

