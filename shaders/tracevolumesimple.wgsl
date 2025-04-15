/* 
 * Copyright (c) 2025 SingChun LEE @ Bucknell University. CC BY-NC 4.0.
 * 
 * This code is provided mainly for educational purposes at Bucknell University.
 *
 * This code is licensed under the Creative Commons Attribution-NonCommerical 4.0
 * International License. To view a copy of the license, visit 
 *   https://creativecommons.org/licenses/by-nc/4.0/
 * or send a letter to Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
 *
 * You are free to:
 *  - Share: copy and redistribute the material in any medium or format.
 *  - Adapt: remix, transform, and build upon the material.
 *
 * Under the following terms:
 *  - Attribution: You must give appropriate credit, provide a link to the license,
 *                 and indicate if changes where made.
 *  - NonCommerical: You may not use the material for commerical purposes.
 *  - No additional restrictions: You may not apply legal terms or technological 
 *                                measures that legally restrict others from doing
 *                                anything the license permits.
 */

// struct to sture 3D PGA multivector
struct MultiVector {
  s: f32, 
  exey: f32, 
  exez: f32, 
  eyez: f32, 
  eoex: f32, 
  eoey: f32, 
  eoez: f32, 
  exeyez: f32, 
  eoexey: f32, 
  eoexez: f32, 
  eoeyez: f32,
  ex: f32, 
  ey: f32, 
  ez: f32, 
  eo: f32,
  eoexeyez: f32
}

// the geometric product 
fn geometricProduct(a: MultiVector, b: MultiVector) -> MultiVector { 
  // The geometric product rules are:
  //   1. eoeo = 0, exex = 1 and eyey = 1, ezez = 1
  //   2. eoex + exeo = 0, eoey + eyeo = 0, eoez + ezeo = 0
  //   3. exey + eyex = 0, exez + ezex = 0, eyez + ezey = 0
  // This results in the following product table:
  var r: MultiVector;
  r.s = a.s * b.s - a.exey * b.exey - a.exez * b.exez - a.eyez * b.eyez - a.exeyez * b.exeyez + a.ex * b.ex + a.ey * b.ey + a.ez * b.ez; // scalar
  r.exey = a.s * b.exey + a.exey * b.s - a.exez * b.eyez + a.eyez * b.exez + a.exeyez * b.ez + a.ex * b.ey - a.ey * b.ex + a.ez * b.exeyez; // exey
  r.exez = a.s * b.exez + a.exey * b.eyez + a.exez * b.s - a.eyez * b.exey - a.exeyez * b.ey + a.ex * b.ez - a.ey * b.exeyez - a.ez * b.ex; // exez
  r.eyez = a.s * b.eyez - a.exey * b.exez + a.exez * b.exey + a.eyez * b.s + a.exeyez * b.ex + a.ex * b.exeyez + a.ey * b.ez - a.ez * b.ey; // eyez
  r.eoex = a.s * b.eoex + a.exey * b.eoey + a.exez * b.eoez - a.eyez * b.eoexeyez + a.eoex * b.s - a.eoey * b.exey - a.eoez * b.exez + a.exeyez * b.eoeyez + a.eoexey * b.ey + a.eoexez * b.ez - a.eoeyez * b.exeyez - a.ex * b.eo + a.ey * b.eoexey + a.ez * b.eoexez + a.eo * b.ex - a.eoexeyez * b.eyez; // eoex
  r.eoey = a.s * b.eoey - a.exey * b.eoex + a.exez * b.eoexeyez + a.eyez * b.eoez + a.eoex * b.exey + a.eoey * b.s - a.eoez * b.eyez - a.exeyez * b.eoexez - a.eoexey * b.ex + a.eoexez * b.exeyez + a.eoeyez * b.ey - a.ex * b.eoexey - a.ey * b.eo + a.ez * b.eoeyez + a.eo * b.ey + a.eoexeyez * b.exez; // eoey
  r.eoez = a.s * b.eoez - a.exey * b.eoexeyez - a.exez * b.eoex - a.eyez * b.eoey + a.eoex * b.exez + a.eoey * b.eyez + a.eoez * b.s + a.exeyez * b.eoexey - a.eoexey * b.exeyez - a.eoexez * b.ex - a.eoeyez * b.ey - a.ex * b.eoexez - a.ey * b.eoeyez - a.ez * b.eo + a.eo * b.ez - a.eoexeyez * b.exey; // eoez
  r.exeyez = a.s * b.exeyez + a.exey * b.ez - a.exez * b.ey + a.eyez * b.ex + a.exeyez * b.s + a.ex * b.eyez - a.ey * b.exez + a.ez * b.exey; // exeyez
  r.eoexey = a.s * b.eoexey + a.exey * b.eo - a.exez * b.eoeyez + a.eyez * b.eoexez + a.eoex * b.ey - a.eoey * b.ex + a.eoez * b.exeyez - a.exeyez * b.eoez + a.eoexey * b.s - a.eoexez * b.eyez + a.eoeyez * b.exez - a.ex * b.eoey + a.ey * b.eoex - a.ez * b.eoexeyez + a.eo * b.exey + a.eoexeyez * b.ez; // eoexey
  r.eoexez = a.s * b.eoexez + a.exey * b.eoeyez + a.exez * b.eo - a.eyez * b.eoexey + a.eoex * b.ez - a.eoey * b.exeyez - a.eoez * b.ex + a.exeyez * b.eoey + a.eoexey * b.eyez + a.eoexez * b.s - a.eoeyez * b.exey - a.ex * b.eoez + a.ey * b.eoexeyez + a.ez * b.eoex + a.eo * b.exez - a.eoexeyez * b.ey; // eoexez
  r.eoeyez = a.s * b.eoeyez - a.exey * b.eoexez + a.exez * b.eoexey + a.eyez * b.eo + a.eoex * b.exeyez + a.eoey * b.ez - a.eoez * b.ey - a.exeyez * b.eoex - a.eoexey * b.exez + a.eoexez * b.exey + a.eoeyez * b.s - a.ex * b.eoexeyez - a.ey * b.eoez + a.ez * b.eoey + a.eo * b.eyez + a.eoexeyez * b.ex; // eoeyez
  r.ex = a.s * b.ex + a.exey * b.ey + a.exez * b.ez - a.eyez * b.exeyez - a.exeyez * b.eyez + a.ex * b.s - a.ey * b.exey - a.ez * b.exez; // ex
  r.ey = a.s * b.ey - a.exey * b.ex + a.exez * b.exeyez + a.eyez * b.ez + a.exeyez * b.exez + a.ex * b.exey + a.ey * b.s - a.ez * b.eyez; // ey
  r.ez = a.s * b.ez - a.exey * b.exeyez - a.exez * b.ex - a.eyez * b.ey - a.exeyez * b.exey + a.ex * b.exez + a.ey * b.eyez + a.ez * b.s; // ez
  r.eo = a.s * b.eo - a.exey * b.eoexey - a.exez * b.eoexez - a.eyez * b.eoeyez + a.eoex * b.ex + a.eoey * b.ey + a.eoez * b.ez + a.exeyez * b.eoexeyez - a.eoexey * b.exey - a.eoexez * b.exez - a.eoeyez * b.eyez - a.ex * b.eoex - a.ey * b.eoey - a.ez * b.eoez + a.eo * b.s - a.eoexeyez * b.exeyez; // eo
  r.eoexeyez = a.s * b.eoexeyez + a.exey * b.eoez - a.exez * b.eoey + a.eyez * b.eoex + a.eoex * b.eyez - a.eoey * b.exez + a.eoez * b.exey - a.exeyez * b.eo + a.eoexey * b.ez - a.eoexez * b.ey + a.eoeyez * b.ex - a.ex * b.eoeyez + a.ey * b.eoexez - a.ez * b.eoexey + a.eo * b.exeyez + a.eoexeyez * b.s; // eoexeyez
  return r;
}

