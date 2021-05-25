extends Control

onready var health_bar = $HealthBar
onready var tweenBar = $TweenBar
onready var update_tween = $UpdateTween
onready var pulse_tween = $PulseTween


export (Color) var damage_color = Color.red
export (Color) var pulse_color = Color.white

export (float, 0, 1, 0.05) var danger = 0.5
export (float, 0, 1, 0.05) var gotHit = 1
export (bool) var will_pulse = false



func _assignHealth():
	get_parent().get("max_health")
	health_bar.max_value = get_parent().max_health
	tweenBar.max_value = get_parent().max_health
	
	
func _on_health_updated():
	var playerHealth = get_parent().health
	health_bar.value = playerHealth
	update_tween.interpolate_property(tweenBar, "value", tweenBar.value, playerHealth, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	update_tween.start()
	_assign_color(playerHealth)	

func _assign_color(playerHealth):
	if playerHealth < health_bar.max_value * gotHit:
		pulse_tween.interpolate_property(health_bar, "tint_progress", pulse_color, damage_color, 1, Tween.TRANS_SINE, Tween.EASE_IN_OUT)	
		pulse_tween.start()
	if playerHealth < health_bar.max_value * danger:
		pulse_tween
			
			
			
#func _on_max_health_updated(max_health):
#	health_bar.max_value = max_health

func _ready():
	_assignHealth()

#func _process(delta):
#	_on_health_updated()
