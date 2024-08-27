extends AnimatedSprite2D

@onready var animation_player = $AnimationPlayer



func _on_area_2d_body_entered(body):
	animation_player.play("pickup")
	global.coin += 1
	print ("your coin is: " + str(global.coin))
	
