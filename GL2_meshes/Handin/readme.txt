Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3

Task GL2.1.1: Compute triangle normals and opening angles
    We compute the different vector between the three vertices.
    Using these vectors, we compute the normal with the cross product between two vectors that have the same starting point.
    The angles are computed using the vec3.angle function. Also we store the absolute values because they are going to be used as weights that need to be positive.

Task GL2.1.2: Compute vertex normals
    We add the normal scaled by it's weight (the angle computed in GL2.1.1) to the vertex normal for each vertex to each face.
    Then we loop over all vertices to normalize the "normals".

Task GL2.2.1: Pass normals to fragment shader
    We start by copy pasting our code for mat_mvp.
    Using the varying variable and the false color formula we set the color in the fragment shader.

Task GL2.2.2: Transforming the normals
    We have mat_normals_to_view = (VM)^-T but mat_normals_to_view is a 3x3 matrix while V and M are 4x4. So we extract the top right 3x3 part of the computed matrix (VM) using the fromMat4 function and then transpose and inverse it.
    The normal in view coordinates can then be computed in the vertex shader with mat_normals_to_view * vertex_normal (and ofc normalize it).

Task GL2.3: Gouraud lighting
    We assume that the materials properties such as ambient, diffuse and specular is 1. Using this assumption we use blinn-phong lighting.

Task GL2.4: Phong lighting
    Same as in GL2.3 but it is instead done in the fragment shader