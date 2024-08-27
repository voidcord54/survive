extends Control
@onready var stop_menu = $"."
var pause = false


func _on_resume_pressed():
	resume()

func _on_exit_pressed():
	quit() 

func resume():
	get_tree().paused = false
	stop_menu.visible = false
	

func quit():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://scene/main.tscn")
	


