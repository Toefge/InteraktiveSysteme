extends Control
signal CloseOptionMenu


func _on_Button_pressed():
	emit_signal("CloseOptionMenu")
	
	
	


func _on_ButtonBack_mouse_entered():
	$Buttonsound.play()
	
