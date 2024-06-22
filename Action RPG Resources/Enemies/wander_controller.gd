extends Node2D
@export var rand_wander :int = 64
@onready var start_position = global_position
@onready var target_position = global_position
@onready var timer =$Timer

func update_target_position():
	var target_vector = Vector2(randi_range(-rand_wander,rand_wander),randi_range(-rand_wander, rand_wander))
	start_position = target_position
	target_position = start_position + target_vector
	
	print(start_position)
func start_wander_timer(duration):
	timer.start(duration)
func _on_timer_timeout():
	update_target_position()
	print("lỏ")
