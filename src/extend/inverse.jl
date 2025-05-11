"""
`inverse` function defines a binary operator's inverse operation.

Mathematically if \n
    z = x ⊕ y, and \n
    x = z ⊖ y \n
then we say `⊖` is the inverse of `⊕` . In the same way for `⊙` and `⨸` .
# Example
Mathematically, if nonnegative numbers `x,y,z` has relation \n
    z = x ⊕ y = sqrt(x² + y²), then \n
    x = z ⊖ y = sqrt(z² - y²) \n
so programmatically we can define \n
    pyt(x,y) = sqrt(x^2 + y^2) \n
    ipyt(z,y) = sqrt(z^2 - y^2) \n
then define \n
    inverse(::Val{pyt}) = ipyt \n
    inverse(::Val{ipyt}) = pyt \n
thus \n
```julia
julia> inverse(Val(pyt))(5,3)
4.0

julia> inverse(Val(ipyt))(4,3)
5.0
```
"""
function inverse end


"""
`inverse(Val(+))` defines `+`'s inverse operation as `-`
"""
inverse(::Val{+}) = Base.:-


"""
`inverse(Val(-))` defines `-`'s inverse operation as `+`
"""
inverse(::Val{-}) = Base.:+


"""
`inverse(Val(*))` defines `*`'s inverse operation as `/`
"""
inverse(::Val{*}) = Base.:/


"""
`inverse(Val(/))` defines `/`'s inverse operation as `*`
"""
inverse(::Val{/}) = Base.:*


"""
`inverse(Val(lcprefix))` defines `lcprefix`'s inverse operation as `deprefix`
"""
inverse(::Val{lcprefix}) = deprefix


"""
`inverse(Val(deprefix))` defines `deprefix`'s inverse operation as `lcprefix`
"""
inverse(::Val{deprefix}) = lcprefix

