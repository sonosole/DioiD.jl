using Random

# generating random Dioid element and random Dioid arrays

# In julia, rand is not ready for BigInt & Rational
function Base.rand(rng::AbstractRNG, ::Random.SamplerType{Dioid{⨁, ⨀, T}}) where {⨁, ⨀, T}
    return Dioid{⨁, ⨀, T}(rand(rng, T))
end

# In julia, randn is for Floats only, but not ready for BigFloat
function Base.randn(rng::AbstractRNG, ::Type{Dioid{⨁, ⨀, T}}) where {⨁, ⨀, T}
    return Dioid{⨁, ⨀, T}(randn(rng, T))
end

