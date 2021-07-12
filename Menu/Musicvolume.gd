extends HSlider


func _ready():
	value = AudioServer.get_bus_volume_db(0)




func _on_Musicvolume_value_changed(value):
	AudioServer.set_bus_volume_db(0,value)
