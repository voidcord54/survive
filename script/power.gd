extends Area2D

var rotation_speed = 360
var can_collide = true
@onready var sprite_2d = $Sprite2D
@onready var audio_stream_player_2d = $AudioStreamPlayer2D



func _on_body_entered(body):
	body.enable_shoot = true
	queue_free()


func _on_power_collide_body_entered(body):
	if can_collide:
		audio_stream_player_2d.play()
		self.show()
		can_collide = false


func _process(delta):
	sprite_2d.rotation_degrees += rotation_speed * delta
