extends CharacterBody2D
const SPEED = 500
var direction: Vector2

@onready var player = $"../../../player"
@onready var bullet_aim = player.get_node("bullet_aim")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	if player:
		direction = (bullet_aim.global_position - global_position).normalized()

func _physics_process(delta):
	velocity = direction * SPEED
	move_and_slide()
	

func _on_bullet_enemy_body_entered(body):
	self.queue_free()
	if body.name == "player":
		player.player_health -= 1
		print("player hp now is : " + str(player.player_health))
