#define NUM_TEX_COORD_INTERPOLATORS 1
#define NUM_MATERIAL_TEXCOORDS_VERTEX 1
#define NUM_CUSTOM_VERTEX_INTERPOLATORS 0

struct Input
{
	//float3 Normal;
	float2 uv_MainTex : TEXCOORD0;
	float2 uv2_Material_Texture2D_0 : TEXCOORD1;
	float4 color : COLOR;
	float4 tangent;
	//float4 normal;
	float3 viewDir;
	float4 screenPos;
	float3 worldPos;
	//float3 worldNormal;
	float3 normal2;
};
struct SurfaceOutputStandard
{
	float3 Albedo;		// base (diffuse or specular) color
	float3 Normal;		// tangent space normal, if written
	half3 Emission;
	half Metallic;		// 0=non-metal, 1=metal
	// Smoothness is the user facing name, it should be perceptual smoothness but user should not have to deal with it.
	// Everywhere in the code you meet smoothness it is perceptual smoothness
	half Smoothness;	// 0=rough, 1=smooth
	half Occlusion;		// occlusion (default 1)
	float Alpha;		// alpha for transparencies
};

//#define HDRP 1
#define URP 1
#define UE5
#define HAS_CUSTOMIZED_UVS 1
#define MATERIAL_TANGENTSPACENORMAL 1
//struct Material
//{
	//samplers start
SAMPLER( SamplerState_Linear_Repeat );
SAMPLER( SamplerState_Linear_Clamp );
TEXTURE2D(       Material_Texture2D_0 );
SAMPLER( sampler_Material_Texture2D_0 );
TEXTURE2D(       Material_Texture2D_1 );
SAMPLER( sampler_Material_Texture2D_1 );
TEXTURE2D(       Material_Texture2D_2 );
SAMPLER( sampler_Material_Texture2D_2 );
TEXTURE2D(       Material_Texture2D_3 );
SAMPLER( sampler_Material_Texture2D_3 );
TEXTURE2D(       Material_Texture2D_4 );
SAMPLER( sampler_Material_Texture2D_4 );
TEXTURE2D(       Material_Texture2D_5 );
SAMPLER( sampler_Material_Texture2D_5 );
TEXTURE2D(       Material_Texture2D_6 );
SAMPLER( sampler_Material_Texture2D_6 );
TEXTURE2D(       Material_Texture2D_7 );
SAMPLER( sampler_Material_Texture2D_7 );
TEXTURE2D(       Material_Texture2D_8 );
SAMPLER( sampler_Material_Texture2D_8 );
TEXTURE2D(       Material_Texture2D_9 );
SAMPLER( sampler_Material_Texture2D_9 );
TEXTURE2D(       Material_Texture2D_10 );
SAMPLER( sampler_Material_Texture2D_10 );

//};

#ifdef UE5
	#define UE_LWC_RENDER_TILE_SIZE			2097152.0
	#define UE_LWC_RENDER_TILE_SIZE_SQRT	1448.15466
	#define UE_LWC_RENDER_TILE_SIZE_RSQRT	0.000690533954
	#define UE_LWC_RENDER_TILE_SIZE_RCP		4.76837158e-07
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_PI		0.673652053
	#define UE_LWC_RENDER_TILE_SIZE_FMOD_2PI	0.673652053
	#define INVARIANT(X) X
	#define PI 					(3.1415926535897932)

	#include "LargeWorldCoordinates.hlsl"
#endif
struct MaterialStruct
{
	float4 PreshaderBuffer[33];
	float4 ScalarExpressions[1];
	float VTPackedPageTableUniform[2];
	float VTPackedUniform[1];
};
static SamplerState View_MaterialTextureBilinearWrapedSampler;
static SamplerState View_MaterialTextureBilinearClampedSampler;
struct ViewStruct
{
	float GameTime;
	float RealTime;
	float DeltaTime;
	float PrevFrameGameTime;
	float PrevFrameRealTime;
	float MaterialTextureMipBias;	
	float4 PrimitiveSceneData[ 40 ];
	float4 TemporalAAParams;
	float2 ViewRectMin;
	float4 ViewSizeAndInvSize;
	float MaterialTextureDerivativeMultiply;
	uint StateFrameIndexMod8;
	float FrameNumber;
	float2 FieldOfViewWideAngles;
	float4 RuntimeVirtualTextureMipLevel;
	float PreExposure;
	float4 BufferBilinearUVMinMax;
};
struct ResolvedViewStruct
{
	#ifdef UE5
		FLWCVector3 WorldCameraOrigin;
		FLWCVector3 PrevWorldCameraOrigin;
		FLWCVector3 PreViewTranslation;
		FLWCVector3 WorldViewOrigin;
	#else
		float3 WorldCameraOrigin;
		float3 PrevWorldCameraOrigin;
		float3 PreViewTranslation;
		float3 WorldViewOrigin;
	#endif
	float4 ScreenPositionScaleBias;
	float4x4 TranslatedWorldToView;
	float4x4 TranslatedWorldToCameraView;
	float4x4 TranslatedWorldToClip;
	float4x4 ViewToTranslatedWorld;
	float4x4 PrevViewToTranslatedWorld;
	float4x4 CameraViewToTranslatedWorld;
	float4 BufferBilinearUVMinMax;
	float4 XRPassthroughCameraUVs[ 2 ];
};
struct PrimitiveStruct
{
	float4x4 WorldToLocal;
	float4x4 LocalToWorld;
};

static ViewStruct View;
static ResolvedViewStruct ResolvedView;
static PrimitiveStruct Primitive;
uniform float4 View_BufferSizeAndInvSize;
uniform float4 LocalObjectBoundsMin;
uniform float4 LocalObjectBoundsMax;
static SamplerState Material_Wrap_WorldGroupSettings;
static SamplerState Material_Clamp_WorldGroupSettings;

#include "UnrealCommon.cginc"

