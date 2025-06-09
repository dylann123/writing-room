extends Node

var damage_amount = 0

var frames = 0
var startframe = 1000
var activeframes = 0

var player: Node2D = null

func _ready():
	player = get_parent().get_parent().get_parent()
	
	damage_amount = get_meta("Damage")
	startframe = get_meta("StartFrame")
	activeframes = get_meta("ActiveFrames")
	damage_amount = get_meta("Damage")
	$Area2D.connect("body_entered",_on_body_entered)
	
	$Area2D/CollisionShape2D.disabled = false  # Start disabled

func activate():
	$Area2D/CollisionShape2D.disabled = false

func deactivate():
	queue_free()

func _physics_process(_delta: float) -> void:
	frames += 1
	if frames > startframe and $Area2D/CollisionShape2D.disabled == true:
		activate()
	if frames > startframe + activeframes:
		deactivate()

func _on_body_entered(body):
	var EnemyPlayer = body.get_parent().get_parent()
	if EnemyPlayer == player:
		return
	if EnemyPlayer.get_meta("PlayerNum") and not $Area2D/CollisionShape2D.disabled:
		if player.direction == -1:
			EnemyPlayer.hit(damage_amount, -get_meta("HorizontalKnockback"), get_meta("VerticalKnockback"))
		else:
			EnemyPlayer.hit(damage_amount, get_meta("HorizontalKnockback"), get_meta("VerticalKnockback"))
		deactivate()
