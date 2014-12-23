extends Node2D

var screen_size

func _ready():
    screen_size = get_viewport_rect().size
    set_process(true)

var time = 0

func process_bullets(delta):
    var bullets = get_tree().get_nodes_in_group("bullets")
    for bullet in bullets:
        var pos = bullet.get_pos()
        pos += bullet.direction * bullet.speed * delta
        bullet.set_pos(pos)
        if pos.x < -screen_size.x/2 || pos.y < -screen_size.y/2 || pos.x > screen_size.x/2 || pos.y > screen_size.y/2:
            bullet.queue_free()

func _process(delta):
    time += delta
    process_bullets(delta)
    var ship1 = get_node("ship1")
    if Input.is_action_pressed("ship_right"):
        ship1.rotate(-5.0,delta)
    if Input.is_action_pressed("ship_left"):
        ship1.rotate(5.0,delta)
    if Input.is_action_pressed("ship_forward"):
        ship1.forward(delta)
    if Input.is_action_pressed("ship_fire"):
        ship1.fire(time)
