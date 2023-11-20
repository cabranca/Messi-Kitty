extends Node


func _on_boton_reiniciar_button_up():
	get_tree().change_scene_to_file("res://Escenas/nivel_1.tscn")


func _on_boton_salir_button_up():
	get_tree().change_scene_to_file("res://Escenas/pantalla_principal.tscn")
