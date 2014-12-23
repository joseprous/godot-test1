
extends Node2D

export var fire_rate = 0.1
export var speed = 200

var direction = Vector2(-1,0)
var last_fire = 0
var bullet_scene = preload("res://bullet.xml")

func rotate(angle,delta):
    var rotation = get_rot()
    var theta = angle * delta
    rotation += theta
    if rotation > 360:
        rotation -= 360
    direction.x = -cos(rotation)
    direction.y = sin(rotation)
    set_rot(rotation)

func forward(delta):
    var position = get_pos()
    position += direction * speed * delta
    set_pos(position)

func fire(time):
    if (time >= last_fire + fire_rate):
        var position = get_pos()
        var bullet = bullet_scene.instance()
        bullet.set_pos(position)
        bullet.set_direction(direction)
        get_node("..").add_child(bullet)
        last_fire = time

func _ready():
    add_to_group("ships")


