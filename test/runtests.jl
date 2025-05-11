using DioiD
using Test

@testset verbose=true "DioiD" begin
    include("addmul.jl")
    include("adj.jl")
    include("alias.jl")
    include("bcast.jl")
    include("copy.jl")
    include("equal.jl")
    include("identity.jl")
    include("parse.jl")
    include("promote.jl")
    include("random.jl")
end