static MaterialStruct Material;
void InitializeExpressions()
{
	Material.PreshaderBuffer[0] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[1] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[2] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(0.534280,0.776042,0.369839,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.534280,0.776042,0.369839,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(0.010000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(0.050000,0.050000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(-0.146100,0.019499,1.292200,1.038998);//(Unknown)
	Material.PreshaderBuffer[20] = float4(1.038998,-0.146100,0.019499,1.292200);//(Unknown)
	Material.PreshaderBuffer[21] = float4(-0.146100,0.019499,1.292200,1.038998);//(Unknown)
	Material.PreshaderBuffer[22] = float4(1.292200,1.038998,-0.146100,0.019499);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.292200,1.292200,1.038998,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(0.773874,0.962466,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,1.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(1.520000,1.520000,2.520000,-0.520000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(-0.206349,0.042580,0.957420,0.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(0.000000,0.000000,0.532250,0.532250);//(Unknown)
	Material.PreshaderBuffer[31] = float4(1.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.000000,-1.000000,0.000000,0.000000);//(Unknown)
}
MaterialFloat2 CustomExpression5(FMaterialVertexParameters Parameters,MaterialFloat Angle)
{
float s;
float c;
sincos(Angle, s, c);
return float2(s,c);
}

MaterialFloat CustomExpression4(FMaterialPixelParameters Parameters)
{
return View.FrameNumber;
}

MaterialFloat CustomExpression3(FMaterialPixelParameters Parameters,MaterialFloat2 p)
{
return Mod( ((uint)(p.x) + 2 * (uint)(p.y)) , 5 );
}

MaterialFloat CustomExpression2(FMaterialPixelParameters Parameters)
{
#ifdef SHADOW_DEPTH_SHADER
	return 1.0;
#else
	return 0.0;
#endif

}

MaterialFloat CustomExpression1(FMaterialPixelParameters Parameters,MaterialFloat2 p)
{
return Mod( ((uint)(p.x) + 2 * (uint)(p.y)) , 5 );
}

MaterialFloat2 CustomExpression0(FMaterialPixelParameters Parameters,MaterialFloat Angle)
{
float s;
float c;
sincos(Angle, s, c);
return float2(s,c);
}
float3 GetMaterialWorldPositionOffset(FMaterialVertexParameters Parameters)
{
	return MaterialFloat3(0.00000000,0.00000000,0.00000000);;
}

void GetMaterialCustomizedUVs(FMaterialPixelParameters PixelParameters, inout float2 OutTexCoords[NUM_TEX_COORD_INTERPOLATORS])
{
	FMaterialVertexParameters Parameters = (FMaterialVertexParameters)0;
	Parameters.TangentToWorld = PixelParameters.TangentToWorld;
	Parameters.WorldPosition = PixelParameters.AbsoluteWorldPosition;
	Parameters.VertexColor = PixelParameters.VertexColor;
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 0
	int m = min( NUM_MATERIAL_TEXCOORDS_VERTEX, NUM_TEX_COORD_INTERPOLATORS );
	for( int i = 0; i < m; i++ )
	{
		Parameters.TexCoords[i] = PixelParameters.TexCoords[i];
	}
#endif
	Parameters.PrimitiveId = PixelParameters.PrimitiveId;

	MaterialFloat Local336 = (View.GameTime * Material.PreshaderBuffer[18].z);
	MaterialFloat Local337 = (View.GameTime * Material.PreshaderBuffer[18].w);
	MaterialFloat2 Local338 = Parameters.TexCoords[0].xy;
	MaterialFloat2 Local339 = (MaterialFloat2(-0.50000000,-0.50000000) + DERIV_BASE_VALUE(Local338));
	MaterialFloat2 Local340 = CustomExpression5(Parameters,Material.PreshaderBuffer[1].x);
	MaterialFloat Local341 = (Local340.r * -1.00000000);
	MaterialFloat Local342 = dot(DERIV_BASE_VALUE(Local339),MaterialFloat2(Local340.g,Local341));
	MaterialFloat Local343 = dot(DERIV_BASE_VALUE(Local339),Local340);
	MaterialFloat2 Local344 = (MaterialFloat2(0.50000000,0.50000000) + MaterialFloat2(Local342,Local343));
	MaterialFloat2 Local345 = (Material.PreshaderBuffer[22].zw + Local344);
	MaterialFloat2 Local346 = (Material.PreshaderBuffer[22].xy * Local345);
	MaterialFloat2 Local347 = (MaterialFloat2(Local336,Local337) + Local346);
	OutTexCoords[0] = Local347;

}
void CalcPixelMaterialInputs(in out FMaterialPixelParameters Parameters, in out FPixelMaterialInputs PixelMaterialInputs)
{
	//WorldAligned texturing & others use normals & stuff that think Z is up
	Parameters.TangentToWorld[0] = Parameters.TangentToWorld[0].xzy;
	Parameters.TangentToWorld[1] = Parameters.TangentToWorld[1].xzy;
	Parameters.TangentToWorld[2] = Parameters.TangentToWorld[2].xzy;

	float3 WorldNormalCopy = Parameters.WorldNormal;

	// Initial calculations (required for Normal)
	MaterialFloat2 Local14 = CustomExpression0(Parameters,Material.PreshaderBuffer[1].x);
	MaterialFloat Local15 = (Local14.r * -1.00000000);
	MaterialFloat2 Local16 = Parameters.TexCoords[0].xy;
	MaterialFloat Local17 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 1);
	MaterialFloat4 Local18 = UnpackNormalMap(Texture2DSample(Material_Texture2D_0,GetMaterialSharedSampler(sampler_Material_Texture2D_0,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local19 = MaterialStoreTexSample(Parameters, Local18, 1);
	MaterialFloat3 Local20 = (MaterialFloat3(MaterialFloat2(Local14.g,Local15),0.00000000) * ((MaterialFloat3)Local18.rgb.r));
	MaterialFloat3 Local21 = (MaterialFloat3(MaterialFloat2(Local14.r,Local14.g),0.00000000) * ((MaterialFloat3)Local18.rgb.g));
	MaterialFloat3 Local22 = (Local20 + Local21);
	MaterialFloat3 Local23 = (MaterialFloat3(0.00000000,0.00000000,1.00000000) * ((MaterialFloat3)Local18.rgb.b));
	MaterialFloat3 Local24 = (Local23 + MaterialFloat3(0.00000000,0.00000000,0.00000000));
	MaterialFloat3 Local25 = (Local22 + Local24);
	MaterialFloat2 Local26 = (Local25.rg * ((MaterialFloat2)Parameters.TwoSidedSign));
	MaterialFloat3 Local27 = lerp(MaterialFloat3(0.00000000,0.00000000,1.00000000),MaterialFloat3(Local26,Local25.b),Material.PreshaderBuffer[1].y);
	MaterialFloat3 Local28 = (Local27 * MaterialFloat3(1.00000000,-1.00000000,1.00000000));
	MaterialFloat3 Local29 = lerp(Local27,Local28,Material.PreshaderBuffer[1].z);

	// The Normal is a special case as it might have its own expressions and also be used to calculate other inputs, so perform the assignment here
	PixelMaterialInputs.Normal = Local29;


#if TEMPLATE_USES_STRATA
	Parameters.StrataPixelFootprint = StrataGetPixelFootprint(Parameters.WorldPosition_CamRelative, GetRoughnessFromNormalCurvature(Parameters));
	Parameters.SharedLocalBases = StrataInitialiseSharedLocalBases();
	Parameters.StrataTree = GetInitialisedStrataTree();
#if STRATA_USE_FULLYSIMPLIFIED_MATERIAL == 1
	Parameters.SharedLocalBasesFullySimplified = StrataInitialiseSharedLocalBases();
	Parameters.StrataTreeFullySimplified = GetInitialisedStrataTree();
#endif
#endif

	// Note that here MaterialNormal can be in world space or tangent space
	float3 MaterialNormal = GetMaterialNormal(Parameters, PixelMaterialInputs);

#if MATERIAL_TANGENTSPACENORMAL

#if FEATURE_LEVEL >= FEATURE_LEVEL_SM4
	// Mobile will rely on only the final normalize for performance
	MaterialNormal = normalize(MaterialNormal);
#endif

	// normalizing after the tangent space to world space conversion improves quality with sheared bases (UV layout to WS causes shrearing)
	// use full precision normalize to avoid overflows
	Parameters.WorldNormal = TransformTangentNormalToWorld(Parameters.TangentToWorld, MaterialNormal);

#else //MATERIAL_TANGENTSPACENORMAL

	Parameters.WorldNormal = normalize(MaterialNormal);

#endif //MATERIAL_TANGENTSPACENORMAL

#if MATERIAL_TANGENTSPACENORMAL
	// flip the normal for backfaces being rendered with a two-sided material
	Parameters.WorldNormal *= Parameters.TwoSidedSign;
#endif

	Parameters.ReflectionVector = ReflectionAboutCustomWorldNormal(Parameters, Parameters.WorldNormal, false);

#if !PARTICLE_SPRITE_FACTORY
	Parameters.Particle.MotionBlurFade = 1.0f;
#endif // !PARTICLE_SPRITE_FACTORY

	// Now the rest of the inputs
	MaterialFloat3 Local30 = lerp(MaterialFloat3(0.00000000,0.00000000,0.00000000),Material.PreshaderBuffer[2].xyz,Material.PreshaderBuffer[1].w);
	MaterialFloat Local31 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 4);
	MaterialFloat4 Local32 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(sampler_Material_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local33 = MaterialStoreTexSample(Parameters, Local32, 4);
	MaterialFloat3 Local34 = PositiveClampedPow(Local32.rgb,Material.PreshaderBuffer[4].xyz);
	MaterialFloat3 Local35 = (Local34 * Material.PreshaderBuffer[9].xyz);
	MaterialFloat3 Local36 = (Local35 + Material.PreshaderBuffer[7].xyz);
	MaterialFloat Local37 = dot(Local36,MaterialFloat3(0.30000001,0.60000002,0.10000000));
	MaterialFloat3 Local38 = lerp(((MaterialFloat3)Local37),Local36,Material.PreshaderBuffer[9].w);
	MaterialFloat3 Local39 = saturate(Local38);
	MaterialFloat3 Local40 = (Local39 * Material.PreshaderBuffer[11].xyz);
	MaterialFloat Local41 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 5);
	MaterialFloat4 Local42 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local43 = MaterialStoreTexSample(Parameters, Local42, 5);
	MaterialFloat Local44 = (1.00000000 - Local42.r);
	MaterialFloat Local45 = lerp(Local42.r,Local44,Material.PreshaderBuffer[12].x);
	MaterialFloat3 Local46 = lerp(Local39,Local40,Local45);
	MaterialFloat Local47 = dot(Parameters.TangentToWorld[2],Parameters.ReflectionVector);
	MaterialFloat Local48 = PositiveClampedPow(Local47,Material.PreshaderBuffer[12].y);
	MaterialFloat Local49 = (1.00000000 - Local48);
	MaterialFloat Local50 = lerp(Local48,Local49,Material.PreshaderBuffer[13].x);
	MaterialFloat Local51 = (Local50 + Material.PreshaderBuffer[13].y);
	MaterialFloat Local52 = MaterialStoreTexCoordScale(Parameters, MaterialFloat2(Local51,Material.PreshaderBuffer[14].y), 8);
	MaterialFloat4 Local53 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(sampler_Material_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),MaterialFloat2(Local51,Material.PreshaderBuffer[14].y)));
	MaterialFloat Local54 = MaterialStoreTexSample(Parameters, Local53, 8);
	MaterialFloat3 Local55 = lerp(Local46,Local53.rgb,Material.PreshaderBuffer[14].w);
	MaterialFloat3 Local56 = lerp(Local46,Local55,Material.PreshaderBuffer[15].y);
	MaterialFloat Local57 = (View.GameTime * Material.PreshaderBuffer[18].z);
	MaterialFloat Local58 = (View.GameTime * Material.PreshaderBuffer[18].w);
	FLWCVector3 Local59 = GetWorldPosition(Parameters);
	FLWCVector3 Local60 = MakeLWCVector(LWCGetX(DERIV_BASE_VALUE(Local59)), LWCGetY(DERIV_BASE_VALUE(Local59)), LWCGetZ(DERIV_BASE_VALUE(Local59)));
	FLWCVector3 Local61 = LWCMultiply(DERIV_BASE_VALUE(Local60), LWCPromote(((MaterialFloat3)0.01000000)));
	FLWCScalar Local62 = LWCGetX(DERIV_BASE_VALUE(Local61));
	FLWCScalar Local63 = LWCGetY(DERIV_BASE_VALUE(Local61));
	FLWCVector2 Local64 = MakeLWCVector(LWCPromote(DERIV_BASE_VALUE(Local62)),LWCPromote(DERIV_BASE_VALUE(Local63)));
	MaterialFloat3 Local65 = sign(Parameters.TangentToWorld[2]);
	MaterialFloat3 Local66 = (Parameters.TangentToWorld[2] + MaterialFloat3(0.00000000,0.00000100,-0.00000100));
	MaterialFloat2 Local67 = normalize(Local66.rg);
	MaterialFloat2 Local68 = abs(Local67);
	MaterialFloat2 Local69 = PositiveClampedPow(Local68,((MaterialFloat2)4.00000000));
	MaterialFloat Local70 = dot(Local69,MaterialFloat2(1.00000000,1.00000000).rg);
	MaterialFloat2 Local71 = (Local69 / ((MaterialFloat2)Local70));
	MaterialFloat2 Local72 = GetPixelPosition(Parameters);
	MaterialFloat Local73 = View.TemporalAAParams.x;
	MaterialFloat2 Local74 = (Local72 + MaterialFloat2(Local73,Local73));
	MaterialFloat Local75 = CustomExpression1(Parameters,Local74);
	MaterialFloat2 Local76 = (Local72 / MaterialFloat2(64.00000000,64.00000000));
	MaterialFloat Local77 = MaterialStoreTexCoordScale(Parameters, Local76, 11);
	MaterialFloat4 Local78 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSampleBias(Material_Texture2D_4,sampler_Material_Texture2D_4,Local76,View.MaterialTextureMipBias));
	MaterialFloat Local79 = MaterialStoreTexSample(Parameters, Local78, 11);
	MaterialFloat Local80 = (Local75 + Local78.r);
	MaterialFloat Local81 = (Local80 * 0.16665000);
	MaterialFloat Local82 = (0.50000000 + Local81);
	MaterialFloat Local83 = (Local82 + -0.50000000);
	FLWCVector3 Local84 = LWCMultiply(DERIV_BASE_VALUE(Local60), LWCPromote(((MaterialFloat3)0.10310000)));
	MaterialFloat3 Local85 = LWCFrac(DERIV_BASE_VALUE(Local84));
	MaterialFloat Local86 = DERIV_BASE_VALUE(Local85).b;
	MaterialFloat Local87 = DERIV_BASE_VALUE(Local85).g;
	MaterialFloat2 Local88 = MaterialFloat2(DERIV_BASE_VALUE(Local86),DERIV_BASE_VALUE(Local87));
	MaterialFloat Local89 = DERIV_BASE_VALUE(Local85).r;
	MaterialFloat3 Local90 = MaterialFloat3(DERIV_BASE_VALUE(Local88),DERIV_BASE_VALUE(Local89));
	MaterialFloat3 Local91 = (DERIV_BASE_VALUE(Local90) + ((MaterialFloat3)33.33000183));
	MaterialFloat Local92 = dot(DERIV_BASE_VALUE(Local85),DERIV_BASE_VALUE(Local91));
	MaterialFloat3 Local93 = (DERIV_BASE_VALUE(Local85) + ((MaterialFloat3)DERIV_BASE_VALUE(Local92)));
	MaterialFloat Local94 = DERIV_BASE_VALUE(Local93).r;
	MaterialFloat Local95 = DERIV_BASE_VALUE(Local93).g;
	MaterialFloat Local96 = (DERIV_BASE_VALUE(Local94) + DERIV_BASE_VALUE(Local95));
	MaterialFloat Local97 = DERIV_BASE_VALUE(Local93).b;
	MaterialFloat Local98 = (DERIV_BASE_VALUE(Local96) * DERIV_BASE_VALUE(Local97));
	MaterialFloat Local99 = frac(DERIV_BASE_VALUE(Local98));
	MaterialFloat Local100 = (GetPathTracingQualitySwitch() ? (DERIV_BASE_VALUE(Local99)) : (Local83));
	MaterialFloat Local101 = (Local100 * 0.99800003);
	MaterialFloat Local102 = (Local101 + 0.00100000);
	MaterialFloat Local103 = (Local102 - 0.50000000);
	MaterialFloat Local104 = (Local103 * 0.50000000);
	MaterialFloat Local105 = (Local104 * 0.50000000);
	MaterialFloat Local106 = (Local71.r + Local105);
	MaterialFloat Local107 = round(Local106);
	MaterialFloat3 Local108 = lerp(MaterialFloat3(0.00000000,1.00000000,0.00000000).rgb,MaterialFloat3(1.00000000,0.00000000,0.00000000).rgb,MaterialFloat2(Local107,0.00000000).x);
	MaterialFloat Local109 = abs(Local66.b);
	MaterialFloat Local110 = (Local109 - (0.63000000 - 0.50000000));
	MaterialFloat Local111 = (Local110 - 0.50000000);
	MaterialFloat Local112 = (Local111 * 2.00000000);
	MaterialFloat Local113 = (Local112 + 0.50000000);
	MaterialFloat Local114 = saturate(Local113);
	MaterialFloat Local115 = (Local114 + Local105);
	MaterialFloat Local116 = round(Local115);
	MaterialFloat3 Local117 = lerp(Local108,MaterialFloat3(0.00000000,0.00000000,1.00000000).rgb,Local116);
	MaterialFloat3 Local118 = (Local65 * Local117);
	FLWCVector2 Local119 = LWCMultiply(DERIV_BASE_VALUE(Local64), LWCPromote(((MaterialFloat2)Local118.b)));
	FLWCScalar Local120 = LWCGetZ(DERIV_BASE_VALUE(Local61));
	FLWCVector2 Local121 = MakeLWCVector(LWCPromote(DERIV_BASE_VALUE(Local63)),LWCPromote(DERIV_BASE_VALUE(Local120)));
	FLWCVector2 Local122 = LWCMultiply(DERIV_BASE_VALUE(Local121), LWCPromote(((MaterialFloat2)-1.00000000)));
	FLWCVector2 Local123 = LWCMultiply(DERIV_BASE_VALUE(Local122), LWCPromote(((MaterialFloat2)Local118.r)));
	FLWCScalar Local124 = LWCMultiply(DERIV_BASE_VALUE(Local120), LWCPromote(-1.00000000));
	FLWCVector2 Local125 = MakeLWCVector(LWCPromote(DERIV_BASE_VALUE(Local62)),LWCPromote(DERIV_BASE_VALUE(Local124)));
	FLWCVector2 Local126 = LWCMultiply(DERIV_BASE_VALUE(Local125), LWCPromote(((MaterialFloat2)Local118.g)));
	FLWCVector2 Local127 = LWCAdd(DERIV_BASE_VALUE(Local123), DERIV_BASE_VALUE(Local126));
	FLWCVector2 Local128 = LWCAdd(DERIV_BASE_VALUE(Local119), DERIV_BASE_VALUE(Local127));
	MaterialFloat Local129 = (Local118.r + Local118.g);
	MaterialFloat Local130 = (Local129 + Local118.b);
	FLWCVector2 Local131 = LWCMultiply(DERIV_BASE_VALUE(Local128), LWCPromote(MaterialFloat2(1.00000000,Local130)));
	FLWCVector2 Local132 = LWCMultiply(LWCPromote(Material.PreshaderBuffer[22].xy), DERIV_BASE_VALUE(Local131));
	FLWCVector2 Local133 = LWCAdd(LWCPromote(MaterialFloat2(0.00000000,0.00000000)), DERIV_BASE_VALUE(Local132));
	FLWCScalar Local134 = LWCDot(DERIV_BASE_VALUE(Local133), LWCPromote(MaterialFloat2(Local14.g,Local15)));
	FLWCScalar Local135 = LWCDot(DERIV_BASE_VALUE(Local133), LWCPromote(Local14));
	FLWCVector2 Local136 = LWCAdd(LWCPromote(MaterialFloat2(0.00000000,0.00000000)), MakeLWCVector(LWCPromote(Local134),LWCPromote(Local135)));
	FLWCVector2 Local137 = LWCAdd(LWCPromote(Material.PreshaderBuffer[22].zw), Local136);
	FLWCVector2 Local138 = LWCAdd(LWCPromote(MaterialFloat2(Local57,Local58)), Local137);
	FLWCVector2 Local139 = LWCMultiply(Local138, LWCPromote(Material.PreshaderBuffer[24].xy));
	MaterialFloat Local140 = lerp(8.00000000,3.00000000,Material.PreshaderBuffer[24].w);
	FLWCVector2 Local141 = LWCMultiply(Local139, LWCPromote(((MaterialFloat2)Local140)));
	MaterialFloat2 Local142 = LWCDdx(DERIV_BASE_VALUE(Local64));
	MaterialFloat2 Local143 = LWCDdy(DERIV_BASE_VALUE(Local64));
	MaterialFloat4 Local144 = MaterialFloat4(DERIV_BASE_VALUE(Local142),DERIV_BASE_VALUE(Local143));
	MaterialFloat4 Local145 = (DERIV_BASE_VALUE(Local144) * ((MaterialFloat4)Local118.b));
	MaterialFloat2 Local146 = LWCDdx(DERIV_BASE_VALUE(Local122));
	MaterialFloat2 Local147 = LWCDdy(DERIV_BASE_VALUE(Local122));
	MaterialFloat4 Local148 = MaterialFloat4(DERIV_BASE_VALUE(Local146),DERIV_BASE_VALUE(Local147));
	MaterialFloat4 Local149 = (DERIV_BASE_VALUE(Local148) * ((MaterialFloat4)Local118.r));
	MaterialFloat2 Local150 = LWCDdx(DERIV_BASE_VALUE(Local125));
	MaterialFloat2 Local151 = LWCDdy(DERIV_BASE_VALUE(Local125));
	MaterialFloat4 Local152 = MaterialFloat4(DERIV_BASE_VALUE(Local150),DERIV_BASE_VALUE(Local151));
	MaterialFloat4 Local153 = (DERIV_BASE_VALUE(Local152) * ((MaterialFloat4)Local118.g));
	MaterialFloat4 Local154 = (DERIV_BASE_VALUE(Local149) + DERIV_BASE_VALUE(Local153));
	MaterialFloat4 Local155 = (DERIV_BASE_VALUE(Local145) + DERIV_BASE_VALUE(Local154));
	MaterialFloat Local156 = DERIV_BASE_VALUE(Local155).b;
	MaterialFloat Local157 = DERIV_BASE_VALUE(Local155).a;
	MaterialFloat2 Local158 = MaterialFloat2(DERIV_BASE_VALUE(Local156),DERIV_BASE_VALUE(Local157));
	MaterialFloat Local159 = DERIV_BASE_VALUE(Local155).r;
	MaterialFloat Local160 = DERIV_BASE_VALUE(Local155).g;
	MaterialFloat2 Local161 = MaterialFloat2(DERIV_BASE_VALUE(Local159),DERIV_BASE_VALUE(Local160));
	MaterialFloat2 Local162 = LWCApplyAddressMode(Local141, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local163 = MaterialStoreTexCoordScale(Parameters, Local162, 2);
	MaterialFloat4 Local164 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleGrad(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local162,DERIV_BASE_VALUE(Local161),DERIV_BASE_VALUE(Local158)));
	MaterialFloat Local165 = MaterialStoreTexSample(Parameters, Local164, 2);
	FLWCVector3 Local166 = ResolvedView.WorldCameraOrigin;
	FLWCVector3 Local167 = LWCSubtract(DERIV_BASE_VALUE(Local59), Local166);
	MaterialFloat3 Local168 = LWCToFloat(DERIV_BASE_VALUE(Local167));
	MaterialFloat Local169 = length(DERIV_BASE_VALUE(Local168));
	MaterialFloat2 Local170 = GetCotanHalfFieldOfView();
	MaterialFloat Local171 = (DERIV_BASE_VALUE(Local169) / Local170.r);
	MaterialFloat Local172 = (DERIV_BASE_VALUE(Local171) / 200.00000000);
	MaterialFloat Local173 = saturate(DERIV_BASE_VALUE(Local172));
	MaterialFloat Local174 = (1.00000000 - DERIV_BASE_VALUE(Local173));
	MaterialFloat Local175 = max(DERIV_BASE_VALUE(Local174),0.20000000);
	MaterialFloat Local176 = min(DERIV_BASE_VALUE(Local175),Material.PreshaderBuffer[25].x);
	MaterialFloat2 Local177 = (DERIV_BASE_VALUE(Local16) * ((MaterialFloat2)0.25000000));
	MaterialFloat Local178 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local177), 3);
	MaterialFloat4 Local179 = ProcessMaterialAlphaTextureLookup(Texture2DSampleGrad(Material_Texture2D_6,GetMaterialSharedSampler(sampler_Material_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local177),DERIV_BASE_VALUE(Local161),DERIV_BASE_VALUE(Local158)));
	MaterialFloat Local180 = MaterialStoreTexSample(Parameters, Local179, 3);
	MaterialFloat Local181 = (Local179.r - 0.33000001);
	MaterialFloat Local182 = (Local181 / ((0.40000001 + 0.33000001) - 0.33000001));
	MaterialFloat Local183 = (Local182 * (0.00000000 - 0.85000002));
	MaterialFloat Local184 = (Local183 + 0.85000002);
	MaterialFloat Local185 = saturate(Local184);
	MaterialFloat2 Local186 = (DERIV_BASE_VALUE(Local16) * ((MaterialFloat2)0.69999999));
	MaterialFloat Local187 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local186), 3);
	MaterialFloat4 Local188 = ProcessMaterialAlphaTextureLookup(Texture2DSampleGrad(Material_Texture2D_6,GetMaterialSharedSampler(sampler_Material_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local186),DERIV_BASE_VALUE(Local161),DERIV_BASE_VALUE(Local158)));
	MaterialFloat Local189 = MaterialStoreTexSample(Parameters, Local188, 3);
	MaterialFloat Local190 = (Local185 * Local188.r);
	MaterialFloat Local191 = (DERIV_BASE_VALUE(Local176) * Local190);
	MaterialFloat Local192 = (Local164.r * Local191);
	MaterialFloat Local193 = (Local192 * Material.PreshaderBuffer[25].z);
	MaterialFloat Local194 = lerp(8.00000000,3.00000000,Material.PreshaderBuffer[26].x);
	FLWCVector2 Local195 = LWCMultiply(Local139, LWCPromote(((MaterialFloat2)Local194)));
	MaterialFloat2 Local196 = LWCApplyAddressMode(Local195, LWCADDRESSMODE_WRAP, LWCADDRESSMODE_WRAP);
	MaterialFloat Local197 = MaterialStoreTexCoordScale(Parameters, Local196, 2);
	MaterialFloat4 Local198 = ProcessMaterialLinearColorTextureLookup(Texture2DSampleGrad(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),Local196,DERIV_BASE_VALUE(Local161),DERIV_BASE_VALUE(Local158)));
	MaterialFloat Local199 = MaterialStoreTexSample(Parameters, Local198, 2);
	MaterialFloat Local200 = min(Material.PreshaderBuffer[26].y,DERIV_BASE_VALUE(Local175));
	MaterialFloat Local201 = (DERIV_BASE_VALUE(Local200) * Local190);
	MaterialFloat Local202 = (Local201 * Local201);
	MaterialFloat Local203 = (Local198.g * Local202);
	MaterialFloat Local204 = (Material.PreshaderBuffer[25].z * Local203);
	MaterialFloat Local205 = (Local193 + Local204);
	MaterialFloat Local206 = saturate(Local205);
	MaterialFloat3 Local207 = lerp(Local56,((MaterialFloat3)0.50000000),Local206);
	MaterialFloat4 Local208 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(sampler_Material_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local209 = MaterialStoreTexSample(Parameters, Local208, 5);
	MaterialFloat Local210 = lerp(Local32.a,Local208.r,Material.PreshaderBuffer[26].z);
	MaterialFloat Local211 = (1.00000000 - Local210);
	MaterialFloat Local212 = lerp(Local210,Local211,Material.PreshaderBuffer[27].x);
	MaterialFloat Local213 = lerp(1.00000000,Local212,Material.PreshaderBuffer[27].y);
	MaterialFloat Local214 = (Local213 * Material.PreshaderBuffer[27].z);
	MaterialFloat Local215 = max(Local214,Material.PreshaderBuffer[27].w);
	MaterialFloat Local216 = dot(WorldNormalCopy,Parameters.CameraVector);
	MaterialFloat Local217 = abs(Local216);
	MaterialFloat Local218 = (1.00000000 - Local217);
	MaterialFloat Local219 = PositiveClampedPow(Local218,5.00000000);
	MaterialFloat Local220 = (Material.PreshaderBuffer[29].z * Local219);
	MaterialFloat Local221 = (Material.PreshaderBuffer[29].y + Local220);
	MaterialFloat Local222 = lerp(Local214,Local215,Local221);
	MaterialFloat Local223 = saturate(Local222);
	MaterialFloat Local224 = lerp(Local223,1.00000000,Local206);
	MaterialFloat Local225 = CustomExpression2(Parameters);
	MaterialFloat Local226 = (1.00000000 - Local225);
	MaterialFloat2 Local227 = (MaterialFloat2(Local73,Local73) * ((MaterialFloat2)Local226));
	MaterialFloat2 Local228 = (Local72 + Local227);
	FLWCVector3 Local229 = LWCMultiply(GetObjectWorldPosition(Parameters), LWCPromote(((MaterialFloat3)0.10310000)));
	MaterialFloat3 Local230 = LWCFrac(Local229);
	MaterialFloat Local231 = DERIV_BASE_VALUE(Local230).b;
	MaterialFloat Local232 = DERIV_BASE_VALUE(Local230).g;
	MaterialFloat2 Local233 = MaterialFloat2(DERIV_BASE_VALUE(Local231),DERIV_BASE_VALUE(Local232));
	MaterialFloat Local234 = DERIV_BASE_VALUE(Local230).r;
	MaterialFloat3 Local235 = MaterialFloat3(DERIV_BASE_VALUE(Local233),DERIV_BASE_VALUE(Local234));
	MaterialFloat3 Local236 = (DERIV_BASE_VALUE(Local235) + ((MaterialFloat3)33.33000183));
	MaterialFloat Local237 = dot(DERIV_BASE_VALUE(Local230),DERIV_BASE_VALUE(Local236));
	MaterialFloat3 Local238 = (DERIV_BASE_VALUE(Local230) + ((MaterialFloat3)DERIV_BASE_VALUE(Local237)));
	MaterialFloat Local239 = DERIV_BASE_VALUE(Local238).r;
	MaterialFloat Local240 = DERIV_BASE_VALUE(Local238).g;
	MaterialFloat Local241 = (DERIV_BASE_VALUE(Local239) + DERIV_BASE_VALUE(Local240));
	MaterialFloat Local242 = DERIV_BASE_VALUE(Local238).b;
	MaterialFloat Local243 = (DERIV_BASE_VALUE(Local241) * DERIV_BASE_VALUE(Local242));
	MaterialFloat Local244 = frac(DERIV_BASE_VALUE(Local243));
	MaterialFloat Local245 = DERIV_BASE_VALUE(Local244).r;
	MaterialFloat Local246 = (DERIV_BASE_VALUE(Local245) * Parameters.TwoSidedSign);
	MaterialFloat Local247 = frac(DERIV_BASE_VALUE(Local246));
	MaterialFloat2 Local248 = (Local228 + ((MaterialFloat2)DERIV_BASE_VALUE(Local247)));
	MaterialFloat Local249 = CustomExpression3(Parameters,Local248);
	MaterialFloat2 Local250 = (Local72 / ((MaterialFloat2)64.00000000));
	MaterialFloat Local251 = MaterialStoreTexCoordScale(Parameters, Local250, 0);
	MaterialFloat4 Local252 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSample(Material_Texture2D_8,GetMaterialSharedSampler(sampler_Material_Texture2D_8,View_MaterialTextureBilinearWrapedSampler),Local250));
	MaterialFloat Local253 = MaterialStoreTexSample(Parameters, Local252, 0);
	MaterialFloat Local254 = (Local249 + Local252.r);
	MaterialFloat Local255 = (Local254 / 6.00000000);
	MaterialFloat Local256 = (GetRayTracingQualitySwitch() ? (Local252.r) : (Local255));
	MaterialFloat Local257 = (Local256 * 0.99800003);
	MaterialFloat Local258 = (Local257 + 0.00100000);
	MaterialFloat Local259 = (Local224 + Local258);
	MaterialFloat Local260 = (Local259 - 0.50000000);
	MaterialFloat Local261 = round(Local260);
	MaterialFloat Local262 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 6);
	MaterialFloat4 Local263 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_9,GetMaterialSharedSampler(sampler_Material_Texture2D_9,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local264 = MaterialStoreTexSample(Parameters, Local263, 6);
	MaterialFloat Local265 = (1.00000000 - Local263.r);
	MaterialFloat Local266 = lerp(Local263.r,Local265,Material.PreshaderBuffer[30].x);
	MaterialFloat Local267 = (Local266 * Material.PreshaderBuffer[30].y);
	MaterialFloat Local268 = lerp(Local267,0.00000000,Local206);
	MaterialFloat Local269 = select((Local261 >= 0.50000000), Local268, 0.00000000);
	MaterialFloat Local270 = (DERIV_BASE_VALUE(Local99) * 64.00000000);
	MaterialFloat Local271 = CustomExpression4(Parameters);
	MaterialFloat Local272 = (DERIV_BASE_VALUE(Local270) + Local271);
	MaterialFloat Local273 = (Parameters.TwoSidedSign * 32.00000000);
	MaterialFloat Local274 = (Local272 + Local273);
	MaterialFloat Local275 = floor(Local274);
	MaterialFloat Local276 = (Local275 / 64.00000000);
	MaterialFloat Local277 = frac(Local276);
	MaterialFloat Local278 = (DERIV_BASE_VALUE(Local277) * 0.99800003);
	MaterialFloat Local279 = (DERIV_BASE_VALUE(Local278) + 0.00100000);
	MaterialFloat Local280 = (Local224 + DERIV_BASE_VALUE(Local279));
	MaterialFloat Local281 = (Local280 - 0.50000000);
	MaterialFloat Local282 = round(Local281);
	MaterialFloat Local283 = (Local268 + DERIV_BASE_VALUE(Local279));
	MaterialFloat Local284 = (Local283 - 0.50000000);
	MaterialFloat Local285 = round(Local284);
	MaterialFloat Local286 = select((Local282 >= 0.50000000), Local285, 0.00000000);
	MaterialFloat Local287 = (GetPathTracingQualitySwitch() ? (Local286) : (Local269));
	MaterialFloat Local288 = (1.00000000 - Local223);
	MaterialFloat Local289 = lerp(Material.PreshaderBuffer[31].x,Material.PreshaderBuffer[30].w,Local288);
	MaterialFloat Local290 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 7);
	MaterialFloat4 Local291 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_10,GetMaterialSharedSampler(sampler_Material_Texture2D_10,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local292 = MaterialStoreTexSample(Parameters, Local291, 7);
	MaterialFloat Local293 = (1.00000000 - Local291.r);
	MaterialFloat Local294 = lerp(Local291.r,Local293,Material.PreshaderBuffer[31].z);
	MaterialFloat Local295 = lerp(0.00000000,Local294,Material.PreshaderBuffer[32].x);
	MaterialFloat Local296 = lerp(Local295,1.00000000,Material.PreshaderBuffer[32].z);
	MaterialFloat Local297 = (Local206 * 0.50000000);
	MaterialFloat Local298 = lerp(Local296,1.00000000,Local297);
	MaterialFloat Local299 = (GetPathTracingQualitySwitch() ? (Local282) : (Local261));
	MaterialFloat Local300 = (Local268 + Local258);
	MaterialFloat Local301 = (Local300 - 0.50000000);
	MaterialFloat Local302 = round(Local301);
	MaterialFloat Local303 = (1.00000000 - Local261);
	MaterialFloat Local304 = (Local302 * Local303);
	MaterialFloat Local305 = (GetPathTracingQualitySwitch() ? (Material.PreshaderBuffer[28].y) : (1.00000000));
	MaterialFloat Local306 = select((Local304 >= 0.50000000), 1.00000000, Local305);
	MaterialFloat Local307 = select((Local285 >= 0.50000000), 0.00000000, Local305);
	MaterialFloat Local308 = (GetPathTracingQualitySwitch() ? (Local307) : (Local306));

	PixelMaterialInputs.EmissiveColor = Local30;
	PixelMaterialInputs.Opacity = Local299;
	PixelMaterialInputs.OpacityMask = 1.00000000;
	PixelMaterialInputs.BaseColor = Local207;
	PixelMaterialInputs.Metallic = Local287;
	PixelMaterialInputs.Specular = Local289;
	PixelMaterialInputs.Roughness = Local298;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local29;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = MaterialFloat3(MaterialFloat2(Local308,0.0f),Material.PreshaderBuffer[32].w);
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 11;
	PixelMaterialInputs.FrontMaterial = GetInitialisedStrataData();
	PixelMaterialInputs.SurfaceThickness = 0.01000000;
	PixelMaterialInputs.Displacement = 0.00000000;


#if MATERIAL_USES_ANISOTROPY
	Parameters.WorldTangent = CalculateAnisotropyTangent(Parameters, PixelMaterialInputs);
#else
	Parameters.WorldTangent = 0;
#endif
}

