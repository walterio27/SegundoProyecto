#Escudo.gd
class_name Escudo
extends Area2D

##Variables
var esta_activado:bool = false setget ,get_esta_activado

##Variables export
export var energia:float = 8.0
export var radio_desgaste:float = -1.6

func _process(delta: float) -> void:
	energia += radio_desgaste * delta
	
	if energia <= 0.0:
		desactivar()
	
func desactivar() -> void:
	set_process(false)
	esta_activado = false
	controlar_colisionador(true)
	$AnimationPlayer.play_backwards("Activando")
	
##  Setters y getters
func get_esta_activado() -> bool:
	return esta_activado
	

#Metodos
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#Aca el process no corre, la energia del escudo no se consume al iniciar el juego.
	set_process(false)
	controlar_colisionador(true)
	
#Metodos Custom
func controlar_colisionador(esta_desactivado:bool) -> void:
	$CollisionShape2D.set_deferred("disabled", esta_desactivado)
	
func activar() -> void:
	if energia <= 0.0:
		return
		
	esta_activado = true
	controlar_colisionador(false)
	$AnimationPlayer.play("Activando")
	
#Señales internas
func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	if anim_name == "Activando" and esta_activado:
		$AnimationPlayer.play("Activado")
		#Aca si empieza a correr el process, cuando el escudo se activa
		set_process(true)
		
func _on_body_entered(body: Node) -> void:
	body.queue_free()
