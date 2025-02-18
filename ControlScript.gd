extends Control

@onready var lantern = $"../Player/SpotLight3D"
@onready var world_env = $"../WorldEnvironment"

# spot_angle_attenuation [default: 1.0]
# spot_attenuation [default: 1.0]

# Lantern settings
@onready var lantern_angle_slider = $HBoxContainer/LanternVBox/AngleSlider
@onready var lantern_angle_value_label = $HBoxContainer/LanternVBox/AngleValueLabel

@onready var lantern_angle_attenuation_slider = $HBoxContainer/LanternVBox/AngleAttenuationSlider
@onready var lantern_angle_attenuation_value_label = $HBoxContainer/LanternVBox/AngleAttenuationValueLabel

@onready var lantern_range_slider = $HBoxContainer/LanternVBox/RangeSlider
@onready var lantern_range_value_label = $HBoxContainer/LanternVBox/RangeValueLabel

@onready var lantern_range_attenuation_slider = $HBoxContainer/LanternVBox/RangeAttenuationSlider
@onready var lantern_range_attenuation_value_label = $HBoxContainer/LanternVBox/RangeAttenuationValueLabel

@onready var lantern_brightness_slider = $HBoxContainer/LanternVBox/BrightnessSlider
@onready var lantern_brightness_value_label = $HBoxContainer/LanternVBox/BrightnessValueLabel
@onready var lantern_color_picker = $HBoxContainer/LanternVBox/ColorPicker

# World environment settings
@onready var ambient_power_slider = $HBoxContainer/AmbientVBox/BrightnessSlider
@onready var ambient_color_picker = $HBoxContainer/AmbientVBox/ColorPicker
@onready var fog_density_slider = $HBoxContainer/AmbientVBox/FogDensitySlider

func _ready():
	# Lantern angle
	lantern_angle_slider.value = lantern.spot_angle
	lantern_angle_slider.value_changed.connect(update_lantern_angle)
	lantern_angle_value_label.text = str(lantern.spot_angle)
	
	lantern_angle_attenuation_slider.value = lantern.spot_angle_attenuation
	lantern_angle_attenuation_slider.value_changed.connect(update_lantern_angle_attenuation)
	lantern_angle_attenuation_value_label.text = str(lantern.spot_angle_attenuation)
	
	# Lantern range
	lantern_range_slider.value = lantern.spot_range
	lantern_range_slider.value_changed.connect(update_lantern_range)
	lantern_range_value_label.text = str(lantern.spot_range)
	
	lantern_range_attenuation_slider.value = lantern.spot_attenuation
	lantern_range_attenuation_slider.value_changed.connect(update_lantern_range_attenuation)
	lantern_range_attenuation_value_label.text = str(lantern.spot_attenuation)
	
	# Lantern light
	lantern_brightness_slider.value = lantern.light_energy
	lantern_brightness_slider.value_changed.connect(update_lantern_brightness)
	lantern_brightness_value_label.text = str(lantern.light_energy)
	
	lantern_color_picker.color = lantern.light_color
	lantern_color_picker.color_changed.connect(update_lantern_color)
	
	# World environment
	ambient_power_slider.value = world_env.environment.ambient_light_energy
	ambient_power_slider.value_changed.connect(update_ambient_power)
	
	ambient_color_picker.color = world_env.environment.ambient_light_color
	ambient_color_picker.color_changed.connect(update_ambient_color)
	
	fog_density_slider.value = world_env.environment.fog_density
	fog_density_slider.value_changed.connect(update_fog_density)

func update_lantern_angle(value):
	lantern.spot_angle = value
	lantern_angle_value_label.text = str(value)
	
func update_lantern_angle_attenuation(value):
	lantern.spot_angle_attenuation = value
	lantern_angle_attenuation_value_label.text = str(value)

func update_lantern_range(value):
	lantern.spot_range = value
	lantern_range_value_label.text = str(value)
	
func update_lantern_range_attenuation(value):
	lantern.spot_attenuation = value
	lantern_range_attenuation_value_label.text = str(value)

func update_lantern_brightness(value):
	lantern.light_energy = value
	lantern_brightness_value_label.text = str(value)

func update_lantern_color(value):
	lantern.light_color = value
	
func update_ambient_power(value):
	world_env.environment.ambient_light_energy = value

func update_ambient_color(value):
	world_env.environment.ambient_light_color = value

func update_fog_density(value):
	world_env.environment.fog_density
