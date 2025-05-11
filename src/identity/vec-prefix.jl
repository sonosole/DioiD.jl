function Base.zero(::Type{Dioid{lcprefix, ⨀, SVec{T}}}) where {⨀, T}
    return Dioid{lcprefix, ⨀, SVec{T}}( SVec{T}(T[], true) )
end

function Base.one(::Type{Dioid{⨁, lcprefix, SVec{T}}}) where {⨁, T}
    return Dioid{⨁, lcprefix, SVec{T}}( SVec{T}(T[], true) )
end
