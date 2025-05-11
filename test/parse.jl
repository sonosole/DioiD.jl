@testset "Parsing" begin
    for dtype ∈ [Int8, Int16, Int32, Int64, Int128, BigInt,
                  UInt8, UInt16, UInt32, UInt64, UInt128, Bool]
        s = Dioid{max,+}( parse(dtype, "1") )
        p = parse(Dioid{max,+,dtype}, "1")
        @test s == p
    end

    for dtype ∈ [Float16, Float32, Float64, BigFloat]
        s = Dioid{max,+}( parse(dtype, "1990.1997") )
        p = parse(Dioid{max,+,dtype}, "1990.1997")
        @test s == p
    end
end
