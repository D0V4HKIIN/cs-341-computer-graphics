precision mediump float;

/* #TODO GL2.4
	Setup the varying values needed to compue the Phong shader:
	* surface normal
	* lighting vector: direction to light
	* view vector: direction to camera
*/
//varying ...
//varying ...
//varying ...
varying vec3 surface_normal;
varying vec3 view_vector;
varying vec3 light_vector;

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main()
{
	float material_ambient = 0.1;

	/*
	/** #TODO GL2.4: Apply the Blinn-Phong lighting model

	Implement the Blinn-Phong shading model by using the passed
	variables and write the resulting color to `color`.

	Make sure to normalize values which may have been affected by interpolation!
	*/

	// Diffuse
	float intensity_diffuse = dot(surface_normal, light_vector);
	if (intensity_diffuse <= 0.) {
		intensity_diffuse = 0.;
	}

	// Specular
	vec3 h = normalize(light_vector + view_vector);
	float intensity_specular =  pow(dot(surface_normal, h), material_shininess);

	// add everything together
	vec3 color = material_color * light_color * (material_ambient + intensity_diffuse + intensity_specular);

	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}
