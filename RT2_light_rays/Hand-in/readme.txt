Shen Chen 361204: 1/3
Nephele Aesopou 361198: 1/3
Jonas Bonnaudet 361946: 1/3

Task RT2.1: Implement Lighting Models
    to compute the intersection we use the ray_intersection function
    ambient light = light_color_ambient * (m.ambient * m.color)
    diffuse light = (mat.diffuse * mat.color) * dot(object_normal, light_vec)
    specular light = ms * pow(dot(object_normal, h), mat.shininess)

    We first check that the dot product between the object normal and the light
    vector is positive. If yes, we add the diffuse component. Similarly, we add the
    specular component, after we have checked which model we are using: Phong or Blinn Phong.

    If the dot product is negative, we simply add a vector (0.,0.,0.) which is black.


Task RT2.2: Implement shadows

    First check that light vector is coming from the same side of the object normal.
    We check if an intersection exists, and if it does and also if the object is not beyond the light source.
    We define a float called FLOAT_COMPENSATION that we set to 1e-3 to work with shadow acne.
    Then, if the distance is too small, it means that the ray intersects the inner surface of the object (acne),
    so we have a shadow (no_shadow = 0.).

    The else statements moves the ray-object intersection point outside of the object,
    along the light direction.

    We finally return (intensity_diffuse + intensity_specular) * shadow_exists * light.color.


Task RT2.3.1: Derive iterative formula

    See TheoryExercise.pdf.

Task RT2.3.2: Implement reflections

    See TheoryExercise.pdf.
