extends Area2D

func _on_animated_sprite_2d_animation_looped():
	var animation = get_child(0)
	animation.stop()
