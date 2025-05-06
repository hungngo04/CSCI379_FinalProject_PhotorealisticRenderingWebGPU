struct tint_symbol {
  /* @offset(0) */
  tint_symbol_1 : f32,
  /* @offset(4) */
  tint_symbol_2 : f32,
  /* @offset(8) */
  tint_symbol_3 : f32,
  /* @offset(12) */
  tint_symbol_4 : f32,
  /* @offset(16) */
  tint_symbol_5 : f32,
  /* @offset(20) */
  tint_symbol_6 : f32,
  /* @offset(24) */
  tint_symbol_7 : f32,
  /* @offset(28) */
  tint_symbol_8 : f32,
  /* @offset(32) */
  tint_symbol_9 : f32,
  /* @offset(36) */
  tint_symbol_10 : f32,
  /* @offset(40) */
  tint_symbol_11 : f32,
  /* @offset(44) */
  tint_symbol_12 : f32,
  /* @offset(48) */
  tint_symbol_13 : f32,
  /* @offset(52) */
  tint_symbol_14 : f32,
  /* @offset(56) */
  tint_symbol_15 : f32,
  /* @offset(60) */
  tint_symbol_16 : f32,
}

struct tint_symbol_63 {
  /* @offset(0) */
  tint_symbol_64 : tint_symbol,
  /* @offset(64) */
  tint_symbol_65 : vec2f,
  /* @offset(72) */
  tint_symbol_66 : vec2f,
}

struct tint_symbol_92_block {
  /* @offset(0) */
  inner : tint_symbol_63,
}

struct tint_symbol_67 {
  /* @offset(0) */
  tint_symbol_68 : vec4f,
  /* @offset(16) */
  tint_symbol_69 : vec4f,
}

struct tint_symbol_93_block {
  /* @offset(0) */
  inner : tint_symbol_67,
}

alias RTArr = array<f32>;

struct tint_symbol_94_block {
  /* @offset(0) */
  inner : RTArr,
}

struct tint_symbol_96_block {
  /* @offset(0) */
  inner : u32,
}

struct tint_symbol_70 {
  /* @offset(0) */
  tint_symbol_71 : vec3f,
  /* @offset(12) */
  tint_symbol_72 : f32,
  /* @offset(16) */
  tint_symbol_73 : f32,
  /* @offset(20) */
  tint_symbol_74 : f32,
  /* @offset(24) */
  tint_symbol_75 : vec2f,
}

struct tint_symbol_97_block {
  /* @offset(0) */
  inner : tint_symbol_70,
}

struct tint_symbol_76 {
  /* @offset(0) */
  tint_symbol_77 : vec3f,
  /* @offset(12) */
  tint_symbol_78 : f32,
  /* @offset(16) */
  tint_symbol_79 : vec3f,
  /* @offset(28) */
  tint_symbol_80 : f32,
}

struct tint_symbol_98_block {
  /* @offset(0) */
  inner : tint_symbol_76,
}

struct tint_symbol_84 {
  /* @offset(0) */
  tint_symbol_85 : vec3f,
  /* @offset(16) */
  tint_symbol_86 : vec3f,
  /* @offset(32) */
  tint_symbol_87 : vec3f,
  /* @offset(48) */
  tint_symbol_88 : vec3f,
  /* @offset(64) */
  tint_symbol_89 : vec3f,
  /* @offset(80) */
  tint_symbol_90 : vec3f,
  /* @offset(96) */
  tint_symbol_91 : vec3f,
}

struct tint_symbol_100_block {
  /* @offset(0) */
  inner : tint_symbol_84,
}

struct tint_symbol_52 {
  /* @offset(0) */
  tint_symbol_23 : vec3f,
  /* @offset(12) */
  tint_symbol_53 : bool,
  /* @offset(16) */
  tint_symbol_54 : bool,
}

struct tint_symbol_81 {
  /* @offset(0) */
  tint_symbol_79 : vec3f,
  /* @offset(12) */
  tint_symbol_82 : f32,
  /* @offset(16) */
  tint_symbol_83 : f32,
  /* @offset(20) */
  tint_symbol_72 : f32,
}

var<private> tint_symbol_199_1 : vec3u;

@group(0) @binding(0) var<uniform> tint_symbol_92 : tint_symbol_92_block;

@group(0) @binding(1) var<uniform> tint_symbol_93 : tint_symbol_93_block;

@group(0) @binding(2) var<storage> tint_symbol_94 : tint_symbol_94_block;

@group(0) @binding(3) var tint_symbol_95 : texture_storage_2d<rgba8unorm, write>;

@group(0) @binding(4) var<uniform> tint_symbol_96 : tint_symbol_96_block;

@group(0) @binding(5) var<uniform> tint_symbol_97 : tint_symbol_97_block;

@group(0) @binding(6) var<uniform> tint_symbol_98 : tint_symbol_98_block;

@group(0) @binding(7) var<uniform> tint_symbol_99 : tint_symbol_96_block;

@group(0) @binding(8) var<uniform> tint_symbol_100 : tint_symbol_100_block;

fn tint_ftoi(v : vec3f) -> vec3i {
  return select(vec3i(2147483647i), select(vec3i(v), vec3i(i32(-2147483648)), (v < vec3f(-2147483648.0f))), (v < vec3f(2147483520.0f)));
}

fn tint_ftoi_1(v_1 : f32) -> i32 {
  return select(2147483647i, select(i32(v_1), i32(-2147483648), (v_1 < -2147483648.0f)), (v_1 < 2147483520.0f));
}

