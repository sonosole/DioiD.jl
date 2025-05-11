function Base.zero(::Type{Dioid{max, ⨀, T}}) where {⨀, T <: Real}
    return Dioid{max, ⨀, T}( typemin(T) )
end

function Base.one(::Type{Dioid{⨁, max, T}}) where {⨁, T <: Real}
    return Dioid{⨁, max, T}( typemin(T) )
end

