# Dioid ⊕ Dioid
function Base.:+(x::Dioid{⨁,⨀,Tx},
                 y::Dioid{⨁,⨀,Ty}) where {⨁, ⨀, Tx, Ty}
    return Dioid{⨁,⨀}(⨁(ᵛ(x), ᵛ(y)))
end

# Dioid ⊕ Number
function Base.:+(x::Dioid{⨁,⨀,Tx}, y::Ty) where {⨁, ⨀, Tx, Ty <: Number}
    return Dioid{⨁,⨀}(⨁(ᵛ(x), y))
end

# Number ⊕ Dioid
function Base.:+(x::Tx, y::Dioid{⨁,⨀,Ty}) where {⨁, ⨀, Tx <: Number, Ty}
    return Dioid{⨁,⨀}(⨁(x, ᵛ(y)))
end

# ⊕ Dioid
function Base.:+(x::Dioid)
    return x
end

# \oplus ⊕ for semiring's written language
# ⚠️⚠️ Notice it is NOT \bigoplus ⨁ ⚠️⚠️
⊕(x::Dioid, y::Dioid) = x + y
⊕(x::Dioid, y::Number) = x + y
⊕(x::Number, y::Dioid) = x + y
⊕(x::Dioid) = x
