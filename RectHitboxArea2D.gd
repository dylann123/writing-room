extends Node

var damage_amount = 0

var frames = 0
var startframe = 1000
var activeframes = 0

var player: Node2D = null

func _ready():
	player = get_parent().get_parent()
	
	damage_amount = get_meta("Damage")
	startframe = get_meta("StartFrame")
	activeframes = get_meta("ActiveFrames")
	damage_amount = get_meta("Damage")
	$Area2D.connect("body_entered",_on_body_entered)
	
	$Area2D/CollisionShape2D.disabled = false  # Start disabled

func activate():
	$Area2D/CollisionShape2D.disabled = false

func deactivate():
	$Area2D/CollisionShape2D.disabled = true
	queue_free()

func _physics_process(delta: float) -> void:
	frames += 1
	$Area2D/CollisionShape2D
	if frames > startframe and $Area2D/CollisionShape2D.disabled == true:
		activate()
	if frames > startframe + activeframes:
		deactivate()

func _on_body_entered(body):
	if body.get_parent().get_parent() == get_parent():
		return
	if body.get_parent().get_meta("PlayerNum") and not $Area2D/CollisionShape2D.disabled:
		body.get_parent().take_damage(damage_amount)
		deactivate()
