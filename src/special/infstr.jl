"""
``Strinf`` is an **`infinite-possible-string`** having **`infinite`** kinds of variants, so we use 
symbol `∞` when printing. `Strinf` can be seen as such a string that any string `s ∈ ∞`, so that:
+ if `+` is `longest-common-prefix/suffix`, then `∞` + `s` = `s`
+ if `*` is concatenation, then `∞` * `s` = `∞`, i.e. still a `infinite-possible-string`
"""
struct Strinf <: AbstractString end


const s∞ = Strinf()
Base.ncodeunits(::Strinf) = 3
Base.codeunit(::Strinf) = UInt8
Base.iterate(::Strinf) = ("∞", 1)
Base.iterate(::Strinf, ::Integer) = nothing
Base.show(io::IO, x::Strinf) = print(io, "∞")
Base.isvalid(::Strinf, i::Integer) = isequal(i,1) ? true : false

promote_rule(::Type{Strinf}, ::Type{T}) where T <: AbstractString = T
promote_rule(::Type{T}, ::Type{Strinf}) where T <: AbstractString = T

# corner cases of "add"
lcprefix(::Strinf, y::AbstractString) = y
lcprefix(x::AbstractString, ::Strinf) = x
lcprefix( ::Strinf,         ::Strinf) = s∞

lcsuffix(::Strinf, y::AbstractString) = y
lcsuffix(x::AbstractString, ::Strinf) = x
lcsuffix( ::Strinf,         ::Strinf) = s∞


# corner cases of "mul"
Base.:*(::Strinf, ::AbstractString) = s∞
Base.:*(::AbstractString, ::Strinf) = s∞
Base.:*(::Strinf,         ::Strinf) = s∞



"""
    lcprefix(x::AbstractString, y::AbstractString)

Return the longest common prefix between `x` and `y`.
"""
function lcprefix(x::AbstractString, y::AbstractString)
    offset = 0  # offset from 1st index
    n = min(length(x), length(y))
    for i = 1:n
        !isequal(x[i], y[i]) && break
        offset = i
    end
    return x[1 : offset]
end



"""
    lcsuffix(x::AbstractString, y::AbstractString)

Return the longest common suffix between `x` and `y`.
"""
function lcsuffix(x::AbstractString, y::AbstractString)
    offset = 0   # offset from last index
    lx = length(x)
    ly = length(y)
    n  = min(lx, ly)
    while offset < n
        !isequal(x[lx-offset], y[ly-offset]) && break
        offset += 1
    end
    return x[lx-offset+1 : lx]
end


function Base.convert(::Type{Dioid{⨁, ⨀, AbstractString}}, 
                     x::Dioid{⨁, ⨀, Strinf}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, AbstractString}(value(x))
end


function Base.convert(::Type{Dioid{⨁, ⨀, AbstractString}}, 
                     x::Dioid{⨁, ⨀, String}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, AbstractString}(value(x))
end


function Base.convert(::Type{Dioid{⨁, ⨀, String}}, 
                     x::Dioid{⨁, ⨀, AbstractString}) where {⨁, ⨀}
    return Dioid{⨁, ⨀, String}(value(x))
end


function deprefix(x::AbstractString, y::AbstractString)
    lx = length(x)
    ly = length(y)
    if lx < ly
        error("length of \"$x\" is less than length of \"$y\"")
    end

    offset = 0  # offset from 1st index
    for i = 1:ly
        !isequal(x[i], y[i]) && break
        offset = i
    end
    return x[offset+1:lx]
end
