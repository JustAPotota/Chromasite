varying mediump vec4 position;
varying mediump vec2 var_texcoord0;

#define PI 3.1415926538

uniform lowp sampler2D texture_sampler;
uniform lowp vec4 seconds_left[256];
// x,y,z = color
// w = current_time
uniform lowp vec4 params;

vec4 color_from_bits(int bits) {
	vec4 color = vec4(0.0);
	if (bits >= 4) {
		color.r = 1.0;
		bits -= 4;
	}
	if (bits >= 2) {
		color.g = 1.0;
		bits -= 2;
	}
	if (bits >= 1) {
		color.b = 1.0;
	}
	color.a = 1.0;
	return color;
}

float map(float value, float min1, float max1, float min2, float max2) {
	return min2 + (value - min1) * (max2 - min2) / (max1 - min1);
}

vec3 get_seconds_left() {
	float angle = atan(var_texcoord0.y - 0.5, var_texcoord0.x - 0.5);
	float mapped_angle = floor(map(angle, -PI, PI, 0.0, 256.0));

	return seconds_left[int(mapped_angle)].rgb;
}

#define SPEED 0.15
void main() {
	// Read data from params
	vec3 pulse_color = params.xyz;
	float seconds_alive = params.w;

	// Parse them into something a bit more useful
	float radius = seconds_alive * SPEED;

	// Draw the ring
	float center_distance = length(var_texcoord0 - vec2(0.5));
	float alpha = 1.0 - smoothstep(distance(center_distance, radius), -0.001, 0.001);

	// Start fading after 3 seconds
	alpha *= 1.0 - smoothstep(3.0, 3.33333, seconds_alive);

	vec3 seconds_left = get_seconds_left();
	pulse_color.r *= step(seconds_alive, seconds_left.r);
	pulse_color.g *= step(seconds_alive, seconds_left.g);
	pulse_color.b *= step(seconds_alive, seconds_left.b);

	gl_FragColor = vec4(pulse_color, alpha);
}