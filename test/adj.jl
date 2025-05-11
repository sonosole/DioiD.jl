@testset "AdjConjTrans" begin
    @testset "about real numbers" begin
        x = Dioid{+,*}(3)
        @test x == transpose(x)
        @test x == adjoint(x)
        @test x == conj(x)
    end
    
    @testset "about complex numbers" begin
        x  = Dioid{+,*}(3 - 4im)
        xᴴ = Dioid{+,*}(3 + 4im)
    
        @test x == transpose(x) # just transpose
        @test x == adjoint(xᴴ)  # returns the complex conjugate
        @test x == conj(xᴴ)     # computes the complex conjugate
    end
    
    @testset "about real arrays" begin
        a  = [1 2;
              3 4;
              5 6];
        aᵀ = [1 3 5;
              2 4 6];
        x  = Dioid{+,*}.(a)
        xᵀ = Dioid{+,*}.(aᵀ)
    
        @test x == transpose(xᵀ) # returns the transposed conjugate
        @test x == adjoint(xᵀ)   # returns the transposed conjugate
        @test x == conj(x)       # computes the conjugate
    end
    
    @testset "about complex arrays" begin
        a  = [1+2im;
              3+4im;
              5+6im];
        aᵀ = [1+2im 3+4im 5+6im];
        aᴴ = [1-2im 3-4im 5-6im];
        x  = Dioid{+,*}.(a)
        xᵀ = Dioid{+,*}.(aᵀ)
        xᴴ = Dioid{+,*}.(aᴴ)
    
        @test all(xᵀ .== transpose(x))                       # returns the transposed
        @test all(xᴴ .== adjoint(x) .== transpose(conj(x)))  # returns the transposed complex conjugate
    end

    @testset "about string arrays" begin
        a  = ["s";
              "o";
              "l";
              "e"];
        aᵀ = ["s" "o" "l" "e"];
        aᴴ = ["s" "o" "l" "e"];
        x  = Dioid{+,*}.(a)
        xᵀ = Dioid{+,*}.(aᵀ)
        xᴴ = Dioid{+,*}.(aᴴ)

        @test all(xᵀ .== xᴴ)
        @test all(xᵀ .== transpose(x))
        @test all(xᴴ .== adjoint(x) .== transpose(conj(x)))
    end
end
