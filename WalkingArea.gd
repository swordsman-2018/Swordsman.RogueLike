extends Node2D

func _ready():
	self.hide()

func _draw():
	var radius = 100
	var circle_color = Color(0.68, 0.85, 0.9, 0.1)
	draw_circle(Vector2(0,0), radius, circle_color)

