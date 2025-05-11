"""
    struct Dual{T <: Real}
        value :: T
        delta :: T
    end

# Constructors
    Dual{T}(v::T, d::T)
    Dual(v::T, d::T=zero(T))

# Math 
+ add defined as `(a+b𝕚) + (x+y𝕚) = (a+x) + (b+y)𝕚` with its identity element `𝟘 = (0, 0)`
+ mul defined as `(a+b𝕚) * (x+y𝕚) = ax + (ay + bx)𝕚` with its identity element `𝟙 = (1, 0)`
"""
struct Dual{T}
    value :: T
    delta :: T
    function Dual{T}(v::T, d::T) where T <: Real
        return new{T}(v, d)
    end
    function Dual(v::T, d::T) where T <: Real
        return new{T}(v, d)
    end
    function Dual(v::T) where T <: Real
        return new{T}(v, zero(T))
    end
end


function Base.show(io::IO, x::Dual)
    print(io, "($(x.value),$(x.delta))")
end


# (a+b𝕚) + (x+y𝕚) = (a+x) + (b+y)𝕚
function Base.:+(A::Dual{TA}, B::Dual{TB}) where {TA,TB}
    x, dx = A.value, A.delta
    y, dy = B.value, B.delta
    return Dual(x + y, dx + dy)
end


# (a+b𝕚) * (x+y𝕚) 
# = ax + (ay + bx)𝕚 + (by)𝕚² 
# ≈ ax + (ay + bx)𝕚
function Base.:*(A::Dual{TA}, B::Dual{TB}) where {TA,TB}
    x, dx = A.value, A.delta
    y, dy = B.value, B.delta
    return Dual(x*y, x*dy + y*dx)
end


# normal + * position
function Base.zero(::Type{ Dioid{+, *, Dual{T}} }) where {T <: Real}
    # (a+b𝕚) + (0+0𝕚) = (a+b𝕚)
    o = Dual{T}(zero(T), zero(T))
    return Dioid{+, *, Dual{T}}(o)
end


function Base.one(::Type{ Dioid{+, *, Dual{T}} }) where {T <: Real}
    # (a+b𝕚) * (1+0𝕚) = (a+b𝕚)
    l = Dual{T}(one(T),  zero(T))
    return Dioid{+, *, Dual{T}}(l)
end


# unnormal + * position
function Base.zero(::Type{ Dioid{*, + , Dual{T}} }) where {T <: Real}
    # (a+b𝕚) * (1+0𝕚) = (a+b𝕚)
    o = Dual{T}(one(T),  zero(T))
    return Dioid{+, *, Dual{T}}(o)
end


function Base.one(::Type{ Dioid{*, +, Dual{T}} }) where {T <: Real}
    # (a+b𝕚) + (0+0𝕚) = (a+b𝕚)
    l = Dual{T}(zero(T), zero(T))
    return Dioid{+, *, Dual{T}}(l)
end
