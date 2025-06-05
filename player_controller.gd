extends Node2D

const inputs = ["Up", "Down", "Left", "Right", "LightPunch", "HeavyPunch", "LightKick", "HeavyKick"]

func _physics_process(delta):
	for k in inputs:
		var key = k
		if get_meta("PlayerNum") == 1:
			if Input.is_action_just_pressed(key):
				pass
			if Input.is_action_just_released(key):
				pass
		elif get_meta("PlayerNum") == 2:
			if Input.is_action_just_pressed(key + "Player2"):
				pass
			if Input.is_action_just_released(key + "Player2"):
				pass
