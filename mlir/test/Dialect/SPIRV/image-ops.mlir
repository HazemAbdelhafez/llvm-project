// RUN: mlir-opt -split-input-file -verify-diagnostics %s | FileCheck %s

//===----------------------------------------------------------------------===//
// spv.ImageSampleImplicitLod
//===----------------------------------------------------------------------===//

func @image_sample_implicit_no_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_bias_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} ["Bias", 23] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_multiple_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} ["Bias|NonPrivateTexel|VolatileTexel", 23] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias|NonPrivateTexel|VolatileTexel", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    spv.ReturnValue %0: vector<4xi32>
}

// -----

func @image_sample_implicit_invalid_result_components_num(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<3xi32> {
    // expected-error @+1 {{number of components in result vector must be four}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<3xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<3xi32>
}

// -----

func @image_sample_implicit_mismatch_result_components_type(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xf32> {
    // expected-error @+1 {{component type of the result vector must match sampled type of the underlying image type if it is not void}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<4xf32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xf32>
}

// -----

func @image_sample_implicit_invalid_bias(%arg0 : !spv.sampledimage<!spv.image<i32, Rect, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{the underlying image type must have Dim (1D, 2D, 3D, Cube) when bias is specified}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Rect, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_invalid_bias(%arg0 : !spv.sampledimage<!spv.image<i32, Cube, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{the underlying image type must have SamplingInfo of SingleSampled when bias is specified}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 23]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Cube, NoDepth, NonArrayed, MultiSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_unknown_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{custom op 'spv.ImageSampleImplicitLod' invalid image_operands attribute specification: "Something"}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Something"]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_unknown_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{custom op 'spv.ImageSampleImplicitLod' invalid image_operands attribute specification: "Bias|Something"}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias|Something", 7]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_missing_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{expected ','}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias"]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_incorrect_attr(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // expected-error @+1 {{expected ']'}}
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 ["Bias", 4, 8]: vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}

// -----

func @image_sample_implicit_bias_attr_dict(%arg0 : !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, %arg1: vector<3xf32>) -> vector<4xi32> {
    // CHECK: spv.ImageSampleImplicitLod {{.*}}, {{.*}} ["Bias", 12] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %arg0, %arg1 {image_operands = 1 : i32, bias = 12 : i32} : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    return %0: vector<4xi32>
}
