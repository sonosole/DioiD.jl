function Base.zero(::Type{Dioid{lcsuffix, ⨀, SVec{T}}}) where {⨀, T}
    return Dioid{lcsuffix, ⨀, SVec{T}}( SVec{T}(T[], true) )
end

function Base.one(::Type{Dioid{⨁, lcsuffix, SVec{T}}}) where {⨁, T}
    return Dioid{⨁, lcsuffix, SVec{T}}( SVec{T}(T[], true) )
end

