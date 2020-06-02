// RUN: mlir-translate -test-spirv-roundtrip %s | FileCheck %s

spv.module Logical GLSL450 requires #spv.vce<v1.0, [Shader], []> {
  // CHECK: !spv.ptr<!spv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var0 bind(0, 1) : !spv.ptr<!spv.image<f32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<si32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var1 bind(0, 2) : !spv.ptr<!spv.image<si32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var2 : !spv.ptr<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var3 : !spv.ptr<!spv.image<i32, Dim2D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Cube, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var4 : !spv.ptr<!spv.image<i32, Cube, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Buffer, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var5 : !spv.ptr<!spv.image<i32, Buffer, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, SubpassData, IsDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var6 : !spv.ptr<!spv.image<i32, SubpassData, IsDepth, NonArrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, SubpassData, DepthUnknown, Arrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var7 : !spv.ptr<!spv.image<i32, SubpassData, DepthUnknown, Arrayed, SingleSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, SubpassData, DepthUnknown, Arrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>
  spv.globalVariable @var8 : !spv.ptr<!spv.image<i32, SubpassData, DepthUnknown, Arrayed, MultiSampled, NoSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Buffer, DepthUnknown, Arrayed, MultiSampled, NeedSampler, Unknown>, UniformConstant>
  spv.globalVariable @var9 : !spv.ptr<!spv.image<i32, Buffer, DepthUnknown, Arrayed, MultiSampled, NeedSampler, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Dim3D, DepthUnknown, Arrayed, MultiSampled, SamplerUnknown, Unknown>, UniformConstant>
  spv.globalVariable @var10 : !spv.ptr<!spv.image<i32, Dim3D, DepthUnknown, Arrayed, MultiSampled, SamplerUnknown, Unknown>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Cube, DepthUnknown, Arrayed, MultiSampled, NoSampler, Rgb10A2>, UniformConstant>
  spv.globalVariable @var11 : !spv.ptr<!spv.image<i32, Cube, DepthUnknown, Arrayed, MultiSampled, NoSampler, Rgb10A2>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Rect, DepthUnknown, Arrayed, MultiSampled, NeedSampler, Rgb10A2>, UniformConstant>
  spv.globalVariable @var12 : !spv.ptr<!spv.image<i32, Rect, DepthUnknown, Arrayed, MultiSampled, NeedSampler, Rgb10A2>, UniformConstant>

  // CHECK: !spv.ptr<!spv.image<i32, Rect, DepthUnknown, Arrayed, MultiSampled, NeedSampler, R8ui>, UniformConstant>
  spv.globalVariable @var13 : !spv.ptr<!spv.image<i32, Rect, DepthUnknown, Arrayed, MultiSampled, NeedSampler, R8ui>, UniformConstant>
}