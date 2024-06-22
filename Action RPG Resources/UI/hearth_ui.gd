extends Node2D

var heart: int =6
var max_heart: int = 6 
@onready var HeartUIFull:TextureRect =$HeartUiFull
@onready var HeartUIEmpty: =$HeartUIEmpty

func set_hearts(value: int) -> void:
	heart = clamp(value, 0, max_heart)
	if HeartUIFull != null:
		HeartUIFull.size.x = heart * 15 

func set_max_hearts(value: int) -> void:
	max_heart = max(value, 1)
	heart = min(heart, max_heart)
	if HeartUIEmpty != null:
		HeartUIEmpty.size.x = heart * 15

func _ready() -> void:
	max_heart = PlayerStats.max_health
	heart = PlayerStats.health
	PlayerStats.connect("health_change",set_hearts)
	PlayerStats.connect("max_health_change",set_max_hearts)
