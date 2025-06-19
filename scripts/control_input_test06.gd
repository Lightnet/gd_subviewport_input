extends Control

@export var sub_viewport: SubViewport

@export var pointer: Node3D
@onready var texture_rect: TextureRect = $TextureRect
#@onready var camera_3d: Camera3D = $"../SubViewport/Node3D2/Camera3D"

# scale 2.0
@export var sscale:float = 1.0
var ray_length: float = 100.0

func _input(event):
	if event is InputEventMouseMotion:
		#camera_3d._unhandled_input(event.position)
		# Get the TextureRect's global position and scale
		var texture_rect_rect = texture_rect.get_global_rect()
		var texture_rect_pos = texture_rect_rect.position
		var texture_rect_scale = texture_rect.scale
		
		#sub_viewport.push_input(event)
		if !sub_viewport:
			print(sub_viewport)
			return
		sub_viewport.get_viewport().push_input(event)#event push and convert?
		
		var sub_mouse_position = sub_viewport.get_viewport().get_mouse_position()
		print("sub_mouse_position:", sub_mouse_position)
		
		# Adjust mouse position to be relative to the TextureRect
		#var mouse_position = event.position - texture_rect_pos
		var mouse_position = (sub_mouse_position - texture_rect_pos) * sscale
		
		# Account for TextureRect scaling
		mouse_position /= texture_rect_scale
		
		# Get SubViewport size and clamp mouse position
		var viewport_size = sub_viewport.size
		mouse_position.x = clamp(mouse_position.x, 0, viewport_size.x)
		mouse_position.y = clamp(mouse_position.y, 0, viewport_size.y)
		
		# Normalize mouse position to [0, 1] for viewport
		var normalized_mouse_pos = mouse_position /  Vector2(viewport_size)
		
		# Get the camera
		var camera: Camera3D = sub_viewport.get_viewport().get_camera_3d()
		if not camera:
			print("No camera found!")
			return
		
		# Calculate ray origin and direction using viewport coordinates
		var origin: Vector3 = camera.project_ray_origin(mouse_position)
		var direction: Vector3 = camera.project_ray_normal(mouse_position)
		var end: Vector3 = origin + direction * ray_length
		
		# Perform raycast
		var space = camera.get_world_3d().direct_space_state
		var ray_query = PhysicsRayQueryParameters3D.create(origin, end)
		var raycast_result = space.intersect_ray(ray_query)
		
		# Debug output
		#print("Mouse Window Pos: ", event.position)
		#print("TextureRect Pos: ", texture_rect_pos)
		#print("TextureRect Scale: ", texture_rect_scale)
		#print("Adjusted Mouse Pos: ", mouse_position)
		#print("Normalized Mouse Pos: ", normalized_mouse_pos)
		#print("Ray Origin: ", origin)
		#print("Ray Direction: ", direction)
		#print("Raycast Result: ", raycast_result)
		
		if not raycast_result.is_empty() and pointer:
			pointer.global_position = raycast_result["position"]
