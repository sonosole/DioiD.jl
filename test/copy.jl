@testset "Copying" begin
    for dtype ∈ [Bool, Float16, Float32, Float64, BigFloat,
                  Int8, Int16, Int32, Int64, Int128, BigInt,
                  UInt8, UInt16, UInt32, UInt64, UInt128, Rational]
        x = Dioid{max,+}( one(dtype) )
        @test x == copy(x) == deepcopy(x)
    end
end
