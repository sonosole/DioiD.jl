"""
``inact`` is placeholder function for doing nothing. It's used for a `Dioid` has only one operation, either `⊕` or `⊙`.
# Example
```julia
julia> Dioid{inact,+}(3) * Dioid{inact,+}(4)
7ᵧ

julia> Dioid{inact,*}(3) + Dioid{inact,*}(4)
ERROR: MethodError: no method matching inact(::Int64, ::Int64)
```

!!! warning
    DO **``NOT``** overwirte this function !!!
"""
function inact end
