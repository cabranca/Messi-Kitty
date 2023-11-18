extends Node


func _on_boton_reanudar_button_up():
	queue_free()
	Variables.menuAbierto = false


func _on_boton_salir_button_up():
	get_tree().change_scene_to_file("res://Escenas/pantalla_principal.tscn")
	Variables.menuAbierto = false
