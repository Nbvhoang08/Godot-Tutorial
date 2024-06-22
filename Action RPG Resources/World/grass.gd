extends Node2D
	
func create_grass_effect():
	var GrassEffect =load("res://Action RPG Resources/Effects/grass_effect.tscn")
	var grassEffect = GrassEffect.instantiate()
	var MainScreen = get_tree().current_scene		
	MainScreen.add_child(grassEffect)
	grassEffect.global_position = global_position

func _on_hurtbox_area_entered(area):
	if area.isHitBox:
		create_grass_effect()
		queue_free()