// the reverse of a Multivector
fn reverse(a: MultiVector) -> MultiVector {
  // The reverse is the reverse order of the basis elements
  //  the reverse of a scalar is the scalar
  //  the reverse of exey is eyex = -exey
  //  the reverse of exez is ezex = -exez
  //  the reverse of eyez is ezey = -eyez
  //  the reverse of eoex is exeo = -eoex
  //  the reverse of eoey is eyeo = -eoey
  //  the reverse of eoez is ezeo = -eoez
  //  the reverse of exeyez is ezeyex = exezey = -exeyez
  //  the reverse of eoexey is eyexeo = eoeyex = -eoexey
  //  the reverse of eoexez is ezexeo = eoezex = -eoexez
  //  the reverse of eoeyez is ezeyeo = eoezey = -eoeyez
  //  the reverse of ex, ey, ez, eo are ex, ey, ez, eo
  //  the reverse of eoexeyez is ezeyexeo = -eoezeyex = -eoexezey = eoexeyez
  // So, for [s, exey, exez, eyez, eoex, eoey, eoez, exeyez, eoexey, eoexez, eoeyez, ex, ey, ez, eo, eoexeyez],
  // Its reverse is [s, -exey, -exez, eyez, -eoex, -eoey, -eoez, -exeyez, -eoexey, -eoexez, -eoeyez, ex, ey, ez, eo, eoexeyez].
  return MultiVector(a.s, -a.exey, -a.exez, -a.eyez, -a.eoex, -a.eoey, -a.eoez, -a.exeyez, -a.eoexey, -a.eoexez, -a.eoeyez, a.ex, a.ey, a.ez, a.eo, a.eoexeyez);
}

fn applyMotor(p: MultiVector, m: MultiVector) -> MultiVector {
  // To apply a motor to a point, we use the sandwich operation
  // The formula is m * p * reverse of m
  // Here * is the geometric product
  return geometricProduct(m, geometricProduct(p, reverse(m)));
}

fn motorNorm(m: MultiVector) -> f32 {
  // The norm of a motor is square root of the sum of square of the terms:
  // we have
  var sum = 0.;
  sum += m.s * m.s;
  sum += m.exey * m.exey;
  sum += m.exez * m.exez;
  sum += m.eyez * m.eyez;
  sum += m.eoex * m.eoex;
  sum += m.eoey * m.eoey;
  sum += m.eoez * m.eoez;
  sum += m.exeyez * m.exeyez;
  sum += m.eoexey * m.eoexey;
  sum += m.eoexez * m.eoexez;
  sum += m.eoeyez * m.eoeyez;
  sum += m.ex * m.ex;
  sum += m.ey * m.ey;
  sum += m.ez * m.ez;
  sum += m.eo * m.eo;
  sum += m.eoexeyez * m.eoexeyez;
  return sqrt(sum);
}

