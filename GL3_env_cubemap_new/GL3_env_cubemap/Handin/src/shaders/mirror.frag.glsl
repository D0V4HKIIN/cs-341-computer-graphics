precision mediump float;

/* #TODO GL3.2.3
	Setup the varying values needed to compue the Phong shader:
	* surface normal
	* view vector: direction to camera
*/
//varying ...
//varying ...
varying vec3 surface_normal;
varying vec3 view_vector;

uniform samplerCube cube_env_map;

void main()
{
	/*
	/* #TODO GL3.2.3: Mirror shader
	Calculate the reflected ray direction R and use it to sample the environment map.
	Pass the resulting color as output.
	*/
	vec3 color = vec3(0., 0.5, 0.);
	vec3 direction_vec3 = reflect(-1. * view_vector, surface_normal);
	vec4 result = textureCube(cube_env_map, direction_vec3);

	gl_FragColor = vec4(result.xyz, 1.); // output: RGBA in 0..1 range
}
