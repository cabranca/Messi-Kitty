extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Escenas/nivel_1.tscn")


func _on_texture_button_button_up():
	get_tree().change_scene_to_file("res://Escenas/pantalla_principal.tscn")


func _on_boton_anivel_button_up():
	get_tree().change_scene_to_file("res://Escenas/nivel_1.tscn")
