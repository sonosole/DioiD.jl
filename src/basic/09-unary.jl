"""
    unary(f::Function)
allow unary function `f` to act on Dioid.

# Example
```julia
julia> begin
           addone(x) = x + one(x);        # a self defined function
           unary(addone);                 # make it work on Dioid
           addone(Dioid{max,+}(2.14))
       end
3.14

julia> begin
           unary(sin);
           sin(Dioid{max,+}(π))
       end
0.0ᵧ
```
"""
function unary(fn::Function)
    m = parentmodule(fn)
    f = string(fn)
    
    body = """
    function $m.$f(x::Dioid{⨁, ⨀}) where {⨁, ⨀}
        return Dioid{⨁, ⨀}( $f(x.data) )
    end
    """
    return eval(Meta.parse(body))
end


# some normal unary math operations
Base.abs(x::Dioid)  = typeof(x)(abs(x.data))
Base.abs2(x::Dioid) = typeof(x)(abs2(x.data))
Base.sign(x::Dioid) = typeof(x)(sign(x.data))

Base.log(base::Int, x::Dioid) = typeof(x)(log(base, x.data))
Base.log(x::Dioid) = typeof(x)(log(x.data))
Base.log2(x::Dioid) = typeof(x)(log2(x.data))
Base.log10(x::Dioid) = typeof(x)(log10(x.data))

Base.exp(x::Dioid) = typeof(x)(exp(x.data))
Base.exp2(x::Dioid) = typeof(x)(exp2(x.data))
Base.exp10(x::Dioid) = typeof(x)(exp10(x.data))

Base.sqrt(x::Dioid) = typeof(x)(sqrt(x.data))
Base.isqrt(x::Dioid) = typeof(x)(isqrt(x.data))
Base.cbrt(x::Dioid) = typeof(x)(cbrt(x.data))

Base.real(x::Dioid) = typeof(x)(real(x.data))
Base.imag(x::Dioid) = typeof(x)(imag(x.data))

