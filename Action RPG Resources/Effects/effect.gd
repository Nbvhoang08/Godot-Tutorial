extends AnimatedSprite2D

# Được gọi khi nút nhập vào cây cảnh lần đầu tiên.
func _ready():
	self.connect("animation_finished",_on_animation_finished)
	play("Animate")
	

func _on_animation_finished():
	self.queue_free()  
