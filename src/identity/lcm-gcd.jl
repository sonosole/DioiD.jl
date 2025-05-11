# least-common-multiple op with 1 as identity
"""
julia> x = rand(UInt, 1024); all(lcm.(1, x) .== lcm.(x, 1) .== x)
true
"""

function Base.zero(::Type{Dioid{lcm, ⨀, T}}) where {⨀, T <: Union{Int,Rational}}
    return Dioid{lcm, ⨀, T}( one(T) )
end

function Base.one(::Type{Dioid{⨁, lcm, T}}) where {⨁, T <: Union{Int,Rational}}
    return Dioid{⨁, lcm, T}( one(T) )
end




# greatest-common-divisor op with 0 as identity
"""
julia> x = rand(UInt64, 1024); all(gcd.(0, x) .== gcd.(x, 0) .== x)
true
"""

function Base.zero(::Type{Dioid{gcd, ⨀, T}}) where {⨀, T <: Union{Int,Rational}}
    return Dioid{gcd, ⨀, T}( zero(T) )
end

function Base.one(::Type{Dioid{⨁, gcd, T}}) where {⨁, T <: Union{Int,Rational}}
    return Dioid{⨁, gcd, T}( zero(T) )
end