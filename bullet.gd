
extends Sprite

export(Vector2) var direction = Vector2(-1,0)
export var speed = 400

func set_direction(dir):
    direction = dir

func _ready():
    add_to_group("bullets")
