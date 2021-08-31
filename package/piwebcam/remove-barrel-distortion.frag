varying vec2 v_texcoord;
uniform sampler2D tex;

void main()
{
  vec2 p = gl_FragCoord.xy / 640.0;
  
  float prop = 640.0 / 360.0;
  vec2 m = vec2(0.5, 0.5 / prop);
  vec2 d = p - m;
  float r = sqrt(dot(d, d));

  float power = ( 2.0 * 3.141592 / (2.0 * sqrt(dot(m, m))) ) * -0.025;

  float bind = m.y;

   vec2 uv;
  if (power > 0.0)//fisheye
    uv = m + normalize(d) * tan(r * power) * bind / tan( bind * power);
  else if (power < 0.0)//antifisheye
   uv = m + normalize(d) * atan(r * -power * 10.0) * bind / atan(-power * bind * 10.0);
  else 
    uv = p;//no effect for power = 1.0
        
  uv.y *= prop;

  vec3 col = texture2D(tex, uv).rgb;

  gl_FragColor = vec4(col, 1.0);
}
