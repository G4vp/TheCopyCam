extends Node

var menu_music = load("res://Assets/Music/puzzle_nodrums.wav")
var in_game_music = load("res://Assets/Music/puzzle_withdrums.wav")

@onready var music = $Music

func play_menu():
	music.stream = menu_music
	music.play()

func play_in_game():
	music.stream = in_game_music
	music.play()
