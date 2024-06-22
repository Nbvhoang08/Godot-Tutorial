extends Area2D

const  HitEffect = preload("res://Action RPG Resources/Effects/hit_effect.tscn")

@export var isHitBox : bool = false
@onready var timer =$Timer
var invicible : bool = false : set = set_invicible
signal invicibility_started
signal invicibility_ended

func set_invicible(value):
	invicible = value
	if invicible == true :
		emit_signal("invicibility_started")
	else:
		emit_signal("invicibility_ended")

func start_incibility(duration):
	self.invicible = true
	timer.start(duration)
func _on_timer_timeout():
	self.invicible = false

func _on_invicibility_started():
	monitorable = false
func _on_invicibility_ended():
	monitorable = true

func _on_area_entered(area):
	if area.isHitBox :
		var effect = HitEffect.instantiate()
		var main = get_tree().current_scene
		main.add_child(effect)
		effect.global_position = global_position
