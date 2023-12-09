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
//#define HAS_CUSTOMIZED_UVS 1
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
	Material.PreshaderBuffer[2] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[3] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[4] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[5] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[6] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[7] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[8] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[9] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[10] = float4(6500.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[11] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[12] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[13] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[14] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[15] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[16] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[17] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[18] = float4(1.000000,1.000000,1.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[19] = float4(1.000000,1.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[20] = float4(0.009134,0.015209,0.015209,1.000000);//(Unknown)
	Material.PreshaderBuffer[21] = float4(0.009134,0.015209,0.015209,0.000000);//(Unknown)
	Material.PreshaderBuffer[22] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[23] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[24] = float4(1.000000,1.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[25] = float4(0.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[26] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[27] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[28] = float4(0.000000,0.000000,0.000000,0.000000);//(Unknown)
	Material.PreshaderBuffer[29] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[30] = float4(1.000000,0.000000,0.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[31] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
	Material.PreshaderBuffer[32] = float4(0.000000,0.000000,1.000000,1.000000);//(Unknown)
}
MaterialFloat2 CustomExpression4(FMaterialVertexParameters Parameters,MaterialFloat Angle)
{
float s;
float c;
sincos(Angle, s, c);
return float2(s,c);
}

MaterialFloat CustomExpression3(FMaterialPixelParameters Parameters)
{
return View.FrameNumber;
}

MaterialFloat CustomExpression2(FMaterialPixelParameters Parameters,MaterialFloat2 p)
{
return Mod( ((uint)(p.x) + 2 * (uint)(p.y)) , 5 );
}

MaterialFloat CustomExpression1(FMaterialPixelParameters Parameters)
{
#ifdef SHADOW_DEPTH_SHADER
	return 1.0;
#else
	return 0.0;
#endif

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
	MaterialFloat Local30 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 2);
	MaterialFloat4 Local31 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_1,GetMaterialSharedSampler(sampler_Material_Texture2D_1,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local32 = MaterialStoreTexSample(Parameters, Local31, 2);
	MaterialFloat3 Local33 = PositiveClampedPow(Local31.rgb,Material.PreshaderBuffer[3].xyz);
	MaterialFloat3 Local34 = (Local33 * Material.PreshaderBuffer[8].xyz);
	MaterialFloat3 Local35 = (Local34 + Material.PreshaderBuffer[6].xyz);
	MaterialFloat Local36 = dot(Local35,MaterialFloat3(0.30000001,0.60000002,0.10000000));
	MaterialFloat3 Local37 = lerp(((MaterialFloat3)Local36),Local35,Material.PreshaderBuffer[8].w);
	MaterialFloat3 Local38 = saturate(Local37);
	MaterialFloat3 Local39 = MaterialExpressionBlackBody(Material.PreshaderBuffer[10].x);
	MaterialFloat3 Local40 = normalize(Local39);
	MaterialFloat3 Local41 = (Material.PreshaderBuffer[10].yzw * Local40);
	MaterialFloat3 Local42 = (((MaterialFloat3)Material.PreshaderBuffer[11].x) * Local41);
	MaterialFloat3 Local43 = (Local38 * Local42);
	MaterialFloat3 Local44 = lerp(Local43,Material.PreshaderBuffer[12].xyz,Material.PreshaderBuffer[11].y);
	MaterialFloat Local45 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 3);
	MaterialFloat4 Local46 = ProcessMaterialColorTextureLookup(Texture2DSample(Material_Texture2D_2,GetMaterialSharedSampler(sampler_Material_Texture2D_2,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local47 = MaterialStoreTexSample(Parameters, Local46, 3);
	MaterialFloat3 Local48 = PositiveClampedPow(Local46.rgb,Material.PreshaderBuffer[14].xyz);
	MaterialFloat3 Local49 = (Local48 * Material.PreshaderBuffer[19].xyz);
	MaterialFloat3 Local50 = (Local49 + Material.PreshaderBuffer[17].xyz);
	MaterialFloat Local51 = dot(Local50,MaterialFloat3(0.30000001,0.60000002,0.10000000));
	MaterialFloat3 Local52 = lerp(((MaterialFloat3)Local51),Local50,Material.PreshaderBuffer[19].w);
	MaterialFloat3 Local53 = saturate(Local52);
	MaterialFloat3 Local54 = (Local53 * Material.PreshaderBuffer[21].xyz);
	MaterialFloat Local55 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 4);
	MaterialFloat4 Local56 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_3,GetMaterialSharedSampler(sampler_Material_Texture2D_3,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local57 = MaterialStoreTexSample(Parameters, Local56, 4);
	MaterialFloat Local58 = (1.00000000 - Local56.r);
	MaterialFloat Local59 = lerp(Local56.r,Local58,Material.PreshaderBuffer[22].x);
	MaterialFloat3 Local60 = lerp(Local53,Local54,Local59);
	MaterialFloat Local61 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 7);
	MaterialFloat4 Local62 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_4,GetMaterialSharedSampler(sampler_Material_Texture2D_4,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local63 = MaterialStoreTexSample(Parameters, Local62, 7);
	MaterialFloat Local64 = (1.00000000 - Local62.r);
	MaterialFloat Local65 = lerp(Local62.r,Local64,Material.PreshaderBuffer[22].z);
	MaterialFloat Local66 = (Local65 * Material.PreshaderBuffer[22].w);
	MaterialFloat Local67 = (Local66 + 0.00000000);
	MaterialFloat Local68 = MaterialStoreTexCoordScale(Parameters, DERIV_BASE_VALUE(Local16), 8);
	MaterialFloat4 Local69 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_5,GetMaterialSharedSampler(sampler_Material_Texture2D_5,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local70 = MaterialStoreTexSample(Parameters, Local69, 8);
	MaterialFloat Local71 = (1.00000000 - Local69.r);
	MaterialFloat Local72 = lerp(Local69.r,Local71,Material.PreshaderBuffer[23].w);
	MaterialFloat Local73 = lerp(0.00000000,Local72,Material.PreshaderBuffer[24].y);
	MaterialFloat Local74 = lerp(Local73,1.00000000,Material.PreshaderBuffer[24].w);
	MaterialFloat4 Local75 = ProcessMaterialLinearColorTextureLookup(Texture2DSample(Material_Texture2D_6,GetMaterialSharedSampler(sampler_Material_Texture2D_6,View_MaterialTextureBilinearWrapedSampler),DERIV_BASE_VALUE(Local16)));
	MaterialFloat Local76 = MaterialStoreTexSample(Parameters, Local75, 4);
	MaterialFloat Local77 = lerp(Local46.a,Local75.r,Material.PreshaderBuffer[25].x);
	MaterialFloat Local78 = (1.00000000 - Local77);
	MaterialFloat Local79 = lerp(Local77,Local78,Material.PreshaderBuffer[25].z);
	MaterialFloat Local80 = lerp(1.00000000,Local79,Material.PreshaderBuffer[25].w);
	MaterialFloat2 Local81 = GetPixelPosition(Parameters);
	MaterialFloat Local82 = View.TemporalAAParams.x;
	MaterialFloat Local83 = CustomExpression1(Parameters);
	MaterialFloat Local84 = (1.00000000 - Local83);
	MaterialFloat2 Local85 = (MaterialFloat2(Local82,Local82) * ((MaterialFloat2)Local84));
	MaterialFloat2 Local86 = (Local81 + Local85);
	FLWCVector3 Local87 = LWCMultiply(GetObjectWorldPosition(Parameters), LWCPromote(((MaterialFloat3)0.10310000)));
	MaterialFloat3 Local88 = LWCFrac(Local87);
	MaterialFloat Local89 = DERIV_BASE_VALUE(Local88).b;
	MaterialFloat Local90 = DERIV_BASE_VALUE(Local88).g;
	MaterialFloat2 Local91 = MaterialFloat2(DERIV_BASE_VALUE(Local89),DERIV_BASE_VALUE(Local90));
	MaterialFloat Local92 = DERIV_BASE_VALUE(Local88).r;
	MaterialFloat3 Local93 = MaterialFloat3(DERIV_BASE_VALUE(Local91),DERIV_BASE_VALUE(Local92));
	MaterialFloat3 Local94 = (DERIV_BASE_VALUE(Local93) + ((MaterialFloat3)33.33000183));
	MaterialFloat Local95 = dot(DERIV_BASE_VALUE(Local88),DERIV_BASE_VALUE(Local94));
	MaterialFloat3 Local96 = (DERIV_BASE_VALUE(Local88) + ((MaterialFloat3)DERIV_BASE_VALUE(Local95)));
	MaterialFloat Local97 = DERIV_BASE_VALUE(Local96).r;
	MaterialFloat Local98 = DERIV_BASE_VALUE(Local96).g;
	MaterialFloat Local99 = (DERIV_BASE_VALUE(Local97) + DERIV_BASE_VALUE(Local98));
	MaterialFloat Local100 = DERIV_BASE_VALUE(Local96).b;
	MaterialFloat Local101 = (DERIV_BASE_VALUE(Local99) * DERIV_BASE_VALUE(Local100));
	MaterialFloat Local102 = frac(DERIV_BASE_VALUE(Local101));
	MaterialFloat Local103 = DERIV_BASE_VALUE(Local102).r;
	MaterialFloat Local104 = (DERIV_BASE_VALUE(Local103) * Parameters.TwoSidedSign);
	MaterialFloat Local105 = frac(DERIV_BASE_VALUE(Local104));
	MaterialFloat2 Local106 = (Local86 + ((MaterialFloat2)DERIV_BASE_VALUE(Local105)));
	MaterialFloat Local107 = CustomExpression2(Parameters,Local106);
	MaterialFloat2 Local108 = (Local81 / ((MaterialFloat2)64.00000000));
	MaterialFloat Local109 = MaterialStoreTexCoordScale(Parameters, Local108, 0);
	MaterialFloat4 Local110 = ProcessMaterialLinearGreyscaleTextureLookup(Texture2DSample(Material_Texture2D_7,GetMaterialSharedSampler(sampler_Material_Texture2D_7,View_MaterialTextureBilinearWrapedSampler),Local108));
	MaterialFloat Local111 = MaterialStoreTexSample(Parameters, Local110, 0);
	MaterialFloat Local112 = (Local107 + Local110.r);
	MaterialFloat Local113 = (Local112 / 6.00000000);
	MaterialFloat Local114 = (GetRayTracingQualitySwitch() ? (Local110.r) : (Local113));
	FLWCVector3 Local115 = GetWorldPosition(Parameters);
	FLWCVector3 Local116 = LWCMultiply(DERIV_BASE_VALUE(Local115), LWCPromote(((MaterialFloat3)0.10310000)));
	MaterialFloat3 Local117 = LWCFrac(DERIV_BASE_VALUE(Local116));
	MaterialFloat Local118 = DERIV_BASE_VALUE(Local117).b;
	MaterialFloat Local119 = DERIV_BASE_VALUE(Local117).g;
	MaterialFloat2 Local120 = MaterialFloat2(DERIV_BASE_VALUE(Local118),DERIV_BASE_VALUE(Local119));
	MaterialFloat Local121 = DERIV_BASE_VALUE(Local117).r;
	MaterialFloat3 Local122 = MaterialFloat3(DERIV_BASE_VALUE(Local120),DERIV_BASE_VALUE(Local121));
	MaterialFloat3 Local123 = (DERIV_BASE_VALUE(Local122) + ((MaterialFloat3)33.33000183));
	MaterialFloat Local124 = dot(DERIV_BASE_VALUE(Local117),DERIV_BASE_VALUE(Local123));
	MaterialFloat3 Local125 = (DERIV_BASE_VALUE(Local117) + ((MaterialFloat3)DERIV_BASE_VALUE(Local124)));
	MaterialFloat Local126 = DERIV_BASE_VALUE(Local125).r;
	MaterialFloat Local127 = DERIV_BASE_VALUE(Local125).g;
	MaterialFloat Local128 = (DERIV_BASE_VALUE(Local126) + DERIV_BASE_VALUE(Local127));
	MaterialFloat Local129 = DERIV_BASE_VALUE(Local125).b;
	MaterialFloat Local130 = (DERIV_BASE_VALUE(Local128) * DERIV_BASE_VALUE(Local129));
	MaterialFloat Local131 = frac(DERIV_BASE_VALUE(Local130));
	MaterialFloat Local132 = (DERIV_BASE_VALUE(Local131) * 64.00000000);
	MaterialFloat Local133 = CustomExpression3(Parameters);
	MaterialFloat Local134 = (DERIV_BASE_VALUE(Local132) + Local133);
	MaterialFloat Local135 = (Parameters.TwoSidedSign * 32.00000000);
	MaterialFloat Local136 = (Local134 + Local135);
	MaterialFloat Local137 = floor(Local136);
	MaterialFloat Local138 = (Local137 / 64.00000000);
	MaterialFloat Local139 = frac(Local138);
	MaterialFloat Local140 = (GetPathTracingQualitySwitch() ? (DERIV_BASE_VALUE(Local139)) : (Local114));
	MaterialFloat Local141 = (Local140 * 0.99800003);
	MaterialFloat Local142 = (Local141 + 0.00100000);
	MaterialFloat Local143 = (Local80 + Local142);
	MaterialFloat Local144 = (Local143 - 0.50000000);
	MaterialFloat Local145 = round(Local144);

	PixelMaterialInputs.EmissiveColor = Local44;
	PixelMaterialInputs.Opacity = 1.00000000;
	PixelMaterialInputs.OpacityMask = Local145;
	PixelMaterialInputs.BaseColor = Local60;
	PixelMaterialInputs.Metallic = Local67;
	PixelMaterialInputs.Specular = 0.50000000;
	PixelMaterialInputs.Roughness = Local74;
	PixelMaterialInputs.Anisotropy = 0.00000000;
	PixelMaterialInputs.Normal = Local29;
	PixelMaterialInputs.Tangent = MaterialFloat3(1.00000000,0.00000000,0.00000000);
	PixelMaterialInputs.Subsurface = 0;
	PixelMaterialInputs.AmbientOcclusion = 1.00000000;
	PixelMaterialInputs.Refraction = 0;
	PixelMaterialInputs.PixelDepthOffset = 0.00000000;
	PixelMaterialInputs.ShadingModel = 1;
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
	if( PixelMaterialInputs.OpacityMask < 0.333 ) discard;

	o.Metallic = PixelMaterialInputs.Metallic;
	o.Smoothness = 1.0 - PixelMaterialInputs.Roughness;
	o.Normal = normalize( PixelMaterialInputs.Normal );
	o.Emission = PixelMaterialInputs.EmissiveColor.rgb;
	o.Occlusion = PixelMaterialInputs.AmbientOcclusion;

	//BLEND_ADDITIVE o.Alpha = ( o.Emission.r + o.Emission.g + o.Emission.b ) / 3;
}