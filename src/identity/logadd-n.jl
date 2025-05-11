function Base.zero(::Type{Dioid{nlogadd, ⨀, T}}) where {⨀, T}
    return Dioid{nlogadd, ⨀, T}( typemax(T) )
end

function Base.one(::Type{Dioid{⨁, nlogadd, T}}) where {⨁, T}
    return Dioid{⨁, nlogadd, T}( typemax(T) )
end
