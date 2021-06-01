extends HSlider


func _ready():
	pass # Replace with function body.




func _on_Musicvolume_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
