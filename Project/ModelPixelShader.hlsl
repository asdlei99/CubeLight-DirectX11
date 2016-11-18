struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR;
	float3 normal : NORMAL;
	float4 world : WORLD;
};

cbuffer LIGHT
{
	float4	color;
	float4	position;
	float4	direction;
	float4	coneDirection;
	float4	camera;
	float4x4 skyboxModel;
};

texture2D env : register(t1);
textureCUBE cubeEnv : register(t2);
SamplerState envFilter : register(s1);

float4 main(PixelShaderInput input) : SV_TARGET
{
	float4 surfaceColor = env.Sample(envFilter, input.color);
	float alpha = surfaceColor.w;
	float4 result = surfaceColor;

	float3 lightDir = normalize(position.xyz - input.world.xyz);
	float3 multiply = mul(-lightDir, skyboxModel);
	float3 cubeReflect = cubeEnv.Sample(envFilter, multiply);

	// Speceular texture
	float3 toCam = normalize(camera.xyz - input.world.xyz);
	float3 toLight = normalize(position.xyz - input.world.xyz);
	float3 refVec = float3(reflect(-toLight.xyz, input.normal.xyz));
	float specPow = saturate(dot(normalize(refVec), toCam));
	specPow = pow(specPow, 125);
	float specIntensity = 0.8f; 
	float4 spec = float4(cubeReflect, 1) * specPow;

	// Point Light
	float lightRatio = saturate(dot(lightDir, input.normal.xyz));
	result = lightRatio * color * surfaceColor * float4(cubeReflect, 1);
	result = result + spec;

	result.w = alpha;
	return result;
}