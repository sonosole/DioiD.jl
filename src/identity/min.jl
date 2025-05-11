function Base.zero(::Type{Dioid{min, ⨀, T}}) where {⨀, T <: Real}
    return Dioid{min, ⨀, T}( typemax(T) )
end

function Base.one(::Type{Dioid{⨁, min, T}}) where {⨁, T <: Real}
    return Dioid{⨁, min, T}( typemax(T) )
end

