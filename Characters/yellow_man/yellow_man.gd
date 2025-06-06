extends Node2D

var actionmap = {
	"LightPunch": {
		"ground": {
			"instance": load("res://Characters/yellow_man/Attacks/LightPunch_Ground.tscn"),
			"execute": (func():
			default(actionmap["LightPunch"]["ground"]["instance"])
			)
		},
		"air": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"crouched": {
			"res": "",
			"execute": (func():
			pass
			)
		}
	},
	"HeavyPunch": {
		"ground": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"air": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"crouched": {
			"res": "",
			"execute": (func():
			pass
			)
		}
	},
	"LightKick": {
		"ground": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"air": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"crouched": {
			"res": "",
			"execute": (func():
			pass
			)
		}
	},
	"HeavyKick": {
		"ground": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"air": {
			"res": "",
			"execute": (func():
			pass
			)
		},
		"crouched": {
			"res": "",
			"execute": (func():
			pass
			)
		}
	}
}

var Player = null

var action_frames = 0

func _ready():
	Player = get_parent()
	var file_name = get_meta("Character")
	
	
func parse_special(type):
	pass

func LightPunch():
	if parse_special("LP"):
		pass
	elif Player.crouching:
		actionmap["LightPunch"]["crouched"]["execute"].call()
	elif not Player.Body.is_on_floor():
		actionmap["LightPunch"]["air"]["execute"].call()
	else:
		actionmap["LightPunch"]["ground"]["execute"].call()
	

func LightKick():
	if not Player.crouching:
		pass

func HeavyPunch():
	if not Player.crouching:
		pass

func HeavyKick():
	if not Player.crouching:
		pass

func default(res):
	var instance = res.instantiate()
	var offset = instance.get_node("RectHitbox").position.x * 2
	add_child(instance)
	instance.position = $CharacterBody2D.position
	if Player.direction == -1:
		instance.position.x *= -1
		instance.position.x += $CharacterBody2D.position.x * 2 - offset
	action_frames = instance.get_meta("ActionFrames")

func _physics_process(delta: float) -> void:
	action_frames = clamp(action_frames - 1, -1, 9999)
	if action_frames == 0:
		get_parent().can_act = true
	elif action_frames > 0:
		get_parent().can_act = false
