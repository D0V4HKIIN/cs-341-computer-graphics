precision mediump float;

// Texture coordinates passed from vertex shader
varying vec2 v2f_uv;

// Texture to sample color from
uniform sampler2D tex_color;

uniform float color_factor;

void main()
{
	/* #TODO GL3.1.1
	Sample texture tex_color at UV coordinates and display the resulting color.
	*/
	vec3 color = vec3(v2f_uv, 0.);
	vec3 texture_color = texture2D(tex_color, v2f_uv).xyz;

	texture_color *= color_factor; // this allows us to reuse this shader for ambient pass
	gl_FragColor = vec4(texture_color, 1.); // output: RGBA in 0..1 range
}