fn createTranslator(d: vec3f) -> MultiVector {
  // Given dx and dy describing the moveming in the x and y directions,
  // the translator is given by 1 + dx/2 exeo + dy/2 eyeo + dz/2 ezeo
  // In code, we always store the coefficents of
  //    scalar, exey, exez, eyez, eoex, eoey, eoez, exeyez, eoexey, eoexez, eoeyez, ex, ey, ez, eo, eoexeyez
  // Hence the implementation is as below
  return MultiVector(1, 0, 0, 0, -d.x / 2, -d.y / 2, -d.z / 2, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn extractTranslator(m: MultiVector) -> MultiVector {
  // Given a general motor, we can extract the translator part
  return MultiVector(1, 0, 0, 0, m.eoex, m.eoey, m.eoez, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn createDir(d: vec3f) -> MultiVector {
  // A direction is given by dx eyez + dy ezex + dz exey
  //    scalar, exey, exez, eyez, eoex, eoey, eoez, exeyez, eoexey, eoexez, eoeyez, ex, ey, ez, eo, eoexeyez
  return MultiVector(0, d.z, -d.y, d.x, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn createLine(s: vec3f, d: vec3f) -> MultiVector {
  // A line is given by a starting point (sx, sy, sz) and a direction (dx, dy, dz)
  //  in this form: dx eyez + dy ezex + dz exey + (dy * sz - dz * sy) exeo + (dz * sx - dx * sz) eyeo + (dx * sy - dy * sx) ezeo
  let n = createDir(d); // represent the input direction in PGA
  let dir = normalizeMotor(n); // normalize the direction to make sure it is a unit direction
  // Note dir.exey = dz, dir.exez = -dy, dir.eyez = dx
  return MultiVector(0, dir.exey, dir.exez, dir.eyez, -(-dir.exez * s.z - dir.exey * s.y), -(dir.exey * s.x - dir.eyez * s.z), -(dir.eyez * s.y + dir.exez * s.x), 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn createRotor(angle: f32, d: vec3f, spt: vec3f) -> MultiVector {
  // Given an angle and a rotation axis direction (dx, dy, dz) and a start point of the rotation axis,
  // the rotor is given by cos(angle / 2 ) + sin(angle / 2 ) L
  //  where L is the line in 3D PGA formed by the direction and the start point
  let c = cos(angle / 2);
  let s = sin(angle / 2);
  let L = createLine(spt, d);
  return MultiVector(c, s * L.exey, s * L.exez, s * L.eyez, s * L.eoex, s * L.eoey, s * L.eoez, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn extractRotor(m: MultiVector) -> MultiVector {
  // Given a general motor, we can extract the rotor part
  return MultiVector(m.s, m.exey, m.exez, m.eyez, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
}

fn createPoint(p: vec3f) -> MultiVector {
  // Given a point in 3D with coordinates (x, y, z)
  // A point in PGA is given by exeyez + x eoezey + y eoexez + z eoeyex
  // In code, we always store the coefficents of 
  //    scalar, exey, exez, eyez, eoex, eoey, eoez, exeyez, eoexey, eoexez, eoeyez, ex, ey, ez, eo, eoexeyez
  return MultiVector(0, 0, 0, 0, 0, 0, 0, 1, -p.z, p.y, -p.x, 0, 0, 0, 0, 0);
}

fn extractPoint(p: MultiVector) -> vec3f {
  // to extract the 3d point from a exeyez + b eoezey + c eoexez + d eoeyex
  // we have x = -b/a and y = c/a and z = -d/a
  return vec3f(-p.eoeyez / p.exeyez, p.eoexez / p.exeyez, -p.eoexey / p.exeyez);
}

fn createPlane(n: vec3f, d: f32) -> MultiVector {
  // Given a plane in 3D with normal (nx, ny, nz) and distance from the origin d
  // A plane in PGA is given by nx ex + ny ey + nz ez - deo
  // In code, we always store the coefficents of 
  //    scalar, exey, exez, eyez, eoex, eoey, eoez, exeyez, eoexey, eoexez, eoeyez, ex, ey, ez, eo, eoexeyez
  return MultiVector(0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, n.x, n.y, n.z, -d, 0);
}

fn createPlaneFromPoints(p1: vec3f, p2: vec3f, p3: vec3f) -> MultiVector {
  // Given three poitns (x1, y1, z1), (x2, y2, z2), (x3, y3, z3)
  // A plane in PGA is given by 
  //        ((y2 * z3 - y3 * z2) -      (y1 * z3 - y3 * z1) +      (y1 * z2 - y2 * z1)) ex 
  // -      ((x2 * z3 - x3 * z2) -      (x1 * z3 - x3 * z1) +      (x1 * z2 - x2 * z1)) ey 
  // +      ((x2 * y3 - x3 * y2) -      (x1 * y3 - x3 * y1) +      (x1 * y2 - x2 * y1)) ez 
  // + (x1 * (y2 * z3 - y3 * z2) - x2 * (y1 * z3 - y3 * z1) + x3 * (y1 * z2 - y2 * z1)) eo
  let nx =          (p2[1] * p3[2] - p3[1] * p2[2]) -         (p1[1] * p3[2] - p3[1] * p1[2]) +         (p1[1] * p2[2] - p2[1] * p1[2]);
  let ny =          (p2[0] * p3[2] - p3[0] * p2[2]) -         (p1[0] * p3[2] - p3[0] * p1[2]) +         (p1[0] * p2[2] - p2[0] * p1[2]);
  let nz =          (p2[0] * p3[1] - p3[0] * p2[1]) -         (p1[0] * p3[1] - p3[0] * p1[1]) +         (p1[0] * p2[1] - p2[0] * p1[1]);
  let d = (p1[0] * (p2[1] * p3[2] - p3[1] * p2[2]) - p2[0] * (p1[1] * p3[2] - p3[1] * p1[2]) + p3[0] * (p1[1] * p2[2] - p2[1] * p1[2]));
  return createPlane(vec3f(nx, -ny, nz), d);
}

// define a constant
const EPSILON : f32 = 0.00000001;

// a structure to store the hit information
struct HitInfo {
  p: vec3f,      // where it hits
  hit: bool,     // if it hits
  inPlane: bool, // if it does not hit, is it in the plane?
}

fn linePlaneIntersection(L: MultiVector, P: MultiVector) -> HitInfo {
  // In PGA, the intersection point is simply embedded in the geometric product betwen them
  let new_p = geometricProduct(L, P);
  var hitInfo: HitInfo;
  hitInfo.p = extractPoint(new_p);
  hitInfo.hit = !(abs(new_p.exeyez) <= EPSILON);
  hitInfo.inPlane = hitInfo.hit && abs(new_p.eoexey) <= EPSILON && abs(new_p.eoexez) <= EPSILON && abs(new_p.eoeyez) <= EPSILON;
  return hitInfo;
}

fn normalizeMotor(m: MultiVector) -> MultiVector {
  // To normalize a motor, we divide each coefficient by its norm
  let mnorm = motorNorm(m);
  if (mnorm == 0.0) {
    return MultiVector(1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0);
  }
  return MultiVector(m.s / mnorm, m.exey / mnorm, m.exez / mnorm, m.eyez / mnorm, m.eoex / mnorm, m.eoey / mnorm, m.eoez / mnorm, m.exeyez / mnorm, m.eoexey / mnorm, m.eoexez / mnorm, m.eoeyez / mnorm, m.ex / mnorm, m.ey / mnorm, m.ez / mnorm, m.eo / mnorm, m.eoexeyez / mnorm);
}

fn applyMotorToPoint(p: vec3f, m: MultiVector) -> vec3f {
  // apply the motor m to transform the point p
  // this code covert the 3d point p into PGA and apply the motor to transform it
  // then extra the result from PGA
  let new_p = applyMotor(createPoint(p), m);
  return extractPoint(new_p);
};

fn applyMotorToDir(d: vec3f, m: MultiVector) -> vec3f {
  // apply the motor m to transform the direction d
  // this code convert the 3d direction d into PGA, then extract the rotor from the motor
  // and transform the direction using the rotor
  // last, extra the result from PGA
  let r = extractRotor(m);
  let new_d = applyMotor(createPoint(d), r);
  return extractPoint(new_d);
}

// struct to store 3D PGA pose
struct Camera {
  motor: MultiVector,
  focal: vec2f,
  res: vec2f,
}

// struct to store the volume info
struct VolInfo {
  dims: vec4f, // volume dimension
  sizes: vec4f, // voxel sizes
}

// binding the camera pose
@group(0) @binding(0) var<uniform> cameraPose: Camera ;
// binding the volume info
@group(0) @binding(1) var<uniform> volInfo: VolInfo;
// binding the volume data
@group(0) @binding(2) var<storage> volData: array<f32>;
// binding the output texture to store the ray tracing results
@group(0) @binding(3) var outTexture: texture_storage_2d<rgba8unorm, write>;

@group(0) @binding(4) var<uniform> traceType: u32;

// a function to transform the direction to the model coordiantes
fn transformDir(d: vec3f) -> vec3f {
  // transform the direction using the camera pose
  var out = applyMotorToDir(d, cameraPose.motor);
  return out;
}

// a function to transform the start pt to the model coordiantes
fn transformPt(pt: vec3f) -> vec3f {
  // transform the point using the camera pose
  var out = applyMotorToPoint(pt, cameraPose.motor);
  return out;
}

// a function to asign the pixel color
fn assignColor(uv: vec2i) {
  var color: vec4f;
  color = vec4f(0.f/255, 56.f/255, 101.f/255, 1.); // Bucknell Blue
  textureStore(outTexture, uv, color);  
}

// a helper function to keep track of the two ray-volume hit values
fn compareVolumeHitValues(curValue: vec2f, t: f32) -> vec2f {
  var result = curValue;
  if (curValue.x < 0) { // no hit value yet
    result.x = t; // update the closest
  }
  else {
    if (t < curValue.x) { // if find a closer hit value
      result.y = curValue.x; // update the second closest
      result.x = t;          // update the closest
    }
    else {
      if (curValue.y < 0) { // no second hit value yet
        result.y = t;
      }
      else if (t < curValue.y) { // if find a second closer
        result.y = t;
      }
    }
  }
  return result;
}

// a helper function to compute the ray-volume hit values
fn getVolumeHitValues(checkval: f32, halfsize: vec2f, pval: f32, dval: f32, p: vec2f, d: vec2f, curT: vec2f) -> vec2f {
  var cur = curT;
  if (abs(dval) > EPSILON) {
    let t = (checkval - pval) / dval; // compute the current hit point to the check value
    if (t > 0) {
      let hPt = p + t * d;
      if (-halfsize.x < hPt.x && hPt.x < halfsize.x && -halfsize.y < hPt.y && hPt.y < halfsize.y) {
        cur = compareVolumeHitValues(cur, t);
      }
    }
  }
  return cur;
}

// a function to compute the start and end t values of the ray hitting the volume
fn rayVolumeIntersection(p: vec3f, d: vec3f) -> vec2f {
  var hitValues = vec2f(-1, -1);
  let halfsize = volInfo.dims * volInfo.sizes * 0.5 / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z); // 1mm
  //let halfsize = vec3f(0.5, 0.5, 0.5) * volInfo.sizes.xyz;
  // hitPt = p + t * d => t = (hitPt - p) / d
  hitValues = getVolumeHitValues(halfsize.z, halfsize.xy, p.z, d.z, p.xy, d.xy, hitValues); // z = halfsize.z
  hitValues = getVolumeHitValues(-halfsize.z, halfsize.xy, p.z, d.z, p.xy, d.xy, hitValues); // z = -halfsize.z
  hitValues = getVolumeHitValues(-halfsize.x, halfsize.yz, p.x, d.x, p.yz, d.yz, hitValues); // x = -halfsize.x
  hitValues = getVolumeHitValues(halfsize.x, halfsize.yz, p.x, d.x, p.yz, d.yz, hitValues); // x = halfsize.x
  hitValues = getVolumeHitValues(halfsize.y, halfsize.xz, p.y, d.y, p.xz, d.xz, hitValues); // y = halfsize.y
  hitValues = getVolumeHitValues(-halfsize.y, halfsize.xz, p.y, d.y, p.xz, d.xz, hitValues); // y = -halfsize.y
  return hitValues;
}

// a helper function to get the next hit value
fn getNextHitValue(startT: f32, curT: f32, checkval: f32, minCorner: vec2f, maxCorner: vec2f, pval: f32, dval: f32, p: vec2f, d: vec2f) -> f32 {
  var cur = curT;
  if (abs(dval) > EPSILON) {
    let t = (checkval - pval) / dval; // compute the current hit point to the check value
    let hPt = p + t * d;
    if (minCorner.x < hPt.x && hPt.x < maxCorner.x && minCorner.y < hPt.y && hPt.y < maxCorner.y) {
      if (t > startT && cur < t) {
        cur = t;
      }
    }
  }
  return cur;
}

// a function to trace the volume - volume rendering
fn traceSceneMIP(uv: vec2i, p: vec3f, d: vec3f) {
  // find the start and end point
  var hits = rayVolumeIntersection(p, d);
  var color = vec4f(0.f/255, 0.f/255, 0.f/255, 1.); 

  // if there is only one hit point, we trace from the camera center
  if (hits.y < 0 && hits.x > 0) {
    hits.y = hits.x;
    hits.x = 0;
  }
  // assign colors
  if (hits.x >= 0) { 
    let epsilon = 0.00001;

    var curHitValue = hits.x + epsilon;

    let voxelSize = vec3f(1, 1, 1) * volInfo.sizes.xyz / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);

    var maxIntensity = 0.0;

    while (curHitValue < hits.y) {
      let curPoint = p + d * curHitValue; // in world position

      // convert world pos to voxel index
      // normalize to [-0.5, 0.5]
      let halfsize = volInfo.dims.xyz * volInfo.sizes.xyz * 0.5 / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
      let normalizedPos = curPoint / halfsize;

      // scale to voxel indices + shift to [0, dims] range
      let voxelPos = (normalizedPos + vec3f(1.0, 1.0, 1.0)) * 0.5 * volInfo.dims.xyz;
      let voxelIdx = vec3i(voxelPos);

      if (voxelIdx.x >= 0 && voxelIdx.x < i32(volInfo.dims.x) &&
          voxelIdx.y >= 0 && voxelIdx.y < i32(volInfo.dims.y) &&
          voxelIdx.z >= 0 && voxelIdx.z < i32(volInfo.dims.z)) {
        
        let index = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + 
                   voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
        let voxelValue = volData[index];
        maxIntensity = max(maxIntensity, voxelValue);
      }

      // voxel corners -> find next hit value
      let minCorner = vec3f(floor(voxelPos.x), floor(voxelPos.y), floor(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      let maxCorner = vec3f(ceil(voxelPos.x), ceil(voxelPos.y), ceil(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
 
      // convert back to the world coordinate
      let minCornerWorld = minCorner * halfsize;
      let maxCornerWorld = maxCorner * halfsize;

      // x
      var nextHitValue = hits.y;
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      
      // y
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      
      // x
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);

      if (nextHitValue <= curHitValue || nextHitValue >= hits.y) {
        curHitValue += min(min(voxelSize.x, voxelSize.y), voxelSize.z) * 0.5;
      } else {
        curHitValue = nextHitValue + epsilon;
      }
    }

    let normalizedIntensity = maxIntensity / 4095.0;
    color = vec4f(normalizedIntensity, normalizedIntensity, normalizedIntensity + (1.0 - normalizedIntensity) * 0.5, 1.0);
  }
  else {
    color = vec4f(0.f/255, 56.f/255, 101.f/255, 1.); // Bucknell Blue
  }

  textureStore(outTexture, uv, color);  
}

fn traceSceneDRR(uv: vec2i, p: vec3f, d: vec3f) {
  // start and end points
  var hits = rayVolumeIntersection(p, d);
  var color = vec4f(0.f/255, 0.f/255, 0.f/255, 1.); 
  
  // if there is only one hit point -> trace from the camera center
  if (hits.y < 0 && hits.x > 0) {
    hits.y = hits.x;
    hits.x = 0;
  }
  
  if (hits.x >= 0) { 
    let epsilon = 0.00001;
    
    var curHitValue = hits.x + epsilon;
    
    let voxelSize = vec3f(1, 1, 1) * volInfo.sizes.xyz / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
    
    var attenuationAccumulator = 0.0;
    
    while (curHitValue < hits.y) {
      let curPoint = p + d * curHitValue;
      
      // convert world position to voxel index
      // normalize to [-0.5, 0.5] range
      let halfsize = volInfo.dims.xyz * volInfo.sizes.xyz * 0.5 / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
      let normalizedPos = curPoint / halfsize;
      
      // scale to voxel indices and shift to [0, dims] range
      let voxelPos = (normalizedPos + vec3f(1.0, 1.0, 1.0)) * 0.5 * volInfo.dims.xyz;
      let voxelIdx = vec3i(voxelPos);
      
      // compute voxel corners -> find the next hit value
      let minCorner = vec3f(floor(voxelPos.x), floor(voxelPos.y), floor(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      let maxCorner = vec3f(ceil(voxelPos.x), ceil(voxelPos.y), ceil(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      
      // back to world coordinates
      let minCornerWorld = minCorner * halfsize;
      let maxCornerWorld = maxCorner * halfsize;
      
      var nextHitValue = hits.y;
      
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      
      var voxelValue = 0.0;
      if (voxelIdx.x >= 0 && voxelIdx.x < i32(volInfo.dims.x) &&
          voxelIdx.y >= 0 && voxelIdx.y < i32(volInfo.dims.y) &&
          voxelIdx.z >= 0 && voxelIdx.z < i32(volInfo.dims.z)) {
        
        let index = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + 
                   voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
        
        voxelValue = volData[index];
      }
      
      if (nextHitValue <= curHitValue || nextHitValue >= hits.y) {
        nextHitValue = curHitValue + min(min(voxelSize.x, voxelSize.y), voxelSize.z) * 0.5;
      }
      
      let deltaT = nextHitValue - curHitValue;
      
      attenuationAccumulator += deltaT * (voxelValue / 4095.0);
      
      curHitValue = nextHitValue + epsilon;
    }
    
    // final intensity using Beer-Lambert law
    let intensity = 1.0 - exp(-attenuationAccumulator);
    let clampedIntensity = clamp(intensity, 0.0, 1.0);
    
    color = vec4f(clampedIntensity, clampedIntensity, clampedIntensity, 1.0);
  }
  else {
    color = vec4f(0.f/255, 56.f/255, 101.f/255, 1.); // Bucknell Blue
  }
  
  textureStore(outTexture, uv, color);
}

// a function to convert from depth to color
fn depthEncoding(t0: f32, t1: f32, tmin: f32, tmax: f32) -> vec4f {
  let r = vec4f(1, 0, 0, 1);
  let g = vec4f(0, 1, 0, 1);
  let b = vec4f(0, 0, 1, 1);
  let t = (t1 + t0) * 0.5;
  let m = (tmax + tmin) * 0.5;
  if (t > m) { // intepolating between green and blue
    let lambda = (t - m) / (tmax - m);
    return b * lambda + g * (1 - lambda);
  }
  let lambda = (m - t) / (m - tmin);
  return r * lambda + g * (1 - lambda);
}

// Color Depth Encoding implementation
fn traceSceneDepthEncoding(uv: vec2i, p: vec3f, d: vec3f) {
  var hits = rayVolumeIntersection(p, d);
  var color = vec4f(0.f/255, 0.f/255, 0.f/255, 1.); 
  
  if (hits.y < 0 && hits.x > 0) {
    hits.y = hits.x;
    hits.x = 0;
  }
  
  if (hits.x >= 0) { 
    let epsilon = 0.00001;
    
    var curHitValue = hits.x + epsilon;
    
    let voxelSize = vec3f(1, 1, 1) * volInfo.sizes.xyz / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
    
    var accumulatedColor = vec4f(0.0, 0.0, 0.0, 1.0);
    
    while (curHitValue < hits.y) {
      let curPoint = p + d * curHitValue;
      
      let halfsize = volInfo.dims.xyz * volInfo.sizes.xyz * 0.5 / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
      let normalizedPos = curPoint / halfsize;
      
      let voxelPos = (normalizedPos + vec3f(1.0, 1.0, 1.0)) * 0.5 * volInfo.dims.xyz;
      let voxelIdx = vec3i(voxelPos);
      
      let minCorner = vec3f(floor(voxelPos.x), floor(voxelPos.y), floor(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      let maxCorner = vec3f(ceil(voxelPos.x), ceil(voxelPos.y), ceil(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      
      let minCornerWorld = minCorner * halfsize;
      let maxCornerWorld = maxCorner * halfsize;
      
      var nextHitValue = hits.y;
      
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      
      var voxelValue = 0.0;
      if (voxelIdx.x >= 0 && voxelIdx.x < i32(volInfo.dims.x) &&
          voxelIdx.y >= 0 && voxelIdx.y < i32(volInfo.dims.y) &&
          voxelIdx.z >= 0 && voxelIdx.z < i32(volInfo.dims.z)) {
        
        let index = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + 
                   voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
        
        voxelValue = volData[index];
      }
      
      if (nextHitValue <= curHitValue || nextHitValue >= hits.y) {
        nextHitValue = curHitValue + min(min(voxelSize.x, voxelSize.y), voxelSize.z) * 0.5;
      }
      
      let deltaT = nextHitValue - curHitValue;
      let depthColor = depthEncoding(curHitValue, nextHitValue, hits.x, hits.y);
      
      accumulatedColor += deltaT * (voxelValue / 4095.0) * depthColor;
      curHitValue = nextHitValue + epsilon;
    }
    
    color = accumulatedColor / (hits.y - hits.x);
    
    color.w = 1.0;
  }
  else {
    color = vec4f(0.f/255, 56.f/255, 101.f/255, 1.); // Bucknell Blue
  }
  
  textureStore(outTexture, uv, color);
}

// convert hsv to rgb
fn hsv2rgb(h: f32, s: f32, v: f32) -> vec3f {
  let c = v * s;
  let hp = h / 60.0;
  let x = c * (1.0 - abs(fract(hp / 2.0) * 2.0 - 1.0));
  
  var rgb: vec3f;
  
  if (hp >= 0.0 && hp < 1.0) { rgb = vec3f(c, x, 0.0); }
  else if (hp >= 1.0 && hp < 2.0) { rgb = vec3f(x, c, 0.0); }
  else if (hp >= 2.0 && hp < 3.0) { rgb = vec3f(0.0, c, x); }
  else if (hp >= 3.0 && hp < 4.0) { rgb = vec3f(0.0, x, c); }
  else if (hp >= 4.0 && hp < 5.0) { rgb = vec3f(x, 0.0, c); }
  else { rgb = vec3f(c, 0.0, x); }
  
  let m = v - c;
  return rgb + vec3f(m, m, m);
}

// calculate gradient at a point in the volume
fn calculateGradient(voxelIdx: vec3i) -> f32 {
  // check if we're in the volume
  if (voxelIdx.x <= 0 || voxelIdx.x >= i32(volInfo.dims.x) - 1 ||
      voxelIdx.y <= 0 || voxelIdx.y >= i32(volInfo.dims.y) - 1 ||
      voxelIdx.z <= 0 || voxelIdx.z >= i32(volInfo.dims.z) - 1) {
    return 0.0;
  }
  
  let idx = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
  
  // sample in all 6 dirs
  let idxX1 = (voxelIdx.x + 1) + voxelIdx.y * i32(volInfo.dims.x) + voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
  let idxX0 = (voxelIdx.x - 1) + voxelIdx.y * i32(volInfo.dims.x) + voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
  let idxY1 = voxelIdx.x + (voxelIdx.y + 1) * i32(volInfo.dims.x) + voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
  let idxY0 = voxelIdx.x + (voxelIdx.y - 1) * i32(volInfo.dims.x) + voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
  let idxZ1 = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + (voxelIdx.z + 1) * i32(volInfo.dims.x * volInfo.dims.y);
  let idxZ0 = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + (voxelIdx.z - 1) * i32(volInfo.dims.x * volInfo.dims.y);
  
  // gradients in each direction
  let gx = (volData[idxX1] - volData[idxX0]) / 2.0;
  let gy = (volData[idxY1] - volData[idxY0]) / 2.0;
  let gz = (volData[idxZ1] - volData[idxZ0]) / 2.0;
  
  return sqrt(gx*gx + gy*gy + gz*gz);
}

fn spectralEdgeDetection(uv: vec2i, p: vec3f, d: vec3f) {
  var hits = rayVolumeIntersection(p, d);
  var color = vec4f(0.f/255, 0.f/255, 0.f/255, 1.); 
  
  if (hits.y < 0 && hits.x > 0) {
    hits.y = hits.x;
    hits.x = 0;
  }
  
  if (hits.x >= 0) { 
    let epsilon = 0.00001;
    var curHitValue = hits.x + epsilon;
    let voxelSize = vec3f(1, 1, 1) * volInfo.sizes.xyz / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
    
    var accumulatedColor = vec3f(0.0, 0.0, 0.0);
    var remainingTransmission = 1.0;
    
    while (curHitValue < hits.y && remainingTransmission > 0.01) {
      let curPoint = p + d * curHitValue;
      
      let halfsize = volInfo.dims.xyz * volInfo.sizes.xyz * 0.5 / max(max(volInfo.dims.x, volInfo.dims.y), volInfo.dims.z);
      let normalizedPos = curPoint / halfsize;
      
      let voxelPos = (normalizedPos + vec3f(1.0, 1.0, 1.0)) * 0.5 * volInfo.dims.xyz;
      let voxelIdx = vec3i(voxelPos);
      
      var voxelValue = 0.0;
      var gradient = 0.0;
      
      if (voxelIdx.x >= 0 && voxelIdx.x < i32(volInfo.dims.x) &&
          voxelIdx.y >= 0 && voxelIdx.y < i32(volInfo.dims.y) &&
          voxelIdx.z >= 0 && voxelIdx.z < i32(volInfo.dims.z)) {
        
        let index = voxelIdx.x + voxelIdx.y * i32(volInfo.dims.x) + 
                   voxelIdx.z * i32(volInfo.dims.x * volInfo.dims.y);
        voxelValue = volData[index];
        gradient = calculateGradient(voxelIdx);
      }
      
      let minCorner = vec3f(floor(voxelPos.x), floor(voxelPos.y), floor(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
      let maxCorner = vec3f(ceil(voxelPos.x), ceil(voxelPos.y), ceil(voxelPos.z)) / volInfo.dims.xyz * 2.0 - vec3f(1.0, 1.0, 1.0);
    
      let minCornerWorld = minCorner * halfsize;
      let maxCornerWorld = maxCorner * halfsize;
      
      var nextHitValue = hits.y;
      
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.x, minCornerWorld.yz, maxCornerWorld.yz, p.x, d.x, p.yz, d.yz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.y, minCornerWorld.xz, maxCornerWorld.xz, p.y, d.y, p.xz, d.xz);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, minCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      nextHitValue = getNextHitValue(hits.x, nextHitValue, maxCornerWorld.z, minCornerWorld.xy, maxCornerWorld.xy, p.z, d.z, p.xy, d.xy);
      
      if (nextHitValue <= curHitValue || nextHitValue >= hits.y) {
        nextHitValue = curHitValue + min(min(voxelSize.x, voxelSize.y), voxelSize.z) * 0.5;
      }
      
      let normalizedValue = voxelValue / 4095.0;
      
      // skip low density regions
      if (normalizedValue > 0.05) {
        let deltaT = nextHitValue - curHitValue;
        
        // normalized gradient
        let normalizedGradient = min(gradient / 300.0, 1.0);
        
        // base opacity from density
        var opacity = normalizedValue * 0.3;
        
        // increase opacity at edges
        opacity = opacity + normalizedGradient * 0.7 * normalizedValue;
        
        // scale opacity by the distance traveled
        opacity = 1.0 - exp(-opacity * deltaT * 10.0);
        
        // map density to hue to create rainbow effect
        // low -> red (0°) 
        // medium density -> green (120°) 
        // high density -> blue (240°)
        let hue = mix(0.0, 360.0, normalizedValue);
        
        // higher saturation for edges
        let saturation = mix(0.5, 1.0, normalizedGradient);
        
        // brightness based on density and depth
        let value = mix(0.5, 1.0, normalizedValue);
        
        let voxelColor = hsv2rgb(hue, saturation, value);
        
        // apply depth effect (distant features gradually become bluer)
        let depthFactor = (curHitValue - hits.x) / (hits.y - hits.x);
        let depthBlue = vec3f(0.0, 0.0, depthFactor * 0.3);
        
        // combine spectral color with depth effect
        let finalVoxelColor = voxelColor + depthBlue;
                
        // front-to-back compositing
        accumulatedColor += remainingTransmission * opacity * finalVoxelColor;
        
        // update remaining transmission
        remainingTransmission *= (1.0 - opacity);
      }
      curHitValue = nextHitValue + epsilon;
    }
    
    color = vec4f(accumulatedColor, 1.0);
  }
  else {
    color = vec4f(0.f/255, 56.f/255, 101.f/255, 1.); // Bucknell Blue
  }
  
  textureStore(outTexture, uv, color);
}

@compute
@workgroup_size(16, 16)
fn computeOrthogonalMain(@builtin(global_invocation_id) global_id: vec3u) {
  // get the pixel coordiantes
  let uv = vec2i(global_id.xy);
  let texDim = vec2i(textureDimensions(outTexture));
  if (uv.x < texDim.x && uv.y < texDim.y) {
    // compute the pixel size
    let psize = vec2f(2, 2) / cameraPose.res.xy;
    // orthogonal camera ray sent from each pixel center at z = 0
    var spt = vec3f((f32(uv.x) + 0.5) * psize.x - 1, (f32(uv.y) + 0.5) * psize.y - 1, 0);
    var rdir = vec3f(0, 0, 1);
    // apply transformation
    spt = transformPt(spt);
    rdir = transformDir(rdir);
    
    switch(traceType) {
      case 0u: {
        // MIP
        traceSceneMIP(uv, spt, rdir);
        break;
      }
      case 1u: {
        // DRR
        traceSceneDRR(uv, spt, rdir);
        break;
      }
      case 2u: {
        // Depth Encoding
        traceSceneDepthEncoding(uv, spt, rdir);
        break;
      }
      case 3u: {
        // Spectral Edge Detection
        spectralEdgeDetection(uv, spt, rdir);
        break;
      }
      default: {
        // Default to spectral edge detection
        spectralEdgeDetection(uv, spt, rdir);
      }
    }
  }
}

@compute
@workgroup_size(16, 16)
fn computeProjectiveMain(@builtin(global_invocation_id) global_id: vec3u) {
  // let uv = vec2i(global_id.xy);
  // let texDim = vec2i(textureDimensions(outTexture));
  // if (uv.x < texDim.x && uv.y < texDim.y) {
  //   let sensorSize = vec2f(2.0, 2.0) / cameraPose.focal;

  //   let psize = sensorSize / cameraPose.res;

  //   let px = (f32(uv.x) + 0.5) * psize.x - sensorSize.x * 0.5;
  //   let py = (f32(uv.y) + 0.5) * psize.y - sensorSize.y * 0.5;
  //   let p = vec3f(px, py, 1.0);

  //   var spt = vec3f(0.0, 0.0, 0.0);

  //   var rdir = normalize(p - spt);

  //   spt = transformPt(spt);
  //   rdir = transformDir(rdir);

  //   let hitInfo = rayVolumeIntersection(spt, rdir);

  //   assignColor(uv, hitInfo.x, i32(hitInfo.y));
  // }
}
