# (a+b𝛜) + (x+y𝛜) = (a+x) + (b+y)𝛜
function dual₊(A::Tuple{T,T}, B::Tuple{V,V}) where {T <:Real, V <:Real}
    x, dx = A
    y, dy = B
    return tuple(x + y, dx + dy)
end


# (a+b𝛜) * (x+y𝛜) 
# = ax + (ay + bx)𝛜 + (by)𝛜² 
# ≈ ax + (ay + bx)𝛜
function dualₓ(A::Tuple{T,T}, B::Tuple{V,V}) where {T <:Real, V <:Real}
    x, dx = A
    y, dy = B
    return tuple(x*y, x*dy + y*dx)
end

# (a+b𝛜) + (0+0𝛜) = (a+b𝛜)
function Base.identity(::Val{dual₊}, ::Type{Tuple{V,V}}) where V <:Real
    return tuple(zero(V), zero(V))
end

# (a+b𝛜) * (1+0𝛜) = (a+b𝛜)
function Base.identity(::Val{dualₓ}, ::Type{Tuple{V,V}}) where V <:Real
    return tuple(one(V), zero(V))
end


# create an alias
"""
`Dual` is the gradient-Dioid often used in forward mode automatic differentiation. 
In probabilistic logic programming field, it's also called expectation-Dioid.
# Constructors
+ `Dual{V,V}(xd::Tuple{V,V})`
+ `dual(x::V)` defined as `Dual{V,V}((x,zero(V)))`
+ `dual(x::V, d::D)` defined as `Dual{V,V}((x,V(d)))`
for examples:
```julia
julia> ones(Dual{Float32}, 1,3)
1×3 Matrix{Dual{Float32}}:
 1.0+0.0ϵ  1.0+0.0ϵ  1.0+0.0ϵ

julia> dual(1.0, 2.0) + dual(-1.0, -2.0)
0.0+0.0ϵ

julia> dual(1.0, 2.0) * dual(3.0, -2.0)
3.0+4.0ϵ
```
# Math
+ add defined as ``(a+b𝛜) + (x+y𝛜) = (a+x) + (b+y)𝛜`` with its identity element ``𝟘 = (0, 0)``
+ mul defined as ``(a+b𝛜) * (x+y𝛜) = ax + (ay+bx)𝛜`` with its identity element ``𝟙 = (1, 0)``
"""
const Dual{V} = Dioid{dual₊,dualₓ,Tuple{V,V}} where V <:Real

# customize a human-readable output
function Base.show(io::IO, ::MIME"text/plain", D::Dual)
    x, y = D.data; y ≥ 0 && 
    return print(io, "$x+$(y)ϵ");
    return print(io, "$x$(y)ϵ");
end


# add constructor-like functions
function dual(x::V) where V <:Real
    tp = tuple(x, zero(V))
    return Dual{V}(tp)
end

function dual(x::V, d::D) where {V <:Real, D <:Real}
    tp = tuple(x, V(d))
    return Dual{V}(tp)
end
