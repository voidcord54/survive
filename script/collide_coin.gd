extends Area2D


var enable = true
@onready var audio_stream_player = $AudioStreamPlayer2D
@onready var sprite_2d = $Sprite2D

var new_color = Color(0.65, 0.16, 0.16)

func _on_body_entered(body):
	if enable:
		sprite_2d.modulate = Color("brown")
		global.add_coin()
		audio_stream_player.play()
		enable = false
