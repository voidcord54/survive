extends Node2D

# Speed of the background scrolling
@export var scroll_speed: float = 100.0
@onready var background = $background

# Reference to the Sprite2D nodes
func _process(delta):
	background.scroll_offset.x -= scroll_speed * delta

