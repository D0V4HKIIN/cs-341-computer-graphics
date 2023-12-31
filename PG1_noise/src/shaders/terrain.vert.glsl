attribute vec3 position;
attribute vec3 normal;

varying float v2f_height;

/* #TODO PG1.6.1: Copy Blinn-Phong shader setup from previous exercises */
//varying ...
//varying ...
//varying ...
varying vec3 surface_normal;
varying vec3 view_vector;
varying vec3 light_vector;

uniform mat4 mat_mvp;
uniform mat4 mat_model_view;
uniform mat3 mat_normals; // mat3 not 4, because normals are only rotated and not translated

uniform vec4 light_position; //in camera space coordinates already
void main()
{
    v2f_height = position.z;
    vec4 position_v4 = vec4(position, 1);

    /** #TODO PG1.6.1:
	Setup all outgoing variables so that you can compute in the fragmend shader
    the phong lighting. You will need to setup all the uniforms listed above, before you
    can start coding this shader.

    Hint: Compute the vertex position, normal and light_position in eye space.
    Hint: Write the final vertex position to gl_Position
    */
	// Setup Blinn-Phong varying variables
	//v2f_normal = normal; // TODO apply normal transformation

	vec3 eye_vertex_position = (mat_model_view * position_v4).xyz;

	view_vector = -1. * eye_vertex_position;
	surface_normal = normalize(mat_normals * normal);
	light_vector = normalize(light_position.xyz - eye_vertex_position);

	gl_Position = mat_mvp * position_v4;
}
