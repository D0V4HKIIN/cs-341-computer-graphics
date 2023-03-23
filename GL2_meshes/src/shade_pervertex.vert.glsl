// Vertex attributes, specified in the "attributes" entry of the pipeline
attribute vec3 vertex_position;
attribute vec3 vertex_normal;

// Per-vertex outputs passed on to the fragment shader

/* #TODO GL2.3
	Pass the values needed for per-pixel
	Create a vertex-to-fragment variable.
*/
//varying ...

varying vec3 vertex_color;

// Global variables specified in "uniforms" entry of the pipeline
uniform mat4 mat_mvp;
uniform mat4 mat_model_view;
uniform mat3 mat_normals_to_view;

uniform vec3 light_position; //in camera space coordinates already

uniform vec3 material_color;
uniform float material_shininess;
uniform vec3 light_color;

void main() {
	float material_ambient = 0.1;

	/** #TODO GL2.3 Gouraud lighting
	Compute the visible object color based on the Blinn-Phong formula.

	Hint: Compute the vertex position, normal and light_position in eye space.
	Hint: Write the final vertex position to gl_Position
	*/
	vec3 eye_vertex_position = (mat_model_view * vec4(vertex_position, 1.)).xyz;
	vec3 eye_vertex_normal = normalize(mat_normals_to_view * vertex_normal);
	vec3 light_vec = normalize(light_position - eye_vertex_position);

	// Diffuse
	float intensity_diffuse = dot(eye_vertex_normal, light_vec);
	if (intensity_diffuse < 0.) {
		intensity_diffuse = 0.;
	}

	vec3 direction_to_camera = -1. * eye_vertex_position;

	// Specular
	vec3 h = normalize(light_vec + direction_to_camera);
	float intensity_specular =  pow(dot(eye_vertex_normal, h), material_shininess);

	// add everything together
	vertex_color = material_color * light_color * (material_ambient + intensity_diffuse + intensity_specular);

	gl_Position = mat_mvp * vec4(vertex_position, 1);
}
