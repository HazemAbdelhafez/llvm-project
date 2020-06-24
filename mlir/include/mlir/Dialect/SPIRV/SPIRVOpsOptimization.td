#ifndef TRANSPOSE_OPT
#define TRANSPOSE_OPT

include "mlir/Dialect/SPIRV/SPIRVBase.td"
include "mlir/Dialect/SPIRV/SPIRVMatrixOps.td"

// -----

// Transpose(Transpose(x)) = x
def TransposeTransposeOptPattern : Pat<(SPV_TransposeOp(SPV_TransposeOp $arg)),
                                   (replaceWithValue $arg)>;

#endif // TRANSPOSE_OPT