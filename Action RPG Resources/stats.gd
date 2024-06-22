extends Node2D

@export var max_health : int = 4
var health = max_health : set =_set_health
signal no_health	
signal health_change(value)
signal max_health_change(value)

func _set_health(value):
	health = value
	emit_signal("health_change",health)
	if health <= 0:
		emit_signal("no_health")
func _set_max_health(value):
	max_health = value
	self.health = min(health, max_health)
	emit_signal("max_health_change",health)
func _ready():
	self.health = max_health
