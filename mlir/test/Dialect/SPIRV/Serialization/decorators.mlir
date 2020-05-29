// RUN: mlir-translate -split-input-file -test-spirv-roundtrip %s | FileCheck %s

spv.module Logical GLSL450 requires #spv.vce<v1.0, [Shader], []> {
  // CHECK: spv.globalVariable {{@.*}} : !spv.ptr<vector<4xf32>, Input>
  spv.globalVariable @var1 {location = 0 : i32} : !spv.ptr<vector<4xf32>, Input>
}

// -----

spv.module Logical GLSL450 requires #spv.vce<v1.0, [Shader], []> {
  // CHECK: spv.globalVariable {{@.*}} : !spv.ptr<vector<4xf32>, Input>
  spv.globalVariable @var1 {location = 0 : i32, no_perspective} : !spv.ptr<vector<4xf32>, Input>
}

// -----

spv.module Logical GLSL450 requires #spv.vce<v1.0, [Shader], []> {
  // CHECK: spv.globalVariable {{@.*}} : !spv.ptr<si32, Input>
  spv.globalVariable @var2 {flat, location = 0 : i32} : !spv.ptr<si32, Input>
}

