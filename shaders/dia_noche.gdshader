shader_type canvas_item;

uniform float hora_dia : hint_range(0.0, 1.0) = 0.5;

void fragment() {
	vec4 color = texture(TEXTURE, UV);

	// Amanecer/anochecer: tono cálido naranja
	vec3 amanecer = vec3(1.0, 0.6, 0.3);
	// Día: sin tinte
	vec3 dia = vec3(1.0, 1.0, 1.0);
	// Noche: tono azul oscuro
	vec3 noche = vec3(0.12, 0.18, 0.35);

	vec3 tinte;
	if (hora_dia < 0.25) {
		// Noche → amanecer
		tinte = mix(noche, amanecer, hora_dia / 0.25);
	} else if (hora_dia < 0.35) {
		// Amanecer → día
		tinte = mix(amanecer, dia, (hora_dia - 0.25) / 0.1);
	} else if (hora_dia < 0.75) {
		// Día pleno
		tinte = dia;
	} else if (hora_dia < 0.85) {
		// Día → atardecer
		tinte = mix(dia, amanecer, (hora_dia - 0.75) / 0.1);
	} else {
		// Atardecer → noche
		tinte = mix(amanecer, noche, (hora_dia - 0.85) / 0.15);
	}

	float brillo = mix(0.25, 1.0, smoothstep(0.2, 0.4, hora_dia) - smoothstep(0.7, 0.9, hora_dia) + smoothstep(0.7, 0.9, hora_dia) * 0.0);
	brillo = clamp(
		mix(0.25, 1.0,
			clamp(sin(hora_dia * 3.14159), 0.0, 1.0) * 0.75 + 0.25
		), 0.25, 1.0
	);

	COLOR = vec4(color.rgb * tinte * brillo, color.a);
}
