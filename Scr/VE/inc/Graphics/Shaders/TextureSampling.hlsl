struct IN
{
    float3 position : POSITION;
    float2 uv : UV;
};
struct Out
{
    float4 position : SV_POSITION;
    float2 uv : UV;
};
cbuffer constant : register(b0)
{
    row_major float4x4 m_world;
    row_major float4x4 m_view;
    row_major float4x4 m_proj;
  
    unsigned int m_time;
}
//Vertex shaders a responsilbe for processing each vertex before it is reasterized or put on the screen, 
//They handle positioning and color of a vertex.
Out vsmain(IN input)
{
    Out output = (Out)0;
    float4 pos = float4(input.position, 1.0f);
	//WORLD SPACE
    output.position = mul(pos, m_world);
	//VIEW SPACE
    output.position = mul(output.position, m_view);
	//SCREEN SPACE
    output.position = mul(output.position, m_proj);
    output.uv = input.uv;
    return output;
}
texture2D tex2D;
SamplerState tex2D_Sampler;
//The Shader/Pixel shader handles the color calculations for each pixel on the screen by
//taking some data from the Vetex shader. 
float4 psmain(Out input) : SV_Target
//SV_Taget tells us that the ouput will be stored in the first render target by native grahicp pipline/Ouput Merger stage
{
   
    return tex2D.Sample(tex2D_Sampler, input.uv);

}