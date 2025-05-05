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

import RayTracingObject from "/lib/DSViz/RayTracingObject.js"
import VolumeData from "/lib/DS/VolumeData.js"

export default class VolumeRenderingSimpleObject extends RayTracingObject {
  constructor(device, canvasFormat, camera, useTrilinear) {
    super(device, canvasFormat);
    this._volume = new VolumeData('/assets/brainweb-t1-1mm-pn0-rf0.raws');
    this._camera = camera;
    this._traceType = 3; // Default to spectralEdgeDetection
    this._useTrilinear = useTrilinear;
    
    this._tissueColors = {
      boneBoundary: [0.96, 0.91, 0.86],
      boneInterior: [0.92, 0.86, 0.78],
      whiteMatterBoundary: [0.95, 0.62, 0.55],
      whiteMatterInterior: [0.92, 0.58, 0.52],
      grayMatterBoundary: [0.89, 0.55, 0.50],
      grayMatterInterior: [0.85, 0.48, 0.45],
      csf: [0.90, 0.65, 0.60]
    };
  }

  setTraceType(traceType) {
    this._traceType = traceType;
    this._device.queue.writeBuffer(this._traceTypeBuffer, 0, new Uint32Array([this._traceType]));
  }

  setUseTrilinear(useTrilinear) {
    this._useTrilinear = useTrilinear ? 1 : 0;
    if (this._useTrilinearBuffer) {
      this._device.queue.writeBuffer(this._useTrilinearBuffer, 0, new Uint32Array([this._useTrilinear]));
    }
  }  

  updateTissueColor(tissueType, color) {
    switch(tissueType) {
      case 'boneBoundary':
        this._tissueColors.boneBoundary = color;
        break;
      case 'boneInterior':
        this._tissueColors.boneInterior = color;
        break;
      case 'whiteMatterBoundary':
        this._tissueColors.whiteMatterBoundary = color;
        break;
      case 'whiteMatterInterior':
        this._tissueColors.whiteMatterInterior = color;
        break;
      case 'grayMatterBoundary':
        this._tissueColors.grayMatterBoundary = color;
        break;
      case 'grayMatterInterior':
        this._tissueColors.grayMatterInterior = color;
        break;
      case 'csf':
        this._tissueColors.csf = color;
        break;
    }
    
    this.updateTissueColorsBuffer();
  }
  
  updateTissueColorsBuffer() {
    if (!this._tissueColorsBuffer) return;
    
    const tissueColorsArray = new Float32Array([
      ...this._tissueColors.boneBoundary, 0, // bone boundary + padding
      ...this._tissueColors.boneInterior, 0, // bone interior + padding
      ...this._tissueColors.whiteMatterBoundary, 0, // white matter boundary + padding
      ...this._tissueColors.whiteMatterInterior, 0, // white matter interior + padding
      ...this._tissueColors.grayMatterBoundary, 0, // gray matter boundary + padding
      ...this._tissueColors.grayMatterInterior, 0, // gray matter interior + padding
      ...this._tissueColors.csf, 0, // csf + padding
    ]);
    
    this._device.queue.writeBuffer(this._tissueColorsBuffer, 0, tissueColorsArray);
  }

