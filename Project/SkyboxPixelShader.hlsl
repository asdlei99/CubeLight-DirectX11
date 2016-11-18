// Per-pixel color data passed through the pixel shader.
struct PixelShaderInput
{
	float4 pos : SV_POSITION;
	float3 color : COLOR;
};

textureCUBE env : register(t0);
SamplerState envFilter : register(s0);

float4 main(PixelShaderInput input) : SV_TARGET
{
	float4 envSample = env.Sample(envFilter, input.color);
	return envSample;
}