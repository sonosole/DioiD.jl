function Base.zero(::Type{Dioid{lcsuffix, ⨀, T}}) where {⨀, T <: AbstractString}
    return Dioid{lcsuffix, ⨀, AbstractString}( s∞ )
end

function Base.one(::Type{Dioid{⨁, lcsuffix, T}}) where {⨁, T <: AbstractString}
    return Dioid{⨁, lcsuffix, AbstractString}( s∞ )
end

