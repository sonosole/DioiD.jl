function Base.zero(::Type{Dioid{lcprefix, ⨀, T}}) where {⨀, T <: AbstractString}
    return Dioid{lcprefix, ⨀, AbstractString}( s∞ )
end

function Base.one(::Type{Dioid{⨁, lcprefix, T}}) where {⨁, T <: AbstractString}
    return Dioid{⨁, lcprefix, AbstractString}( s∞ )
end
