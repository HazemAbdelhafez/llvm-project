//===-- SPIRVLogicalOps.td - MLIR SPIR-V Logical Ops -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains arithmetic ops for the SPIR-V dialect. It corresponds
// to "3.36.10. Image Instructions" of the SPIR-V spec.
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_IMAGE_OPS
#define SPIRV_IMAGE_OPS

include "mlir/Dialect/SPIRV/SPIRVBase.td"
include "mlir/Interfaces/SideEffectInterfaces.td"

// -----

def SPV_ImageSampleImplicitLodOp : SPV_Op<"ImageSampleImplicitLod", []> {
  let summary = "Sample an image with an implicit level of detail.";

  let description = [{
    Result Type must be a vector of four components of floating-point type
    or integer type.  Its components must be the same as Sampled Type of the
    underlying OpTypeImage (unless that underlying Sampled Type is
    OpTypeVoid).

    Sampled Image must be an object whose type is OpTypeSampledImage.

    Coordinate  must be a scalar or vector of floating-point type.  It
    contains (u[, v] … [, array layer]) as needed by the definition of
    Sampled Image. It may be a vector larger than needed, but all unused
    components will appear after all used components.

    Image Operands encodes what operands follow, as per Image Operands.

    This instruction is only valid in the Fragment Execution Model. In
    addition, it consumes an implicit derivative that can be affected by
    code motion.

    <!-- End of AutoGen section -->

    ```
    image-operands ::= `"None"` | `"Bias"` | `"Lod"` | `"Grad"`
                     | `"ConstOffset"` | `"Offser"` | `"ConstOffsets"`
                     | `"Sample"` | `"MinLod"` | `"MakeTexelAvailable"`
                     | `"MakeTexelVisible"` | `"NonPrivateTexel"`
                     | `"VolatileTexel"` | `"SignExtend"` | `"ZeroExtend"`
                     (`, ` integer-literal)*

    image-sample-implicit-lod-op ::= ssa-id `=` `spv.ImageSampleImplicitLod`
                            ssa-use `, ` ssa-use ` ` (`[` image-operands `]`)?
                            ` : ` vector-type `, ` sampled-image-type `, ` vector-type
    ```

    #### Example:

    ```mlir
    %0 = spv.ImageSampleImplicitLod %1, %2 : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    %0 = spv.ImageSampleImplicitLod %1, %2 ["Bias", 23] : vector<4xi32>, !spv.sampledimage<!spv.image<i32, Dim1D, NoDepth, NonArrayed, SingleSampled, NoSampler, Unknown>>, vector<3xf32>
    ```
  }];

  let availability = [
    MinVersion<SPV_V_1_0>,
    MaxVersion<SPV_V_1_5>,
    Extension<[]>,
    Capability<[SPV_C_Shader]>
  ];

  let arguments = (ins
    SPV_Type:$sampled_image,
    SPV_ScalarOrVectorOf<SPV_Float>:$coordinate,
    OptionalAttr<SPV_ImageOperandsAttr>:$image_operands,
    OptionalAttr<I32Attr>:$bias
  );

  let results = (outs
    SPV_Vector:$result
  );
}

// -----

#endif // SPIRV_IMAGE_OPS
