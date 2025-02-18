extends Control

@onready var lantern = $"../Player/SpotLight3D"
@onready var world_env = $"../WorldEnvironment"

@onready var lantern_angle_slider = $HBoxContainer/LanternVBox/AngleSlider
@onready var lantern_angle_value_label = $HBoxContainer/LanternVBox/AngleValueLabel
@onready var lantern_brightness_slider = $HBoxContainer/LanternVBox/BrightnessSlider
@onready var lantern_brightness_value_label = $HBoxContainer/LanternVBox/BrightnessValueLabel
@onready var lantern_color_picker = $HBoxContainer/LanternVBox/ColorPicker

@onready var ambient_power_slider = $HBoxContainer/AmbientVBox/BrightnessSlider
@onready var ambient_color_picker = $HBoxContainer/AmbientVBox/ColorPicker
@onready var fog_density_slider = $HBoxContainer/AmbientVBox/FogDensitySlider

func _ready():
	lantern_angle_slider.value = lantern.spot_angle
	lantern_angle_slider.value_changed.connect(update_lantern_angle)
	lantern_angle_value_label.text = str(lantern.spot_angle)
	
	lantern_brightness_slider.value = lantern.light_energy
	lantern_brightness_slider.value_changed.connect(update_lantern_brightness)
	lantern_brightness_value_label.text = str(lantern.light_energy)
	
	lantern_color_picker.color = lantern.light_color
	lantern_color_picker.color_changed.connect(update_lantern_color)
	
	ambient_power_slider.value = world_env.environment.ambient_light_energy
	ambient_power_slider.value_changed.connect(update_ambient_power)
	
	ambient_color_picker.color = world_env.environment.ambient_light_color
	ambient_color_picker.color_changed.connect(update_ambient_color)
	
	fog_density_slider.value = world_env.environment.fog_density
	fog_density_slider.value_changed.connect(update_fog_density)

func update_lantern_angle(value):
	lantern.spot_angle = value
	lantern_angle_value_label.text = str(value)
	
func update_lantern_brightness(value):
	lantern.light_energy = value

func update_lantern_color(value):
	lantern.light_color = value
	
func update_ambient_power(value):
	world_env.environment.ambient_light_energy = value

func update_ambient_color(value):
	world_env.environment.ambient_light_color = value

func update_fog_density(value):
	world_env.environment.fog_density
