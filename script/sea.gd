extends Sprite2D
signal die
@onready var timer = $killzone/Timer
@onready var player = $player


func _on_area_2d_body_entered(body):
	die.emit()
	timer.start()

	
func _on_timer_timeout():
	get_tree().reload_current_scene()

