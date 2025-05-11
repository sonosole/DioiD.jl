"""
    is0closed(x::Dioid)
return true if one(x) == one(x) + x
"""
function is0closed(x::Dioid)
    I = one(x)
    return I == I + x
end

"""
    iszeroclosed(x::Dioid)
return true if one(x) == one(x) + x
"""
function iszeroclosed(x::Dioid)
    I = one(x)
    return I == I + x
end

