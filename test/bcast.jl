@testset "Broadcast" begin
    a = [1 2 3;
         4 5 6]
    @test all(2 .* Dioid{max,+}.(a) .== Dioid{max,+}.( 2 .+ a ))
    @test all(2 .+ Dioid{max,+}.(a) .== Dioid{max,+}.( max.(2,a) ))
end