#define UnityObjectToWorldDir TransformObjectToWorld

void SetupCommonData( int Parameters_PrimitiveId )
{
	View_MaterialTextureBilinearWrapedSampler = SamplerState_Linear_Repeat;
	View_MaterialTextureBilinearClampedSampler = SamplerState_Linear_Clamp;

	Material_Wrap_WorldGroupSettings = SamplerState_Linear_Repeat;
	Material_Clamp_WorldGroupSettings = SamplerState_Linear_Clamp;

	View.GameTime = View.RealTime = _Time.y;// _Time is (t/20, t, t*2, t*3)
	View.PrevFrameGameTime = View.GameTime - unity_DeltaTime.x;//(dt, 1/dt, smoothDt, 1/smoothDt)
	View.PrevFrameRealTime = View.RealTime;
	View.DeltaTime = unity_DeltaTime.x;
	View.MaterialTextureMipBias = 0.0;
	View.TemporalAAParams = float4( 0, 0, 0, 0 );
	View.ViewRectMin = float2( 0, 0 );
	View.ViewSizeAndInvSize = View_BufferSizeAndInvSize;
	View.MaterialTextureDerivativeMultiply = 1.0f;
	View.StateFrameIndexMod8 = 0;
	View.FrameNumber = (int)_Time.y;
	View.FieldOfViewWideAngles = float2( PI * 0.42f, PI * 0.42f );//75degrees, default unity
	View.RuntimeVirtualTextureMipLevel = float4( 0, 0, 0, 0 );
	View.PreExposure = 0;
	View.BufferBilinearUVMinMax = float4(
		View_BufferSizeAndInvSize.z * ( 0 + 0.5 ),//EffectiveViewRect.Min.X
		View_BufferSizeAndInvSize.w * ( 0 + 0.5 ),//EffectiveViewRect.Min.Y
		View_BufferSizeAndInvSize.z * ( View_BufferSizeAndInvSize.x - 0.5 ),//EffectiveViewRect.Max.X
		View_BufferSizeAndInvSize.w * ( View_BufferSizeAndInvSize.y - 0.5 ) );//EffectiveViewRect.Max.Y

	for( int i2 = 0; i2 < 40; i2++ )
		View.PrimitiveSceneData[ i2 ] = float4( 0, 0, 0, 0 );

	float4x4 LocalToWorld = transpose( UNITY_MATRIX_M );
	float4x4 WorldToLocal = transpose( UNITY_MATRIX_I_M );
	float4x4 ViewMatrix = transpose( UNITY_MATRIX_V );
	float4x4 InverseViewMatrix = transpose( UNITY_MATRIX_I_V );
	float4x4 ViewProjectionMatrix = transpose( UNITY_MATRIX_VP );
	uint PrimitiveBaseOffset = Parameters_PrimitiveId * PRIMITIVE_SCENE_DATA_STRIDE;
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 0 ] = LocalToWorld[ 0 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 1 ] = LocalToWorld[ 1 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 2 ] = LocalToWorld[ 2 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 3 ] = LocalToWorld[ 3 ];//LocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 5 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 100.0 );//ObjectWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 6 ] = WorldToLocal[ 0 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 7 ] = WorldToLocal[ 1 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 8 ] = WorldToLocal[ 2 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 9 ] = WorldToLocal[ 3 ];//WorldToLocal
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 10 ] = LocalToWorld[ 0 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 11 ] = LocalToWorld[ 1 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 12 ] = LocalToWorld[ 2 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 13 ] = LocalToWorld[ 3 ];//PreviousLocalToWorld
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 18 ] = float4( ToUnrealPos( SHADERGRAPH_OBJECT_POSITION ), 0 );//ActorWorldPosition
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 19 ] = LocalObjectBoundsMax - LocalObjectBoundsMin;//ObjectBounds
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 21 ] = mul( LocalToWorld, float3( 1, 0, 0 ) );
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 23 ] = LocalObjectBoundsMin;//LocalObjectBoundsMin 
	View.PrimitiveSceneData[ PrimitiveBaseOffset + 24 ] = LocalObjectBoundsMax;//LocalObjectBoundsMax

