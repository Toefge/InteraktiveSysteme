extends Node

onready var bullets = $AmmoBar
onready var ammotween = $AmmoTween

export (Color) var first_color = Color.darkgray
export (Color) var pulse_color = Color.red
export (Color) var white_color = Color.white

func _assignAmmo():
	bullets.max_value = 6
	bullets.value = 6
	
func AmmoUpdate():
	var currentAmmo = get_parent().get_node("Gun").shots
	bullets.value = currentAmmo
	_assign_color(bullets)

func Reload():
	var currentAmmo = get_parent().get_node("Gun").shots
	bullets.value = currentAmmo
	
	
func _assign_color(bullets):
	if bullets.value <= 0:
		ammotween.interpolate_property(bullets, "tint_under", first_color, pulse_color, 0.9, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
		ammotween.start()
	if bullets.value > 0:
		ammotween.interpolate_property(bullets, "tint_progress", white_color, white_color, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
		ammotween.interpolate_property(bullets, "tint_under", first_color, first_color, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
		ammotween.start()
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	_assignAmmo()


