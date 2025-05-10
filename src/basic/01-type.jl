"""
``Dioid{⨁ , ⨀ , T}`` is semiring of `(𝕊, ⨁ , ⨀ , 𝟘 , 𝟙)` where
+ `𝕊` is the domain of `T`
+ `⨁` is a binary operator with an identity element `𝟘`, so `x ⨁ 𝟘 == 𝟘 ⨁ x == x`
+ `⨀` is a binary operator with an identity element `𝟙`, so `x ⨀ 𝟙 == 𝟙 ⨀ x == x`
!!! note
    In the expression `Dioid{⨁, ⨀, T}`, I call the `⨁`'s position as addition-position 
    and `⨀`'s multiplication-position, in short `add-position` and `mul-position` respectively.
    Those names would be used in this pkg elsewhere.
# Constructor
## Type precise constructor
    Dioid{⨁, ⨀, T}(x)
## Type-inferred-by-input constructor
    Dioid{⨁, ⨀}(x::T)
"""
struct Dioid{⨁,⨀,T}
    data :: T

    function Dioid{⨁,⨀,T}(x::T) where {⨁,⨀,T}
        return new{⨁,⨀,T}(x)    # precise constructor
    end

    function Dioid{⨁,⨀,T}(x::S) where {⨁,⨀,T,S}
        return new{⨁,⨀,T}(T(x))    # precise constructor
    end

    function Dioid{⨁,⨀}(x::T) where {⨁,⨀,T}
        return new{⨁,⨀,T}(x)    # easy constructor
    end
end


# easy access to core data
@inline function ᵛ(x::Dioid)
    return x.data
end

# easy access to core data
@inline function value(x::Dioid)
    return x.data
end


# easy shows
global MARK = "ᵧ" 

function setmark(s::String)
    global MARK
    MARK = s
    return nothing
end

function Base.show(io::IO, x::Dioid{⨁, ⨀, Bool}) where {⨁, ⨀}
    T = ᵛ(x)
    F = !T
    T && print(io, "1")
    F && print(io, "·")
end

function Base.show(io::IO, x::Dioid)
    v = ᵛ(x)
    isequal(v, -Inf) && return print(io, "-∞")
    isequal(v,  Inf) && return print(io, "∞")
    return print(io, v, MARK)
end

function Base.show(io::IO, ::MIME"text/plain", x::Dioid)
    return show(io, x)
end



Base.copy(x::Dioid{⨁, ⨀, T}) where {⨁, ⨀, T} = Dioid{⨁, ⨀, T}( copy(ᵛ(x)) )
Base.deepcopy(x::Dioid{⨁, ⨀, T}) where {⨁, ⨀, T} = Dioid{⨁, ⨀, T}( deepcopy(ᵛ(x)) )

# special case for string and general case for other types
Base.conj(x::Dioid{⨁, ⨀, <:AbstractString}) where {⨁, ⨀} = x
Base.adjoint(x::Dioid{⨁, ⨀, <:AbstractString}) where {⨁, ⨀} = x
Base.transpose(x::Dioid{⨁, ⨀, <:AbstractString}) where {⨁, ⨀} = x

Base.conj(x::Dioid{⨁, ⨀, T}) where {⨁, ⨀, T} = Dioid{⨁, ⨀, T}( conj(ᵛ(x)) )
Base.adjoint(x::Dioid{⨁, ⨀, T}) where {⨁, ⨀, T} = Dioid{⨁, ⨀, T}( adjoint(ᵛ(x)) )
Base.transpose(x::Dioid{⨁, ⨀, T}) where {⨁, ⨀, T} = Dioid{⨁, ⨀, T}( transpose(ᵛ(x)) )


# for ones and zeros
Base.zero(x::Dioid) = zero(typeof(x))
Base.one(x::Dioid)  =  one(typeof(x))

Base.oneunit(::     Dioid{⨁, ⨀, T} ) where {⨁, ⨀, T} = one(Dioid{⨁, ⨀, T})
Base.oneunit(::Type{Dioid{⨁, ⨀, T}}) where {⨁, ⨀, T} = one(Dioid{⨁, ⨀, T})

