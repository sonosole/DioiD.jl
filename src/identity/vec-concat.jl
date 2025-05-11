function Base.one(::Type{Dioid{⨁, append!, T}}) where {⨁, T <: AbstractVector}
    return Dioid{⨁, append!, T}(T[])
end

function Base.zero(::Type{Dioid{append!, ⨀, T}}) where {⨀, T <: AbstractVector}
    return Dioid{append!, ⨀, T}(T[])
end

