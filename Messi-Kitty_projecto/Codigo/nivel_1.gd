extends Node

@export var basura_scene: PackedScene
var puntajePrefix = "Puntaje: "
var contadorBasuraPrefix = "Basura acumulada: "

func _ready():
	new_game()
	
func new_game():
	Variables.puntaje = 0
	Variables.contadorBasura = 0
	$Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)
	$BasuraTimer.start()
	
func _process(delta):
	#if Variables.contadorBasura == 12:
	#	game_over()	
	$Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)
	


func game_over():
	$BasuraTimer.stop()

# Cuando el timer llega a cero spawneo nueva basura
# en una posicion random
func _on_basura_timer_timeout():
	# Creo la nueva instancia de la escena Basura
	var basura = basura_scene.instantiate()
	
	var tamanio_basura = basura.find_child("Sprite2D").texture.get_size()
	
	# Genero una posicion random inicial (probar get_viewport_rect())
	var xPos = randf() * get_viewport().get_visible_rect().size.x
	var yPos = randf() * get_viewport().get_visible_rect().size.y
	
	# Seteo la posicion a la nueva basura
	basura.position = Vector2(xPos, yPos)
	
	Variables.contadorBasura += 1
	
	# Agrego el nuevo objeto como hijo del nodo principal
	add_child(basura)
