@testset "Promote" begin
    SRing = Dioid{max,+}
    Ts = [Bool, Int8, UInt8, Int16, UInt16, Int32,
          UInt32, Int64, UInt64, Int128, UInt128,
          Float16, Float32, Float64]
    for i = 2:length(Ts)
        S = Ts[i-1]
        T = Ts[i]
        @test typeof(SRing(one(S)) + SRing(one(T))) == SRing{T}
    end
end

