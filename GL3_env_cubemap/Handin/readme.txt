Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3

Task GL3.1.1: Sampling a texture
	To sample the texture color we use vec3 texture_color = texture2D(tex_color, v2f_uv).xyz. We want it as an 3d vector hence we use ".xyz".
	When the colors are unshaded, we want the color to be returned to be the texture color.

Task GL3.1.2: UV coordinates and wrapping modes
	To repeat the tiles four time in each direction we change the vertex_tex_coords from 1 to 4 and we change the wrap function to 'repeat'.
	This way we sample beyond the range of the UV coordinates and with the repeat option we achieve the desired result.


Task GL3.2.1: Projection matrix for a cube camera
	We construct the camera projection matrix using a vertical field of view of 90 degrees (we transform to radians), asn aspect ratio of 1
	because we do not want to scale anything, near = 0.1 and far=200 (given).


Task GL3.2.2: Up vectors for cube camera
	For the up vectors we asked a TA to gain a deeper undestanding as to what is the idea between the numbers. He told us there is no exact
	formula/idea, so we used trial and error to produce the vectors. What we knew was that they had to be orthogonal to the cube face vectors.

Task GL3.2.3: Reflection shader
	In mirror.frag.glsl we defined two varying values and we calculated the direction of the reflected ray R by reflecting the view_vector on
	the surface normal axis. We use (-1*) because we do not want the direction to the camera, instead the direction from the camera.
	We project the resulting color to 3d coordinates so it can be then passed as a homogeneous coordinate.
	In mirror.vert.glsl we first calculate the vertex_position in eye space and set the view_vector as poiting opposite to the vertex_position.
	We also get the surface normal in eye coordinates. As in previous labs, we need to multiply the final position by mat_mvp.

Task GL3.3.1: Phong Lighting Shader with Shadows
	vert: compute the vertex normal in eye view coordinates and store in a varying value. Then calculate the fragment position in view space
	too. As in previous labs, we need to multiply the final position by mat_mvp.
	frag: First get the texture color. Our view vector is the negative of the normalized vector pointing to the fragment, because the eyes are
	at (0,0,0) in eye coordinates.
	We use textureCube to get the distance between the light and the first object intersection in that direction.
	As in previous labs, we calculate the diffuse and specular and we get the final color by multiplying texture, light color,
	and the diffuse and specular. We divide by the distance squared. We do not need to add ambient because it is calculated in unshaded file.

Task GL3.3.2 Blend Options
	We used 'one' and 'one' as blend options because we want to add each light contribution.
	this means that each pixel color is the sum of : scr - computed color +  dst - already stored from previous computations.