function Base.one(::Type{Dioid{⨁, *, T}}) where {⨁, T <: Number}
    return Dioid{⨁, *, T}( one(T) )
end

function Base.zero(::Type{Dioid{*, ⨀, T}}) where {⨀, T <: Number}
    return Dioid{*, ⨀, T}( one(T) )
end
