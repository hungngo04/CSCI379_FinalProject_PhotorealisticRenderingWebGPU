/**
 * UI Controls module - Handles UI creation and event listeners
 */

/**
 * Creates UI controls and adds them to the document
 * @returns {HTMLElement} The container div for UI controls
 */
export function createUIControls() {
  const controlsDiv = document.createElement("div");
  controlsDiv.style.position = "absolute";
  controlsDiv.style.top = "10px";
  controlsDiv.style.left = "10px";
  controlsDiv.style.padding = "8px";
  controlsDiv.style.border = "1px solid black";
  controlsDiv.style.background = "white";
  controlsDiv.style.fontFamily = "sans-serif";
  controlsDiv.innerHTML = `
      <h3>Camera Controls</h3>
      <!-- Translation buttons -->
      <button id="btnForward">Forward (Z-)</button>
      <button id="btnBackward">Backward (Z+)</button><br/><br/>
      <button id="btnLeft">Left (X-)</button>
      <button id="btnRight">Right (X+)</button><br/><br/>
      <button id="btnUp">Up (Y+)</button>
      <button id="btnDown">Down (Y-)</button>
      <hr/>
      <!-- Rotation buttons -->
      <button id="btnRotXPos">Rotate +X</button>
      <button id="btnRotXNeg">Rotate -X</button><br/><br/>
      <button id="btnRotYPos">Rotate +Y</button>
      <button id="btnRotYNeg">Rotate -Y</button><br/><br/>
      <button id="btnRotZPos">Rotate +Z</button>
      <button id="btnRotZNeg">Rotate -Z</button>
      <hr/>
      <!-- Trace Type Selection -->
      <h3>Trace Type</h3>
      <button id="btnMIP">MIP</button>
      <button id="btnDRR">DRR</button><br/><br/>
      <button id="btnDepth">Depth Encoding</button>
      <button id="btnEdge">Spectral Edge</button>
    `;
  document.body.appendChild(controlsDiv);
  return controlsDiv;
}

/**
 * Sets up event listeners for camera movement and rotation
 * @param {Object} camera - Camera object with movement methods
 * @param {Object} tracerObj - The tracer object to update
 * @param {number} moveStep - Movement step size
 * @param {number} rotateStep - Rotation step size
 */
export function setupCameraControls(camera, tracerObj, moveStep = 0.05, rotateStep = 0.1) {
  // Movement controls
  document.getElementById("btnForward").addEventListener("click", () => {
    camera.moveZ(-moveStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnBackward").addEventListener("click", () => {
    camera.moveZ(moveStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnLeft").addEventListener("click", () => {
    camera.moveX(-moveStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRight").addEventListener("click", () => {
    camera.moveX(moveStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnUp").addEventListener("click", () => {
    camera.moveY(moveStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnDown").addEventListener("click", () => {
    camera.moveY(-moveStep);
    tracerObj.updateCameraPose();
  });

  // Rotation controls
  document.getElementById("btnRotXPos").addEventListener("click", () => {
    camera.rotateX(rotateStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRotXNeg").addEventListener("click", () => {
    camera.rotateX(-rotateStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRotYPos").addEventListener("click", () => {
    camera.rotateY(rotateStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRotYNeg").addEventListener("click", () => {
    camera.rotateY(-rotateStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRotZPos").addEventListener("click", () => {
    camera.rotateZ(rotateStep);
    tracerObj.updateCameraPose();
  });
  document.getElementById("btnRotZNeg").addEventListener("click", () => {
    camera.rotateZ(-rotateStep);
    tracerObj.updateCameraPose();
  });
}

/**
 * Sets up trace type selection buttons
 * @param {Object} tracerObj - The tracer object to update
 */
export function setupTraceTypeControls(tracerObj) {
  document.getElementById("btnMIP").addEventListener("click", () => {
    tracerObj.setTraceType(0); // MIP
  });
  document.getElementById("btnDRR").addEventListener("click", () => {
    tracerObj.setTraceType(1); // DRR
  });
  document.getElementById("btnDepth").addEventListener("click", () => {
    tracerObj.setTraceType(2); // Depth Encoding
  });
  document.getElementById("btnEdge").addEventListener("click", () => {
    tracerObj.setTraceType(3); // Spectral Edge Detection
  });
}
