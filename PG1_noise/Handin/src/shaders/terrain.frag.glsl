precision highp float;

varying float v2f_height;

/* #TODO PG1.6.1: Copy Blinn-Phong shader setup from previous exercises */
//varying ...
//varying ...
//varying ...
varying vec3 surface_normal;
varying vec3 view_vector;
varying vec3 light_vector;


const vec3  light_color = vec3(1.0, 0.941, 0.898);
// Small perturbation to prevent "z-fighting" on the water on some machines...
const float terrain_water_level    = -0.03125 + 1e-6;
const vec3  terrain_color_water    = vec3(0.29, 0.51, 0.62);
const vec3  terrain_color_mountain = vec3(0.8, 0.5, 0.4);
const vec3  terrain_color_grass    = vec3(0.33, 0.43, 0.18);

void main()
{
	const vec3 ambient = 0.2 * light_color; // Ambient light intensity
	float height = v2f_height;

	/* #TODO PG1.6.1
	Compute the terrain color ("material") and shininess based on the height as
	described in the handout. `v2f_height` may be useful.

	Water:
			color = terrain_color_water
			shininess = 30.
	Ground:
			color = interpolate between terrain_color_grass and terrain_color_mountain, weight is (height - terrain_water_level)*2
	 		shininess = 2.
	*/
	//float s = perlin_fbm(point);
	vec3 material_color = terrain_color_grass;
	float shininess = 2.;

	if (height < terrain_water_level) {
		material_color = terrain_color_water;
		shininess = 30.;
	} else {
		material_color = mix(terrain_color_grass, terrain_color_mountain, (height - terrain_water_level)*2.);
	}


	/* #TODO PG1.6.1: apply the Blinn-Phong lighting model
    	Implement the Phong shading model by using the passed variables and write the resulting color to `color`.
    	`material_color` should be used as material parameter for ambient, diffuse and specular lighting.
    	Hints:
	*/
	//vec3 color = material_color * light_color;

	// Diffuse
	float intensity_diffuse = dot(surface_normal, light_vector);
	if (intensity_diffuse <= 0.) {
		intensity_diffuse = 0.;
	}

	// Specular	
	vec3 h = normalize(light_vector + view_vector);
	float specular_angle = dot(h, surface_normal);
	float intensity_specular = pow(specular_angle, shininess);
	if (specular_angle <= 0.) {
		intensity_specular = 0.;
	}

	// add everything together
	vec3 color = material_color * light_color * (ambient + intensity_diffuse + intensity_specular);
	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}
