"""
A tropical algebra with a field for counting

    struct Counter{T <: Real}
        c :: Int    # the counts
        v :: T      # the value
    end

# Constructors
    Counter(c::Int, x::Real)
    Counter{T}(c::Int, x::T)

# Math 
+ add defined as `(a,x) + (b,y) = (c, max(x,y))` with its identity element `(0, -∞)`, where 
    + c = a,   if x > y
    + c = b,   if x < y
    + c = a+b, if x == y

+ mul defined as `(a,x) * (b,y) = (a*b, x+y)` with its identity element `(1, 0)`
"""
struct Counter{T}
    c :: Int
    v :: T
    function Counter{T}(c::Int, x::T) where T <: Real
        return new{T}(c, x)
    end
    function Counter(c::Int, x::T) where T <: Real
        return new{T}(c, x)
    end
end

function Base.show(io::IO, x::Counter)
    print(io, "($(x.c),$(x.v))")
end


function Base.:+(x::Counter, y::Counter)
    vx = x.v
    cx = x.c
    vy = y.v
    cy = y.c

    (vx > vy) && return x
    (vy > vx) && return y
    return Counter(cx + cy, vx)
end


function Base.:*(x::Counter, y::Counter)
    vx = x.v
    cx = x.c
    vy = y.v
    cy = y.c
    return Counter(cx * cy, vx + vy)
end


# normal + * position
function Base.zero(::Type{Dioid{+, *, Counter{R}}}) where {R<:Real}
    val = Counter{R}(0, typemin(R))
    return Dioid{+, *}( val )
end

function Base.one(::Type{Dioid{+, *, Counter{R}}}) where {R<:Real}
    val = Counter{R}(1, zero(R))
    return Dioid{+, *}( val )
end


# unnormal + * position
function Base.zero(::Type{Dioid{*, +, Counter{R}}}) where {R<:Real}
    val = Counter{R}(1, zero(R))
    return Dioid{*, +}( val )
end

function Base.one(::Type{Dioid{*, +, Counter{R}}}) where {R<:Real}
    val = Counter{R}(0, typemin(R))
    return Dioid{*, +}( val )
end