Base.eps(x::Dioid{⨁,⨀,T})      where {⨁,⨀,T} = Dioid{⨁,⨀}(eps(T))
Base.eps(::Type{Dioid{⨁,⨀,T}}) where {⨁,⨀,T} = Dioid{⨁,⨀}(eps(T))

Base.typemax(::Type{Dioid{⨁,⨀,T}}) where {⨁,⨀,T} = Dioid{⨁,⨀}(typemax(T))
Base.typemin(::Type{Dioid{⨁,⨀,T}}) where {⨁,⨀,T} = Dioid{⨁,⨀}(typemin(T))


function Base.promote_rule(::Type{Dioid{⨁, ⨀, Tx}},
                           ::Type{Dioid{⨁, ⨀, Ty}}) where {⨁, ⨀, Tx, Ty}
    return Dioid{⨁, ⨀, promote_type(Tx, Ty)}
end

function Base.parse(::Type{Dioid{⨁,⨀,T}}, str::AbstractString) where {⨁,⨀,T}
    return Dioid{⨁,⨀,T}(parse(T, str))
end

function Base.tryparse(::Type{Dioid{⨁, ⨀, T}}, str::AbstractString) where {⨁, ⨀, T}
    x = tryparse(T, str)
    isnothing(x) && return nothing
    return Dioid{⨁, ⨀}(x)
end

function Base.convert(::Type{Dioid{⨁,⨀,T}}, x::Dioid{⨁,⨀,S}) where {⨁,⨀,T,S}
    return Dioid{⨁,⨀}(convert(T, x.data))
end


# equality
function Base.hash(x::Dioid, h::UInt)
    return hash(ᵛ(x), h)
end

function Base.isapprox(x::Dioid{⨁,⨀},
                       y::Dioid{⨁,⨀};
                       atol::Real = 0,
                       rtol::Real = atol>0 ? 0 : 1e-3) where {⨁,⨀}
    return isapprox(x.data, y.data; atol, rtol)
end

function Base.:(==)(x::Dioid{⨁, ⨀, Tx},
                    y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    return ᵛ(x) == ᵛ(y)
end


function Base.:(<)(x::Dioid{⨁, ⨀, Tx},
                   y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    return ᵛ(x) < ᵛ(y)
end

function Base.:(≤)(x::Dioid{⨁, ⨀, Tx},
                   y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    return ᵛ(x) ≤ ᵛ(y)
end

function Base.:(>)(x::Dioid{⨁, ⨀, Tx},
                   y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    return ᵛ(x) > ᵛ(y)
end

function Base.:(≥)(x::Dioid{⨁, ⨀, Tx},
                   y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    return ᵛ(x) ≥ ᵛ(y)
end


# let `Dioid` be a broadcast-compatible object
# so the broadcast can happen between arrays and scalar
Broadcast.broadcastable(x::Dioid) = Ref(x)


# Dioid ⇾ common number
(t::Type{<:Number})(x::Dioid{⨁, ⨀, <:Number})       where {⨁, ⨀} = t(x.data)
(t::Type{<:Number})(x::Dioid{⨁, ⨀, <:Number}, mode) where {⨁, ⨀} = t(x.data, mode)


# judgements
Base.isfinite(x::Dioid) = isfinite(x.data)
Base.isinf(x::Dioid) = isinf(x.data)
Base.isnan(x::Dioid) = isnan(x.data)

Base.isinteger(x::Dioid) = isinteger(x.data)
Base.isreal(x::Dioid) = isreal(x.data)
Base.isodd(x::Dioid) = isodd(x.data)
Base.iseven(x::Dioid) = iseven(x.data)
Base.ispow2(x::Dioid) = ispow2(x.data)


# precision
Base.trunc(x::Dioid; digits::Int=3) = typeof(x)(trunc(x.data; digits))
Base.floor(x::Dioid; digits::Int=3) = typeof(x)(floor(x.data; digits))
Base.round(x::Dioid; digits::Int=3) = typeof(x)(round(x.data; digits))
Base.ceil( x::Dioid; digits::Int=3) = typeof(x)( ceil(x.data; digits))
Base.clamp(x::Dioid, l::Real, h::Real) = typeof(x)(clamp(x.data, l, h))

