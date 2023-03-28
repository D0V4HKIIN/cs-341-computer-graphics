Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3

Task GL2.1.1: Compute triangle normals and opening angles
    We compute the different vectors between the three vertices.
    Using these vectors, we compute the normal using the cross product between two vectors that have the same starting vertex.
    The angles are computed using the vec3.angle function. Also we store the absolute values because they are going to be used as weights that
    need to be positive.

Task GL2.1.2: Compute vertex normals
    For each face we get its normal and the three corresponding weights (we access them using their corresponding index in angle_weights).
    We add the normal scaled by it's weight (the angle computed in GL2.1.1) and using vec3.scale, to the vertex normal for each vertex.
    Then we loop over all vertices to normalize the "normals".

Task GL2.2.1: Pass normals to fragment shader
    We start by copy pasting our code for mat_mvp.
    Using the varying variable and the false color formula we set the color in the fragment shader.

Task GL2.2.2: Transforming the normals
    We have mat_normals_to_view = (VM)^-T but mat_normals_to_view is a 3x3 matrix while V and M are 4x4. So we extract the top right 3x3 part
    of the computed matrix (VM) using the fromMat4 function and then transpose and inverse it.
    The normal in view coordinates can then be computed in the vertex shader with mat_normals_to_view * vertex_normal
    (and of course we normalize it).

Task GL2.3: Gouraud lighting
    Initially, we put our vertex position and vertex normal in view-space. For the vertex position we need to change the position to
    homogeneous coordinates (vec4(vertex_position, 1.)) and after we multiply it with mat_model_view, we need to project it again to xyz coordinates (by .xyz).
    For the diffuse component we check again if the light vector is on the right side by using the dot product.
    We assume that the materials properties for diffuse and specular is 1. Using this assumption we use blinn-phong lighting.

Task GL2.4: Phong lighting
    For vert.js we do the same as in GL2.3 and again the view_vector is opposite to the vertex position.
    we do the same as in GL2.3 but it is instead we do it in the fragment shader (per pixel).