  async createGeometry() {
    await this._volume.init();
    // Create camera buffer to store the camera pose and scale in GPU
    this._cameraBuffer = this._device.createBuffer({
      label: "Camera " + this.getName(),
      size: this._camera._pose.byteLength + this._camera._focal.byteLength + this._camera._resolutions.byteLength,
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    // Copy from CPU to GPU - both pose and scales
    this._device.queue.writeBuffer(this._cameraBuffer, 0, this._camera._pose);
    this._device.queue.writeBuffer(this._cameraBuffer, this._camera._pose.byteLength, this._camera._focal);
    this._device.queue.writeBuffer(this._cameraBuffer, this._camera._pose.byteLength + this._camera._focal.byteLength, this._camera._resolutions);
    // Create uniform buffer to store the volume dimensions and voxel sizes in GPU
    this._volumeBuffer = this._device.createBuffer({
      label: "Volume " + this.getName(),
      size: (this._volume._dims.length + this._volume._sizes.length + 2) * Float32Array.BYTES_PER_ELEMENT,
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    // Copy from CPU to GPU - both dims and sizes
    this._device.queue.writeBuffer(this._volumeBuffer, 0, new Float32Array([... this._volume._dims, 0, ...this._volume._sizes, 0]));
    // Create data buffer to store the volume data in GPU
    this._dataBuffer = this._device.createBuffer({
      label: "Data " + this.getName(),
      size: this._volume._data.length * Float32Array.BYTES_PER_ELEMENT,
      usage: GPUBufferUsage.STORAGE | GPUBufferUsage.COPY_DST,
    });

    // Create a new buffer for trace type
    this._traceTypeBuffer = this._device.createBuffer({
      label: "TraceType " + this.getName(),
      size: Uint32Array.BYTES_PER_ELEMENT,
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    // Initialize trace type buffer
    this._device.queue.writeBuffer(this._traceTypeBuffer, 0, new Uint32Array([this._traceType]));

    // --- Material buffer: add for photorealistic rendering ---
    this._materialBuffer = this._device.createBuffer({
      label: "Material " + this.getName(),
      size: 16, // space for 4 floats
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    
    // --- Light buffer: add for photorealistic rendering ---
    this._lightBuffer = this._device.createBuffer({
      label: "Light " + this.getName(),
      size: 8 * Float32Array.BYTES_PER_ELEMENT, // space for position, intensity, color, padding
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    
    // Initialize light position at the center on the -z side
    const lightParams = new Float32Array([
      0.0, 0.0, -2.0, // position (x, y, z)
      0.8,           // intensity
      1.0, 1.0, 1.0, // color (white)
      0.0            // padding
    ]);
    this._device.queue.writeBuffer(this._lightBuffer, 0, lightParams);
    
    // Create trilinear interpolation flag buffer
    this._useTrilinearBuffer = this._device.createBuffer({
      label: "UseTrilinear " + this.getName(),
      size: Uint32Array.BYTES_PER_ELEMENT,
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    // Initialize trilinear flag buffer
    this._device.queue.writeBuffer(this._useTrilinearBuffer, 0, new Uint32Array([this._useTrilinear ? 1 : 0]));

    // Create tissue colors buffer
    this._tissueColorsBuffer = this._device.createBuffer({
      label: "TissueColors " + this.getName(),
      size: 28 * Float32Array.BYTES_PER_ELEMENT, // 7 colors with vec4 alignment (x,y,z,padding)
      usage: GPUBufferUsage.UNIFORM | GPUBufferUsage.COPY_DST,
    });
    
    this.updateTissueColorsBuffer();

    // Copy from CPU to GPU
    // Note, here we make use of the offset to copy them over one by one
    this._device.queue.writeBuffer(this._dataBuffer, 0, new Float32Array(this._volume._data));
  }

  updateGeometry() {
    // update the image size of the camera
    this._camera.updateSize(this._imgWidth, this._imgHeight);
    this._device.queue.writeBuffer(this._cameraBuffer, this._camera._pose.byteLength + this._camera._focal.byteLength, this._camera._resolutions);
  }

  updateCameraPose() {
    this._device.queue.writeBuffer(this._cameraBuffer, 0, this._camera._pose);
  }

  updateCameraFocal() {
    this._device.queue.writeBuffer(this._cameraBuffer, this._camera._pose.byteLength, this._camera._focal);
  }

  async createShaders() {
    let shaderCode = await this.loadShader("/shaders/tracevolumesimple.wgsl");
    this._shaderModule = this._device.createShaderModule({
      label: " Shader " + this.getName(),
      code: shaderCode,
    });
    // Create the bind group layout
    this._bindGroupLayout = this._device.createBindGroupLayout({
      label: "Ray Trace Volume Layout " + this.getName(),
      entries: [{
        binding: 0,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Camera buffer
      }, {
        binding: 1,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Volume buffer
      }, {
        binding: 2,
        visibility: GPUShaderStage.COMPUTE,
        buffer: { type: "read-only-storage" } // Data storage buffer
      }, {
        binding: 3,
        visibility: GPUShaderStage.COMPUTE,
        storageTexture: { format: this._canvasFormat } // texture
      }, {
        binding: 4,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Trace type buffer
      }, {
        binding: 5,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Material buffer
      }, {
        binding: 6,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Light buffer
      }, {
        binding: 7,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Use trilinear buffer
      }, {
        binding: 8,
        visibility: GPUShaderStage.COMPUTE,
        buffer: {} // Tissue colors buffer
      }]
    });
    this._pipelineLayout = this._device.createPipelineLayout({
      label: "Ray Trace Volume Pipeline Layout",
      bindGroupLayouts: [this._bindGroupLayout],
    });
  }

  async createComputePipeline() {
    // Create a compute pipeline that updates the image.
    this._computePipeline = this._device.createComputePipeline({
      label: "Ray Trace Volume Orthogonal Pipeline " + this.getName(),
      layout: this._pipelineLayout,
      compute: {
        module: this._shaderModule,
        entryPoint: "computeOrthogonalMain",
      }
    });
    // Create a compute pipeline that updates the image.
    this._computeProjectivePipeline = this._device.createComputePipeline({
      label: "Ray Trace Volume Projective Pipeline " + this.getName(),
      layout: this._pipelineLayout,
      compute: {
        module: this._shaderModule,
        entryPoint: "computeProjectiveMain",
      }
    });
  }

  createBindGroup(outTexture) {
    // Create a bind group
    this._bindGroup = this._device.createBindGroup({
      label: "Ray Trace Volume Bind Group",
      layout: this._computePipeline.getBindGroupLayout(0),
      entries: [
        {
          binding: 0,
          resource: { buffer: this._cameraBuffer }
        },
        {
          binding: 1,
          resource: { buffer: this._volumeBuffer }
        },
        {
          binding: 2,
          resource: { buffer: this._dataBuffer }
        },
        {
          binding: 3,
          resource: outTexture.createView()
        },
        {
          binding: 4,
          resource: { buffer: this._traceTypeBuffer }
        },
        {
          binding: 5,
          resource: { buffer: this._materialBuffer }
        },
        {
          binding: 6,
          resource: { buffer: this._lightBuffer }
        },
        {
          binding: 7,
          resource: { buffer: this._useTrilinearBuffer }
        },
        {
          binding: 8,
          resource: { buffer: this._tissueColorsBuffer }
        } 
      ],
    });
    this._wgWidth = Math.ceil(outTexture.width);
    this._wgHeight = Math.ceil(outTexture.height);
  }

  compute(pass) {
    // add to compute pass
    if (this._camera?._isProjective) {
      pass.setPipeline(this._computeProjectivePipeline);        // set the compute projective pipeline
    }
    else {
      pass.setPipeline(this._computePipeline);                 // set the compute orthogonal pipeline
    }
    pass.setBindGroup(0, this._bindGroup);                  // bind the buffer
    pass.dispatchWorkgroups(Math.ceil(this._wgWidth / 16), Math.ceil(this._wgHeight / 16)); // dispatch
  }
}