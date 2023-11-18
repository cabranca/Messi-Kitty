extends Node

@export var basura_scene: PackedScene
var count

func _ready():
	new_game()
	
func _process(delta):
	pass
	
func new_game():
	count = 0
	$BasuraTimer.start()

func game_over():
	$GarbageTimer.stop()

# Cuando el timer llega a cero spawneo nueva basura
# en una posicion random
func _on_basura_timer_timeout():
	# Creo la nueva instancia de la escena Basura
	var basura = basura_scene.instantiate()
	
	# Genero una posicion random inicial (probar get_viewport_rect())
	var xPos = randf() * $Camera2D/Control/FondoA.size.x
	var yPos = randf() * $Camera2D/Control/FondoA.size.y
	
	# Seteo la posicion a la nueva basura
	basura.position = Vector2(xPos, yPos)
	
	# Agrego el nuevo objeto como hijo del nodo principal
	add_child(basura)
