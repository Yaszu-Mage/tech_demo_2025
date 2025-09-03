extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0
@export var sprint_multiplier = 100.0
@onready var sprite = $AnimatedSprite2D
var last_move = Vector2(0,1)
func _physics_process(delta: float) -> void:
	if (is_multiplayer_authority()):
		movement(delta)
		animation()

func animation():
	var input_dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	var is_sprinting = Input.is_action_just_pressed("sprint")
	var is_dashing = Input.is_action_just_pressed("dash")
	if input_dir:
		match input_dir:
			Vector2(0,-1):
				#up
				sprite.play("walk_up")
				sprite.flip_h = false
			Vector2(0,1):
				#down
				sprite.play("walk_down")
				sprite.flip_h = false
			Vector2(-1,0):
				#left
				sprite.play("walk_side")
				sprite.flip_h = true
			Vector2(1,0):
				#right
				sprite.play("walk_side")
				sprite.flip_h = false
			Vector2 (0.707107, -0.707107):
				#up right
				sprite.play("walk_side")
				sprite.flip_h = false
			Vector2 (-0.707107, -0.707107):
				#up left
				sprite.play("walk_side")
				sprite.flip_h = true
			Vector2(-0.707107, 0.707107):
				#up left
				sprite.play("walk_side")
				sprite.flip_h = true
			Vector2(0.707107, 0.707107):
				#up left
				sprite.play("walk_side")
				sprite.flip_h = false
	else:
				match last_move:
					Vector2(0,-1):
						#up
						sprite.play("idle_up")
						sprite.flip_h = false
					Vector2(0,1):
						#down
						sprite.play("idle_down")
						sprite.flip_h = false
					Vector2(-1,0):
						#left
						sprite.play("idle_side")
						sprite.flip_h = true
					Vector2(1,0):
						#right
						sprite.play("idle_side")
						sprite.flip_h = false
					Vector2 (0.707107, -0.707107):
						#up right
						sprite.play("idle_side")
						sprite.flip_h = false
					Vector2 (-0.707107, -0.707107):
						#up left
						sprite.play("idle_side")
						sprite.flip_h = true
					Vector2(-0.707107, 0.707107):
						#up left
						sprite.play("idle_side")
						sprite.flip_h = true
					Vector2(0.707107, 0.707107):
						#up left
						sprite.play("idle_side")
						sprite.flip_h = false

func movement(delta: float):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	if (get_multiplayer_authority() == int(name)):
		var is_sprinting = Input.is_action_just_pressed("sprint")
		var dir = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
		if is_sprinting:
			if dir:
				velocity = dir * SPEED * sprint_multiplier
				last_move = dir
			else:
				velocity = Vector2.ZERO
		else:
			if dir:
				velocity = dir * SPEED
				last_move = dir
			else:
				velocity = Vector2.ZERO
		
		move_and_slide()
	
