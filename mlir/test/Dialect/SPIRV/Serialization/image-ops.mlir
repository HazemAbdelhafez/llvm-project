// RUN: mlir-translate -test-spirv-roundtrip %s | FileCheck %s

spv.module Logical GLSL450 requires #spv.vce<v1.0, [Shader], []> {
  spv.func @image_sample_implicit_no_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> "None" {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    spv.ReturnValue %0: vector<4xi32>
  }
  spv.func @image_sample_implicit_bias_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> "None" {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} ["Bias", 23] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    spv.ReturnValue %0: vector<4xi32>
  }
  spv.func @image_sample_implicit_multiple_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> "None" {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} ["Bias|NonPrivateTexel|VolatileTexel", 23] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias|NonPrivateTexel|VolatileTexel", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    spv.ReturnValue %0: vector<4xi32>
  }
}