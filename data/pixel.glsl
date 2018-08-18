#ifdef GL_ES
precision mediump float;
precision mediump int;
#endif

#define PROCESSING_TEXTURE_SHADER

uniform sampler2D texture;
uniform vec2 texOffset;

varying vec4 vertColor;
varying vec4 vertTexCoord;


uniform int pixelSize;

void main(void)
{
    vec2 p = vertTexCoord.st;

    vec2 mp=vec2(p.x-mod(p.x,1.0/pixelSize)+.5/pixelSize,p.y-mod(p.y,1.0/pixelSize)+.5/pixelSize);

    if(distance(p,mp)<=(1.0/pixelSize*.2)){

        vec3 col = texture2D(texture, mp).rgb;

        gl_FragColor = vec4(col, 1.0);
        if(gl_FragColor==vec4(0.0,0.0,0.0,1.0)) gl_FragColor=vec4(0.0);
    }else{
        gl_FragColor=vec4(0.0,0.0,0.0,0.0);
    }
}


