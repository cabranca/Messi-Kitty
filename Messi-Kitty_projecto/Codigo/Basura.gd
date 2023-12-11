extends StaticBody2D


# Called when the node enters the scene tree for the first time.
#func _ready():
	#pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(_delta):
	#pass

func _input_event(_viewport, event, _shape_idx):
	var sprite2 = find_child("Sprite2")
	if sprite2.visible:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				print("click")
				$GomaBorrando.play()
				Variables.contadorBasura -= 1
				Variables.puntaje += 1
				sprite2.visible = false
				var sprite1 = find_child("Sprite1")
				sprite1.visible = true
				Variables.spawnPositionsVisited[Variables.index] = false
