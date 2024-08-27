extends CharacterBody2D

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer
@onready var player = $"."
@onready var collision_shape = $CollisionShape2D
@onready var audio_stream_player = $AudioStreamPlayer2D
@onready var stop_menu = $"../canvas/stop_menu"

@onready var bullet_spawn = $bullet_spawn
@onready var bullet_container = $bullet_container
@onready var shoot = $shoot
@onready var timer = $AnimatedSprite2D/Timer

@onready var die_menu = $"../canvas/die_menu"




const ROOL_SPEED = move_toward(0,300,1000)
const SPEED = 150
const JUMP_VELOCITY = -330
const LIFT_VELOCITY = -430
const BULLET_PATH = preload("res://scene/bullet_player.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var on_lift = false
var enable_x = true
var look_right = true
var player_health = 3
var enable_rool = true
var enable_shoot = false

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

		
	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	# Get the input direction and handle the movement/deceleration.

	var direction = Input.get_axis("walk_left", "walk_right")
	
	if enable_x:
		if direction > 0:
			animated_sprite.flip_h = false
			look_right = true
			
		elif direction < 0:
			look_right = false
			animated_sprite.flip_h = true
			

		if direction:
			velocity.x = direction * SPEED

		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			
	move_and_slide()

	
	if Input.is_action_just_pressed("pause"):
		pause()
	
	if Input.is_action_just_pressed("lift") and on_lift:
		velocity.y = LIFT_VELOCITY
		
	if Input.is_action_just_pressed("attack") and enable_shoot:
		attack(look_right)
	
	if Input.is_action_just_pressed("rool") and is_on_floor() and enable_rool:
		rool(look_right)
	
	if player_health == 0:
		get_tree().paused = true
		die_menu.show()





func _on_area_2d_body_entered(body):
	on_lift = true




func _on_area_2d_body_exited(body):
	on_lift = false
	



func _on_sea_die():
	animation_player.play("die")
	die()
	
func pause():
	get_tree().paused = true
	stop_menu.visible = true
		
	
	
func _on_enemy_touch_enemy():
	die()

func die():
	collision_shape.queue_free()
	velocity.x = 0
	enable_x = false
	velocity.y = -250

func attack(look_right):
	var bullet = BULLET_PATH.instantiate()
	shoot.play()
	bullet.global_position = bullet_spawn.global_position
	get_parent().add_child(bullet)
	
	if look_right:
		bullet.speed = Vector2(1, 0) * bullet.SPEED  # Move to the right
	else:
		bullet.speed = Vector2(-1, 0) * bullet.SPEED  # Move to the left

	
		
func rool(look_right):
	enable_x = false
	animated_sprite.play("rool")
	timer.start()
	if look_right:
		player.velocity.x = ROOL_SPEED
		
	elif not look_right:
		velocity.x = -ROOL_SPEED
	enable_rool = false



func _on_animated_sprite_2d_animation_finished():
	animated_sprite.play("idle")
	enable_x = true
	print("rool stop")



func _on_timer_timeout():
	enable_rool = true 


