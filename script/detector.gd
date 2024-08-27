extends Node
@onready var timer_space = $space/Timer
@onready var press_space = $"../canvas/press_space"

@onready var press_lift = $"../canvas/press_lift"
@onready var timer_lift = $lift/Timer

@onready var press_shoot = $"../canvas/press_shoot"
@onready var timer_shoot = $shoot/shoot

@onready var win_menu = $"../canvas/win_menu"

var enable_show_space = true
var enable_show_lift = true
var enable_show_shoot = true

func _on_space_body_entered(body):
	if enable_show_space:
		press_space.show()
		timer_space.start()
		enable_show_space = false


func _on_timer_timeout():
	press_space.hide()


func _on_lift_body_entered(body):
	if enable_show_lift:
		press_lift.show()
		timer_lift.start()
		enable_show_lift = false


func _on_timer_lift_timeout():
	press_lift.hide()


func _on_shoot_body_entered(body):
	if enable_show_shoot:
		press_shoot.show()
		timer_shoot.start()
		enable_show_shoot = false


func _on_shoot_timeout():
	press_shoot.hide()


func _on_win_body_entered(body):
	win_menu.show()
	get_tree().paused = true
