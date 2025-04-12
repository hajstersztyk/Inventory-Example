extends Button


@export var data: Item
@export var count: int
@export var mouse_item: Control
@export var armor: bool
@export var crafting_output: bool
@export var crafting_slot: bool
@export var craft_index: int
@onready var texture: TextureRect = $TextureRect
@onready var count_label: Label = $TextureRect/Count


func _ready() -> void:
	update()
	$Armor.visible = armor

func _on_pressed(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		if armor:
			if data:
				if mouse_item.data != null:
					if mouse_item.data.armor:
						var tempData
						var tempCount: int
						tempData = data
						tempCount = count
						data = mouse_item.data
						count = mouse_item.count
						mouse_item.count = tempCount
						mouse_item.data = tempData
				else:
					mouse_item.data = data
					mouse_item.count = count
					data = null
					count = 0
			else:
				if mouse_item.data != null:
					if mouse_item.data.armor:
						data = mouse_item.data
						count += mouse_item.count
						mouse_item.count = 0
		else:
			if not crafting_output:
				if data:
					if mouse_item.data != null:
						if mouse_item.data == data:
							if event.button_index == MOUSE_BUTTON_LEFT:
								if data.stackable:
									count += mouse_item.count
									mouse_item.count = 0
							if event.button_index == MOUSE_BUTTON_RIGHT:
								if data.stackable:
									count += 1
									mouse_item.count -= 1
						else:
							var tempData
							var tempCount: int
							tempData = data
							tempCount = count
							data = mouse_item.data
							count = mouse_item.count
							mouse_item.count = tempCount
							mouse_item.data = tempData
					else:
						if event.button_index == MOUSE_BUTTON_LEFT:
							mouse_item.data = data
							mouse_item.count = count
							count = 0
							data = null
						if event.button_index == MOUSE_BUTTON_RIGHT:
							var tempCount: int
							tempCount = count/2
							mouse_item.data = data
							mouse_item.count = tempCount
							count -= tempCount
				else:
					if mouse_item.data != null:
						if event.button_index == MOUSE_BUTTON_LEFT:
							data = mouse_item.data
							count = mouse_item.count
							mouse_item.count = 0
							mouse_item.data = null
						if event.button_index == MOUSE_BUTTON_RIGHT:
							data = mouse_item.data
							count += 1
							mouse_item.count -= 1
			else:
				if data:
					if mouse_item.data != null:
						if mouse_item.data == data:
							if event.button_index == MOUSE_BUTTON_LEFT:
								if data.stackable:
									mouse_item.count += count
									data = null
									count = 0
									for i in %CraftingSlots.get_child_count():
										if %CraftingSlots.get_child(i).data:
											if %CraftingSlots.get_child(i).data.stackable:
												%CraftingSlots.get_child(i).count -= 1
											else:
												%CraftingSlots.get_child(i).data = null
											%CraftingSlots.get_child(i).update()
					else:
						if data.stackable:
							mouse_item.data = data
							mouse_item.count += count
							data = null
							count = 0
						else:
							mouse_item.data = data
							mouse_item.count = 1
							data = null
							count = 0
							for i in %CraftingSlots.get_child_count():
								if %CraftingSlots.get_child(i).data:
									if %CraftingSlots.get_child(i).data.stackable:
										%CraftingSlots.get_child(i).count -= 1
									else:
										%CraftingSlots.get_child(i).data = null
									%CraftingSlots.get_child(i).update()
		update()

func update():
	if data:
		texture.texture = data.texture
		count_label.text = str(count)
		tooltip_text = data.name
		if crafting_slot:
			get_parent().get_parent().update_recipe(craft_index, data.id)
		if data.stackable:
			if count > 1:
				count_label.visible = true
			else:
				count_label.visible = false
			if count <= 0:
				data = null
				update()
		else:
			count_label.visible = false
	else:
		texture.texture = null
		count_label.text = ""
		tooltip_text = ""
		if crafting_slot:
			get_parent().get_parent().update_recipe(craft_index, "")
