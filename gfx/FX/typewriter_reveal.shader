// Typewriter text reveal by Scars

Includes = {
	"buttonstate.fxh"
	"sprite_animation.fxh"
}

PixelShader =
{
	Samplers =
	{
		MapTexture =
		{
			Index = 0
			MagFilter = "Point"
			MinFilter = "Point"
			MipFilter = "None"
			AddressU = "Wrap"
			AddressV = "Wrap"
		}
	}
}


VertexStruct VS_OUTPUT
{
	float4  vPosition : PDX_POSITION;
	float2  vTexCoord : TEXCOORD0;
};

VertexShader =
{
	MainCode VertexShader
	[[
		VS_OUTPUT main(const VS_INPUT v )
		{
			VS_OUTPUT Out;
			Out.vPosition = mul(WorldViewProjectionMatrix, float4(v.vPosition.xyz, 1));
			Out.vTexCoord = v.vTexCoord;
			return Out;
		}
	]]
}

PixelShader =
{
	MainCode PixelShader
	[[
		float4 main( VS_OUTPUT v ) : PDX_COLOR
		{
			// Put the frame information as XXYYY
			// X is the number of characters per line
			// Y is the number of lines

			// For example, 19 lines with 27 characters per line will be `frame = 19027`

			float charactersPerLine = mod(Offset.x,1000) + 1;
			float numberOfLines = floor(Offset.x/1000);
			float linesPerSecond = 0.4;

			float vTime = (Time - AnimationTime) * linesPerSecond;
			float yRoundedTime = ceil(vTime)/numberOfLines;
			float xRoundedTime = floor(vTime*charactersPerLine)/charactersPerLine - floor(v.vTexCoord.y*numberOfLines);
			
			if(v.vTexCoord.x <= xRoundedTime && v.vTexCoord.y <= yRoundedTime){
				return float4(0.0, 0.0, 0.0, 0.0);
			}
			else {
				return tex2D( MapTexture, v.vTexCoord );
			}
		}
	]]
}

BlendState BlendState
{
	BlendEnable = yes
	SourceBlend = "src_alpha"
	DestBlend = "inv_src_alpha"
}

Effect Up
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShader"
}

Effect Down
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShader"
}

Effect Disable
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShader"
}

Effect Over
{
	VertexShader = "VertexShader"
	PixelShader = "PixelShader"
}