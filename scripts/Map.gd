extends Node2D

# Paramètres de la planche
var planche_width = DisplayServer.screen_get_size()[0]
var planche_height = DisplayServer.screen_get_size()[1]

# Nombre de germes (points de départ pour les formes)
var nb_germes = 10

# Liste pour stocker les germes
var germes = []

# Liste pour stocker les formes
var formes = {}

func _ready():
	randomize()  # Initialise le générateur de nombres aléatoires
	generer_germes(nb_germes)
	generer_formes()

func generer_germes(nombre):
	for _i in range(nombre):
		var x = randi_range(0, planche_width)
		var y = randi_range(0, planche_height)
		germes.append(Vector2(x, y))
		formes[Vector2(x, y)] = []

func generer_formes():
	for x in range(planche_width):
		for y in range(planche_height):
			var point = Vector2(x, y)
			var germe_le_plus_proche = trouver_germe_le_plus_proche(point)
			formes[germe_le_plus_proche].append(point)

func trouver_germe_le_plus_proche(point):
	var germe_le_plus_proche = null
	var distance_min = INF
	for germe in germes:
		var distance = point.distance_to(germe)
		if distance < distance_min:
			distance_min = distance
			germe_le_plus_proche = germe
	return germe_le_plus_proche

func _draw():
	for germe in formes:  # Assurez-vous que l'indice est valide
		var liste_pixels = formes[germe]
		var couleur = Color(randf(), randf(), randf())
		for pixel in liste_pixels:
			draw_circle(pixel, 1, couleur)  # Dessine un petit cercle pour représenter le point

