extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass


func _on_boton_inicio_button_down():
	$PlayButtonClick.play()
	while $PlayButtonClick.playing:
		pass
	get_tree().change_scene_to_file("res://Escenas/nivel_1.tscn")


func _on_boton_creditos_button_down():
	get_tree().change_scene_to_file("res://Escenas/creditos.tscn")
	

func _on_boton_salir_button_down():
	get_tree().quit()



func _on_boton_cinematica_button_down():
	get_tree().change_scene_to_file("res://Escenas/cinematica.tscn")
