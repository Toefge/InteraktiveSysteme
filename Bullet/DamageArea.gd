extends Area2D

signal entity_damaged(entity)

export (float) var damage_amount = 2

var exceptions = []

func add_exception(node : Node):
	exceptions.append(node)
	
func remove_exception(node : Node):
	exceptions.erase(node)
	
func _on_DamageArea_area_entered(area):
	if area is Hitbox:
		if !exceptions.has(area.entity) && area.entity.has_method("damage"):
			area.entity.damage(damage_amount, "Bullet") #(damage_amount, self) for testing

