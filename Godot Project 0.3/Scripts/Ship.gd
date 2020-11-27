extends "res://Scripts/weightless.gd"
var Missile = preload("res://Scenes/Missile.tscn")
export var engine_thrust = -200
export var spin_thrust = 500
export var missile_speed = -300
export var recharge_time = 0.1

var thrust = Vector2()
var rotation_dir = 0
var recharge_timer = 0




func _process(delta):
	if Input.is_action_pressed("ui_up"):
		thrust = Vector2(0, engine_thrust)
	else:
		thrust	= Vector2()
		
	if Input.is_action_pressed("ui_left"):
		rotation_dir = -1
	elif Input.is_action_pressed("ui_right"):
		rotation_dir = 1
	else:
		rotation_dir = 0
		
		
	if Input.is_action_pressed("ui_accept"):
		if recharge_timer <= 0:
			var missile = Missile.instance()
			missile.position = position
			missile.rotation = rotation
			missile.linear_velocity = linear_velocity + Vector2(0, missile_speed).rotated(rotation)
			get_parent().add_child(missile)
			recharge_timer = recharge_time
		else:
			recharge_timer -= delta
		
		
func _integrate_forces(state):
	set_applied_force(thrust.rotated((rotation)))
	set_applied_torque(rotation_dir * spin_thrust)	
	._integrate_forces(state)

