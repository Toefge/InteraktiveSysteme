extends Control
signal CloseOptionMenu


func _on_Button_pressed():
	$ButtonClick.play()
	yield(get_tree().create_timer(0.1), "timeout")
	emit_signal("CloseOptionMenu")
	
	
func _on_ButtonBack_mouse_entered():
	$ButtonHover.play()
	
