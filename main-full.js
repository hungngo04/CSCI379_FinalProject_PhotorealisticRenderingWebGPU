class Renderer{constructor(canvas){this._canvas=canvas;this._objects=[];this._clearColor={r:0,g:56/255,b:101/255,a:1};}
async init(){if(!navigator.gpu){throw Error("WebGPU is not supported in this browser.");}
const adapter=await navigator.gpu.requestAdapter();if(!adapter){throw Error("Couldn't request WebGPU adapter.");}
this._device=await adapter.requestDevice();this._context=this._canvas.getContext("webgpu");this._canvasFormat=navigator.gpu.getPreferredCanvasFormat();this._context.configure({device:this._device,format:this._canvasFormat,});this.resizeCanvas();window.addEventListener('resize',this.resizeCanvas.bind(this));}
resizeCanvas(){const devicePixelRatio=window.devicePixelRatio||1;const width=window.innerWidth*devicePixelRatio;const height=window.innerHeight*devicePixelRatio;this._canvas.width=width;this._canvas.height=height;this._canvas.style.width=`${window.innerWidth}px`;this._canvas.style.height=`${window.innerHeight}px`;this._canvas.style.transformOrigin="center";this.render();}
async appendSceneObject(obj){await obj.init();this._objects.push(obj);}
renderToSelectedView(outputView){for(const obj of this._objects){obj?.updateGeometry();}
let encoder=this._device.createCommandEncoder();const pass=encoder.beginRenderPass({colorAttachments:[{view:outputView,clearValue:this._clearColor,loadOp:"clear",storeOp:"store",}]});for(const obj of this._objects){obj?.render(pass);}
pass.end();const computePass=encoder.beginComputePass();for(const obj of this._objects){obj?.compute(computePass);}
computePass.end();const commandBuffer=encoder.finish();this._device.queue.submit([commandBuffer]);}
render(){this.renderToSelectedView(this._context.getCurrentTexture().createView());}}
class RayTracer extends Renderer{constructor(canvas){super(canvas);this._tracer=null;}
async init(){if(!navigator.gpu){throw Error("WebGPU is not supported in this browser.");}
const adapter=await navigator.gpu.requestAdapter();if(!adapter){throw Error("Couldn't request WebGPU adapter.");}
this._device=await adapter.requestDevice();this._context=this._canvas.getContext("webgpu");this._canvasFormat="rgba8unorm";this._context.configure({device:this._device,format:this._canvasFormat,});this._shaderModule=this._device.createShaderModule({label:"Ray Tracer Shader",code:`
      @vertex
      fn vertexMain(@builtin(vertex_index) vIdx: u32) -> @builtin(position) vec4f {
        var pos = array<vec2f, 6>(
          vec2f(-1, -1), vec2f(1, -1), vec2f(-1, 1),
          vec2f(-1, 1), vec2f(1, -1), vec2f(1, 1)
        );
        return vec4f(pos[vIdx], 0, 1);
      }
      
      @group(0) @binding(0) var inTexture: texture_2d<f32>;
      @group(0) @binding(1) var inSampler: sampler;
      @group(0) @binding(2) var<uniform> imgSize: vec2f;
      
      @fragment
      fn fragmentMain(@builtin(position) fragCoord: vec4f) -> @location(0) vec4f {
        let uv = fragCoord.xy / imgSize; // vec2f(textureDimensions(inTexture, 0));
        return textureSample(inTexture, inSampler, uv);
      }
      `});this._outputSizeBuffer=this._device.createBuffer({label:"Ray Tracer output size buffer",size:8,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._pipeline=this._device.createRenderPipeline({label:"Ray Tracer Pipeline",layout:"auto",vertex:{module:this._shaderModule,entryPoint:"vertexMain",},fragment:{module:this._shaderModule,entryPoint:"fragmentMain",targets:[{format:this._canvasFormat}]}});this._sampler=this._device.createSampler({label:"Ray Tracer Sampler",magFilter:"linear",minFilter:"linear"});this.resizeCanvas();window.addEventListener('resize',this.resizeCanvas.bind(this));}
resizeCanvas(){const devicePixelRatio=window.devicePixelRatio||1;const width=window.innerWidth*devicePixelRatio;const height=window.innerHeight*devicePixelRatio;const ratio=width/height;const tgtHeight=height;let imgSize={width:tgtHeight*ratio,height:tgtHeight};this._offScreenTexture=this._device.createTexture({size:imgSize,format:this._canvasFormat,usage:GPUTextureUsage.TEXTURE_BINDING|GPUTextureUsage.STORAGE_BINDING,});if(this._tracer){this._tracer._imgWidth=this._offScreenTexture.width;this._tracer._imgHeight=this._offScreenTexture.height;this._tracer.updateGeometry();this._tracer.createBindGroup(this._offScreenTexture);}
this._bindGroup=this._device.createBindGroup({label:"Ray Tracer Renderer Bind Group",layout:this._pipeline.getBindGroupLayout(0),entries:[{binding:0,resource:this._offScreenTexture.createView()},{binding:1,resource:this._sampler},{binding:2,resource:{buffer:this._outputSizeBuffer}}],});super.resizeCanvas();this._device.queue.writeBuffer(this._outputSizeBuffer,0,new Float32Array([width,height]));}
async setTracerObject(obj){await obj.init();obj._imgWidth=this._offScreenTexture.width;obj._imgHeight=this._offScreenTexture.height;obj.updateGeometry();this._tracer=obj;this._tracer.createBindGroup(this._offScreenTexture);}
render(){if(this._tracer){let encoder=this._device.createCommandEncoder();const computePass=encoder.beginComputePass();this._tracer.compute(computePass);computePass.end();this._device.queue.submit([encoder.finish()]);}
let encoder=this._device.createCommandEncoder();const pass=encoder.beginRenderPass({colorAttachments:[{view:this._context.getCurrentTexture().createView(),clearValue:this._clearColor,loadOp:"clear",storeOp:"store",}]});pass.setPipeline(this._pipeline);pass.setBindGroup(0,this._bindGroup);pass.draw(6);pass.end();this._device.queue.submit([encoder.finish()]);}};class SceneObject{static _objectCnt=0;constructor(device,canvasFormat){if(this.constructor==SceneObject){throw new Error("Abstract classes can't be instantiated.");}
this._device=device;this._canvasFormat=canvasFormat;SceneObject._objectCnt+=1;}
getName(){return this.constructor.name+" "+SceneObject._objectCnt.toString();}
async init(){await this.createGeometry();await this.createShaders();await this.createRenderPipeline();await this.createComputePipeline();}
async createGeometry(){throw new Error("Method 'createGeometry()' must be implemented.");}
updateGeometry(){}
loadShader(filename){return new Promise((resolve,reject)=>{const xhttp=new XMLHttpRequest();xhttp.open("GET",filename);xhttp.setRequestHeader("Cache-Control","no-cache, no-store, max-age=0");xhttp.onload=function(){if(xhttp.readyState===XMLHttpRequest.DONE&&xhttp.status===200){resolve(xhttp.responseText);}
else{reject({status:xhttp.status,statusText:xhttp.statusText});}};xhttp.onerror=function(){reject({status:xhttp.status,statusText:xhttp.statusText});};xhttp.send();});}
async createShaders(){throw new Error("Method 'createShaders()' must be implemented.");}
async createRenderPipeline(){throw new Error("Method 'createRenderPipeline()' must be implemented.");}
render(pass){throw new Error("Method 'render(pass)' must be implemented.");}
async createComputePipeline(){throw new Error("Method 'createComputePipeline()' must be implemented.");}
compute(pass){throw new Error("Method 'compute(pass)' must be implemented.");}}
class RayTracingObject extends SceneObject{async createGeometry(){}
async createShaders(){let shaderCode=await this.loadShader("/shaders/optimized_tracenothing.wgsl");this._shaderModule=this._device.createShaderModule({label:" Shader "+this.getName(),code:shaderCode,});}
updateGeometry(){}
async createRenderPipeline(){}
render(pass){}
async createComputePipeline(){this._computePipeline=this._device.createComputePipeline({label:"Ray Tracing Pipeline "+this.getName(),layout:"auto",compute:{module:this._shaderModule,entryPoint:"computeMain",}});}
createBindGroup(outTexture){this._bindGroup=this._device.createBindGroup({label:"Ray Tracing Bind Group",layout:this._computePipeline.getBindGroupLayout(0),entries:[{binding:0,resource:outTexture.createView()}],});this._wgWidth=Math.ceil(outTexture.width);this._wgHeight=Math.ceil(outTexture.height);}
compute(pass){pass.setPipeline(this._computePipeline);pass.setBindGroup(0,this._bindGroup);pass.dispatchWorkgroups(Math.ceil(this._wgWidth/16),Math.ceil(this._wgHeight/16));}}
class VolumeByteIO{constructor(){}
static readBinary(filename){return new Promise((resolve,reject)=>{const xhttp=new XMLHttpRequest();xhttp.open("GET",filename);xhttp.setRequestHeader("Cache-Control","no-cache, no-store, max-age=0");xhttp.responseType='arraybuffer';xhttp.onload=function(){if(xhttp.readyState===XMLHttpRequest.DONE&&xhttp.status===200){resolve(xhttp.response);}
else{reject(new Error('Error loading volume byte data: '+xhttp.status));}}
xhttp.onerror=function(){reject(new Error('Network error loading volume byte data'));}
xhttp.send();});}
static readBytes(view,offset,isLittle,type){switch(type){case'char':return[view.getInt8(offset,1)];break;case'uchar':return[view.getUint8(offset,1)];break;case'short':return[view.getInt16(offset,isLittle),2];break;case'ushort':return[view.getUint16(offset,isLittle),2];break;case'int':return[view.getInt32(offset,isLittle),4];break;case'uint':return[view.getUint32(offset,isLittle),4];break;case'float':return[view.getFloat32(offset,isLittle),4];break;case'double':return[view.getFloat64(offset,isLittle),8];break;}}
static async read(filename){let binarydata=await VolumeByteIO.readBinary(filename);let text=new TextDecoder().decode(binarydata);const dims=[181,217,181];const sizes=[1,1,1];const data=[];let offset=0;let view=new DataView(binarydata);for(let i=0;i<dims.reduce((s,val)=>s*val,1);++i){const[value,delta]=VolumeByteIO.readBytes(view,offset,true,'short');data.push(value);offset+=delta;}
return[dims,sizes,data];}
static isLittleEndian(){const buffer=new ArrayBuffer(2);const view=new DataView(buffer);view.setInt16(0,256,true);return view.getInt8(0)===0;}
static async write(volume,filename){const volumeData=new Uint8Array(volume.data.length*2);volume.data.forEach((value,index)=>{const view=new Uint16Array([value]);volumeData.set(new Uint8Array(view.buffer),index*2);});const blob=new Blob([volumeData],{type:'application/octet-stream'});const a=document.createElement('a');a.href=URL.createObjectURL(blob);a.download='download.raws';a.click();URL.revokeObjectURL(a.href);}}
class VolumeData{constructor(filename){this._filename=filename;}
async init(){const[dims,sizes,data]=await VolumeByteIO.read(this._filename);this._dims=dims;this._sizes=sizes;this._data=data;}}
class VolumeRenderingSimpleObject extends RayTracingObject{constructor(device,canvasFormat,camera,useTrilinear){super(device,canvasFormat);this._volume=new VolumeData('/assets/brainweb-t1-1mm-pn0-rf0.raws');this._camera=camera;this._traceType=3;this._useTrilinear=useTrilinear;this._useLighting=1;this._tissueColors={boneBoundary:[0.96,0.91,0.86],boneInterior:[0.92,0.86,0.78],whiteMatterBoundary:[0.95,0.62,0.55],whiteMatterInterior:[0.92,0.58,0.52],grayMatterBoundary:[0.89,0.55,0.50],grayMatterInterior:[0.85,0.48,0.45],csf:[0.90,0.65,0.60]};}
setTraceType(traceType){this._traceType=traceType;this._device.queue.writeBuffer(this._traceTypeBuffer,0,new Uint32Array([this._traceType]));}
setUseTrilinear(useTrilinear){this._useTrilinear=useTrilinear?1:0;if(this._useTrilinearBuffer){this._device.queue.writeBuffer(this._useTrilinearBuffer,0,new Uint32Array([this._useTrilinear]));}}
setUseLighting(useLighting){this._useLighting=useLighting?1:0;if(this._useLightingBuffer){this._device.queue.writeBuffer(this._useLightingBuffer,0,new Uint32Array([this._useLighting]));}}
updateTissueColor(tissueType,color){switch(tissueType){case'boneBoundary':this._tissueColors.boneBoundary=color;break;case'boneInterior':this._tissueColors.boneInterior=color;break;case'whiteMatterBoundary':this._tissueColors.whiteMatterBoundary=color;break;case'whiteMatterInterior':this._tissueColors.whiteMatterInterior=color;break;case'grayMatterBoundary':this._tissueColors.grayMatterBoundary=color;break;case'grayMatterInterior':this._tissueColors.grayMatterInterior=color;break;case'csf':this._tissueColors.csf=color;break;}
this.updateTissueColorsBuffer();}
updateTissueColorsBuffer(){if(!this._tissueColorsBuffer)return;const tissueColorsArray=new Float32Array([...this._tissueColors.boneBoundary,0,...this._tissueColors.boneInterior,0,...this._tissueColors.whiteMatterBoundary,0,...this._tissueColors.whiteMatterInterior,0,...this._tissueColors.grayMatterBoundary,0,...this._tissueColors.grayMatterInterior,0,...this._tissueColors.csf,0,]);this._device.queue.writeBuffer(this._tissueColorsBuffer,0,tissueColorsArray);}
async createGeometry(){await this._volume.init();this._cameraBuffer=this._device.createBuffer({label:"Camera "+this.getName(),size:this._camera._pose.byteLength+this._camera._focal.byteLength+this._camera._resolutions.byteLength,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._device.queue.writeBuffer(this._cameraBuffer,0,this._camera._pose);this._device.queue.writeBuffer(this._cameraBuffer,this._camera._pose.byteLength,this._camera._focal);this._device.queue.writeBuffer(this._cameraBuffer,this._camera._pose.byteLength+this._camera._focal.byteLength,this._camera._resolutions);this._volumeBuffer=this._device.createBuffer({label:"Volume "+this.getName(),size:(this._volume._dims.length+this._volume._sizes.length+2)*Float32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._device.queue.writeBuffer(this._volumeBuffer,0,new Float32Array([...this._volume._dims,0,...this._volume._sizes,0]));this._dataBuffer=this._device.createBuffer({label:"Data "+this.getName(),size:this._volume._data.length*Float32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.STORAGE|GPUBufferUsage.COPY_DST,});this._traceTypeBuffer=this._device.createBuffer({label:"TraceType "+this.getName(),size:Uint32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._device.queue.writeBuffer(this._traceTypeBuffer,0,new Uint32Array([this._traceType]));this._materialBuffer=this._device.createBuffer({label:"Material "+this.getName(),size:16,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._lightBuffer=this._device.createBuffer({label:"Light "+this.getName(),size:8*Float32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});const lightParams=new Float32Array([0.0,0.0,-2.0,0.8,1.0,1.0,1.0,0.0]);this._device.queue.writeBuffer(this._lightBuffer,0,lightParams);this._useTrilinearBuffer=this._device.createBuffer({label:"UseTrilinear "+this.getName(),size:Uint32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._device.queue.writeBuffer(this._useTrilinearBuffer,0,new Uint32Array([this._useTrilinear?1:0]));this._tissueColorsBuffer=this._device.createBuffer({label:"TissueColors "+this.getName(),size:28*Float32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this.updateTissueColorsBuffer();this._useLightingBuffer=this._device.createBuffer({label:"UseLighting "+this.getName(),size:Uint32Array.BYTES_PER_ELEMENT,usage:GPUBufferUsage.UNIFORM|GPUBufferUsage.COPY_DST,});this._device.queue.writeBuffer(this._useLightingBuffer,0,new Uint32Array([this._useLighting]));this._device.queue.writeBuffer(this._dataBuffer,0,new Float32Array(this._volume._data));}
updateGeometry(){this._camera.updateSize(this._imgWidth,this._imgHeight);this._device.queue.writeBuffer(this._cameraBuffer,this._camera._pose.byteLength+this._camera._focal.byteLength,this._camera._resolutions);}
updateCameraPose(){this._device.queue.writeBuffer(this._cameraBuffer,0,this._camera._pose);}
updateCameraFocal(){this._device.queue.writeBuffer(this._cameraBuffer,this._camera._pose.byteLength,this._camera._focal);}
async createShaders(){let shaderCode=await this.loadShader("/shaders/optimized_tracevolumesimple.wgsl");this._shaderModule=this._device.createShaderModule({label:" Shader "+this.getName(),code:shaderCode,});this._bindGroupLayout=this._device.createBindGroupLayout({label:"Ray Trace Volume Layout "+this.getName(),entries:[{binding:0,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:1,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:2,visibility:GPUShaderStage.COMPUTE,buffer:{type:"read-only-storage"}},{binding:3,visibility:GPUShaderStage.COMPUTE,storageTexture:{format:this._canvasFormat}},{binding:4,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:5,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:6,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:7,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:8,visibility:GPUShaderStage.COMPUTE,buffer:{}},{binding:9,visibility:GPUShaderStage.COMPUTE,buffer:{}}]});this._pipelineLayout=this._device.createPipelineLayout({label:"Ray Trace Volume Pipeline Layout",bindGroupLayouts:[this._bindGroupLayout],});}
async createComputePipeline(){this._computePipeline=this._device.createComputePipeline({label:"Ray Trace Volume Orthogonal Pipeline "+this.getName(),layout:this._pipelineLayout,compute:{module:this._shaderModule,entryPoint:"computeOrthogonalMain",}});this._computeProjectivePipeline=this._device.createComputePipeline({label:"Ray Trace Volume Projective Pipeline "+this.getName(),layout:this._pipelineLayout,compute:{module:this._shaderModule,entryPoint:"computeProjectiveMain",}});}
createBindGroup(outTexture){this._bindGroup=this._device.createBindGroup({label:"Ray Trace Volume Bind Group",layout:this._computePipeline.getBindGroupLayout(0),entries:[{binding:0,resource:{buffer:this._cameraBuffer}},{binding:1,resource:{buffer:this._volumeBuffer}},{binding:2,resource:{buffer:this._dataBuffer}},{binding:3,resource:outTexture.createView()},{binding:4,resource:{buffer:this._traceTypeBuffer}},{binding:5,resource:{buffer:this._materialBuffer}},{binding:6,resource:{buffer:this._lightBuffer}},{binding:7,resource:{buffer:this._useTrilinearBuffer}},{binding:8,resource:{buffer:this._tissueColorsBuffer}},{binding:9,resource:{buffer:this._useLightingBuffer}}],});this._wgWidth=Math.ceil(outTexture.width);this._wgHeight=Math.ceil(outTexture.height);}
compute(pass){if(this._camera?._isProjective){pass.setPipeline(this._computeProjectivePipeline);}
else{pass.setPipeline(this._computePipeline);}
pass.setBindGroup(0,this._bindGroup);pass.dispatchWorkgroups(Math.ceil(this._wgWidth/16),Math.ceil(this._wgHeight/16));}};class PGA3D{static geometricProduct(a,b){return[a[0]*b[0]-a[1]*b[1]-a[2]*b[2]-a[3]*b[3]-a[7]*b[7]+a[11]*b[11]+a[12]*b[12]+a[13]*b[13],a[0]*b[1]+a[1]*b[0]-a[2]*b[3]+a[3]*b[2]+a[7]*b[13]+a[11]*b[12]-a[12]*b[11]+a[13]*b[7],a[0]*b[2]+a[1]*b[3]+a[2]*b[0]-a[3]*b[1]-a[7]*b[12]+a[11]*b[13]-a[12]*b[7]-a[13]*b[11],a[0]*b[3]-a[1]*b[2]+a[2]*b[1]+a[3]*b[0]+a[7]*b[11]+a[11]*b[7]+a[12]*b[13]-a[13]*b[12],a[0]*b[4]+a[1]*b[5]+a[2]*b[6]-a[3]*b[15]+a[4]*b[0]-a[5]*b[1]-a[6]*b[2]+a[7]*b[10]+a[8]*b[12]+a[9]*b[13]-a[10]*b[7]-a[11]*b[14]+a[12]*b[8]+a[13]*b[9]+a[14]*b[11]-a[15]*b[3],a[0]*b[5]-a[1]*b[4]+a[2]*b[15]+a[3]*b[6]+a[4]*b[1]+a[5]*b[0]-a[6]*b[3]-a[7]*b[9]-a[8]*b[11]+a[9]*b[7]+a[10]*b[12]-a[11]*b[8]-a[12]*b[14]+a[13]*b[10]+a[14]*b[12]+a[15]*b[2],a[0]*b[6]-a[1]*b[15]-a[2]*b[4]-a[3]*b[5]+a[4]*b[2]+a[5]*b[3]+a[6]*b[0]+a[7]*b[8]-a[8]*b[7]-a[9]*b[11]-a[10]*b[12]-a[11]*b[9]-a[12]*b[10]-a[13]*b[14]+a[14]*b[13]-a[15]*b[1],a[0]*b[7]+a[1]*b[13]-a[2]*b[12]+a[3]*b[11]+a[7]*b[0]+a[11]*b[3]-a[12]*b[2]+a[13]*b[1],a[0]*b[8]+a[1]*b[14]-a[2]*b[10]+a[3]*b[9]+a[4]*b[12]-a[5]*b[11]+a[6]*b[7]-a[7]*b[6]+a[8]*b[0]-a[9]*b[3]+a[10]*b[2]-a[11]*b[5]+a[12]*b[4]-a[13]*b[15]+a[14]*b[1]+a[15]*b[13],a[0]*b[9]+a[1]*b[10]+a[2]*b[14]-a[3]*b[8]+a[4]*b[13]-a[5]*b[7]-a[6]*b[11]+a[7]*b[5]+a[8]*b[3]+a[9]*b[0]-a[10]*b[1]-a[11]*b[6]+a[12]*b[15]+a[13]*b[4]+a[14]*b[2]-a[15]*b[12],a[0]*b[10]-a[1]*b[9]+a[2]*b[8]+a[3]*b[14]+a[4]*b[7]+a[5]*b[13]-a[6]*b[12]-a[7]*b[4]-a[8]*b[2]+a[9]*b[1]+a[10]*b[0]-a[11]*b[15]-a[12]*b[6]+a[13]*b[5]+a[14]*b[3]+a[15]*b[11],a[0]*b[11]+a[1]*b[12]+a[2]*b[13]-a[3]*b[7]-a[7]*b[3]+a[11]*b[0]-a[12]*b[1]-a[13]*b[2],a[0]*b[12]-a[1]*b[11]+a[2]*b[7]+a[3]*b[13]+a[7]*b[2]+a[11]*b[1]+a[12]*b[0]-a[13]*b[3],a[0]*b[13]-a[1]*b[7]-a[2]*b[11]-a[3]*b[12]-a[7]*b[1]+a[11]*b[2]+a[12]*b[3]+a[13]*b[0],a[0]*b[14]-a[1]*b[8]-a[2]*b[9]-a[3]*b[10]+a[4]*b[11]+a[5]*b[12]+a[6]*b[13]+a[7]*b[15]-a[8]*b[1]-a[9]*b[2]-a[10]*b[3]-a[11]*b[4]-a[12]*b[5]-a[13]*b[6]+a[14]*b[0]-a[15]*b[7],a[0]*b[15]+a[1]*b[6]-a[2]*b[5]+a[3]*b[4]+a[4]*b[3]-a[5]*b[2]+a[6]*b[1]-a[7]*b[14]+a[8]*b[13]-a[9]*b[12]+a[10]*b[11]-a[11]*b[10]+a[12]*b[9]-a[13]*b[8]+a[14]*b[7]+a[15]*b[0],];}
static reverse(a){return[a[0],-a[1],-a[2],-a[3],-a[4],-a[5],-a[6],-a[7],-a[8],-a[9],-a[10],a[11],a[12],a[13],a[14],a[15]];}
static applyMotor(p,m){return PGA3D.geometricProduct(m,PGA3D.geometricProduct(p,PGA3D.reverse(m)));}
static motorNorm(m){return Math.sqrt(m.map(val=>val*val).reduce((s,val)=>s+val,0));}
static createTranslator(dx,dy,dz){return[1,0,0,0,-dx/2,-dy/2,-dz/2,0,0,0,0,0,0,0,0,0];}
static extractTranslator(m){return[1,0,0,0,m[4],m[5],m[6],0,0,0,0,0,0,0,0,0];}
static createRotor(angle,dx=1,dy=0,dz=0,sx=0,sy=0,sz=0){let c=Math.cos(angle/2);let s=Math.sin(angle/2);let L=PGA3D.createLine(sx,sy,sz,dx,dy,dz);return[c,s*L[1],s*L[2],s*L[3],s*L[4],s*L[5],s*L[6],0,0,0,0,0,0,0,0,0];}
static extractRotor(m){return[m[0],m[1],m[2],m[3],0,0,0,0,0,0,0,0,0,0,0,0];}
static createDir(dx,dy,dz){return[0,dz,-dy,dx,0,0,0,0,0,0,0,0,0,0,0,0];}
static createLine(sx,sy,sz,dx,dy,dz){let n=PGA3D.createDir(dx,dy,dz);let dir=PGA3D.normalizeMotor(n);return[0,dir[1],dir[2],dir[3],-(-dir[2]*sz-dir[1]*sy),-(dir[1]*sx-dir[3]*sz),-(dir[3]*sy+dir[2]*sx),0,0,0,0,0,0,0,0,0];}
static createPoint(x,y,z){return[0,0,0,0,0,0,0,1,-z,y,-x,0,0,0,0,0];}
static extractPoint(p){return[-p[10]/p[7],p[9]/p[7],-p[8]/p[7]];}
static createPlane(nx,ny,nz,d){return[0,0,0,0,0,0,0,0,0,0,0,nx,ny,nz,-d,0];}
static createPlaneFromPoints(p1,p2,p3){let nx=(p2[1]*p3[2]-p3[1]*p2[2])-(p1[1]*p3[2]-p3[1]*p1[2])+(p1[1]*p2[2]-p2[1]*p1[2]);let ny=(p2[0]*p3[2]-p3[0]*p2[2])-(p1[0]*p3[2]-p3[0]*p1[2])+(p1[0]*p2[2]-p2[0]*p1[2]);let nz=(p2[0]*p3[1]-p3[0]*p2[1])-(p1[0]*p3[1]-p3[0]*p1[1])+(p1[0]*p2[1]-p2[0]*p1[1]);let d=(p1[0]*(p2[1]*p3[2]-p3[1]*p2[2])-p2[0]*(p1[1]*p3[2]-p3[1]*p1[2])+p3[0]*(p1[1]*p2[2]-p2[1]*p1[2]));return PGA3D.createPlane(nx,-ny,nz,d);}
static linePlaneIntersection(L,P){let new_p=PGA3D.geometricProduct(L,P);let isParallel=(Math.abs(new_p[7])<=0.00000001);let inPlane=isParallel&&(Math.abs(new_p[8])<=0.00000001)&&(Math.abs(new_p[9])<=0.00000001)&&(Math.abs(new_p[10])<=0.00000001);return[PGA3D.extractPoint(new_p),!isParallel,inPlane];}
static normalizeMotor(m){let mnorm=PGA3D.motorNorm(m);if(mnorm==0.0){return[1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0];}
return m.map(val=>val/mnorm);}
static applyMotorToPoint(p,m){let new_p=PGA3D.applyMotor(PGA3D.createPoint(p[0],p[1],p[2]),m);return PGA3D.extractPoint(new_p);};static applyMotorToDir(d,m){let r=PGA3D.extractRotor(m);let new_d=PGA3D.applyMotor(PGA3D.createPoint(d[0],d[1],d[2]),r);return PGA3D.extractPoint(new_d);}
static isInside(v0,v1,v2,p){let pga0=PGA3D.createPoint(v0[0],v0[1],v0[2]);let pga1=PGA3D.createPoint(v1[0],v1[1],v1[2]);let pga2=PGA3D.createPoint(v2[0],v2[1],v2[2]);let pgap=PGA3D.createPoint(p[0],p[1],p[2]);let plane012=PGA3D.createPlaneFromPoints(v0,v1,v2);let planep12=PGA3D.createPlaneFromPoints(p,v1,v2);let plane0p2=PGA3D.createPlaneFromPoints(v0,p,v2);let plane01p=PGA3D.createPlaneFromPoints(v0,v1,p);let area012=plane012[11]*plane012[11]+plane012[12]*plane012[12]+plane012[13]*plane012[13]+plane012[14]*plane012[14];let areap12=plane012[11]*planep12[11]+plane012[12]*planep12[12]+plane012[13]*planep12[13]+plane012[14]*planep12[14];let area0p2=plane012[11]*plane0p2[11]+plane012[12]*plane0p2[12]+plane012[13]*plane0p2[13]+plane012[14]*plane0p2[14];let area01p=plane012[11]*plane01p[11]+plane012[12]*plane01p[12]+plane012[13]*plane01p[13]+plane012[14]*plane01p[14];let lambda1=areap12/area012;let lambda2=area0p2/area012;let lambda3=area01p/area012;return lambda1>=0&&lambda1<=1&&lambda2>=0&&lambda2<=1&&lambda3>=0&&lambda3<=1;}}
class Camera{constructor(width,height){this._pose=new Float32Array(Array(16).fill(0));this._pose[0]=1;this._focal=new Float32Array(Array(2).fill(0.25));this._resolutions=new Float32Array([width,height]);}
resetPose(){this._pose[0]=1;for(let i=1;i<16;++i)this._pose[i]=0;this._focal[0]=1;this._focal[1]=1;}
updatePose(newpose){for(let i=0;i<16;++i)this._pose[i]=newpose[i];}
updateSize(width,height){this._resolutions[0]=width;this._resolutions[1]=height;}
moveX(d){const worldX=PGA3D.applyMotorToDir([1,0,0],this._pose);const dx=worldX[0]*d;const dy=worldX[1]*d;const dz=worldX[2]*d;const translator=PGA3D.createTranslator(dx,dy,dz);let newpose=PGA3D.geometricProduct(translator,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}
moveY(d){const worldX=PGA3D.applyMotorToDir([0,1,0],this._pose);const dx=worldX[0]*d;const dy=worldX[1]*d;const dz=worldX[2]*d;const translator=PGA3D.createTranslator(dx,dy,dz);let newpose=PGA3D.geometricProduct(translator,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}
moveZ(d){const worldZ=PGA3D.applyMotorToDir([0,0,1],this._pose);const dx=worldZ[0]*d;const dy=worldZ[1]*d;const dz=worldZ[2]*d;const translator=PGA3D.createTranslator(dx,dy,dz);let newpose=PGA3D.geometricProduct(translator,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}
rotateX(d){const camPos=PGA3D.applyMotorToPoint([0,0,0],this._pose);const axisX=PGA3D.applyMotorToDir([1,0,0],this._pose);const rotor=PGA3D.createRotor(d,axisX[0],axisX[1],axisX[2],camPos[0],camPos[1],camPos[2]);let newpose=PGA3D.geometricProduct(rotor,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}
rotateY(d){const camPos=PGA3D.applyMotorToPoint([0,0,0],this._pose);const axisY=PGA3D.applyMotorToDir([0,1,0],this._pose);const rotor=PGA3D.createRotor(d,axisY[0],axisY[1],axisY[2],camPos[0],camPos[1],camPos[2]);let newpose=PGA3D.geometricProduct(rotor,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}
rotateZ(d){const camPos=PGA3D.applyMotorToPoint([0,0,0],this._pose);const axisZ=PGA3D.applyMotorToDir([0,0,1],this._pose);const rotor=PGA3D.createRotor(d,axisZ[0],axisZ[1],axisZ[2],camPos[0],camPos[1],camPos[2]);let newpose=PGA3D.geometricProduct(rotor,this._pose);newpose=PGA3D.normalizeMotor(newpose);this.updatePose(newpose);}};export function createCanvas(){const canvasTag=document.createElement('canvas');canvasTag.id="renderCanvas";document.body.appendChild(canvasTag);return canvasTag;};export function createUIControls(){const controlsDiv=document.createElement("div");controlsDiv.style.position="absolute";controlsDiv.style.top="50px";controlsDiv.style.left="10px";controlsDiv.style.padding="15px";controlsDiv.style.borderRadius="8px";controlsDiv.style.background="rgba(40, 44, 52, 0.85)";controlsDiv.style.border="1px solid #4A90E2";controlsDiv.style.boxShadow="0 4px 8px rgba(0, 0, 0, 0.5)";controlsDiv.style.fontFamily="'Roboto', 'Segoe UI', sans-serif";controlsDiv.style.color="#E9E9E9";controlsDiv.style.width="260px";controlsDiv.style.backdropFilter="blur(5px)";controlsDiv.style.zIndex="1000";controlsDiv.innerHTML=`
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
      <div class="input-row">
        <label for="use-lighting">Lighting:</label>
        <input type="checkbox" id="use-lighting" checked>
        <span class="value-display" id="use-lighting-value">on</span>
      </div>
    </div>
  `;document.body.appendChild(controlsDiv);const minimizeButton=document.createElement("button");minimizeButton.innerHTML="−";minimizeButton.style.position="absolute";minimizeButton.style.top="8px";minimizeButton.style.right="8px";minimizeButton.style.padding="0 5px";minimizeButton.style.fontSize="16px";minimizeButton.style.lineHeight="20px";minimizeButton.style.width="24px";minimizeButton.style.height="24px";minimizeButton.style.borderRadius="4px";minimizeButton.style.background="transparent";minimizeButton.style.border="none";minimizeButton.style.cursor="pointer";minimizeButton.style.color="#4A90E2";const allSections=controlsDiv.querySelectorAll('.control-section');let minimized=false;minimizeButton.addEventListener("click",()=>{if(minimized){allSections.forEach(section=>section.style.display="block");minimizeButton.innerHTML="−";}else{allSections.forEach(section=>section.style.display="none");minimizeButton.innerHTML="+";}
minimized=!minimized;});controlsDiv.appendChild(minimizeButton);return controlsDiv;}
export function setupCameraControls(camera,tracerObj,moveStep=0.05,rotateStep=0.1){document.getElementById("btnForward").addEventListener("click",()=>{camera.moveZ(-moveStep);tracerObj.updateCameraPose();});document.getElementById("btnBackward").addEventListener("click",()=>{camera.moveZ(moveStep);tracerObj.updateCameraPose();});document.getElementById("btnLeft").addEventListener("click",()=>{camera.moveX(-moveStep);tracerObj.updateCameraPose();});document.getElementById("btnRight").addEventListener("click",()=>{camera.moveX(moveStep);tracerObj.updateCameraPose();});document.getElementById("btnUp").addEventListener("click",()=>{camera.moveY(moveStep);tracerObj.updateCameraPose();});document.getElementById("btnDown").addEventListener("click",()=>{camera.moveY(-moveStep);tracerObj.updateCameraPose();});document.getElementById("btnRotXPos").addEventListener("click",()=>{camera.rotateX(rotateStep);tracerObj.updateCameraPose();});document.getElementById("btnRotXNeg").addEventListener("click",()=>{camera.rotateX(-rotateStep);tracerObj.updateCameraPose();});document.getElementById("btnRotYPos").addEventListener("click",()=>{camera.rotateY(rotateStep);tracerObj.updateCameraPose();});document.getElementById("btnRotYNeg").addEventListener("click",()=>{camera.rotateY(-rotateStep);tracerObj.updateCameraPose();});document.getElementById("btnRotZPos").addEventListener("click",()=>{camera.rotateZ(rotateStep);tracerObj.updateCameraPose();});document.getElementById("btnRotZNeg").addEventListener("click",()=>{camera.rotateZ(-rotateStep);tracerObj.updateCameraPose();});}
export function setupTraceTypeControls(tracerObj){tracerObj.setTraceType(1);}
export function setupLightControls(volumeObj){const lx=document.getElementById('light-x');const ly=document.getElementById('light-y');const lz=document.getElementById('light-z');const lint=document.getElementById('light-intensity');const lxVal=document.getElementById('light-x-value');const lyVal=document.getElementById('light-y-value');const lzVal=document.getElementById('light-z-value');const lintVal=document.getElementById('light-intensity-value');lxVal.textContent=lx.value;lyVal.textContent=ly.value;lzVal.textContent=lz.value;lintVal.textContent=lint.value;function updateLight(){const lightParams=new Float32Array([parseFloat(lx.value),parseFloat(ly.value),parseFloat(lz.value),parseFloat(lint.value),1.0,1.0,1.0,0.0]);lxVal.textContent=parseFloat(lx.value).toFixed(1);lyVal.textContent=parseFloat(ly.value).toFixed(1);lzVal.textContent=parseFloat(lz.value).toFixed(1);lintVal.textContent=parseFloat(lint.value).toFixed(1);volumeObj._device.queue.writeBuffer(volumeObj._lightBuffer,0,lightParams);}
[lx,ly,lz,lint].forEach(ctrl=>ctrl.addEventListener('input',updateLight));}
export function setupInterpolationControls(volumeObj){const useTrilinearCheckbox=document.getElementById('use-trilinear');const useTrilinearValue=document.getElementById('use-trilinear-value');useTrilinearCheckbox.checked=true;useTrilinearValue.textContent=useTrilinearCheckbox.checked?"on":"off";volumeObj.setUseTrilinear(useTrilinearCheckbox.checked);useTrilinearCheckbox.addEventListener('change',()=>{useTrilinearValue.textContent=useTrilinearCheckbox.checked?"on":"off";volumeObj.setUseTrilinear(useTrilinearCheckbox.checked);});}
export function setupLightingControls(volumeObj){const useLightingCheckbox=document.getElementById('use-lighting');const useLightingValue=document.getElementById('use-lighting-value');useLightingCheckbox.checked=true;useLightingValue.textContent=useLightingCheckbox.checked?"on":"off";volumeObj.setUseLighting(useLightingCheckbox.checked);useLightingCheckbox.addEventListener('change',()=>{useLightingValue.textContent=useLightingCheckbox.checked?"on":"off";volumeObj.setUseLighting(useLightingCheckbox.checked);});}
export function setupTissueColorControls(volumeObj){const controlsDiv=document.querySelector('div[style*="position: absolute"]');const tissueSection=document.createElement('div');tissueSection.className='control-section';tissueSection.innerHTML=`
    <h3>Tissue Colors</h3>
    <div class="tissue-colors">
      <div class="color-picker-row">
        <label for="bone-boundary-color">Bone Boundary:</label>
        <input type="color" id="bone-boundary-color" value="#f5e8db">
        <div class="color-preview" id="bone-boundary-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="bone-interior-color">Bone Interior:</label>
        <input type="color" id="bone-interior-color" value="#ebdbc7">
        <div class="color-preview" id="bone-interior-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="white-matter-boundary-color">White Matter Boundary:</label>
        <input type="color" id="white-matter-boundary-color" value="#f29e8c">
        <div class="color-preview" id="white-matter-boundary-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="white-matter-interior-color">White Matter Interior:</label>
        <input type="color" id="white-matter-interior-color" value="#eb9485">
        <div class="color-preview" id="white-matter-interior-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="gray-matter-boundary-color">Gray Matter Boundary:</label>
        <input type="color" id="gray-matter-boundary-color" value="#e38c80">
        <div class="color-preview" id="gray-matter-boundary-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="gray-matter-interior-color">Gray Matter Interior:</label>
        <input type="color" id="gray-matter-interior-color" value="#d87a73">
        <div class="color-preview" id="gray-matter-interior-preview"></div>
      </div>
      <div class="color-picker-row">
        <label for="csf-color">CSF & Other Tissues:</label>
        <input type="color" id="csf-color" value="#e6a699">
        <div class="color-preview" id="csf-preview"></div>
      </div>
    </div>
  `;const styleElement=document.createElement('style');styleElement.textContent=`
    .color-picker-row {
      display: flex;
      align-items: center;
      margin-bottom: 6px;
    }
    .color-picker-row label {
      width: 120px;
      font-size: 12px;
    }
    .color-picker-row input[type="color"] {
      width: 25px;
      height: 25px;
      border: none;
      padding: 0;
      background: none;
      cursor: pointer;
    }
    .color-preview {
      width: 20px;
      height: 20px;
      border-radius: 3px;
      margin-left: 5px;
      border: 1px solid #999;
    }
  `;document.head.appendChild(styleElement);controlsDiv.appendChild(tissueSection);function hexToRgb(hex){const result=/^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);return result?[parseInt(result[1],16)/255,parseInt(result[2],16)/255,parseInt(result[3],16)/255]:[1,1,1];}
function updatePreview(id,color){const preview=document.getElementById(id);preview.style.backgroundColor=color;}
const colorInputs={'bone-boundary-color':{id:'bone-boundary-preview',type:'boneBoundary'},'bone-interior-color':{id:'bone-interior-preview',type:'boneInterior'},'white-matter-boundary-color':{id:'white-matter-boundary-preview',type:'whiteMatterBoundary'},'white-matter-interior-color':{id:'white-matter-interior-preview',type:'whiteMatterInterior'},'gray-matter-boundary-color':{id:'gray-matter-boundary-preview',type:'grayMatterBoundary'},'gray-matter-interior-color':{id:'gray-matter-interior-preview',type:'grayMatterInterior'},'csf-color':{id:'csf-preview',type:'csf'}};Object.entries(colorInputs).forEach(([inputId,data])=>{const input=document.getElementById(inputId);updatePreview(data.id,input.value);input.addEventListener('input',()=>{updatePreview(data.id,input.value);});input.addEventListener('change',()=>{const rgbColor=hexToRgb(input.value);volumeObj.updateTissueColor(data.type,rgbColor);});});};class StandardTextObject{constructor(inputText,spacing=5,textFont='18px Arial'){this._textFont=textFont;this._lineSpacing=spacing;this._textCanvas=document.createElement('canvas');this._textContext=this._textCanvas.getContext('2d');this.updateTextRegion(inputText);this.updateText(inputText);this._textCanvas.style.position='absolute';this._textCanvas.style.top='10px';this._textCanvas.style.left='10px';this._textCanvas.style.border='1px solid red';document.body.appendChild(this._textCanvas);}
toggleVisibility(){this._textCanvas.hidden=!this._textCanvas.hidden;}
updateTextRegion(newText){this._textContext.font=this._textFont;this._lines=newText.split('\n');this._width=Math.max(...this._lines.map(line=>this._textContext.measureText(line).width));const match=this._textFont.match(/(\d+)px/);if(match){this._fontSize=parseInt(match[1],10);}
else{this._fontSize=18;this._textFont="18px Arial";}
this._height=this._lines.length*(this._fontSize+this._lineSpacing);this._paddingx=5;this._paddingtop=3;this._canvasWidth=Math.ceil(this._width+this._paddingx*2);this._canvasHeight=Math.ceil(this._height+this._paddingtop);this._textCanvas.width=this._canvasWidth;this._textCanvas.height=this._canvasHeight;this._textContext.font=this._textFont;this._textContext.textBaseline='top';}
updateText(newText){this._lines=newText.split('\n');this._textContext.fillStyle='rgba(1, 1, 1, 0.5)';this._textContext.clearRect(0,0,this._canvasWidth,this._canvasHeight);this._textContext.fillRect(0,0,this._canvasWidth,this._canvasHeight);this._textContext.fillStyle='white';this._lines.forEach((line,idx)=>{const x=this._paddingx;const y=this._paddingtop+idx*(this._fontSize+this._lineSpacing);this._textContext.fillText(line,x,y);});}};export function setupRenderLoop(tracer,targetFPS=60){let fps='??';const fpsText=new StandardTextObject('fps: '+fps);let frameCnt=0;const secPerFrame=1/targetFPS;const frameInterval=secPerFrame*1000;let lastCalled=Date.now();const renderFrame=()=>{let elapsed=Date.now()-lastCalled;if(elapsed>frameInterval){++frameCnt;lastCalled=Date.now()-(elapsed%frameInterval);tracer.render();}
requestAnimationFrame(renderFrame);};renderFrame();setInterval(()=>{fpsText.updateText('fps: '+frameCnt);frameCnt=0;},1000);return{fpsText,getFrameCount:()=>frameCnt};};export async function initApp(){const canvas=createCanvas();const tracer=new RayTracer(canvas);await tracer.init();const camera=new Camera();const tracerObj=new VolumeRenderingSimpleObject(tracer._device,tracer._canvasFormat,camera);await tracer.setTracerObject(tracerObj);createUIControls();const moveStep=0.05;const rotateStep=0.1;setupCameraControls(camera,tracerObj,moveStep,rotateStep);setupLightControls(tracerObj);setupTraceTypeControls(tracerObj);setupRenderLoop(tracer);setupInterpolationControls(tracerObj);setupTissueColorControls(tracerObj);setupLightingControls(tracerObj);return tracer;}
export function handleInitError(error){const pTag=document.createElement('p');pTag.innerHTML=navigator.userAgent+"</br>"+error.message;document.body.appendChild(pTag);const canvas=document.getElementById("renderCanvas");if(canvas){canvas.remove();}};initApp().then(tracer=>{console.log(tracer);}).catch(error=>{handleInitError(error);});