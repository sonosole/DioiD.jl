import Base.identity

"""
    identity(::Val{func}, T::DataType) = identity_element_of_func_in_domain_T

define the identity-element of `func`::Function in domain `T`. here is an example of max for general data type

    identity(::Val{max}, T::DataType) = typemin(T); or
    identity(::Val{max}, ::Type{T}) where T <: Real = typemin(T);

or specific data types for max

    identity(::Val{max}, ::Float32) = -Inf32;
    identity(::Val{max}, ::Int8) = -128;

# Example
```julia
struct XType
    data::String
    function XType(x)
        new(x)
    end
end

function A end
function M end

Base.identity(::Val{A}, ::Type{XType}) = XType("𝟘")
Base.identity(::Val{M}, ::Type{XType}) = XType("𝟙")

julia> zeros(Dioid{A,M,XType}, 1,3)
1×3 Matrix{Dioid{A, M, XType}}:
 XType("𝟘")  XType("𝟘")  XType("𝟘")

julia> zeros(Dioid{M,A,XType}, 1,3)
1×3 Matrix{Dioid{M, A, XType}}:
 XType("𝟙")  XType("𝟙")  XType("𝟙")

julia> ones(Dioid{A,M,XType}, 1,3)
1×3 Matrix{Dioid{A, M, XType}}:
 XType("𝟙")  XType("𝟙")  XType("𝟙")

julia> ones(Dioid{M,A,XType}, 1,3)
1×3 Matrix{Dioid{M, A, XType}}:
 XType("𝟘")  XType("𝟘")  XType("𝟘")
```
"""
function identity(f::Function, T::DataType)
    error("""
    your identity defined for $f here is not correct :/
    you have to follow the following style:

        Base.identity(::Val{fn}, T::DataType) = identity_element_of_func_in_domain_T;

    here is an example of max for general data type

        Base.identity(::Val{max}, T::DataType) = typemin(T); or
        Base.identity(::Val{max}, ::Type{T}) where T <: Real = typemin(T);

    or specific data types for max

        Base.identity(::Val{max}, ::Float32) = -Inf32;
        Base.identity(::Val{max}, ::Int8) = -128;
    """)
end


identity(::Val{ logadd}, T::DataType) = typemin(T)
identity(::Val{nlogadd}, T::DataType) = typemax(T)

identity(::Val{max}, T::DataType) = typemin(T)
identity(::Val{min}, T::DataType) = typemax(T)

identity(::Val{+}, T::DataType) = zero(T)
identity(::Val{*}, T::DataType) =  one(T)

identity(::Val{|}, ::Bool) = false
identity(::Val{&}, ::Bool) = true


function Base.zero(::Type{Dioid{⨁, ⨀, T}}) where {⨁, ⨀, T}
    return Dioid{⨁, ⨀, T}( identity(Val(⨁), T) )
end

function Base.one(::Type{Dioid{⨁, ⨀, T}}) where {⨁, ⨀, T}
    return Dioid{⨁, ⨀, T}( identity(Val(⨀), T) )
end

