extends Area2D
class_name Lying_Item

var SceneMP9 := load("res://Scenes/Weapons/mp9/mp9.tscn")

func getItem() -> PackedScene:
	print("I was picked up!")
	return SceneMP9
