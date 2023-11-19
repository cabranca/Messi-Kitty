extends Node

@export var basura_scene: PackedScene
@export var menu_pausa_escena: PackedScene

var puntajePrefix = "Puntaje: "
var contadorBasuraPrefix = "Basura acumulada: "
var contadorNuevaBasura = 0

func _ready():
	new_game()
	
func new_game():
	Variables.puntaje = 0
	Variables.contadorBasura = 0
	Variables.menuAbierto = false
	$Ui/Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$Ui/ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)
	$BasuraTimer.start()
	
func _process(delta):
	if Variables.contadorBasura == 30:
		game_over()	
	
	update_timer()
	$Ui/Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$Ui/ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)
	

func update_timer():
	if Variables.menuAbierto and not $BasuraTimer.is_stopped():
		$BasuraTimer.stop()
	if not Variables.menuAbierto and $BasuraTimer.is_stopped():
		$BasuraTimer.start()

func game_over():
	$BasuraTimer.stop()

# Cuando el timer llega a cero spawneo nueva basura
# en una posicion random
func _on_basura_timer_timeout():
	# Creo la nueva instancia de la escena Basura
	var basura = basura_scene.instantiate()
	
	#var tamanio_basura = basura.find_child("Sprite2D").texture.get_size()
	
	# Genero una posicion random inicial (probar get_viewport_rect())
	var xPos = randf() * $FondoA.size.x
	var yPos = randf() * $FondoA.size.y
	
	# Seteo la posicion a la nueva basura
	basura.position = Vector2(xPos, yPos)
	
	Variables.contadorBasura += 1
	
	# Cada 5 basuras que creo hago que una tenga sonido
	if contadorNuevaBasura % 5 == 0:
		$CaidaObjeto.play()
	contadorNuevaBasura += 1
	
	# Agrego el nuevo objeto como hijo del nodo principal
	add_child(basura)
	

func _input(ev):
	if Input.is_key_pressed(KEY_ESCAPE):
		if Variables.menuAbierto:
			cerrar_menu_pausa()
		else:
			abrir_menu_pausa()
		
func abrir_menu_pausa():
	var menu = menu_pausa_escena.instantiate()
	add_child(menu)
	Variables.menuAbierto = true
	
func cerrar_menu_pausa():
	var menu = get_node("MenuPausa")
	remove_child(menu)
	Variables.menuAbierto = false
