precision highp float;

/* #TODO GL3.3.1: Pass on the normals and fragment position in camera coordinates */
//varying ...
//varying ...
varying vec2 v2f_uv;
varying vec3 surface_not_normal;
varying vec3 frag_position;

uniform vec3 light_position; // light position in camera coordinates
uniform vec3 light_color;
uniform samplerCube cube_shadowmap;
uniform sampler2D tex_color;

void main() {
	float material_shininess = 12.;

	/* #TODO GL3.1.1
	Sample texture tex_color at UV coordinates and display the resulting color.
	*/
	// vec3 material_color = vec3(v2f_uv, 0.);
	vec3 texture_color = texture2D(tex_color, v2f_uv).xyz;

	/*
	#TODO GL3.3.1: Blinn-Phong with shadows and attenuation

	Compute this light's diffuse and specular contributions.
	You should be able to copy your phong lighting code from GL2 mostly as-is,
	though notice that the light and view vectors need to be computed from scratch here;
	this time, they are not passed from the vertex shader.
	Also, the light/material colors have changed; see the Phong lighting equation in the handout if you need
	a refresher to understand how to incorporate `light_color` (the diffuse and specular
	colors of the light), `v2f_diffuse_color` and `v2f_specular_color`.

	To model the attenuation of a point light, you should scale the light
	color by the inverse distance squared to the point being lit.

	The light should only contribute to this fragment if the fragment is not occluded
	by another object in the scene. You need to check this by comparing the distance
	from the fragment to the light against the distance recorded for this
	light ray in the shadow map.

	To prevent "shadow acne" and minimize aliasing issues, we need a rather large
	tolerance on the distance comparison. It's recommended to use a *multiplicative*
	instead of additive tolerance: compare the fragment's distance to 1.01x the
	distance from the shadow map.

	Implement the Blinn-Phong shading model by using the passed
	variables and write the resulting color to `color`.

	Make sure to normalize values which may have been affected by interpolation!
	*/
	// Calculate from scratch light and view vectors

	vec3 surface_normal = normalize(surface_not_normal);
	vec3 light_vector = normalize(light_position - frag_position);
	vec3 view_vector = normalize(-frag_position);
	float distance_light_frag = distance(light_position, frag_position);
	float stored_distance = textureCube(cube_shadowmap, -1. * light_vector).r;


	// Diffuse
	float intensity_diffuse = dot(surface_normal, light_vector);
	if (intensity_diffuse <= 0.) {
		intensity_diffuse = 0.;
	}

	// Specular
	vec3 h = normalize(light_vector + view_vector);
	float specular_angle = dot(h, surface_normal);
	float intensity_specular = pow(specular_angle, material_shininess);
	if (specular_angle <= 0.) {
		intensity_specular = 0.;
	}

	vec3 color = vec3(0.);

	// add everything together
	// ambient component = material_color * light_color * material_ambient?
	if (distance_light_frag <= 1.01 * stored_distance) {
		color = texture_color * light_color * (intensity_diffuse + intensity_specular) / (distance_light_frag * distance_light_frag);
	}

	gl_FragColor = vec4(color, 1.); // output: RGBA in 0..1 range
}
