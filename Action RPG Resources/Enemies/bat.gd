extends CharacterBody2D

# thay knockback bằng velocity
enum{
	Idle,
	Wander,
	Chase
}
@onready var stats =$stats
const EnemyDeathEffect = preload("res://Action RPG Resources/Effects/enemy_death_effect.tscn")
@onready var detectionZone = $PlayerDetectionZone
@onready var wanderController =$WanderController
var state
@export var MAX_SPEED = 50
@export var ACCRELATION =300
@export var FRICTION =200

func _ready():
	state =Idle
func _physics_process(delta):
	velocity = velocity.move_toward(Vector2.ZERO, FRICTION*delta)
	move_and_slide()

	print(state)
	match state:
		Idle:
			velocity = velocity.move_toward(Vector2.ZERO,FRICTION*delta)
			seek_player()
			if wanderController.timer.time_left >= 0 && wanderController.timer.time_left <=0.01:
				state = pick_new_state([Idle,Wander])
				wanderController.start_wander_timer(randi_range(1,3))	
		Wander:
			seek_player()
			var direction =global_position.direction_to(wanderController.target_position)
			velocity = velocity.move_toward(direction*MAX_SPEED, ACCRELATION*delta)	
			if wanderController.timer.time_left >= 0 && wanderController.timer.time_left <=0.01 :
				state = pick_new_state([Idle,Wander])
				wanderController.start_wander_timer(randi_range(1,3))
				
				
		Chase:
			if detectionZone.player !=null:
				var direction = position.direction_to(detectionZone.player.global_position)
				velocity = velocity.move_toward(direction*MAX_SPEED, ACCRELATION*delta)
				move_and_slide()
			
				
func _on_hurtbox_area_entered(area):
	if area.isHitBox:
		stats.health -= area.damage
		var knockback_vector = (global_position -area.global_position).normalized()
		velocity = knockback_vector *100
		if stats.health <= 0:
			queue_free()
	
func _on_stats_no_health():
	queue_free() # Replace with function body.
	var enemyDeathEffect=EnemyDeathEffect.instantiate()
	get_parent().add_child(enemyDeathEffect)
	enemyDeathEffect.global_position = global_position
func seek_player():
	if detectionZone.player != null:
		state = Chase
	else:
		if state == null:
			state = pick_new_state([Idle,Wander])
			wanderController.start_wander_timer(randi_range(1,3))	
func pick_new_state(state_list):
		state_list.shuffle()
		return state_list.front()
	
