extends Node2D

var lightpunchres: Resource = null
var lightpunchinstance: Node2D = null
var lightkickres: Resource = null
var lightkickinstance = null
var heavypunchres: Resource = null
var heavypunchinstance = null
var heavykickres: Resource = null
var heavykickinstance = null

var Player = null

var action_frames = 0

func _ready():
	Player = get_parent()
	var file_name = get_meta("Character")
	
	lightpunchres = load("res://Characters/yellow_man/Attacks/LightPunch.tscn")

func LightPunch():
	if not Player.crouching:
		lightpunchinstance = lightpunchres.instantiate()
		var offset = lightpunchinstance.get_node("RectHitbox").position.x * 2
		add_child(lightpunchinstance)
		lightpunchinstance.position = $CharacterBody2D.position
		if Player.direction == -1:
			lightpunchinstance.position.x *= -1
			lightpunchinstance.position.x += $CharacterBody2D.position.x * 2 - offset
		action_frames = lightpunchinstance.get_meta("ActionFrames")

func LightKick():
	if not Player.crouching:
		pass

func HeavyPunch():
	if not Player.crouching:
		pass

func HeavyKick():
	if not Player.crouching:
		pass

func _physics_process(delta: float) -> void:
	action_frames -= 1
	if action_frames == 0:
		get_parent().can_act = true
	elif action_frames > 0:
		get_parent().can_act = false
