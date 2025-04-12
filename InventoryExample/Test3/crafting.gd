extends Control

@onready var slots: GridContainer = $CraftingSlots
@onready var output: Button = $Output

@export var curr_recipe: Array[String]

func _ready() -> void:
	for i in slots.get_child_count():
		slots.get_child(i).craft_index = i

func update_recipe(index: int, id: String):
	curr_recipe[index] = id
	check()
	if output:
		output.update()

func check():
	for i in List.item:
		if List.item[i].recipe:
			if List.item[i].recipe == curr_recipe:
				output.data = List.item[i]
				break
			elif output:
				output.data = null
				output.update()

func _physics_process(delta: float) -> void:
	$Label.text = str(curr_recipe)
