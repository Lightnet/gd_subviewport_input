# gd subviewport input

# License: MIT

# Godot: 4.4

# Information:
	This is just a sample test for subviewport input handler test. To test raycast input hit position.

# methods:
	There are couple of ways to use subviewports.

	There are simple ways depend on the project build.
	
	One is the using the second camera to render another view or independent world render.

	Another is using pushing input.
```
@export var sub_viewport: SubViewport
#...
func _input(event):
	sub_viewport.get_viewport().push_input(event)
```
	Note that it required Control UI to get the handle input.

# Notes:
- When using the texture react you need to factor the scale from subviewport size and position different.


# control_input_test07.gd
```
@export var sub_viewport: SubViewport
@onready var texture_rect: TextureRect = $TextureRect
#...
var texture_rect_rect = texture_rect.get_global_rect()
var texture_rect_size = texture_rect_rect.size

var sub_viewport_size = Vector2(sub_viewport.size)

sub_viewport.get_viewport().push_input(event)#event push and convert
var sub_mouse_position = sub_viewport.get_viewport().get_mouse_position()
var sub_viewport_size = Vector2(sub_viewport.size) #convert due conflict different type

# Account for TextureRect scaling
var size_ratio = sub_viewport_size / texture_rect_size

# Adjust mouse position to be relative to the TextureRect
var mouse_position = (sub_mouse_position - texture_rect_pos) * size_ratio
#...
```
	This handle mouse position correctly in subviewport raycast.

	Note this could be use second camera follow. It dpend on the project.

# References:
- Godot 4 3D Mouse Tutorial
	- https://www.youtube.com/watch?v=mJRDyXsxT9g
- https://www.reddit.com/r/godot/comments/1hjloer/how_to_ray_cast_from_mouse_position_in_a/
- Ray-casting from the screen : Look at the mouse in 3D [GODOT]
	- https://www.youtube.com/watch?v=mmvIkkKJVlQ
- https://www.reddit.com/r/godot/comments/tx9x2b/a_guide_to_mouse_events_in_subviewports/
- https://godotengine.org/asset-library/asset/127