#ifdef UE5
	ResolvedView.WorldCameraOrigin = LWCPromote( ToUnrealPos( _WorldSpaceCameraPos.xyz ) );
	ResolvedView.PreViewTranslation = LWCPromote( float3( 0, 0, 0 ) );
	ResolvedView.WorldViewOrigin = LWCPromote( float3( 0, 0, 0 ) );
#else
	ResolvedView.WorldCameraOrigin = ToUnrealPos( _WorldSpaceCameraPos.xyz );
	ResolvedView.PreViewTranslation = float3( 0, 0, 0 );
	ResolvedView.WorldViewOrigin = float3( 0, 0, 0 );
#endif
	ResolvedView.PrevWorldCameraOrigin = ResolvedView.WorldCameraOrigin;
	ResolvedView.ScreenPositionScaleBias = float4( 1, 1, 0, 0 );
	ResolvedView.TranslatedWorldToView		 = ViewMatrix;
	ResolvedView.TranslatedWorldToCameraView = ViewMatrix;
	ResolvedView.TranslatedWorldToClip		 = ViewProjectionMatrix;
	ResolvedView.ViewToTranslatedWorld		 = InverseViewMatrix;
	ResolvedView.PrevViewToTranslatedWorld = ResolvedView.ViewToTranslatedWorld;
	ResolvedView.CameraViewToTranslatedWorld = InverseViewMatrix;
	ResolvedView.BufferBilinearUVMinMax = View.BufferBilinearUVMinMax;
	Primitive.WorldToLocal = WorldToLocal;
	Primitive.LocalToWorld = LocalToWorld;
}
float3 PrepareAndGetWPO( float4 VertexColor, float3 UnrealWorldPos, float3 UnrealNormal, float4 InTangent,
						 float4 UV0, float4 UV1 )
{
	InitializeExpressions();
	FMaterialVertexParameters Parameters = (FMaterialVertexParameters)0;

	float3 InWorldNormal = UnrealNormal;
	float4 tangentWorld = InTangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	
	UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	Parameters.WorldPosition = UnrealWorldPos;
	Parameters.TangentToWorld[ 0 ] = Parameters.TangentToWorld[ 0 ].xzy;
	Parameters.TangentToWorld[ 1 ] = Parameters.TangentToWorld[ 1 ].xzy;
	Parameters.TangentToWorld[ 2 ] = Parameters.TangentToWorld[ 2 ].xzy;//WorldAligned texturing uses normals that think Z is up

	Parameters.VertexColor = VertexColor;

#if NUM_MATERIAL_TEXCOORDS_VERTEX > 0			
	Parameters.TexCoords[ 0 ] = float2( UV0.x, UV0.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 1
	Parameters.TexCoords[ 1 ] = float2( UV1.x, UV1.y );
#endif
#if NUM_MATERIAL_TEXCOORDS_VERTEX > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( UV0.x, UV0.y );
	}
#endif

	Parameters.PrimitiveId = 0;

	SetupCommonData( Parameters.PrimitiveId );

#ifdef UE5
	Parameters.PrevFrameLocalToWorld = MakeLWCMatrix( float3( 0, 0, 0 ), Primitive.LocalToWorld );
#else
	Parameters.PrevFrameLocalToWorld = Primitive.LocalToWorld;
#endif
	
	float3 Offset = float3( 0, 0, 0 );
	Offset = GetMaterialWorldPositionOffset( Parameters );
	//Convert from unreal units to unity
	Offset /= float3( 100, 100, 100 );
	Offset = Offset.xzy;
	return Offset;
}

