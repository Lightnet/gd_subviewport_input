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
- small size offset not working for rect texture a lot of work.
	- 128x128 does not work
	- 512x512 work

# References:
- Godot 4 3D Mouse Tutorial
	- https://www.youtube.com/watch?v=mJRDyXsxT9g
- https://www.reddit.com/r/godot/comments/1hjloer/how_to_ray_cast_from_mouse_position_in_a/
- Ray-casting from the screen : Look at the mouse in 3D [GODOT]
	- https://www.youtube.com/watch?v=mmvIkkKJVlQ
- https://www.reddit.com/r/godot/comments/tx9x2b/a_guide_to_mouse_events_in_subviewports/



# 
