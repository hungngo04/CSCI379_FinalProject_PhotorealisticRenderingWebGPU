/**
 * Canvas setup module - Handles the creation and configuration of the WebGPU canvas
 */

/**
 * Creates and adds a canvas to the document body
 * @returns {HTMLCanvasElement} The created canvas element
 */
export function createCanvas() {
  const canvasTag = document.createElement('canvas');
  canvasTag.id = "renderCanvas";
  document.body.appendChild(canvasTag);
  return canvasTag;
}