void SurfaceReplacement( Input In, out SurfaceOutputStandard o )
{
	InitializeExpressions();

	float3 Z3 = float3( 0, 0, 0 );
	float4 Z4 = float4( 0, 0, 0, 0 );

	float3 UnrealWorldPos = float3( In.worldPos.x, In.worldPos.y, In.worldPos.z );

	float3 UnrealNormal = In.normal2;	

	FMaterialPixelParameters Parameters = (FMaterialPixelParameters)0;
#if NUM_TEX_COORD_INTERPOLATORS > 0			
	Parameters.TexCoords[ 0 ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 1
	Parameters.TexCoords[ 1 ] = float2( In.uv2_Material_Texture2D_0.x, 1.0 - In.uv2_Material_Texture2D_0.y );
#endif
#if NUM_TEX_COORD_INTERPOLATORS > 2
	for( int i = 2; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
	{
		Parameters.TexCoords[ i ] = float2( In.uv_MainTex.x, 1.0 - In.uv_MainTex.y );
	}
#endif
	Parameters.VertexColor = In.color;
	Parameters.WorldNormal = UnrealNormal;
	Parameters.ReflectionVector = half3( 0, 0, 1 );
	Parameters.CameraVector = normalize( _WorldSpaceCameraPos.xyz - UnrealWorldPos.xyz );
	//Parameters.CameraVector = mul( ( float3x3 )unity_CameraToWorld, float3( 0, 0, 1 ) ) * -1;
	Parameters.LightVector = half3( 0, 0, 0 );
	//float4 screenpos = In.screenPos;
	//screenpos /= screenpos.w;
	Parameters.SvPosition = In.screenPos;
	Parameters.ScreenPosition = Parameters.SvPosition;

	Parameters.UnMirrored = 1;

	Parameters.TwoSidedSign = 1;


	float3 InWorldNormal = UnrealNormal;	
	float4 tangentWorld = In.tangent;
	tangentWorld.xyz = normalize( tangentWorld.xyz );
	//float3x3 tangentToWorld = CreateTangentToWorldPerVertex( InWorldNormal, tangentWorld.xyz, tangentWorld.w );
	Parameters.TangentToWorld = float3x3( normalize( cross( InWorldNormal, tangentWorld.xyz ) * tangentWorld.w ), tangentWorld.xyz, InWorldNormal );

	//WorldAlignedTexturing in UE relies on the fact that coords there are 100x larger, prepare values for that
	//but watch out for any computation that might get skewed as a side effect
	UnrealWorldPos = ToUnrealPos( UnrealWorldPos );
	
	Parameters.AbsoluteWorldPosition = UnrealWorldPos;
	Parameters.WorldPosition_CamRelative = UnrealWorldPos;
	Parameters.WorldPosition_NoOffsets = UnrealWorldPos;

	Parameters.WorldPosition_NoOffsets_CamRelative = Parameters.WorldPosition_CamRelative;
	Parameters.LightingPositionOffset = float3( 0, 0, 0 );

	Parameters.AOMaterialMask = 0;

	Parameters.Particle.RelativeTime = 0;
	Parameters.Particle.MotionBlurFade;
	Parameters.Particle.Random = 0;
	Parameters.Particle.Velocity = half4( 1, 1, 1, 1 );
	Parameters.Particle.Color = half4( 1, 1, 1, 1 );
	Parameters.Particle.TranslatedWorldPositionAndSize = float4( UnrealWorldPos, 0 );
	Parameters.Particle.MacroUV = half4( 0, 0, 1, 1 );
	Parameters.Particle.DynamicParameter = half4( 0, 0, 0, 0 );
	Parameters.Particle.LocalToWorld = float4x4( Z4, Z4, Z4, Z4 );
	Parameters.Particle.Size = float2( 1, 1 );
	Parameters.Particle.SubUVCoords[ 0 ] = Parameters.Particle.SubUVCoords[ 1 ] = float2( 0, 0 );
	Parameters.Particle.SubUVLerp = 0.0;
	Parameters.TexCoordScalesParams = float2( 0, 0 );
	Parameters.PrimitiveId = 0;
	Parameters.VirtualTextureFeedback = 0;

	FPixelMaterialInputs PixelMaterialInputs = (FPixelMaterialInputs)0;
	PixelMaterialInputs.Normal = float3( 0, 0, 1 );
	PixelMaterialInputs.ShadingModel = 0;
	PixelMaterialInputs.FrontMaterial = 0;

	SetupCommonData( Parameters.PrimitiveId );
	//CustomizedUVs
	#if NUM_TEX_COORD_INTERPOLATORS > 0 && HAS_CUSTOMIZED_UVS
		float2 OutTexCoords[ NUM_TEX_COORD_INTERPOLATORS ];
		GetMaterialCustomizedUVs( Parameters, OutTexCoords );
		for( int i = 0; i < NUM_TEX_COORD_INTERPOLATORS; i++ )
		{
			Parameters.TexCoords[ i ] = OutTexCoords[ i ];
		}
	#endif
	//<-
	CalcPixelMaterialInputs( Parameters, PixelMaterialInputs );

	#define HAS_WORLDSPACE_NORMAL 0
	#if HAS_WORLDSPACE_NORMAL
		PixelMaterialInputs.Normal = mul( PixelMaterialInputs.Normal, (MaterialFloat3x3)( transpose( Parameters.TangentToWorld ) ) );
	#endif

	o.Albedo = PixelMaterialInputs.BaseColor.rgb;
	o.Alpha = PixelMaterialInputs.Opacity;
	//if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}