fn tint_symbol_17(tint_symbol_18 : tint_symbol, tint_symbol_19 : tint_symbol) -> tint_symbol {
  var tint_symbol_20 = tint_symbol(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
  tint_symbol_20.tint_symbol_1 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_1) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_3)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_4)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_14));
  tint_symbol_20.tint_symbol_2 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_2) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_14)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_8));
  tint_symbol_20.tint_symbol_3 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_3) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_12));
  tint_symbol_20.tint_symbol_4 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_4) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_1)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_13));
  tint_symbol_20.tint_symbol_5 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_5) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_7)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_16)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_15)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_9)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_10)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_12)) - (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_4));
  tint_symbol_20.tint_symbol_6 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_6) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_5)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_16)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_7)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_4)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_10)) - (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_9)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_15)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_3));
  tint_symbol_20.tint_symbol_7 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_7) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_16)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_5)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_1)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_9)) - (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_12)) - (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_10)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_11)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_15)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_2));
  tint_symbol_20.tint_symbol_8 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_8) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_1)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_4)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_2));
  tint_symbol_20.tint_symbol_9 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_9) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_15)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_10)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_7)) + (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_3)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_5)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_16)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_14));
  tint_symbol_20.tint_symbol_10 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_10) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_15)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_9)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_7)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_16)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_5)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_3)) - (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_13));
  tint_symbol_20.tint_symbol_11 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_11) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_10)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_9)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_15)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_5)) - (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_16)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_7)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_12));
  tint_symbol_20.tint_symbol_12 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_12) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_3));
  tint_symbol_20.tint_symbol_13 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_13) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_14)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_4));
  tint_symbol_20.tint_symbol_14 = ((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_14) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_8)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_12)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_13)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_2)) + (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_4)) + (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_1));
  tint_symbol_20.tint_symbol_15 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_15) - (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_9)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_10)) - (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_12)) + (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_14)) + (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_16)) - (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_3)) - (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_4)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_5)) - (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_6)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_7)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_1)) - (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_8));
  tint_symbol_20.tint_symbol_16 = ((((((((((((((((tint_symbol_18.tint_symbol_1 * tint_symbol_19.tint_symbol_16) + (tint_symbol_18.tint_symbol_2 * tint_symbol_19.tint_symbol_7)) - (tint_symbol_18.tint_symbol_3 * tint_symbol_19.tint_symbol_6)) + (tint_symbol_18.tint_symbol_4 * tint_symbol_19.tint_symbol_5)) + (tint_symbol_18.tint_symbol_5 * tint_symbol_19.tint_symbol_4)) - (tint_symbol_18.tint_symbol_6 * tint_symbol_19.tint_symbol_3)) + (tint_symbol_18.tint_symbol_7 * tint_symbol_19.tint_symbol_2)) - (tint_symbol_18.tint_symbol_8 * tint_symbol_19.tint_symbol_15)) + (tint_symbol_18.tint_symbol_9 * tint_symbol_19.tint_symbol_14)) - (tint_symbol_18.tint_symbol_10 * tint_symbol_19.tint_symbol_13)) + (tint_symbol_18.tint_symbol_11 * tint_symbol_19.tint_symbol_12)) - (tint_symbol_18.tint_symbol_12 * tint_symbol_19.tint_symbol_11)) + (tint_symbol_18.tint_symbol_13 * tint_symbol_19.tint_symbol_10)) - (tint_symbol_18.tint_symbol_14 * tint_symbol_19.tint_symbol_9)) + (tint_symbol_18.tint_symbol_15 * tint_symbol_19.tint_symbol_8)) + (tint_symbol_18.tint_symbol_16 * tint_symbol_19.tint_symbol_1));
  let x_864 = tint_symbol_20;
  return x_864;
}

fn tint_symbol_21(tint_symbol_18_1 : tint_symbol) -> tint_symbol {
  return tint_symbol(tint_symbol_18_1.tint_symbol_1, -(tint_symbol_18_1.tint_symbol_2), -(tint_symbol_18_1.tint_symbol_3), -(tint_symbol_18_1.tint_symbol_4), -(tint_symbol_18_1.tint_symbol_5), -(tint_symbol_18_1.tint_symbol_6), -(tint_symbol_18_1.tint_symbol_7), -(tint_symbol_18_1.tint_symbol_8), -(tint_symbol_18_1.tint_symbol_9), -(tint_symbol_18_1.tint_symbol_10), -(tint_symbol_18_1.tint_symbol_11), tint_symbol_18_1.tint_symbol_12, tint_symbol_18_1.tint_symbol_13, tint_symbol_18_1.tint_symbol_14, tint_symbol_18_1.tint_symbol_15, tint_symbol_18_1.tint_symbol_16);
}

fn tint_symbol_22(tint_symbol_23 : tint_symbol, tint_symbol_24 : tint_symbol) -> tint_symbol {
  let x_900 = tint_symbol_21(tint_symbol_24);
  let x_901 = tint_symbol_17(tint_symbol_23, x_900);
  let x_902 = tint_symbol_17(tint_symbol_24, x_901);
  return x_902;
}

fn tint_symbol_25(tint_symbol_24_1 : tint_symbol) -> f32 {
  var tint_symbol_26 = 0.0f;
  tint_symbol_26 = 0.0f;
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_1 * tint_symbol_24_1.tint_symbol_1));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_2 * tint_symbol_24_1.tint_symbol_2));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_3 * tint_symbol_24_1.tint_symbol_3));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_4 * tint_symbol_24_1.tint_symbol_4));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_5 * tint_symbol_24_1.tint_symbol_5));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_6 * tint_symbol_24_1.tint_symbol_6));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_7 * tint_symbol_24_1.tint_symbol_7));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_8 * tint_symbol_24_1.tint_symbol_8));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_9 * tint_symbol_24_1.tint_symbol_9));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_10 * tint_symbol_24_1.tint_symbol_10));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_11 * tint_symbol_24_1.tint_symbol_11));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_12 * tint_symbol_24_1.tint_symbol_12));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_13 * tint_symbol_24_1.tint_symbol_13));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_14 * tint_symbol_24_1.tint_symbol_14));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_15 * tint_symbol_24_1.tint_symbol_15));
  tint_symbol_26 = (tint_symbol_26 + (tint_symbol_24_1.tint_symbol_16 * tint_symbol_24_1.tint_symbol_16));
  let x_991 = tint_symbol_26;
  return sqrt(x_991);
}

