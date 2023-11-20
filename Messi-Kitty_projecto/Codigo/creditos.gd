extends Node


func _on_boton_volver_button_up():
	get_tree().change_scene_to_file("res://Escenas/pantalla_principal.tscn")


func _on_video_stream_player_finished():
	get_tree().change_scene_to_file("res://Escenas/pantalla_principal.tscn")
