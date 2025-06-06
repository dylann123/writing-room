extends Node2D

const JUMP_HEIGHT = 400
const WALK_SPEED = 5000
const WALK_SPEED_CROUCH = WALK_SPEED * 1/5
const WALK_SPEED_AIR = 1000
const GRAVITY = 1000

var direction = 1 # right
var can_act = true
var crouching = false
var x_velocity_custom = 0
var x_velocity_last_on_floor = 0

var on_floor_last_frame = false
var left_floor_last_frame = false

var Character: Node2D = null
var Body: CharacterBody2D = null

var pnum: int = 0

func _ready() -> void:
	var charname = get_meta("Character")
	var char_scene = load("res://Characters/"+charname+"/"+charname+".tscn")
	var char_instance = char_scene.instantiate()
	add_child(char_instance)
	print("Loaded "+charname)
	
	Character = $Character
	Body = $Character/CharacterBody2D
	
	pnum = get_meta("PlayerNum")
	
	# floor is evil
	Body.floor_max_angle = deg_to_rad(1)
	
	# flip
	if pnum == 2:
		flip()

var inputs = {
	"Left": {
		"pressed": (func():
		if Body.is_on_floor():
			if crouching:
				x_velocity_custom -= WALK_SPEED_CROUCH
			else:
				x_velocity_custom -= WALK_SPEED
		else:
			x_velocity_custom -= WALK_SPEED_AIR
		),
	}, 
	"Right": {
		"pressed": (func():
		if Body.is_on_floor():
			if crouching:
				x_velocity_custom += WALK_SPEED_CROUCH
			else:
				x_velocity_custom += WALK_SPEED
		else:
			x_velocity_custom += WALK_SPEED_AIR
		),
	}, 
	"Up": {
		"just_pressed": (func():
		if not crouching and Body.is_on_floor():
			Body.velocity = Vector2(Body.velocity.x, -JUMP_HEIGHT)
			x_velocity_last_on_floor = x_velocity_custom
		),
	}, 
	"Down": {
		"just_pressed": (func():
		if Body.is_on_floor():
			set_crouching(true)
		),
		"just_released": (func():
		set_crouching(false)
		)
	}, 
	"LightPunch": {
		"just_pressed": (func():
		Character.LightPunch()
		),
	}, 
	"HeavyPunch": {
		"just_pressed": (func():
		Character.HeavyPunch()
		),
	}, 
	"LightKick": {
		"just_pressed": (func():
		Character.LightKick()
		),
	}, 
	"HeavyKick": {
		"just_pressed": (func():
		Character.HeavyKick()
		),
	}
}

func set_crouching(val):
	
	crouching = val
	
	$Character/CharacterBody2D/SpriteStanding.visible = not val
	$Character/CharacterBody2D/PhysicsBodyStanding.disabled = val
	
	$Character/CharacterBody2D/SpriteCrouching.visible = val
	$Character/CharacterBody2D/PhysicsBodyCrouching.disabled = not val

func _physics_process(delta):
	if not Body:
		return

	if Body.is_on_floor():
		x_velocity_custom = 0
	else:
		x_velocity_custom = x_velocity_last_on_floor
		
	if can_act:
		for k in inputs:
			var key = k
			if pnum == 1:
				if Input.is_action_just_pressed(key) and inputs[key].has("just_pressed"):
					inputs[key]["just_pressed"].call()
				if Input.is_action_pressed(key) and inputs[key].has("pressed"):
					inputs[key]["pressed"].call()
				if Input.is_action_just_released(key) and inputs[key].has("just_released"):
					inputs[key]["just_released"].call()
			elif pnum == 2:
				if Input.is_action_just_pressed(key + "Player2") and inputs[key].has("just_pressed"):
					inputs[key]["just_pressed"].call()
				if Input.is_action_pressed(key + "Player2") and inputs[key].has("pressed"):
					inputs[key]["pressed"].call()
				if Input.is_action_just_released(key + "Player2") and inputs[key].has("just_released"):
					inputs[key]["just_released"].call()
					
	Body.velocity.x = x_velocity_custom * delta
	Body.velocity.y += GRAVITY * delta
	Body.move_and_slide()

func flip():
	direction *= -1
	Body.get_node("SpriteStanding").scale.x *= -1
	Body.get_node("SpriteCrouching").scale.x *= -1
