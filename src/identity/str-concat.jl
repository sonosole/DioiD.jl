function Base.one(::Type{Dioid{⨁, *, T}}) where {⨁, T <: AbstractString}
    return Dioid{⨁, *, T}("")
end

function Base.zero(::Type{Dioid{*, ⨀, T}}) where {⨀, T <: AbstractString}
    return Dioid{*, ⨀, T}("")
end

