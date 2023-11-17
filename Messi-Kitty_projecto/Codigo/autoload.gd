extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_boton_inicio_button_down():
	get_tree().change_scene_to_file("res://Escenas/nivel_1.tscn")


func _on_boton_creditos_button_down():
	get_tree().change_scene_to_file("res://Escenas/creditos.tscn")
