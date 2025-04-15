/**
 * Render Loop module - Handles the animation loop and FPS tracking
 */

import StandardTextObject from '/lib/DSViz/StandardTextObject.js';

/**
 * Sets up and starts the render loop
 * @param {RayTracer} tracer - The ray tracer object
 * @param {number} targetFPS - Target frames per second
 * @returns {Object} - Object containing FPS text and frame count for external reference
 */
export function setupRenderLoop(tracer, targetFPS = 60) {
  // Initial FPS counter
  let fps = '??';
  const fpsText = new StandardTextObject('fps: ' + fps);
  
  // Animation timing variables
  let frameCnt = 0;
  const secPerFrame = 1 / targetFPS;
  const frameInterval = secPerFrame * 1000;
  let lastCalled = Date.now();
  
  // Define render frame function
  const renderFrame = () => {
    let elapsed = Date.now() - lastCalled;
    if (elapsed > frameInterval) {
      ++frameCnt;
      lastCalled = Date.now() - (elapsed % frameInterval);
      tracer.render();
    }
    requestAnimationFrame(renderFrame);
  };
  
  // Start the render loop
  renderFrame();
  
  // Set up FPS counter update
  setInterval(() => {
    fpsText.updateText('fps: ' + frameCnt);
    frameCnt = 0;
  }, 1000); // call every 1000 ms
  
  return {
    fpsText,
    getFrameCount: () => frameCnt
  };
}
