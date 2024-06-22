extends CharacterBody2D
enum {
	MOVE,
	SKIP,
	ATTACK
}

@onready var animtionPlayer =$AnimationPlayer
@onready var animationTree = $AnimationTree
@onready var animationState = animationTree.get("parameters/playback")
@export var MAX_SPEED = 300
@export var SKIP_SPEED = 200
@export var ACCRELATION =500
@export var FRICTION =500
var state = MOVE
var skip_Vector=Vector2.LEFT
var stats = PlayerStats

func _ready():
	stats.connect("no_health",queue_free)
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVE:
			move_state(delta)
		SKIP:
			skip_state()
		ATTACK:
			attack_state()
			
func move_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") -Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") -Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector!=Vector2.ZERO:
		skip_Vector = input_vector
		animationTree.set("parameters/Idle/blend_position",input_vector)
		animationTree.set("parameters/Run/blend_position",input_vector)
		animationTree.set("parameters/Attack/blend_position",input_vector)
		animationTree.set("parameters/Skip/blend_position",input_vector)
		animationState.travel("Run")
		#velocity += input_vector*ACCRELATION*delta
		#velocity = velocity.limit_length(MAX_SPEED * delta)
		velocity =velocity.move_toward(input_vector*MAX_SPEED,ACCRELATION*delta)
	else: 
		skip_Vector=Vector2.LEFT
		animationState.travel("Idle")
		velocity = velocity.move_toward(Vector2.ZERO,FRICTION*delta)
	move_and_slide()
	if Input.is_action_just_pressed("attack"):
		state = ATTACK	
	if Input.is_action_just_pressed("skip"):
		state = SKIP

	
func attack_state():
	animationState.travel("Attack")
func  skip_state():
	animationState.travel("Skip")	
	velocity=skip_Vector*SKIP_SPEED
	move_and_slide()
	
func skip_animation_finished():
	velocity=velocity*0.4
	state = MOVE
func attack_animation_finished():
	state = MOVE


func _on_hurtbox_area_entered(area):
	if area.isHitBox:
		stats.health -= 1
