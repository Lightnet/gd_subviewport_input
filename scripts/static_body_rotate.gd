extends StaticBody3D

var rotation_amount = 1

#func _ready() -> void:
	#pass

func _process(delta: float) -> void:
	rotation.y += rotation_amount * delta
	#pass
