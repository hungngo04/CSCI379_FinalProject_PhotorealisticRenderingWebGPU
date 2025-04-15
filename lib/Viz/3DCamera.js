/*!
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
 
import PGA3D from '/lib/Math/PGA3D.js'
 
export default class Camera {
  constructor(width, height) {
    this._pose = new Float32Array(Array(16).fill(0));
    this._pose[0] = 1;
    this._focal = new Float32Array(Array(2).fill(0.25));
    this._resolutions = new Float32Array([width, height]);
  }
  
  resetPose() {
    this._pose[0] = 1;
    for (let i = 1; i < 16; ++i) this._pose[i] = 0;
    this._focal[0] = 1;
    this._focal[1] = 1;
  }
  
  updatePose(newpose) {
    for (let i = 0; i < 16; ++i) this._pose[i] = newpose[i];
  }
  
  updateSize(width, height) {
    this._resolutions[0] = width;
    this._resolutions[1] = height;
  }

  moveX(d) {
    const worldX = PGA3D.applyMotorToDir([1, 0, 0], this._pose);
    const dx = worldX[0] * d;
    const dy = worldX[1] * d;
    const dz = worldX[2] * d;

    const translator = PGA3D.createTranslator(dx, dy, dz);

    let newpose = PGA3D.geometricProduct(translator, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);

    this.updatePose(newpose);
  }
  
  moveY(d) {
    const worldX = PGA3D.applyMotorToDir([0, 1, 0], this._pose);
    const dx = worldX[0] * d;
    const dy = worldX[1] * d;
    const dz = worldX[2] * d;

    const translator = PGA3D.createTranslator(dx, dy, dz);

    let newpose = PGA3D.geometricProduct(translator, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);

    this.updatePose(newpose);
  }
  
  moveZ(d) {
    const worldZ = PGA3D.applyMotorToDir([0, 0, 1], this._pose);
    const dx = worldZ[0] * d;
    const dy = worldZ[1] * d;
    const dz = worldZ[2] * d;

    const translator = PGA3D.createTranslator(dx, dy, dz);
    let newpose = PGA3D.geometricProduct(translator, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);

    this.updatePose(newpose);
  }
  
  rotateX(d) {
    const camPos = PGA3D.applyMotorToPoint([0, 0, 0], this._pose);
    const axisX = PGA3D.applyMotorToDir([1, 0, 0], this._pose);
    const rotor = PGA3D.createRotor(d, axisX[0], axisX[1], axisX[2],
                                    camPos[0], camPos[1], camPos[2]);

    let newpose = PGA3D.geometricProduct(rotor, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);

    this.updatePose(newpose);
  }
  
  rotateY(d) {
    const camPos = PGA3D.applyMotorToPoint([0, 0, 0], this._pose);
    const axisY = PGA3D.applyMotorToDir([0, 1, 0], this._pose);
    const rotor = PGA3D.createRotor(d, axisY[0], axisY[1], axisY[2],
                                    camPos[0], camPos[1], camPos[2]);

    let newpose = PGA3D.geometricProduct(rotor, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);
    this.updatePose(newpose);
  }
  
  rotateZ(d) {
    const camPos = PGA3D.applyMotorToPoint([0, 0, 0], this._pose);
    const axisZ = PGA3D.applyMotorToDir([0, 0, 1], this._pose);
    const rotor = PGA3D.createRotor(d, axisZ[0], axisZ[1], axisZ[2],
                                    camPos[0], camPos[1], camPos[2]);

    let newpose = PGA3D.geometricProduct(rotor, this._pose);
    newpose = PGA3D.normalizeMotor(newpose);
    this.updatePose(newpose);
  }
}
