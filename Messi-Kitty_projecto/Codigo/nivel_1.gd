extends Node

@export var basura_scene: PackedScene
@export var menu_pausa_escena: PackedScene
@export var messi_escena : PackedScene

var puntajePrefix = "Puntaje: "
var contadorBasuraPrefix = "Basura acumulada: "
var barraBasura
var contadorApariciones = 0
var messiOnScene = false
var spawnPositions = [
	{"pos": Vector2(-627, 612), "animacion": "tirando", "nodo": "Mate" }, # Mate
	{"pos": Vector2(-1650, 908), "animacion": "tirando", "nodo": "Zapatillas"}, # Zapas
	{"pos": Vector2(418, 473), "animacion": "tirando", "nodo": "Planta"}, # Planta 1
	{"pos": Vector2(1305, 501), "animacion": "tirando", "nodo": "Piluso"}, # Piluso
	{"pos": Vector2(2085, 166), "animacion": "tirando", "nodo": "Corneta"}, # Corneta
	{"pos": Vector2(2512, 218), "animacion": "tirando", "nodo": "Planta2"}, # Planta 2
	{"pos": Vector2(2027, 776), "animacion": "tirando", "nodo": "Vuvuzela"}, # Vuvuzela
	{"pos": Vector2(1717, 851), "animacion": "rascando", "nodo": "Juguete"}, # Juguete
	{"pos": Vector2(1300, 894), "animacion": "saltando", "nodo": "Vaso"}, # Vaso
	{"pos": Vector2(-150, 867), "animacion": "saltando", "nodo": "Termo"}, # Termo
	{"pos": Vector2(2615, 777), "animacion": "saltando", "nodo": "Portarretratos"}, # Portarretrato
	{"pos": Vector2(2872, 934), "animacion": "lamiendo", "nodo": "Alfombra"}, # Alfombra
	{"pos": Vector2(-687, 951), "animacion": "maullido", "nodo": "Nada"}, # Maullido 1
	{"pos": Vector2(225, 654), "animacion": "maullido", "nodo": "Nada"}, # Maullido 2
	{"pos": Vector2(3038, 549), "animacion": "maullido", "nodo": "Nada"}, # Maullido 3
	{"pos": Vector2(138, 656), "animacion": "tirando", "nodo": "Lapicero"}
]

var condicionDerrota = 12


func _ready():
	new_game()
	

func new_game():
	Variables.puntaje = 0
	Variables.contadorBasura = 0
	Variables.menuAbierto = false
	$Ui/Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$Ui/ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)
	$BasuraTimer.start()

	barraBasura = $Ui/BarraBasura
	barraBasura.max_value = condicionDerrota


func _process(delta):
	if Variables.contadorBasura == condicionDerrota:
		game_over()	
	
	
	if messiOnScene:
		var messi = get_node("Messi")
		if not messi.find_child("AnimatedSprite2D").is_playing():
			init_basura()
			
	update_timer()
	$Ui/Puntaje.text = puntajePrefix + str(Variables.puntaje)
	$Ui/ContadorBasura.text = contadorBasuraPrefix + str(Variables.contadorBasura)

	barraBasura.value = Variables.contadorBasura

func update_timer():
	if Variables.menuAbierto and not $BasuraTimer.is_stopped():
		$BasuraTimer.stop()
	if not Variables.menuAbierto and $BasuraTimer.is_stopped():
		$BasuraTimer.start()


func game_over():
	$BasuraTimer.stop()
	get_tree().change_scene_to_file("res://Escenas/menu_game_over.tscn")


# Cuando el timer llega a cero spawneo a Messi en una posicion de las posibles
func _on_basura_timer_timeout():
	# Creo una instancia de Messi
	var messi = messi_escena.instantiate()
	
	# Seteo la posicion incial donde sea que este el indice de spawn
	var availableIndexFound = false
	while(!availableIndexFound):
		Variables.index = int(round(randf() * 16))
		if Variables.index == 16:
			Variables.index = 15
		if !Variables.spawnPositionsVisited[Variables.index]:
			availableIndexFound = true
			
	messi.position = spawnPositions[Variables.index]["pos"]
	var animation = messi.find_child("AnimatedSprite2D")
	# Falta la posibilidad de otra animacion
	animation.play(spawnPositions[Variables.index]["animacion"])
	
	# Cada 3 apariciones que creo hago que una tenga sonido
	if contadorApariciones % 3 == 0:
		$Maullido.position = messi.position
		$Maullido.play()
	contadorApariciones += 1
		
	if spawnPositions[Variables.index]["nodo"] == "Juguete" or spawnPositions[Variables.index]["nodo"] == "Alfombra":
		$Rascar.play()
	messiOnScene = true
	
	# Agrego a Messi  y elijo una animacion
	add_child(messi)
	
	


# Cuando Messi haya terminado la animacion se llama esta funcion para borrarlo y agregar basura
func init_basura():
	# Encuentro el prop
	var nombreNodo = spawnPositions[Variables.index]["nodo"]
	if nombreNodo != "Nada" and nombreNodo != "Juguete":
		var prop = get_node("Props/" + nombreNodo)
		prop.find_child("Sprite1").visible = false
		prop.find_child("Sprite2").visible = true
		# Aumento el contador de basura
		Variables.contadorBasura += 1
	
		var fx = prop.find_child("FX")
		if fx != null:
			fx.play()
	
	# Encuentro a Messi
	var messi = get_node("Messi")
	
	#Elimino a Messi
	remove_child(messi)
	$Rascar.stop()
	messiOnScene = false
	
	


func _input(ev):
	if Input.is_action_just_released("Salir"):
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