fn tint_symbol_27(tint_symbol_28 : vec3f) -> tint_symbol {
  return tint_symbol(1.0f, 0.0f, 0.0f, 0.0f, (-(tint_symbol_28.x) / 2.0f), (-(tint_symbol_28.y) / 2.0f), (-(tint_symbol_28.z) / 2.0f), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_29(tint_symbol_24_2 : tint_symbol) -> tint_symbol {
  return tint_symbol(1.0f, 0.0f, 0.0f, 0.0f, tint_symbol_24_2.tint_symbol_5, tint_symbol_24_2.tint_symbol_6, tint_symbol_24_2.tint_symbol_7, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_30(tint_symbol_28_1 : vec3f) -> tint_symbol {
  return tint_symbol(0.0f, tint_symbol_28_1.z, -(tint_symbol_28_1.y), tint_symbol_28_1.x, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_34(tint_symbol_24_3 : tint_symbol) -> tint_symbol {
  var tint_return_flag = false;
  var tint_return_value = tint_symbol(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
  let x_1030 = tint_symbol_25(tint_symbol_24_3);
  if ((x_1030 == 0.0f)) {
    tint_return_flag = true;
    tint_return_value = tint_symbol(1.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
  }
  if (!(tint_return_flag)) {
    tint_return_flag = true;
    tint_return_value = tint_symbol((tint_symbol_24_3.tint_symbol_1 / x_1030), (tint_symbol_24_3.tint_symbol_2 / x_1030), (tint_symbol_24_3.tint_symbol_3 / x_1030), (tint_symbol_24_3.tint_symbol_4 / x_1030), (tint_symbol_24_3.tint_symbol_5 / x_1030), (tint_symbol_24_3.tint_symbol_6 / x_1030), (tint_symbol_24_3.tint_symbol_7 / x_1030), (tint_symbol_24_3.tint_symbol_8 / x_1030), (tint_symbol_24_3.tint_symbol_9 / x_1030), (tint_symbol_24_3.tint_symbol_10 / x_1030), (tint_symbol_24_3.tint_symbol_11 / x_1030), (tint_symbol_24_3.tint_symbol_12 / x_1030), (tint_symbol_24_3.tint_symbol_13 / x_1030), (tint_symbol_24_3.tint_symbol_14 / x_1030), (tint_symbol_24_3.tint_symbol_15 / x_1030), (tint_symbol_24_3.tint_symbol_16 / x_1030));
  }
  let x_1073 = tint_return_value;
  return x_1073;
}

fn tint_symbol_31(tint_symbol_1 : vec3f, tint_symbol_28_2 : vec3f) -> tint_symbol {
  let x_1079 = tint_symbol_30(tint_symbol_28_2);
  let x_1080 = tint_symbol_34(x_1079);
  return tint_symbol(0.0f, x_1080.tint_symbol_2, x_1080.tint_symbol_3, x_1080.tint_symbol_4, -(((-(x_1080.tint_symbol_3) * tint_symbol_1.z) - (x_1080.tint_symbol_2 * tint_symbol_1.y))), -(((x_1080.tint_symbol_2 * tint_symbol_1.x) - (x_1080.tint_symbol_4 * tint_symbol_1.z))), -(((x_1080.tint_symbol_4 * tint_symbol_1.y) + (x_1080.tint_symbol_3 * tint_symbol_1.x))), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_35(tint_symbol_36 : f32, tint_symbol_28_3 : vec3f, tint_symbol_37 : vec3f) -> tint_symbol {
  let x_1118 = sin((tint_symbol_36 / 2.0f));
  let x_1120 = tint_symbol_31(tint_symbol_37, tint_symbol_28_3);
  return tint_symbol(cos((tint_symbol_36 / 2.0f)), (x_1118 * x_1120.tint_symbol_2), (x_1118 * x_1120.tint_symbol_3), (x_1118 * x_1120.tint_symbol_4), (x_1118 * x_1120.tint_symbol_5), (x_1118 * x_1120.tint_symbol_6), (x_1118 * x_1120.tint_symbol_7), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_40(tint_symbol_24_4 : tint_symbol) -> tint_symbol {
  return tint_symbol(tint_symbol_24_4.tint_symbol_1, tint_symbol_24_4.tint_symbol_2, tint_symbol_24_4.tint_symbol_3, tint_symbol_24_4.tint_symbol_4, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_41(tint_symbol_23_1 : vec3f) -> tint_symbol {
  return tint_symbol(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 1.0f, -(tint_symbol_23_1.z), tint_symbol_23_1.y, -(tint_symbol_23_1.x), 0.0f, 0.0f, 0.0f, 0.0f, 0.0f);
}

fn tint_symbol_42(tint_symbol_23_2 : tint_symbol) -> vec3f {
  return vec3f((-(tint_symbol_23_2.tint_symbol_11) / tint_symbol_23_2.tint_symbol_8), (tint_symbol_23_2.tint_symbol_10 / tint_symbol_23_2.tint_symbol_8), (-(tint_symbol_23_2.tint_symbol_9) / tint_symbol_23_2.tint_symbol_8));
}

fn tint_symbol_43(tint_symbol_32 : vec3f, tint_symbol_28_4 : f32) -> tint_symbol {
  return tint_symbol(0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, 0.0f, tint_symbol_32.x, tint_symbol_32.y, tint_symbol_32.z, -(tint_symbol_28_4), 0.0f);
}

fn tint_symbol_44(tint_symbol_45 : vec3f, tint_symbol_46 : vec3f, tint_symbol_47 : vec3f) -> tint_symbol {
  let x_1284 = tint_symbol_43(vec3f(((((tint_symbol_46.y * tint_symbol_47.z) - (tint_symbol_47.y * tint_symbol_46.z)) - ((tint_symbol_45.y * tint_symbol_47.z) - (tint_symbol_47.y * tint_symbol_45.z))) + ((tint_symbol_45.y * tint_symbol_46.z) - (tint_symbol_46.y * tint_symbol_45.z))), -(((((tint_symbol_46.x * tint_symbol_47.z) - (tint_symbol_47.x * tint_symbol_46.z)) - ((tint_symbol_45.x * tint_symbol_47.z) - (tint_symbol_47.x * tint_symbol_45.z))) + ((tint_symbol_45.x * tint_symbol_46.z) - (tint_symbol_46.x * tint_symbol_45.z)))), ((((tint_symbol_46.x * tint_symbol_47.y) - (tint_symbol_47.x * tint_symbol_46.y)) - ((tint_symbol_45.x * tint_symbol_47.y) - (tint_symbol_47.x * tint_symbol_45.y))) + ((tint_symbol_45.x * tint_symbol_46.y) - (tint_symbol_46.x * tint_symbol_45.y)))), (((tint_symbol_45.x * ((tint_symbol_46.y * tint_symbol_47.z) - (tint_symbol_47.y * tint_symbol_46.z))) - (tint_symbol_46.x * ((tint_symbol_45.y * tint_symbol_47.z) - (tint_symbol_47.y * tint_symbol_45.z)))) + (tint_symbol_47.x * ((tint_symbol_45.y * tint_symbol_46.z) - (tint_symbol_46.y * tint_symbol_45.z)))));
  return x_1284;
}

fn tint_symbol_55(tint_symbol_39 : tint_symbol, tint_symbol_56 : tint_symbol) -> tint_symbol_52 {
  var tint_symbol_58 = tint_symbol_52(vec3f(), false, false);
  var x_1313 : bool;
  var x_1314 : bool;
  var x_1319 : bool;
  var x_1320 : bool;
  var x_1325 : bool;
  var x_1326 : bool;
  let x_1293 = tint_symbol_17(tint_symbol_39, tint_symbol_56);
  let x_1299 = tint_symbol_42(x_1293);
  tint_symbol_58.tint_symbol_23 = x_1299;
  tint_symbol_58.tint_symbol_53 = !((abs(x_1293.tint_symbol_8) <= 0.00000000999999993923f));
  let x_1308 = tint_symbol_58.tint_symbol_53;
  x_1314 = x_1308;
  if (x_1308) {
    x_1313 = (abs(x_1293.tint_symbol_9) <= 0.00000000999999993923f);
    x_1314 = x_1313;
  }
  x_1320 = x_1314;
  if (x_1314) {
    x_1319 = (abs(x_1293.tint_symbol_10) <= 0.00000000999999993923f);
    x_1320 = x_1319;
  }
  x_1326 = x_1320;
  if (x_1320) {
    x_1325 = (abs(x_1293.tint_symbol_11) <= 0.00000000999999993923f);
    x_1326 = x_1325;
  }
  tint_symbol_58.tint_symbol_54 = x_1326;
  let x_1327 = tint_symbol_58;
  return x_1327;
}

fn tint_symbol_60(tint_symbol_23_3 : vec3f, tint_symbol_24_5 : tint_symbol) -> vec3f {
  let x_1333 = tint_symbol_41(tint_symbol_23_3);
  let x_1334 = tint_symbol_22(x_1333, tint_symbol_24_5);
  let x_1335 = tint_symbol_42(x_1334);
  return x_1335;
}

fn tint_symbol_61(tint_symbol_28_5 : vec3f, tint_symbol_24_6 : tint_symbol) -> vec3f {
  let x_1340 = tint_symbol_40(tint_symbol_24_6);
  let x_1341 = tint_symbol_41(tint_symbol_28_5);
  let x_1342 = tint_symbol_22(x_1341, x_1340);
  let x_1343 = tint_symbol_42(x_1342);
  return x_1343;
}

fn tint_symbol_101(tint_symbol_28_6 : vec3f) -> vec3f {
  var tint_symbol_102 = vec3f();
  let x_1351 = tint_symbol_92.inner.tint_symbol_64;
  let x_1348 = tint_symbol_61(tint_symbol_28_6, x_1351);
  tint_symbol_102 = x_1348;
  let x_1354 = tint_symbol_102;
  return x_1354;
}

fn tint_symbol_103(tint_symbol_104 : vec3f) -> vec3f {
  var tint_symbol_102_1 = vec3f();
  let x_1360 = tint_symbol_92.inner.tint_symbol_64;
  let x_1358 = tint_symbol_60(tint_symbol_104, x_1360);
  tint_symbol_102_1 = x_1358;
  let x_1362 = tint_symbol_102_1;
  return x_1362;
}

fn tint_symbol_105(tint_symbol_106 : vec2i) {
  var tint_symbol_79 = vec4f();
  tint_symbol_79 = vec4f(0.0f, 0.21960784494876861572f, 0.39607843756675720215f, 1.0f);
  let x_1377 = tint_symbol_79;
  textureStore(tint_symbol_95, tint_symbol_106, x_1377);
  return;
}

fn tint_symbol_107(tint_symbol_108 : vec2f, tint_symbol_109 : f32) -> vec2f {
  var tint_symbol_110 = vec2f();
  tint_symbol_110 = tint_symbol_108;
  if ((tint_symbol_108.x < 0.0f)) {
    tint_symbol_110.x = tint_symbol_109;
  } else {
    if ((tint_symbol_109 < tint_symbol_108.x)) {
      tint_symbol_110.y = tint_symbol_108.x;
      tint_symbol_110.x = tint_symbol_109;
    } else {
      if ((tint_symbol_108.y < 0.0f)) {
        tint_symbol_110.y = tint_symbol_109;
      } else {
        if ((tint_symbol_109 < tint_symbol_108.y)) {
          tint_symbol_110.y = tint_symbol_109;
        }
      }
    }
  }
  let x_1411 = tint_symbol_110;
  return x_1411;
}

fn tint_symbol_111(tint_symbol_112 : f32, tint_symbol_113 : vec2f, tint_symbol_114 : f32, tint_symbol_115 : f32, tint_symbol_23_4 : vec2f, tint_symbol_28_7 : vec2f, tint_symbol_116 : vec2f) -> vec2f {
  var tint_symbol_117 = vec2f();
  tint_symbol_117 = tint_symbol_116;
  if ((abs(tint_symbol_115) > 0.00000000999999993923f)) {
    var x_1428 : f32;
    var x_1442 : bool;
    var x_1443 : bool;
    var x_1449 : bool;
    var x_1450 : bool;
    var x_1455 : bool;
    var x_1456 : bool;
    x_1428 = ((tint_symbol_112 - tint_symbol_114) / tint_symbol_115);
    if ((x_1428 > 0.0f)) {
      let x_1433 = (tint_symbol_23_4 + (tint_symbol_28_7 * x_1428));
      let x_1437 = (-(tint_symbol_113.x) < x_1433.x);
      x_1443 = x_1437;
      if (x_1437) {
        x_1442 = (x_1433.x < tint_symbol_113.x);
        x_1443 = x_1442;
      }
      x_1450 = x_1443;
      if (x_1443) {
        x_1449 = (-(tint_symbol_113.y) < x_1433.y);
        x_1450 = x_1449;
      }
      x_1456 = x_1450;
      if (x_1450) {
        x_1455 = (x_1433.y < tint_symbol_113.y);
        x_1456 = x_1455;
      }
      if (x_1456) {
        let x_1460 = tint_symbol_117;
        let x_1459 = tint_symbol_107(x_1460, x_1428);
        tint_symbol_117 = x_1459;
      }
    }
  }
  let x_1461 = tint_symbol_117;
  return x_1461;
}

fn tint_symbol_119(tint_symbol_23_5 : vec3f, tint_symbol_28_8 : vec3f) -> vec2f {
  var tint_symbol_120 = vec2f();
  var x_1490 = vec3f();
  tint_symbol_120 = vec2f(-1.0f);
  let x_1489 = (((tint_symbol_93.inner.tint_symbol_68.xyz * tint_symbol_93.inner.tint_symbol_69.xyz) * 0.5f) / vec3f(max(max(tint_symbol_93.inner.tint_symbol_68.x, tint_symbol_93.inner.tint_symbol_68.y), tint_symbol_93.inner.tint_symbol_68.z)));
  let x_1499 = tint_symbol_120;
  let x_1492 = tint_symbol_111(x_1489.z, x_1489.xy, tint_symbol_23_5.z, tint_symbol_28_8.z, tint_symbol_23_5.xy, tint_symbol_28_8.xy, x_1499);
  tint_symbol_120 = x_1492;
  let x_1508 = tint_symbol_120;
  let x_1500 = tint_symbol_111(-(x_1489.z), x_1489.xy, tint_symbol_23_5.z, tint_symbol_28_8.z, tint_symbol_23_5.xy, tint_symbol_28_8.xy, x_1508);
  tint_symbol_120 = x_1500;
  let x_1517 = tint_symbol_120;
  let x_1509 = tint_symbol_111(-(x_1489.x), x_1489.yz, tint_symbol_23_5.x, tint_symbol_28_8.x, tint_symbol_23_5.yz, tint_symbol_28_8.yz, x_1517);
  tint_symbol_120 = x_1509;
  let x_1525 = tint_symbol_120;
  let x_1518 = tint_symbol_111(x_1489.x, x_1489.yz, tint_symbol_23_5.x, tint_symbol_28_8.x, tint_symbol_23_5.yz, tint_symbol_28_8.yz, x_1525);
  tint_symbol_120 = x_1518;
  let x_1533 = tint_symbol_120;
  let x_1526 = tint_symbol_111(x_1489.y, x_1489.xz, tint_symbol_23_5.y, tint_symbol_28_8.y, tint_symbol_23_5.xz, tint_symbol_28_8.xz, x_1533);
  tint_symbol_120 = x_1526;
  let x_1542 = tint_symbol_120;
  let x_1534 = tint_symbol_111(-(x_1489.y), x_1489.xz, tint_symbol_23_5.y, tint_symbol_28_8.y, tint_symbol_23_5.xz, tint_symbol_28_8.xz, x_1542);
  tint_symbol_120 = x_1534;
  let x_1543 = tint_symbol_120;
  return x_1543;
}

fn tint_symbol_121(tint_symbol_122 : f32, tint_symbol_116_1 : f32, tint_symbol_112_1 : f32, tint_symbol_123 : vec2f, tint_symbol_124 : vec2f, tint_symbol_114_1 : f32, tint_symbol_115_1 : f32, tint_symbol_23_6 : vec2f, tint_symbol_28_9 : vec2f) -> f32 {
  var tint_symbol_117_1 = 0.0f;
  var x_1572 : bool;
  var x_1573 : bool;
  var x_1578 : bool;
  var x_1579 : bool;
  var x_1584 : bool;
  var x_1585 : bool;
  tint_symbol_117_1 = tint_symbol_116_1;
  if ((abs(tint_symbol_115_1) > 0.00000000999999993923f)) {
    let x_1562 = ((tint_symbol_112_1 - tint_symbol_114_1) / tint_symbol_115_1);
    let x_1564 = (tint_symbol_23_6 + (tint_symbol_28_9 * x_1562));
    let x_1567 = (tint_symbol_123.x < x_1564.x);
    x_1573 = x_1567;
    if (x_1567) {
      x_1572 = (x_1564.x < tint_symbol_124.x);
      x_1573 = x_1572;
    }
    x_1579 = x_1573;
    if (x_1573) {
      x_1578 = (tint_symbol_123.y < x_1564.y);
      x_1579 = x_1578;
    }
    x_1585 = x_1579;
    if (x_1579) {
      x_1584 = (x_1564.y < tint_symbol_124.y);
      x_1585 = x_1584;
    }
    var x_1592 : bool;
    var x_1593 : bool;
    if (x_1585) {
      let x_1588 = (x_1562 > tint_symbol_122);
      x_1593 = x_1588;
      if (x_1588) {
        x_1592 = (tint_symbol_117_1 < x_1562);
        x_1593 = x_1592;
      }
      if (x_1593) {
        tint_symbol_117_1 = x_1562;
      }
    }
  }
  let x_1596 = tint_symbol_117_1;
  return x_1596;
}

fn tint_symbol_125(tint_symbol_126 : f32, tint_symbol_127 : f32) -> u32 {
  var tint_return_flag_1 = false;
  var tint_return_value_1 = 0u;
  var x_1607 : f32;
  var x_1608 : f32;
  var x_1628 : bool;
  var x_1629 : bool;
  x_1607 = (tint_symbol_126 / 4095.0f);
  x_1608 = min((length(tint_symbol_127) / 300.0f), 1.0f);
  if ((x_1607 > 0.69999998807907104492f)) {
    if ((x_1608 > 0.5f)) {
      tint_return_flag_1 = true;
      tint_return_value_1 = 1u;
    }
    if (!(tint_return_flag_1)) {
      tint_return_flag_1 = true;
      tint_return_value_1 = 2u;
    }
  } else {
    let x_1625 = (x_1607 > 0.40000000596046447754f);
    x_1629 = x_1625;
    if (x_1625) {
      x_1628 = (x_1607 <= 0.69999998807907104492f);
      x_1629 = x_1628;
    }
    var x_1645 : bool;
    var x_1646 : bool;
    if (x_1629) {
      if ((x_1608 > 0.30000001192092895508f)) {
        tint_return_flag_1 = true;
        tint_return_value_1 = 3u;
      }
      if (!(tint_return_flag_1)) {
        tint_return_flag_1 = true;
        tint_return_value_1 = 4u;
      }
    } else {
      let x_1642 = (x_1607 > 0.20000000298023223877f);
      x_1646 = x_1642;
      if (x_1642) {
        x_1645 = (x_1607 <= 0.40000000596046447754f);
        x_1646 = x_1645;
      }
      if (x_1646) {
        if ((x_1608 > 0.25f)) {
          tint_return_flag_1 = true;
          tint_return_value_1 = 5u;
        }
        if (!(tint_return_flag_1)) {
          tint_return_flag_1 = true;
          tint_return_value_1 = 6u;
        }
      } else {
        if ((x_1607 > 0.05000000074505805969f)) {
          tint_return_flag_1 = true;
          tint_return_value_1 = 7u;
        }
      }
    }
  }
  if (!(tint_return_flag_1)) {
    tint_return_flag_1 = true;
    tint_return_value_1 = 0u;
  }
  let x_1666 = tint_return_value_1;
  return x_1666;
}

fn tint_symbol_130(tint_symbol_131 : u32) -> tint_symbol_81 {
  var tint_symbol_132 = tint_symbol_81(vec3f(), 0.0f, 0.0f, 0.0f);
  switch(tint_symbol_131) {
    case 7u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_91;
      tint_symbol_132.tint_symbol_82 = 0.20000000298023223877f;
      tint_symbol_132.tint_symbol_83 = 0.0f;
      tint_symbol_132.tint_symbol_72 = 1.0f;
    }
    case 6u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_90;
      tint_symbol_132.tint_symbol_82 = 0.40000000596046447754f;
      tint_symbol_132.tint_symbol_83 = 0.05000000074505805969f;
      tint_symbol_132.tint_symbol_72 = 0.89999997615814208984f;
    }
    case 5u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_89;
      tint_symbol_132.tint_symbol_82 = 0.60000002384185791016f;
      tint_symbol_132.tint_symbol_83 = 0.10000000149011611938f;
      tint_symbol_132.tint_symbol_72 = 0.69999998807907104492f;
    }
    case 4u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_88;
      tint_symbol_132.tint_symbol_82 = 0.60000002384185791016f;
      tint_symbol_132.tint_symbol_83 = 0.05000000074505805969f;
      tint_symbol_132.tint_symbol_72 = 0.80000001192092895508f;
    }
    case 3u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_87;
      tint_symbol_132.tint_symbol_82 = 0.69999998807907104492f;
      tint_symbol_132.tint_symbol_83 = 0.20000000298023223877f;
      tint_symbol_132.tint_symbol_72 = 0.60000002384185791016f;
    }
    case 2u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_86;
      tint_symbol_132.tint_symbol_82 = 0.89999997615814208984f;
      tint_symbol_132.tint_symbol_83 = 0.10000000149011611938f;
      tint_symbol_132.tint_symbol_72 = 0.89999997615814208984f;
    }
    case 1u: {
      tint_symbol_132.tint_symbol_79 = tint_symbol_100.inner.tint_symbol_85;
      tint_symbol_132.tint_symbol_82 = 0.94999998807907104492f;
      tint_symbol_132.tint_symbol_83 = 0.30000001192092895508f;
      tint_symbol_132.tint_symbol_72 = 0.69999998807907104492f;
    }
    default: {
      tint_symbol_132.tint_symbol_79 = vec3f(0.30000001192092895508f);
      tint_symbol_132.tint_symbol_82 = 0.0f;
      tint_symbol_132.tint_symbol_83 = 0.0f;
      tint_symbol_132.tint_symbol_72 = 1.0f;
    }
  }
  let x_1737 = tint_symbol_132;
  return x_1737;
}

const x_1764 = vec3f(1.0f);

fn tint_symbol_133(tint_symbol_134 : vec3f) -> f32 {
  var tint_return_flag_2 = false;
  var tint_return_value_2 = 0.0f;
  var x_1761 = vec3f();
  var x_1784 : bool;
  var x_1785 : bool;
  var x_1789 : bool;
  var x_1790 : bool;
  var x_1798 : bool;
  var x_1799 : bool;
  var x_1803 : bool;
  var x_1804 : bool;
  var x_1812 : bool;
  var x_1813 : bool;
  let x_1770 = ((((tint_symbol_134 / (((tint_symbol_93.inner.tint_symbol_68.xyz * tint_symbol_93.inner.tint_symbol_69.xyz) * 0.5f) / vec3f(max(max(tint_symbol_93.inner.tint_symbol_68.x, tint_symbol_93.inner.tint_symbol_68.y), tint_symbol_93.inner.tint_symbol_68.z)))) + x_1764) * 0.5f) * tint_symbol_93.inner.tint_symbol_68.xyz);
  let x_1771 = tint_ftoi(floor(x_1770));
  let x_1774 = (x_1770 - vec3f(x_1771));
  let x_1776 = (x_1771.x < 0i);
  x_1785 = x_1776;
  if (x_1776) {
  } else {
    let x_1782 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1780 = tint_ftoi_1((x_1782 - 1.0f));
    x_1784 = (x_1771.x >= x_1780);
    x_1785 = x_1784;
  }
  x_1790 = x_1785;
  if (x_1785) {
  } else {
    x_1789 = (x_1771.y < 0i);
    x_1790 = x_1789;
  }
  x_1799 = x_1790;
  if (x_1790) {
  } else {
    let x_1796 = tint_symbol_93.inner.tint_symbol_68.y;
    let x_1794 = tint_ftoi_1((x_1796 - 1.0f));
    x_1798 = (x_1771.y >= x_1794);
    x_1799 = x_1798;
  }
  x_1804 = x_1799;
  if (x_1799) {
  } else {
    x_1803 = (x_1771.z < 0i);
    x_1804 = x_1803;
  }
  x_1813 = x_1804;
  if (x_1804) {
  } else {
    let x_1810 = tint_symbol_93.inner.tint_symbol_68.z;
    let x_1808 = tint_ftoi_1((x_1810 - 1.0f));
    x_1812 = (x_1771.z >= x_1808);
    x_1813 = x_1812;
  }
  if (x_1813) {
    tint_return_flag_2 = true;
    tint_return_value_2 = 0.0f;
  }
  if (!(tint_return_flag_2)) {
    let x_1824 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1822 = tint_ftoi_1(x_1824);
    let x_1830 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1832 = tint_symbol_93.inner.tint_symbol_68.y;
    let x_1828 = tint_ftoi_1((x_1830 * x_1832));
    let x_1835 = ((x_1771.x + (x_1771.y * x_1822)) + (x_1771.z * x_1828));
    let x_1838 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1840 = tint_symbol_93.inner.tint_symbol_68.y;
    let x_1836 = tint_ftoi_1((x_1838 * x_1840));
    let x_1842 = (x_1835 + x_1836);
    let x_1845 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1843 = tint_ftoi_1(x_1845);
    let x_1846 = (x_1835 + x_1843);
    let x_1849 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1847 = tint_ftoi_1(x_1849);
    let x_1850 = (x_1842 + x_1847);
    let x_1857 = tint_symbol_94.inner[x_1835];
    let x_1859 = tint_symbol_94.inner[x_1842];
    let x_1861 = tint_symbol_94.inner[x_1846];
    let x_1863 = tint_symbol_94.inner[x_1850];
    let x_1865 = tint_symbol_94.inner[(x_1835 + 1i)];
    let x_1867 = tint_symbol_94.inner[(x_1842 + 1i)];
    let x_1869 = tint_symbol_94.inner[(x_1846 + 1i)];
    let x_1871 = tint_symbol_94.inner[(x_1850 + 1i)];
    tint_return_flag_2 = true;
    tint_return_value_2 = mix(mix(mix(x_1857, x_1865, x_1774.x), mix(x_1861, x_1869, x_1774.x), x_1774.y), mix(mix(x_1859, x_1867, x_1774.x), mix(x_1863, x_1871, x_1774.x), x_1774.y), x_1774.z);
  }
  let x_1886 = tint_return_value_2;
  return x_1886;
}

fn tint_symbol_170(tint_symbol_134_1 : vec3f) -> f32 {
  var tint_return_flag_4 = false;
  var tint_return_value_4 = 0.0f;
  var x_1909 = vec3f();
  var x_1928 : bool;
  var x_1929 : bool;
  var x_1933 : bool;
  var x_1934 : bool;
  var x_1941 : bool;
  var x_1942 : bool;
  var x_1946 : bool;
  var x_1947 : bool;
  var x_1954 : bool;
  var x_1955 : bool;
  let x_1893 = tint_symbol_93.inner.tint_symbol_68;
  let x_1896 = tint_symbol_93.inner.tint_symbol_69;
  let x_1900 = max(max(tint_symbol_93.inner.tint_symbol_68.x, tint_symbol_93.inner.tint_symbol_68.y), tint_symbol_93.inner.tint_symbol_68.z);
  let x_1915 = tint_symbol_93.inner.tint_symbol_68;
  let x_1918 = tint_ftoi(round(((((tint_symbol_134_1 / (((x_1893.xyz * x_1896.xyz) * 0.5f) / vec3f(x_1900))) + x_1764) * 0.5f) * x_1915.xyz)));
  let x_1921 = (x_1918.x < 0i);
  x_1929 = x_1921;
  if (x_1921) {
  } else {
    let x_1927 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1925 = tint_ftoi_1(x_1927);
    x_1928 = (x_1918.x >= x_1925);
    x_1929 = x_1928;
  }
  x_1934 = x_1929;
  if (x_1929) {
  } else {
    x_1933 = (x_1918.y < 0i);
    x_1934 = x_1933;
  }
  x_1942 = x_1934;
  if (x_1934) {
  } else {
    let x_1940 = tint_symbol_93.inner.tint_symbol_68.y;
    let x_1938 = tint_ftoi_1(x_1940);
    x_1941 = (x_1918.y >= x_1938);
    x_1942 = x_1941;
  }
  x_1947 = x_1942;
  if (x_1942) {
  } else {
    x_1946 = (x_1918.z < 0i);
    x_1947 = x_1946;
  }
  x_1955 = x_1947;
  if (x_1947) {
  } else {
    let x_1953 = tint_symbol_93.inner.tint_symbol_68.z;
    let x_1951 = tint_ftoi_1(x_1953);
    x_1954 = (x_1918.z >= x_1951);
    x_1955 = x_1954;
  }
  if (x_1955) {
    tint_return_flag_4 = true;
    tint_return_value_4 = 0.0f;
  }
  if (!(tint_return_flag_4)) {
    let x_1966 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1964 = tint_ftoi_1(x_1966);
    let x_1972 = tint_symbol_93.inner.tint_symbol_68.x;
    let x_1974 = tint_symbol_93.inner.tint_symbol_68.y;
    let x_1970 = tint_ftoi_1((x_1972 * x_1974));
    tint_return_flag_4 = true;
    tint_return_value_4 = tint_symbol_94.inner[((x_1918.x + (x_1918.y * x_1964)) + (x_1918.z * x_1970))];
  }
  let x_1980 = tint_return_value_4;
  return x_1980;
}

fn tint_symbol_164(tint_symbol_134_2 : vec3f) -> f32 {
  var tint_return_flag_3 = false;
  var tint_return_value_3 = 0.0f;
  if ((tint_symbol_99.inner != 0u)) {
    tint_return_flag_3 = true;
    let x_1993 = tint_symbol_133(tint_symbol_134_2);
    tint_return_value_3 = x_1993;
  } else {
    tint_return_flag_3 = true;
    let x_1994 = tint_symbol_170(tint_symbol_134_2);
    tint_return_value_3 = x_1994;
  }
  let x_1995 = tint_return_value_3;
  return x_1995;
}

fn tint_symbol_161(tint_symbol_134_3 : vec3f) -> vec3f {
  let x_2002 = (x_1764 / tint_symbol_93.inner.tint_symbol_68.xyz);
  let x_2003 = tint_symbol_164((tint_symbol_134_3 + vec3f(x_2002.x, 0.0f, 0.0f)));
  let x_2007 = tint_symbol_164((tint_symbol_134_3 - vec3f(x_2002.x, 0.0f, 0.0f)));
  let x_2011 = tint_symbol_164((tint_symbol_134_3 + vec3f(0.0f, x_2002.y, 0.0f)));
  let x_2015 = tint_symbol_164((tint_symbol_134_3 - vec3f(0.0f, x_2002.y, 0.0f)));
  let x_2019 = tint_symbol_164((tint_symbol_134_3 + vec3f(0.0f, 0.0f, x_2002.z)));
  let x_2023 = tint_symbol_164((tint_symbol_134_3 - vec3f(0.0f, 0.0f, x_2002.z)));
  return vec3f(((x_2003 - x_2007) / (2.0f * x_2002.x)), ((x_2011 - x_2015) / (2.0f * x_2002.y)), ((x_2019 - x_2023) / (2.0f * x_2002.z)));
}

const x_2048 = vec4f(0.0f, 0.0f, 0.0f, 1.0f);

fn tint_symbol_172(tint_symbol_106_1 : vec2i, tint_symbol_23_7 : vec3f, tint_symbol_28_10 : vec3f) {
  var tint_symbol_173 = vec2f();
  var tint_symbol_79_1 = vec4f();
  var tint_symbol_175 = 0.0f;
  var x_2089 = vec3f();
  var tint_symbol_177 = vec3f();
  var tint_symbol_178 = 0.0f;
  var tint_symbol_180 = 0i;
  var tint_symbol_185 = vec3f();
  var tint_symbol_186 = false;
  var tint_symbol_82 = 0.0f;
  var x_2057 : bool;
  var x_2058 : bool;
  let x_2046 = tint_symbol_119(tint_symbol_23_7, tint_symbol_28_10);
  tint_symbol_173 = x_2046;
  tint_symbol_79_1 = x_2048;
  let x_2052 = (tint_symbol_173.y < 0.0f);
  x_2058 = x_2052;
  if (x_2052) {
    x_2057 = (tint_symbol_173.x > 0.0f);
    x_2058 = x_2057;
  }
  if (x_2058) {
    tint_symbol_173.y = tint_symbol_173.x;
    tint_symbol_173.x = 0.0f;
  }
  if ((tint_symbol_173.x >= 0.0f)) {
    tint_symbol_175 = (tint_symbol_173.x + 0.00000999999974737875f);
    let x_2088 = ((x_1764 * tint_symbol_93.inner.tint_symbol_69.xyz) / vec3f(max(max(tint_symbol_93.inner.tint_symbol_68.x, tint_symbol_93.inner.tint_symbol_68.y), tint_symbol_93.inner.tint_symbol_68.z)));
    tint_symbol_177 = vec3f();
    tint_symbol_178 = 1.0f;
    tint_symbol_180 = 0i;
    loop {
      var x_2109 : bool;
      var x_2110 : bool;
      var x_2114 : bool;
      var x_2115 : bool;
      let x_2104 = (tint_symbol_175 < tint_symbol_173.y);
      x_2110 = x_2104;
      if (x_2104) {
        x_2109 = (tint_symbol_178 > 0.00999999977648258209f);
        x_2110 = x_2109;
      }
      x_2115 = x_2110;
      if (x_2110) {
        x_2114 = (tint_symbol_180 < 500i);
        x_2115 = x_2114;
      }
      if (!(x_2115)) {
        break;
      }
      tint_symbol_180 = (tint_symbol_180 + 1i);
      let x_2122 = (tint_symbol_23_7 + (tint_symbol_28_10 * tint_symbol_175));
      let x_2123 = tint_symbol_164(x_2122);
      let x_2131 = (tint_symbol_175 + (min(min(x_2088.x, x_2088.y), x_2088.z) * 0.5f));
      let x_2133 = (x_2131 - tint_symbol_175);
      tint_symbol_185 = vec3f();
      tint_symbol_186 = false;
      let x_2136 = tint_symbol_161(x_2122);
      if ((length(x_2136) > 0.00000000999999993923f)) {
        tint_symbol_185 = -(normalize(x_2136));
        tint_symbol_186 = true;
      }
      var x_2169 : bool;
      var x_2170 : bool;
      if ((x_2123 > 20.0f)) {
        let x_2147 = tint_symbol_125(x_2123, length(x_2136));
        let x_2149 = tint_symbol_130(x_2147);
        tint_symbol_82 = (x_2149.tint_symbol_82 * (1.0f - exp(-(((x_2133 * 10.0f) * (1.0f + (min(((x_2123 / 4095.0f) * 3.0f), 1.0f) * 5.0f)))))));
        let x_2166 = (x_2147 == 1u);
        x_2170 = x_2166;
        if (x_2166) {
        } else {
          x_2169 = (x_2147 == 2u);
          x_2170 = x_2169;
        }
        if (x_2170) {
          tint_symbol_82 = min((tint_symbol_82 * 1.5f), 0.98000001907348632812f);
        }
        if (tint_symbol_186) {
          let x_2183 = normalize((tint_symbol_98.inner.tint_symbol_77 - x_2122));
          tint_symbol_177 = (tint_symbol_177 + (((x_2149.tint_symbol_79 * ((0.20000000298023223877f + (max(dot(tint_symbol_185, x_2183), 0.0f) * tint_symbol_98.inner.tint_symbol_78)) + (pow(max(dot(reflect(-(x_2183), tint_symbol_185), -(tint_symbol_28_10)), 0.0f), mix(128.0f, 1.0f, x_2149.tint_symbol_72)) * x_2149.tint_symbol_83))) * tint_symbol_98.inner.tint_symbol_79) * (tint_symbol_178 * tint_symbol_82)));
        } else {
          tint_symbol_177 = (tint_symbol_177 + (x_2149.tint_symbol_79 * (tint_symbol_178 * tint_symbol_82)));
        }
        tint_symbol_178 = (tint_symbol_178 * (1.0f - tint_symbol_82));
        if ((tint_symbol_178 < 0.5f)) {
          break;
        }
      }
      tint_symbol_175 = (x_2131 + 0.00000999999974737875f);
    }
    tint_symbol_79_1 = vec4f(tint_symbol_177.x, tint_symbol_177.y, tint_symbol_177.z, 1.0f);
  } else {
    tint_symbol_79_1 = x_2048;
  }
  let x_2240 = tint_symbol_79_1;
  textureStore(tint_symbol_95, tint_symbol_106_1, x_2240);
  return;
}

fn tint_symbol_198_inner(tint_symbol_199 : vec3u) {
  var tint_symbol_37_1 = vec3f();
  var tint_symbol_202 = vec3f();
  var x_2258 : bool;
  var x_2259 : bool;
  let x_2245 = bitcast<vec2i>(tint_symbol_199.xy);
  let x_2248 = bitcast<vec2i>(vec2i(textureDimensions(tint_symbol_95)));
  let x_2253 = (x_2245.x < x_2248.x);
  x_2259 = x_2253;
  if (x_2253) {
    x_2258 = (x_2245.y < x_2248.y);
    x_2259 = x_2258;
  }
  if (x_2259) {
    let x_2267 = (vec2f(2.0f) / tint_symbol_92.inner.tint_symbol_66.xy);
    tint_symbol_37_1 = vec3f((((f32(x_2245.x) + 0.5f) * x_2267.x) - 1.0f), (((f32(x_2245.y) + 0.5f) * x_2267.y) - 1.0f), 0.0f);
    tint_symbol_202 = vec3f(0.0f, 0.0f, 1.0f);
    let x_2285 = tint_symbol_37_1;
    let x_2284 = tint_symbol_103(x_2285);
    tint_symbol_37_1 = x_2284;
    let x_2287 = tint_symbol_202;
    let x_2286 = tint_symbol_101(x_2287);
    tint_symbol_202 = x_2286;
    let x_2289 = tint_symbol_37_1;
    let x_2290 = tint_symbol_202;
    tint_symbol_172(x_2245, x_2289, x_2290);
  }
  return;
}

fn tint_symbol_198_1() {
  let x_2295 = tint_symbol_199_1;
  tint_symbol_198_inner(x_2295);
  return;
}

@compute @workgroup_size(16i, 16i, 1i)
fn computeOrthogonalMain(@builtin(global_invocation_id) tint_symbol_199_1_param : vec3u) {
  tint_symbol_199_1 = tint_symbol_199_1_param;
  tint_symbol_198_1();
}
