Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3


Task GL1.1.1: 2D translation in shader
	GL1.1.1.1: We simply add the mouse_offset to the position of the vertex. This is still a vertex hence the 0(z-axis) and the 1(homogenous coordinates = point).
	
	GL1.1.1.2: We set the mouse_offset to the mouse_offset constant and the color equal to the color constant blue that is given.


Task GL1.1.2: 2D matrix transform
	GL1.1.2.1: To transform the postition we need to multiply with the transformation matrix. As it is in glsl we simply need to multiply using *.
	
	GL1.1.2.2: We create the translation matrix using: mat4.fromTranslation(mat_translation, [0.5, 0, 0])
	Additionally, the rotation along the z axis using: mat4.fromZRotation(mat_rotation, sim_time * 30 * deg_to_rad)
	
	Then we create two transformation matrices for the two different colored triangles. For the green one, we apply the translation first and then the rotation.'
	On the other hand, for the red triangle, we do the opposite: first rotate and then translate.


Task GL1.2.1: MVP matrix
	GL1.2.1.1: To apply a transformation matrix, here the mat_mvp, we need to multiply the matrix with the vertex position vector.
	
	GL1.2.1.2: The mvp matrix is a multiplication of many matrices. To achieve the Model View Projection we first multiply the model matrix with
	the model coordinates to get to the world coordinates.Then, we multiply with the view matrix to get to camera coordinates and finally multiply 
	with the projection matrix to project the coordinates to our image. The final matrix (mat_mvp) is then added at "entries_to_draw.push".


Task GL1.2.2: View matrix
	Creating the lookAt function: we calculate "r" which is the distance from the camera to the origin. The lookAt function creates a matrix that
	takes the camera position in world coordinates as [-r,0,0] because the camera has to look towards the origin while r looks the other way.
	Then, we create three matrices: one for the rotation of the camera along the z-axis, one for the rotation along the y-axis and a final one called 
	"eye_rotation" that mutliplies the two rotations (first rotating along z, then along y).

	The variable frame_info.mat_turntable is the product of first rotating the point along the y and z axes and then applying the lookAt function so 
	that the camera always points twoards the origin.


Task GL1.2.3: Model matrix

	We create several matrices:
	* planet_rotation = rotation of planet around its own axis with its own speed.
	* planet_scale = scaling of planet to its own size along every axis (x,y,z) : [actor.size, actor.size, actor.size].
	* M_planet = multiplication of the two above, first scaling the planet and then starting its rotation around itself.

	Inside the if-statement that checks if the planet orbits around some other planet:
	* parent_translation = translate planet to the "centre"/origin of its parent planet.
	* orbit_translation = translation matrix that moves the planet along the x-axis to a distance of its orbit radius.
	* orbit_rotation = rotation matrix for the orbit angle of the planet around its parent.
	* M_orbit = mutliplication of the three above, first move the planet to a distance of its orbit radius, then start its rotation around the orbit angle,
	and finally a translate it to do that at the "centre" of its parent planet.

	Finally, for the final actor.mat_model_to_world multiply M_orbit and M_planet. We first aply the M_planet so the planet rotates around itself and
	has the right size, and then we move it to the right orbit position.

