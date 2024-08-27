extends Area2D
@onready var timer = $Timer
@onready var player = $"../../player"
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var timer2 = $Timer2
@onready var bullet_spawn = $bullet_spawn
@onready var attack_effect = $"../../attack_effect"


signal touch_enemy
const BULLET_PATH = preload("res://scene/bullet_enemy.tscn")
const EFFECT_PATH = preload("res://scene/attack_effect.tscn")

var health = 100
var distance_player = 0
var direction_player = 0
var flipping_distance = 100
var start_shoot = false
var shoot_cd = false


func _on_body_entered(body):
	timer.start()
	touch_enemy.emit()


func _on_timer_timeout():
	get_tree().reload_current_scene() # Replace with function body.

func _process(delta):
	distance_player = player.position.x
	if health <= 0:
		queue_free()
		
	direction_player = calculate_distance(distance_player)
	if abs(direction_player) < flipping_distance:
		start_shoot = true
	else:
		start_shoot = false
	if abs(direction_player) < flipping_distance and direction_player < 0:
		animated_sprite_2d.flip_h = true
	elif abs(direction_player) < flipping_distance and direction_player > 0:
		animated_sprite_2d.flip_h = false
	
	var bullet = BULLET_PATH.instantiate()
	if start_shoot and shoot_cd == false:
		bullet.position = bullet_spawn.position
		add_child(bullet)
		shoot_cd = true
		timer2.start()
		
func calculate_distance(distance_player):
	var distance = 0
	distance = distance_player - position.x
	return distance


func _on_timer_2_timeout():
	shoot_cd = false # Replace with function body.


func _on_area_entered(area):
	print("bullet come")
	attack_effect.global_position = self.global_position
	attack_effect.emitting = true
