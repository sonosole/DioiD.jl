function Base.zero(::Type{Dioid{+, ⨀, T}}) where {⨀, T <: Number}
    return Dioid{+, ⨀, T}( zero(T) )
end

function Base.one(::Type{Dioid{⨁, +, T}}) where {⨁, T <: Number}
    return Dioid{⨁, +, T}( zero(T) )
end
