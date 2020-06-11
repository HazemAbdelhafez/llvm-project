//===-- SPIRVMatrixOps.td - MLIR SPIR-V Matrix Ops -------*- tablegen -*-===//
//
// Part of the LLVM Project, under the Apache License v2.0 with LLVM Exceptions.
// See https://llvm.org/LICENSE.txt for license information.
// SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
//
//===----------------------------------------------------------------------===//
//
// This file contains matrix operations for the SPIR-V dialect.
//
//===----------------------------------------------------------------------===//

#ifndef SPIRV_MATRIX_OPS
#define SPIRV_MATRIX_OPS

// -----

// Using the default SPV_ArithmeticOp will lead to a default check that all operands are of the same type which
// is incorrect for the matrix operations, thus it fails. This class 'SPV_ArithmeticMatrixOp' replicates the same logic
// of 'SPV_ArithmeticOp' but without the 'SameOperandsAndResultType' trait.

class SPV_ArithmeticMatrixOp<string mnemonic, Type type,
                       list<OpTrait> traits = []> :
      // Operands type same as result type.
      SPV_BinaryOp<mnemonic, type, type,
                   !listconcat(traits,
                               [NoSideEffect])> {

}

def SPV_MatrixTimesScalarOp : SPV_ArithmeticMatrixOp<"MatrixTimesScalar", SPV_AnyMatrix, []> {
  let summary = "Scale a floating-point matrix.";

  let description = [{
    Result Type must be an OpTypeMatrix whose Column Type is a vector of
    floating-point type.

     The type of Matrix must be the same as Result Type. Each component in
    each column in Matrix is multiplied by Scalar.

    Scalar must have the same type as the Component Type in Result Type.

    <!-- End of AutoGen section -->

    ```
    matrix-times-scalar-op ::= ssa-id `=` `spv.MatrixTimesScalar` ssa-use, ssa-use `:` matrix-type `,` float-type `->` matrix-type

    ```

    #### Example:

    ```mlir

    %0 = spv.MatrixTimesScalar %matrix, %scalar : !spv.matrix<3 x vector<3xf32>>, f32 -> !spv.matrix<3 x vector<3xf32>>

    ```
  }];

  let arguments = (ins
    SPV_AnyMatrix:$matrix,
    SPV_Float:$scalar
  );

  let results = (outs
    SPV_AnyMatrix:$result
  );

  let assemblyFormat = [{
    operands attr-dict `:` type($matrix) `,` type($scalar) `->` type($result)
  }];

  let availability = [
    MinVersion<SPV_V_1_0>,
    MaxVersion<SPV_V_1_5>,
    Extension<[]>,
    Capability<[SPV_C_Matrix]>
  ];

  let verifier = [{ return verifyMatrixTimesScalar(*this); }];
}

// -----

#endif // SPIRV_MATRIX_OPS