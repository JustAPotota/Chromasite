varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

#define PI 3.1415926538

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 seconds_left[256];
// x,y,z = color
// w = current_time
uniform lowp vec4 params;

float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec3 get_seconds_left() {
	float angle = atan(var_texcoord0.y - 0.5, var_texcoord0.x - 0.5);
	float mapped_angle = map(angle, -PI, PI, 0.0, 256.0);
	float upper_index = mod(ceil(mapped_angle), 256.0);
	float lower_index = mod(floor(mapped_angle), 256.0);

	vec3 upper = seconds_left[int(upper_index)].rgb;
	vec3 lower = seconds_left[int(lower_index)].rgb;

	return mix(lower, upper, fract(mapped_angle));
}

#define SPEED 0.15
#define RED vec3(0.82, 0.16, 0.16)
#define GREEN vec3(0.12, 0.90, 0.50)
#define BLUE vec3(0.00, 0.20, 0.80)
void main() {
	// Read data from params
	vec3 initial_color = params.rgb;
	float seconds_alive = params.w;

	// Parse them into something a bit more useful
	float radius = seconds_alive * SPEED;

	// Draw the ring
	float center_distance = length(var_texcoord0 - vec2(0.5));
	float alpha = 1.0 - smoothstep(distance(center_distance, radius), -0.001, 0.001);

	// Start fading after 3 seconds
	alpha *= 1.0 - smoothstep(3.0, 3.33333, seconds_alive);

	vec3 seconds_left = get_seconds_left();

	vec3 not_collided_yet = vec3(
		1.0 - smoothstep(0.0, 0.2, seconds_alive - seconds_left.r),
		1.0 - smoothstep(0.0, 0.2, seconds_alive - seconds_left.g),
		1.0 - smoothstep(0.0, 0.2, seconds_alive - seconds_left.b)
	);
	vec3 is_active = vec3(
		ceil(initial_color.r)*not_collided_yet.r,
		ceil(initial_color.g)*not_collided_yet.g,
		ceil(initial_color.b)*not_collided_yet.b
	);
	float active_colors = ceil(is_active.r) + ceil(is_active.g) + ceil(is_active.b);
	vec3 pulse_color = vec3(0.0);
	pulse_color += RED   * is_active.r / active_colors;
	pulse_color += GREEN * is_active.g / active_colors;
	pulse_color += BLUE  * is_active.b / active_colors;

	gl_FragColor = vec4(pulse_color, alpha * step(0.1, active_colors));
}