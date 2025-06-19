extends Control

@onready var sub_viewport: SubViewport = $"../../SubViewport"
@export var pointer:Node3D
@onready var texture_rect: TextureRect = $TextureRect

var ray_length = 100
#works
#func _ready() -> void:
	#pass

func _input(event):
	if event is InputEventMouseButton:
		#print("Mouse Click/Unclick at: ", event.position)
		pass
	elif event is InputEventMouseMotion:
		#print("Mouse Motion at: ", event.position)
		var screen_view = texture_rect.get_screen_position()
		print(screen_view)
		
		# mouse position
		var mouse_position = event.position
		# if the texture rect position is not zero it update offset base on mouse position subtract rect position
		if screen_view.x != 0 and screen_view.y != 0:
			print("offset?")
			mouse_position.x = mouse_position.x - screen_view.x
			mouse_position.y = mouse_position.y - screen_view.y
			pass
		
		var camera:Camera3D = sub_viewport.get_viewport().get_camera_3d()
		# always the same in both
		var origin:Vector3 = camera.project_ray_origin(mouse_position) 
		# always 0,0,-1 with SubViewport, changes with position in top level Viewport
		var normal:Vector3 = camera.project_ray_normal(mouse_position) * ray_length
		#print(normal)
		var space = camera.get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.new()
		ray_query.from = origin
		ray_query.to = normal
		var raycast_result = space.intersect_ray(ray_query)
		print(raycast_result)
		if !raycast_result.is_empty():
			if pointer:
				pointer.global_position = raycast_result["position"]
		
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
