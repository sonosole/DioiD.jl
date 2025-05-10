#=
general inverse op of multiplication, mathematically we have
    xᵧ / yᵧ = zᵧ iff zᵧ ⨀ yᵧ = xᵧ
=#
function Base.div(x::Dioid{⨁, ⨀, Tx},
                  y::Dioid{⨁, ⨀, Ty}) where {⨁, ⨀, Tx, Ty}
    z = inverse(Val(⨀))(ᵛ(x), ᵛ(y))
    return Dioid{⨁, ⨀}(z)
end


# Dioid ⨸ Dioid ≝ xᵧ + (-y)ᵧ
function Base.div(x::Dioid{⨁, +, Tx},
                  y::Dioid{⨁, +, Ty}) where {⨁, Tx, Ty}
    return Dioid{⨁, +}(ᵛ(x) - ᵛ(y))
end

# Dioid ⨸ Number ≝ xᵧ + (-y)
# Number ⨸ Dioid ≝ x + (-y)ᵧ
Base.div(x::Dioid{⨁, +, Tx}, y::Number) where {⨁, Tx} = Dioid{⨁, +}(ᵛ(x) - y)
Base.div(x::Number, y::Dioid{⨁, +, Ty}) where {⨁, Ty} = Dioid{⨁, +}(x - ᵛ(y))


# Dioid ⨸ Dioid ≝ xᵧ * (1 / y)ᵧ
function Base.div(x::Dioid{⨁, *, Tx}, y::Dioid{⨁, *, Ty}) where {⨁, Tx, Ty}
    return Dioid{⨁, *}( ᵛ(x) / ᵛ(y) )
end

# Dioid ⨸ Number ≝ xᵧ * (1 / y)
# Number ⨸ Dioid ≝ x * (1 / y)ᵧ
Base.div(x::Dioid{⨁, *, Tx}, y::Number) where {⨁, Tx} = Dioid{⨁, *}( ᵛ(x) / y ) # x * (1/y)
Base.div(x::Number, y::Dioid{⨁, *, Ty}) where {⨁, Ty} = Dioid{⨁, *}( x / ᵛ(y) ) # x * inv(y)


# 🤿 \odiv ⨸ for semiring's written language
"""
    ⨸ (x::Dioid, y::Dioid)
    ⨸ (x::Dioid, y::Number)
    ⨸ (x::Number, y::Dioid)

`xᵧ⨸ yᵧ = zᵧ iff zᵧ⊙ yᵧ = xᵧ`. This syntax is not **``recommended``**, because of its confusability.\n
for `⊙ ≝ +`, we have `xᵧ⨸ yᵧ ≝ xᵧ + (0-y)ᵧ` and   \n
for `⊙ ≝ *`, we have `xᵧ⨸ yᵧ ≝ xᵧ * (1/y)ᵧ`

# Examples
```julia
julia> 1 / Dioid{max, +}(5) == Dioid{max, +}(1-5)
true

julia> 1 / Dioid{max, *}(5) == Dioid{max, *}(1/5)
true

julia> 1.0 / Dioid{+, min}(5.0)
ERROR: MethodError: no method matching div(::Float64, ::Dioid{+, min, Float64}, ::RoundingMode{:ToZero})
```
"""
⨸(x::Dioid, y::Dioid) = div(x, y)
⨸(x::Dioid, y::Number)    = div(x, y)
⨸(x::Number,    y::Dioid) = div(x, y)


Base.:/(x::Dioid, y::Dioid) = div(x, y)
Base.:/(x::Dioid, y::Number)    = div(x, y)
Base.:/(x::Number,    y::Dioid) = div(x, y)
