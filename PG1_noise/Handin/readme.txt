Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3

Task 2.1
    We created a phi_1d function to calculate the contributions and followed step in the handout. In the end we use the mix function to interpolate the contributions.
    We only use the x coordinate of the given gradients.

Task 3.1
    We used a for loop to loop over the octaves to compute the higher frequency with less amplitude perlin noises and add them all up.

Task 4.1
    Very similar to Task 2.1 but had to make sure that the difference vectors where correct and interpolate on the x and y axis with alphax and alphay.
    This time we could use the given phi_2d function and blending_weight_poly.

Task 4.2
    Same methodology as Task 4.1.

Task 4.3
    Similar methodology to Task 4.2, just with a absolute value of octaves.

Task 5.1
    tex map: if under water level we show the water color else we interpolate with the grass and mountain color based on the height above water.
    tex wood: interpolate dark and light brown with the alpha defined in the handout
    tex marble: compute q and alpha to mix dark brown and white.

Task 6.1
    If we are under water level, the shininess is set to 30 and the material_color is set to water_color, else keep shininess to 2 and the material_color to the mix between grass and mountain like in tex map.
    Then classic Blinn-Phong shading using the varying surface_normal, view_vector and light_vector.
    In terrain.js we create 2 triangles to create a square for each grid coordinate and add them to the faces to render.
    We also normalize the range of the integer grid locations to [0;1] and substract 0.5 to bring the center to 0. and the waters normal is 0,0,1 and keep their elevation to a constant (WATER_LEVEL).