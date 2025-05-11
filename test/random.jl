@testset "Randoms" begin
    # In julia, randn is for Floats only, but not ready for BigFloat
    for dtype ∈ [Float16, Float32, Float64]
        T = Dioid{max, +, dtype}
        @test T == typeof( randn(T) ) == typeof( T(randn(dtype)) )
        @test T == eltype( randn(T, 1) ) == eltype( T.(randn(dtype, 1)) )
        @test T == eltype( randn(T, 1,2) ) == eltype( T.(randn(dtype, 1,2)) )
    end

    # In julia, rand is not ready for BigInt & Rational
    for dtype ∈ [Bool, Float16, Float32, Float64, BigFloat,
                  Int8, Int16, Int32, Int64, Int128,
                  UInt8, UInt16, UInt32, UInt64, UInt128]
        T = Dioid{max, +, dtype}
        @test T == typeof( rand(T) ) == typeof( T(rand(dtype)) )
        @test T == eltype( rand(T, 1) ) == eltype( T.(rand(dtype, 1)) )
        @test T == eltype( rand(T, 1,2) ) == eltype( T.(rand(dtype, 1,2)) )
    end
end
