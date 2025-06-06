extends Node2D

var position_sign = -1
@onready
var p1body = $Player/Character/CharacterBody2D
@onready
var p2body = $Player2/Character/CharacterBody2D

func _physics_process(delta: float) -> void:
	if (p1body.global_position.x - p2body.global_position.x) * position_sign < 0:
		position_sign *= -1
		$Player.flip()
		$Player2.flip()
		pass
