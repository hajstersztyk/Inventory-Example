extends Control

@onready var mouse_item: TextureRect = $MouseItem
@export var held_item: String

func _process(delta: float) -> void:
	mouse_item.global_position = get_global_mouse_position() - Vector2(32, 32)

func _ready() -> void:
	give("sword")
	give("pickaxe")
	give("chestplate")

func give(id: String):
	for i in %Slots.get_child_count():
		var slot = %Slots.get_child(i)
		if slot.armor:
			break
		if List.item[id].stackable:
			if slot.data == List.item[id]:
				slot.count += 1
				slot.update()
				break
		if slot.data == null:
			slot.data = List.item[id]
			slot.count += 1
			slot.update()
			break
func _on_button_pressed() -> void:
	give("coin")
