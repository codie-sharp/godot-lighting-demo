extends Control

@onready var lantern = $"../Player/SpotLight3D"
@onready var world_env = $"../WorldEnvironment".environment

var settings = []
 
func _ready():
	settings = [
		{ 
			"object": lantern, 
			"setter": $"LanternVBox/AngleSlider", 
			"label": $"LanternVBox/AngleValueLabel", 
			"property": "spot_angle" 
		},
		{ 
			"object": lantern, 
			"setter": $"LanternVBox/AngleAttenuationSlider", 
			"label": $"LanternVBox/AngleAttenuationValueLabel", 
			"property": "spot_angle_attenuation" 
		},
		{ 
			"object": lantern, 
			"setter": $"LanternVBox/RangeSlider", 
			"label": $"LanternVBox/RangeValueLabel", 
			"property": "spot_range" 
		},
		{ 
			"object": lantern, 
			"setter": $"LanternVBox/RangeAttenuationSlider", 
			"label": $"LanternVBox/RangeAttenuationValueLabel", 
			"property": "spot_attenuation" 
		},
		{ 
			"object": lantern, 
			"setter": $"LanternVBox/BrightnessSlider", 
			"label": $"LanternVBox/BrightnessValueLabel", 
			"property": "light_energy" 
		},
		{ 
			"object": world_env, 
			"setter": $"AmbientLightVBox/BrightnessSlider", 
			"label": $"AmbientLightVBox/BrightnessValueLabel", 
			"property": "ambient_light_energy" 
		},
		{ 
			"object": world_env, 
			"setter": $"FogVBox/BrightnessSlider", 
			"label": $"FogVBox/BrightnessValueLabel", 
			"property": "fog_light_energy" 
		},
		{ 
			"object": world_env, 
			"setter": $"FogVBox/DensitySlider", 
			"label": $"FogVBox/DensityValueLabel", 
			"property": "fog_density" 
		},
		{
			"object": lantern, 
			"setter": $"LanternVBox/ColorPicker",
			"property": "light_color",
			"is_color": true
		},
		{
			"object": world_env, 
			"setter": $"AmbientLightVBox/ColorPicker",
			"property": "ambient_light_color",
			"is_color": true
		},
		{
			"object": world_env, 
			"setter": $"FogVBox/ColorPicker",
			"property": "fog_light_color",
			"is_color": true
		},
	]

	for setting in settings:
		var object = setting["object"]
		var setter = setting["setter"]
		var label = setting.get("label", null)
		var property = setting["property"]
		var is_color = setting.get("is_color", false)
		
		if is_color:
			setter.color = object.get(property)
			setter.color_changed.connect(func(value): update_setting(object, property, value, label))
		else:
			setter.value = object.get(property)
			label.text = str(setter.value)
			setter.value_changed.connect(func(value): update_setting(object, property, value, label))

func update_setting(object, property, value, label):
	object.set(property, value)
	if(label):
		label.text = str(value)
