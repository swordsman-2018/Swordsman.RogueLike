extends Node2D

#export var rotation_angle = 50
export var middle_angle = 135
export var half_angle = 60
export var radius = 80

func _process(delta):
#	angle_from += rotation_angle
#	angle_to += rotation_angle
#    # We only wrap angles when both of them are bigger than 360.
#	if angle_from > 360 and angle_to > 360:
#		angle_from = wrapf(angle_from, 0, 360)
#		angle_to = wrapf(angle_to, 0, 360)
	update()

func _draw():
	var center = Vector2(0, 0)
	var color = Color(1.0, 0.0, 0.0, 0.2)
	var angle_from = middle_angle - half_angle
	var angle_to = middle_angle + half_angle

	draw_circle_arc_poly(center, radius, angle_from, angle_to, color)

func draw_circle_arc_poly(center, radius, angle_from, angle_to, color):
    var nb_points = 32
    var points_arc = PoolVector2Array()
    points_arc.push_back(center)
    var colors = PoolColorArray([color])

    for i in range(nb_points + 1):
        var angle_point = deg2rad(angle_from + i * (angle_to - angle_from) / nb_points - 90)
        points_arc.push_back(center + Vector2(cos(angle_point), sin(angle_point)) * radius)
    draw_polygon(points_arc, colors)