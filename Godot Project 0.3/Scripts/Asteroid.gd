extends "res://Scripts/weightless.gd"
export (PackedScene) var AsteroidSMALL 
export (PackedScene) var AsteroidMEDIUM 
signal explode
enum Size {
	SMALL, MEDIUM, LARGE
}

export(Size) var size = Size.LARGE
var radius


export var expolde_force = 300

func _ready():
	connect("explode", self, "_explode")
	radius = get_node("Sprite").texture.get_width() / 2 * get_node("Sprite").scale
	pass 
	

	
func _explode():
	if size != Size.SMALL:
		for i in range(0,2):
			var offset_dir = PI * 2 / 3 * i
			var asteroid
			match size:
				Size.MEDIUM:
					asteroid = AsteroidSMALL.instance()
					
				Size.LARGE:
					asteroid = AsteroidMEDIUM.instance()
			asteroid.position = position + radius.rotated(offset_dir)
			asteroid.linear_velocity = linear_velocity + Vector2(expolde_force, 0).rotated(offset_dir)
			get_parent().add_child(asteroid)
	queue_free()
	sleeping = true 
