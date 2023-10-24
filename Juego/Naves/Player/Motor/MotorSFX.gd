#Motor
class_name Motor
extends AudioStreamPlayer2D

export var tiempo_transicion:float = 0.6
export var volumen_apagado:float = -30.0

onready var tween_sonido:Tween = $Tween

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
var volumen_original:float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	volumen_original = volume_db
	volume_db = volumen_apagado

func sonido_on() -> void:
	if not playing:
		play()
		
	efecto_transicion(volume_db, volumen_original)
	
func sonido_off() -> void:
	efecto_transicion(volume_db, volumen_apagado)
	
func efecto_transicion(desde_vol: float, hasta_vol: float) -> void:
	tween_sonido.interpolate_property(
		self,
		"volume_db",
		desde_vol,
		hasta_vol,
		tiempo_transicion,
		Tween.TRANS_LINEAR,
		Tween.EASE_OUT_IN
	)
	tween_sonido.start()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
