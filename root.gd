extends Node2D

var screen_size

func _ready():
    screen_size = get_viewport_rect().size
    set_process(true)

var ship_speed = 200
var bullet_speed = 400

var ship_rot = 0

var ship_direction = Vector2(-1,0)

var bullets = []
var fire_rate = 0.1
var last_bullet = 0
var time = 0

var bullet = preload("res://bullet.scn")

func rotate_ship(angle,delta):
    var theta = angle * delta
    ship_rot += theta
    if ship_rot > 360:
        ship_rot -= 360
    ship_direction.x = -cos(ship_rot)
    ship_direction.y = sin(ship_rot)
    get_node("ship1").set_rot(ship_rot)

func process_bullets(delta):
    var remove = []
    for i in range(bullets.size()):
        var pos = bullets[i]["sprite"].get_pos()
        pos += bullets[i]["dir"] * bullet_speed * delta
        bullets[i]["sprite"].set_pos(pos)
        if pos.x < -screen_size.x/2 || pos.y < -screen_size.y/2 || pos.x > screen_size.x/2 || pos.y > screen_size.y/2:
            remove.append(i)
    for i in remove:
        bullets[i]["sprite"].queue_free()
        bullets.remove(i)


func _process(delta):
    time += delta
    process_bullets(delta)
    var ship_pos = get_node("ship1").get_pos()
    var ship_scale = get_node("ship1").get_scale()
    if Input.is_action_pressed("ship_right"):
        rotate_ship(-5.0,delta)
    if Input.is_action_pressed("ship_left"):
        rotate_ship(5.0,delta)
    if Input.is_action_pressed("ship_forward"):
        ship_pos += ship_direction * ship_speed * delta
    if Input.is_action_pressed("ship_fire"):
        if (time >= last_bullet + fire_rate):
            var b = bullet.instance()
            b.set_pos(ship_pos)
            add_child(b)
            bullets.append({"sprite":b,"dir":ship_direction})
            last_bullet = time

    get_node("ship1").set_pos(ship_pos)
