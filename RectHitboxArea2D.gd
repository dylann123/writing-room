extends Node

var damage_amount = get_meta("Damage")

func _ready():
	damage_amount = get_meta("Damage")
	$Area2D.connect("body_entered",_on_body_entered)
	
	$Area2D/CollisionShape2D.disabled = false  # Staart disabled

func activate():
	$Area2D/CollisionShape2D.disabled = false

func deactivate():
	$Area2D/CollisionShape2D.disabled = true

func _on_body_entered(body):
	if body.get_parent().get_meta("PlayerNum") and not $Area2D/CollisionShape2D.disabled:
		body.get_parent().take_damage(damage_amount)
		deactivate()
