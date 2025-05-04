export function createUIControls() {
  const controlsDiv = document.createElement("div");
  controlsDiv.style.position = "absolute";
  controlsDiv.style.top = "50px";
  controlsDiv.style.left = "10px";
  controlsDiv.style.padding = "15px";
  controlsDiv.style.borderRadius = "8px";
  controlsDiv.style.background = "rgba(40, 44, 52, 0.85)";
  controlsDiv.style.border = "1px solid #4A90E2";
  controlsDiv.style.boxShadow = "0 4px 8px rgba(0, 0, 0, 0.5)";
  controlsDiv.style.fontFamily = "'Roboto', 'Segoe UI', sans-serif";
  controlsDiv.style.color = "#E9E9E9";
  controlsDiv.style.width = "260px";
  controlsDiv.style.backdropFilter = "blur(5px)";
  controlsDiv.style.zIndex = "1000";
  
  controlsDiv.innerHTML = `
    <style>
      .control-section {
        margin-bottom: 15px;
        padding-bottom: 15px;
        border-bottom: 1px solid #4A90E2;
      }
      .control-section:last-child {
        border-bottom: none;
        margin-bottom: 0;
        padding-bottom: 0;
      }
      h3 {
        color: #4A90E2;
        margin-top: 0;
        margin-bottom: 12px;
        font-size: 16px;
        font-weight: 500;
      }
      button {
        background: #2C3748;
        color: #E9E9E9;
        border: 1px solid #4A90E2;
        border-radius: 4px;
        padding: 6px 10px;
        margin: 3px;
        cursor: pointer;
        font-size: 12px;
        transition: background 0.2s, transform 0.1s;
      }
      button:hover {
        background: #3A4A61;
      }
      button:active {
        transform: scale(0.98);
        background: #4A90E2;
      }
      .button-row {
        display: flex;
        justify-content: space-between;
        margin-bottom: 8px;
      }
      label {
        display: inline-block;
        width: 70px;
        margin-right: 10px;
        font-size: 13px;
      }
      input[type="number"] {
        width: 60px;
        background: #2C3748;
        color: #E9E9E9;
        border: 1px solid #4A90E2;
        border-radius: 4px;
        padding: 4px;
        font-size: 13px;
      }
      .value-display {
        display: inline-block;
        width: 30px;
        text-align: right;
        color: #4A90E2;
      }
    </style>
    
    <div class="control-section">
      <h3>Camera Controls</h3>
      <div class="button-row">
        <button id="btnForward">Forward (Z-)</button>
        <button id="btnBackward">Backward (Z+)</button>
      </div>
      <div class="button-row">
        <button id="btnLeft">Left (X-)</button>
        <button id="btnRight">Right (X+)</button>
      </div>
      <div class="button-row">
        <button id="btnUp">Up (Y+)</button>
        <button id="btnDown">Down (Y-)</button>
      </div>
    </div>
    
    <div class="control-section">
      <h3>Rotation</h3>
      <div class="button-row">
        <button id="btnRotXPos">Rotate +X</button>
        <button id="btnRotXNeg">Rotate -X</button>
      </div>
      <div class="button-row">
        <button id="btnRotYPos">Rotate +Y</button>
        <button id="btnRotYNeg">Rotate -Y</button>
      </div>
      <div class="button-row">
        <button id="btnRotZPos">Rotate +Z</button>
        <button id="btnRotZNeg">Rotate -Z</button>
      </div>
    </div>
    
    <div class="control-section">
      <h3>Light Settings</h3>
      <div class="input-row">
        <label for="light-x">X:</label>
        <input type="number" id="light-x" value="0.0" step="0.1">
        <span class="value-display" id="light-x-value">0.0</span>
      </div>
      <div class="input-row">
        <label for="light-y">Y:</label>
        <input type="number" id="light-y" value="0.0" step="0.1">
        <span class="value-display" id="light-y-value">0.0</span>
      </div>
      <div class="input-row">
        <label for="light-z">Z:</label>
        <input type="number" id="light-z" value="0.0" step="0.1">
        <span class="value-display" id="light-z-value">0.0</span>
      </div>
      <div class="input-row">
        <label for="light-intensity">Intensity:</label>
        <input type="number" id="light-intensity" value="1.0" step="0.1" min="0" max="5">
        <span class="value-display" id="light-intensity-value">1.0</span>
      </div>
    </div>
    <div class="control-section">
      <h3>Volume Settings</h3>
      <div class="input-row">
        <label for="use-trilinear">Interpolation:</label>
        <input type="checkbox" id="use-trilinear">
        <span class="value-display" id="use-trilinear-value">0</span>
      </div>
    </div>
  `;
  
  document.body.appendChild(controlsDiv);
  
  // Add minimize/maximize functionality
  const minimizeButton = document.createElement("button");
  minimizeButton.innerHTML = "−";
  minimizeButton.style.position = "absolute";
  minimizeButton.style.top = "8px";
  minimizeButton.style.right = "8px";
  minimizeButton.style.padding = "0 5px";
  minimizeButton.style.fontSize = "16px";
  minimizeButton.style.lineHeight = "20px";
  minimizeButton.style.width = "24px";
  minimizeButton.style.height = "24px";
  minimizeButton.style.borderRadius = "4px";
  minimizeButton.style.background = "transparent";
  minimizeButton.style.border = "none";
  minimizeButton.style.cursor = "pointer";
  minimizeButton.style.color = "#4A90E2";
  
  const allSections = controlsDiv.querySelectorAll('.control-section');
  let minimized = false;
  
  minimizeButton.addEventListener("click", () => {
    if (minimized) {
      allSections.forEach(section => section.style.display = "block");
      minimizeButton.innerHTML = "−";
    } else {
      allSections.forEach(section => section.style.display = "none");
      minimizeButton.innerHTML = "+";
    }
    minimized = !minimized;
  });
  
  controlsDiv.appendChild(minimizeButton);
  
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
 * Sets up light controls with enhanced UI feedback
 * @param {Object} volumeObj - The volume object to update
 */
export function setupLightControls(volumeObj) {
  const lx = document.getElementById('light-x');
  const ly = document.getElementById('light-y');
  const lz = document.getElementById('light-z');
  const lint = document.getElementById('light-intensity');
  
  const lxVal = document.getElementById('light-x-value');
  const lyVal = document.getElementById('light-y-value');
  const lzVal = document.getElementById('light-z-value');
  const lintVal = document.getElementById('light-intensity-value');
  
  // Initialize display values
  lxVal.textContent = lx.value;
  lyVal.textContent = ly.value;
  lzVal.textContent = lz.value;
  lintVal.textContent = lint.value;
  
  function updateLight() {
    const lightParams = new Float32Array([
      parseFloat(lx.value),
      parseFloat(ly.value),
      parseFloat(lz.value),
      parseFloat(lint.value), // intensity in slot 3
      1.0, 1.0, 1.0,         // color (white) in slots 4,5,6
      0.0                    // pad
    ]);
    
    // Update display values
    lxVal.textContent = parseFloat(lx.value).toFixed(1);
    lyVal.textContent = parseFloat(ly.value).toFixed(1);
    lzVal.textContent = parseFloat(lz.value).toFixed(1);
    lintVal.textContent = parseFloat(lint.value).toFixed(1);
    
    volumeObj._device.queue.writeBuffer(volumeObj._lightBuffer, 0, lightParams);
  }
  
  [lx, ly, lz, lint].forEach(ctrl => ctrl.addEventListener('input', updateLight));
}

export function setupInterpolationControls(volumeObj) {
  const useTrilinearCheckbox = document.getElementById('use-trilinear');
  const useTrilinearValue = document.getElementById('use-trilinear-value');
  
  useTrilinearCheckbox.checked = true;
  useTrilinearValue.textContent = useTrilinearCheckbox.checked ? "on" : "off";
  
  volumeObj.setUseTrilinear(useTrilinearCheckbox.checked);
  
  useTrilinearCheckbox.addEventListener('change', () => {
    useTrilinearValue.textContent = useTrilinearCheckbox.checked ? "on" : "off";
    
    volumeObj.setUseTrilinear(useTrilinearCheckbox.checked);
  });
}