extends Node2D

@export var posicionCentro: Vector2
@export var posicionIz: Vector2 
@export var posicionDe: Vector2
var enElCentro: bool


func _ready():
	position = posicionCentro
	enElCentro = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass

# Código para cambiar de lugar la pantalla y ocultar las flechitas.
func _on_flecha_iz_button_down():
	if enElCentro == true:
		position = posicionIz
		enElCentro = false
		$FlechaIz.visible = false
	else:
		position = posicionCentro
		enElCentro = true
		$FlechaDe.visible = true

func _on_flecha_de_button_down():
	if enElCentro == true:
		position = posicionDe
		enElCentro = false
		$FlechaDe.visible = false
	else:
		position = posicionCentro
		enElCentro = true
		$FlechaIz.visible = true


func _on_flecha_iz_2_button_down():
	position = posicionCentro


func _on_flecha_de_2_button_down():
	position = posicionCentro
