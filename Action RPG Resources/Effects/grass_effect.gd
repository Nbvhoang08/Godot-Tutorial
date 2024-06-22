extends Node2D

@onready var animateSprite = $AnimatedSprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	animateSprite.frame =0
	animateSprite.play("animate")

# Called every frame. 'delta' is the elapsed time since the previous frame.


func _on_animated_sprite_2d_animation_finished():
	queue_free() # Replace with function body.
