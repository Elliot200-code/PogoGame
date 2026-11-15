extends Node

@export var music : AudioStreamPlayer
@export var bounce_sounc : AudioStreamPlayer
@export var lose_sound : AudioStreamPlayer



func bounce():
	bounce_sounc.playing = false
	bounce_sounc.playing = true

func lose():
	lose_sound.playing = false
	lose_sound.playing = true
