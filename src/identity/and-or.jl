function Base.zero(::Type{Dioid{&, ⨀, Bool}}) where ⨀
    return Dioid{&, ⨀, Bool}(true)
end

function Base.one(::Type{Dioid{⨁, &, Bool}}) where ⨁
    return Dioid{⨁, &, Bool}(true)
end


function Base.zero(::Type{Dioid{|, ⨀, Bool}}) where ⨀
    return Dioid{|, ⨀, Bool}(false)
end

function Base.one(::Type{Dioid{⨁, |, Bool}}) where ⨁
    return Dioid{⨁, |, Bool}(false)
end

