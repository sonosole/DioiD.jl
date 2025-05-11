@testset "Identity" begin
    SQRT(x,y) = sqrt(x^2 + y^2)

    Base.identity(::Val{SQRT}, T::DataType) = zero(T)

    a = Dioid{SQRT,*,Float32}(rand(Float32))
    e = zero(Dioid{SQRT,*,Float32})
    @test a == a + e == e + a

    b = Dioid{+,SQRT,Float32}(rand(Float32))
    e = one(Dioid{+,SQRT,Float32})
    @test b == b * e == e * b
end

