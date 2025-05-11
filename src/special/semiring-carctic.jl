"""
add defined as `(x,a) + (y,b) = (max(x,y),c)` with its identity element `(-∞, 0)`, where 
    + c = a,   if x > y
    + c = b,   if x < y
    + c = a+b, if x == y
"""
function carctic₊(x::Tuple{T,Int}, y::Tuple{V,Int}) where {T <:Real, V <:Real}
    vx, cx = x
    vy, cy = y
    v = max(vx, vy)
    (vx > vy) && return tuple(v, cx)
    (vy > vx) && return tuple(v, cy)
    return tuple(v, cx + cy)
end


"""
mul defined as `(x,a) * (y,b) = (x+y, a*b)` with its identity element `(0,1)`
"""
function carcticₓ(x::Tuple{T,Int}, y::Tuple{V,Int}) where {T <:Real, V <:Real}
    vx, cx = x
    vy, cy = y
    return tuple(vx + vy, cx * cy)
end



"""
A arctic algebra with a field for counting

# Constructors
    carctic(x::V)
    carctic(x::V, c::Int)

# Math 
+ add defined as `(x,a) + (y,b) = (max(x,y),c)` with its identity element `(-∞, 0)`, where 
    + c = a,   if x > y
    + c = b,   if x < y
    + c = a+b, if x == y

+ mul defined as `(x,a) * (y,b) = (x+y, a*b)` with its identity element `(0,1)`
"""
const Carctic{V} = Dioid{carctic₊,carcticₓ,Tuple{V,Int}} where V <:Real


function Base.show(io::IO, ::MIME"text/plain", C::Carctic{V}) where V <:Real
    x, c = C.data
    print(io, "($x,$c)ᵧ")
end



function carctic(x::V) where V <:Real
    return Carctic{V}(tuple(x, 0))
end


function carctic(x::V, c::Int) where V <:Real
    return Carctic{V}(tuple(x, c))
end


