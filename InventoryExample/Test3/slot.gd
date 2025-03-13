extends Button


@export var data: Item
@export var count: int
@export var mouse_item: Control
@export var armor: bool
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
			if data:
				if mouse_item.data != null:
					if mouse_item.data == data:
						if event.button_index == MOUSE_BUTTON_LEFT:
							if data.stackable:
								count += mouse_item.count
								mouse_item.count = 0
							else:
								pass
						if event.button_index == MOUSE_BUTTON_RIGHT:
							if data.stackable:
								count += 1
								mouse_item.count -= 1
							else:
								pass
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
					pass
	update()

func update():
	if data:
		texture.texture = data.texture
		count_label.text = str(count)
		if data.stackable:
			if count > 1:
				count_label.visible = true
			else:
				count_label.visible = true
		else:
			count_label.visible = false
		tooltip_text = data.name
	else:
		texture.texture = null
		count_label.text = ""
		tooltip_text = ""
