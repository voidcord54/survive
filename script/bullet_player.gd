extends CharacterBody2D
@onready var attack_effect = $attack_effect

var damage = 50
const SPEED = 500
var speed = Vector2(1,0)
func _process(delta):
	move_and_collide(speed.normalized() * delta * SPEED)


func _on_bullet_player_body_entered(body):
	queue_free() 
	


func _on_bullet_player_area_entered(enemy):
	enemy.health -= damage
	self.queue_free()
	







