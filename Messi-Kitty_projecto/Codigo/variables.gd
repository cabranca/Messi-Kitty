extends Node

var puntaje
var contadorBasura
var menuAbierto
var firstPlaythrough = true

var spawnPositionsVisited = [
	false, false, false, false, false, 
	false, false, false, false, false, 
	false, false, false, false, false, false
	]
	
var index = 0

func reiniciar():
	contadorBasura = 0
	puntaje = 0
	menuAbierto = false
	for i in range(spawnPositionsVisited.size()):
		spawnPositionsVisited[i] = false
