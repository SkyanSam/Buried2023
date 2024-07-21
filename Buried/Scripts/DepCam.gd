extends Camera2D


@onready var screen_size = Vector2(ProjectSettings.get_setting("display/window/size/viewport_width"), ProjectSettings.get_setting("display/window/size/viewport_height"))

func _ready():
	var canvas_transform = get_viewport().get_canvas_transform()
	canvas_transform[2] = - get_node("../Player").position + screen_size / 2
	get_viewport().set_canvas_transform(canvas_transform)
