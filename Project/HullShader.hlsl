// Input control point
struct VS_CONTROL_POINT_OUTPUT
{
	float4 clr : COLOR;
	float3 PositionL : POSITION;
};

// Output control point
struct HS_CONTROL_POINT_OUTPUT
{
	float4 clr : COLOR;
	float3 PositionL : POSITION;
};

[domain("tri")]
[partitioning("fractional_odd")]
[outputtopology("triangle_cw")]
[outputcontrolpoints(3)]
[patchconstantfunc("CalcHSPatchConstants")]

HS_CONTROL_POINT_OUTPUT main(InputPatch<VS_CONTROL_POINT_OUTPUT, NUM_CONTROL_POINTS> ip, uint i : SV_OutputControlPointID, uint PatchID : SV_PrimitiveID)
{
	HS_CONTROL_POINT_OUTPUT Output;
	Output.PositionL = ip[i].PositionL;
	Output.clr = ip[i].clr;
	return Output;
}
