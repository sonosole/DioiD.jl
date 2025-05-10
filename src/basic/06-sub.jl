#=
general inverse op of addition, mathematically we have
    xᵧ - yᵧ = zᵧ iff zᵧ ⊕ yᵧ = xᵧ
=#
function Base.:-(x::Dioid{⨁, ⨀, Tx},
                 y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    z = inverse(Val(⨁))(ᵛ(x), ᵛ(y))
    return Dioid{⨁, ⨀}(z)
end


function Base.:-(x::Dioid{+, ⨀, Tx},
                 y::Dioid{+, ⨀, Ty}) where {⨀, Tx, Ty}
    return Dioid{+, ⨀}(ᵛ(x) - ᵛ(y))
end

Base.:-(x::Dioid{+, ⨀, Tx}, y::Number) where {⨀, Tx} = Dioid{+, ⨀}( ᵛ(x) - y )
Base.:-(x::Number, y::Dioid{+, ⨀, Ty}) where {⨀, Ty} = Dioid{+, ⨀}( x - ᵛ(y) )


function Base.:-(x::Dioid{*, ⨀, Tx},
                 y::Dioid{*, ⨀, Ty}) where {⨀, Tx, Ty}
    return Dioid{*, ⨀}(ᵛ(x) / ᵛ(y))
end

Base.:-(x::Dioid{*, ⨀, Tx}, y::Number) where {⨀, Tx} = Dioid{*, ⨀}( ᵛ(x) / y )
Base.:-(x::Number, y::Dioid{*, ⨀, Ty}) where {⨀, Ty} = Dioid{*, ⨀}( x / ᵛ(y) )

# 𝟘 - xᵧ = yᵧ iff xᵧ ⊕ yᵧ = 𝟘
Base.:-(x::Dioid{*, ⨀, T}) where {⨀, T} = Dioid{*, ⨀, T}( inv( ᵛ(x) ) )
Base.:-(x::Dioid{+, ⨀, T}) where {⨀, T} = Dioid{+, ⨀, T}(    - ᵛ(x)   )


# \ominus ⊖ for semiring's written language
"""
    ⊖ (x::Dioid, y::Dioid) = x - y
    ⊖ (x::Dioid, y::Number) = x - y
    ⊖ (x::Number, y::Dioid) = x - y
    ⊖ (x::Dioid) = - x

`xᵧ⊖ yᵧ = zᵧ iff zᵧ⊕ yᵧ = xᵧ`. This syntax is not **``recommended``**, because of its confusability.\n
for `⊕ ≝ +`, we have `xᵧ⊖ yᵧ ≝ xᵧ + (0-y)ᵧ` and \n
for `⊕ ≝ *`, we have `xᵧ⊖ yᵧ ≝ xᵧ * (1/y)ᵧ`

# Examples
```julia
julia> 1 - Dioid{*, min}(5) == Dioid{*, min}(1/5)
true

julia> 1 - Dioid{+, min}(5) == Dioid{+, min}(1-5)
true

julia> 1 - Dioid{max, logadd}(5)
ERROR: MethodError: no method matching -(::Int64, ::Dioid{max, logadd, Int64})
```
"""
⊖(x::Dioid, y::Dioid) = x - y
⊖(x::Dioid, y::Number)    = x - y
⊖(x::Number,    y::Dioid) = x - y
⊖(x::Dioid) = - x
