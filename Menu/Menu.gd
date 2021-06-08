extends Control


func _ready():
	pass


func _on_ButtonStart_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://MainGame/mainGame.tscn")

	
func _on_ButtonExit_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().quit()
	

func _on_ButtonDemo_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	get_tree().change_scene("res://Demo/DemoGame.tscn")


func _on_ButtonOption_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	var options_menu = load("res://Menu/OptionMenu.tscn").instance()
	add_child(options_menu)
	get_node("OptionMenu").connect("CloseOptionMenu", self, "CloseOptionMenu")
	
func CloseOptionMenu():
	get_node("OptionMenu").queue_free()



func _on_ButtonStart_mouse_entered():
	$ButtonHover.play()
	pass # Replace with function body.


func _on_ButtonOption_mouse_entered():
	$ButtonHover.play()
	pass # Replace with function body.


func _on_ButtonDemo_mouse_entered():
	$ButtonHover.play()
	pass # Replace with function body.


func _on_ButtonExit_mouse_entered():
	$ButtonHover.play()
	pass # Replace with function body.
