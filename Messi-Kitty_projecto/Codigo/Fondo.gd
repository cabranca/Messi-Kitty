extends Camera2D

@export var posicionCentro: Vector2
@export var posicionIz: Vector2 
@export var posicionDe: Vector2
# Called when the node enters the scene tree for the first time.
func _ready():
	position = posicionCentro
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_flecha_iz_button_down():
	position = posicionIz


func _on_flecha_de_button_down():
	position = posicionDe


func _on_flecha_iz_2_button_down():
	position = posicionCentro


func _on_flecha_de_2_button_down():
	position = posicionCentro
