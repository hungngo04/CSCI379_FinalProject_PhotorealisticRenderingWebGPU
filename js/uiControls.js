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
      <!-- Light Controls -->
      <h3>Light Controls</h3>
      <label for="light-x">X:</label>
      <input type="number" id="light-x" value="0.0"><br/>
      <label for="light-y">Y:</label>
      <input type="number" id="light-y" value="0.0"><br/>
      <label for="light-z">Z:</label>
      <input type="number" id="light-z" value="0.0"><br/>
      <label for="light-intensity">Intensity:</label>
      <input type="number" id="light-intensity" value="1.0">
      <span id="light-intensity-value">1.0</span>
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
 * Sets up trace type control - now only supports DRR
 * @param {Object} tracerObj - The tracer object to update
 */
export function setupTraceTypeControls(tracerObj) {
  // Setting DRR as the default trace type
  tracerObj.setTraceType(1); // DRR
}

/**
 * Sets up light controls - handles x, y, z, and intensity UI for the light and updates the GPU buffer
 * @param {Object} volumeObj - The volume object to update
 */
export function setupLightControls(volumeObj) {
  const lx = document.getElementById('light-x');
  const ly = document.getElementById('light-y');
  const lz = document.getElementById('light-z');
  const lint = document.getElementById('light-intensity');
  const lintVal = document.getElementById('light-intensity-value');
  function updateLight() {
    const lightParams = new Float32Array([
      parseFloat(lx.value),
      parseFloat(ly.value),
      parseFloat(lz.value),
      parseFloat(lint.value), // intensity in slot 3
      1.0, 1.0, 1.0,         // color (white) in slots 4,5,6
      0.0                    // pad
    ]);
    volumeObj._device.queue.writeBuffer(volumeObj._lightBuffer, 0, lightParams);
    lintVal.textContent = lint.value;
  }
  [lx, ly, lz, lint].forEach(ctrl => ctrl.addEventListener('input', updateLight));
}
