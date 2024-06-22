extends Area2D
var player = null 
@export var isPlayer : bool = false


func _on_body_entered(body):
	if body.is_in_group("Player"):
		player = body
		isPlayer  = true
		

func _on_body_exited(body):
	if body == player:
		player = null
		isPlayer = false
	

