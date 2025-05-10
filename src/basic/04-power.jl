# promoted by higher data type, in case of trunc error
Base.:^(x::Dioid{⨁, *, <:Integer}, n::Integer) where ⨁ = Dioid{⨁, *}( ᵛ(x) ^ n )
Base.:^(x::Dioid{⨁, +, <:Integer}, n::Integer) where ⨁ = Dioid{⨁, +}( ᵛ(x) * n )

# keep Dioid's data type
Base.:^(x::Dioid{⨁, *, T}, n::Real)    where {⨁, T} = Dioid{⨁, *, T}( ᵛ(x) ^ T(n) )
Base.:^(x::Dioid{⨁, *, T}, n::Integer) where {⨁, T} = Dioid{⨁, *, T}( ᵛ(x) ^ n )

# BE CAREFUL, if ⨀ op is +, then the radix must be positive integer
Base.:^(x::Dioid{⨁, +, T}, n::Integer) where {⨁, T} = Dioid{⨁, +, T}( ᵛ(x) * n )

# BE CAREFUL, if ⨀ op is max or min, then the radix must be positive integer
Base.:^(x::Dioid{⨁, min, T}, ::Integer) where {⨁, T} = x
Base.:^(x::Dioid{⨁, max, T}, ::Integer) where {⨁, T} = x

# BE CAREFUL, if ⨀ op is max or min, then the radix must be positive integer
Base.:^(x::Dioid{⨁,  logadd, T}, n::Integer) where {⨁, T} = Dioid{⨁,  logadd}( ᵛ(x) + T(log(n)) )
Base.:^(x::Dioid{⨁, nlogadd, T}, n::Integer) where {⨁, T} = Dioid{⨁, nlogadd}( ᵛ(x) - T(log(n)) )

#= 
inv is a op about symmetric, that is saying the input and output are symmetric about the identity of ⊙ operation.
Mathematically we have yᵧ = inv(xᵧ) iff xᵧ ⨀ yᵧ = 𝟙
=#
Base.inv(x::Dioid{⨁, *, T}) where {⨁,T} = Dioid{⨁, *}( inv(ᵛ(x)) )
Base.inv(x::Dioid{⨁, +, T}) where {⨁,T} = Dioid{⨁, +}(   - ᵛ(x)  )
Base.inv(x::Dioid{⨁, ⨀, T}) where {⨁,⨀,T} = div(one(Dioid{⨁,⨀,T}), x)

