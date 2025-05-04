/**
 * Main Application module - Coordinates the overall application flow
 */

import RayTracer from '/lib/Viz/RayTracer.js';
import VolumeRenderingSimpleObject from '/lib/DSViz/VolumeRenderingSimpleObject.js';
import Camera from '/lib/Viz/3DCamera.js';
import { createCanvas } from './canvasSetup.js';
import { createUIControls, setupCameraControls, setupLightControls, setupTraceTypeControls, setupInterpolationControls } from './uiControls.js';
import { setupRenderLoop } from './renderLoop.js';

/**
 * Initialize the application
 * @returns {Promise<RayTracer>} The initialized ray tracer
 */
export async function initApp() {
  // Set up canvas
  const canvas = createCanvas();
  
  // Create a ray tracer
  const tracer = new RayTracer(canvas);
  await tracer.init();
  
  // Create a 3D Camera
  const camera = new Camera();
  
  // Create an object to trace
  const tracerObj = new VolumeRenderingSimpleObject(tracer._device, tracer._canvasFormat, camera);
  await tracer.setTracerObject(tracerObj);
  
  // Create UI controls
  createUIControls();
  
  // Set up movement and rotation controls
  const moveStep = 0.05;
  const rotateStep = 0.1;
  setupCameraControls(camera, tracerObj, moveStep, rotateStep);
  setupLightControls(tracerObj);
  
  // Set up trace type controls
  setupTraceTypeControls(tracerObj);
  
  // Set up render loop
  setupRenderLoop(tracer);

  setupInterpolationControls(tracerObj);
  
  return tracer;
}

/**
 * Handle errors that occur during initialization
 * @param {Error} error - The error that occurred
 */
export function handleInitError(error) {
  const pTag = document.createElement('p');
  pTag.innerHTML = navigator.userAgent + "</br>" + error.message;
  document.body.appendChild(pTag);
  
  const canvas = document.getElementById("renderCanvas");
  if (canvas) {
    canvas.remove();
  }
}
