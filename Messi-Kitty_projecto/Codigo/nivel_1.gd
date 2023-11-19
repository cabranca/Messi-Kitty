extends Node

@export var basura_scene: PackedScene
@export var menu_pausa_escena: PackedScene
@export var messi_escena : PackedScene

var puntajePrefix = "Puntaje: "
var contadorBasuraPrefix = "Basura acumulada: "
var contadorNuevaBasura = 0
var messiOnScene = false
var spawnPositions = [Vector2(-1536, 910), Vector2(-1104, 638), Vector2(-640, 606), 
	Vector2(-144, 702), Vector2(176, 848), Vector2(288, 670), Vector2(480, 478), 
	Vector2(1184, 782), Vector2(1568, 670), Vector2(1344, 506), Vector2(2048, 758), 
	Vector2(2240, 164), Vector2(2592, 220), Vector2(2592, 622), Vector2(3008, 565)]
var fakeIndex = 0

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
	
	
	if messiOnScene:
		var messi = get_node("Messi")
		if not messi.find_child("AnimatedSprite2D").is_playing():
			init_basura()
			
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


# Cuando el timer llega a cero spawneo a Messi en una posicion de las posibles
func _on_basura_timer_timeout():
	# Creo una instancia de Messi
	var messi = messi_escena.instantiate()
	
	# Seteo la posicion incial donde sea que este el indice de spawn
	var index = int(round(randf() * 15))
	if index == 15:
		index = 14
	messi.position = spawnPositions[index]
	
	# Agrego a Messi  y elijo una animacion
	add_child(messi)
	var animation = messi.find_child("AnimatedSprite2D")
	# Falta la posibilidad de otra animacion
	animation.play("tirando")
	messiOnScene = true


# Cuando Messi haya terminado la animacion se llama esta funcion para borrarlo y agregar basura
func init_basura():
	# Creo la nueva instancia de la escena Basura
	var basura = basura_scene.instantiate()
	
	# Encuentro a Messi
	var messi = get_node("Messi")
	
	# Seteo la posicion a la nueva basura
	basura.position = messi.position
	
	#Elimino a Messi
	remove_child(messi)
	messiOnScene = false
	
	# Aumento el contador de basura
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
