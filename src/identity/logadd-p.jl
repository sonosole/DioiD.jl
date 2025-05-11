function Base.zero(::Type{Dioid{logadd, ⨀, T}}) where {⨀, T}
    return Dioid{logadd, ⨀, T}( typemin(T) )
end

function Base.one(::Type{Dioid{⨁, logadd, T}}) where {⨁, T}
    return Dioid{⨁, logadd, T}( typemin(T) )
end
