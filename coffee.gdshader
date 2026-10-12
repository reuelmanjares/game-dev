shader_type canvas_item;

uniform vec4 outline_color : source_color = vec4(1.0, 0.0, 0.0, 1.0);
uniform float outline_size = 2.0;

void fragment() {
		COLOR = texture(TEXTURE, UV);
		
			vec2 pixel = TEXTURE_PIXEL_SIZE * outline_size;
			
				float alpha = 0.0;
				
					alpha += texture(TEXTURE, UV + vec2(pixel.x, 0.0)).a;
						alpha += texture(TEXTURE, UV + vec2(-pixel.x, 0.0)).a;
							alpha += texture(TEXTURE, UV + vec2(0.0, pixel.y)).a;
								alpha += texture(TEXTURE, UV + vec2(0.0, -pixel.y)).a;
								
									if (COLOR.a == 0.0 && alpha > 0.0) {
												COLOR = outline_color;
													
													
													
									}
}