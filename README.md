# 1. Package Installation 💾

```julia
using Pkg
Pkg.add("DioiD") # if registered, other wise use this repo's url as input
```

# 2. Customized Semirings 🛠️

**Dioid** is an alias for **semiring**, but much shorter for typing.

## 2.1 Constructor 🏭

We can use the type-precise constructor

```julia
Dioid{f₊, fₓ, S}(a)	                  # a would be converted to type S internally
```

or its type-inferred-by-input version

```julia
Dioid{f₊, fₓ}(b::S)
```

to mathematically customize the addition $+$ and multiplication $×$ operations between any elements $a$ and $b$ in a non-empty set $S$ as follows:

$$
\begin{align*}
    a + b := f_+(a, b)\\
    a × b := f_×(a, b)
\end{align*}
$$

where $f_+$ and $f_×$ are **user-defined binary functions**. Thus, programmatically we can assert

```julia
Dioid{f₊,fₓ}(a) + Dioid{f₊,fₓ}(b) == Dioid{f₊,fₓ}( f₊(a,b) )
Dioid{f₊,fₓ}(a) * Dioid{f₊,fₓ}(b) == Dioid{f₊,fₓ}( fₓ(a,b) )
```

For example, defining `+` as `min` at the addtion position and `*` as `+` at the multiplication position, leads to interesting results:

```julia
julia> Dioid{min,+}(2) + Dioid{min,+}(5)
2ᵧ

julia> Dioid{min,+}(2) * Dioid{min,+}(5)
7ᵧ
```

With this definition, the polynomial function $f(x,y) = x^3 + xy + y^2$ becomes piecewise linear function $f(x,y) = {\rm min}(3x, \ x+y, \ 2y)$.

## 2.2 Customizing 👨‍🍳🍽️

A semiring is an algebraic structure with two binary operations $\oplus$ and $\odot$ over a set $S$. Mathematically, a semiring is a system $(S,\oplus,\odot,\bar{0},\bar{1})$ where:

* $⊕$ is associative with $\bar{0} \in S$ as its identity element
* $⊙$ is associative with $\bar{1} \in S$ as its identity element
* $⊕$ is commutative
* $⊙$ distributes over $⊕$
* $\bar{0}$ is an annihilator for $⊙$

**Thus when defining a semiring programmatically, we need at least three essentials:**

* a data type $\rm T$
* $f_+$ and $f_×$ that defined over $\rm T$
* identity elements of $f_+$ and $f_×$ over $\rm T$

The definition of identity element is very important to the matrix multiplication over semirings. If zero, zeros, one, ones are not even used in your project, then just ignore the definition of identity elements.

### 2.2.1 Customizing via User Defined Data Types 👨‍💻

For demonstration purposes, let's define a type `Komplex` and its two binary op `f₊` and `fₓ`

```julia
struct Komplex
    r :: Float64    # real
    i :: Float64    # imag
end

function f₊(x::Komplex, y::Komplex)
    return Komplex(x.r + y.r, x.i + y.i)
end

function fₓ(x::Komplex, y::Komplex)
    a,b = x.r, x.i
    c,d = y.r, y.i
    return Komplex(a*c-b*d, a*d+b*c)
end

# define neutral elements for f₊ and fₓ over Komplex
Base.identity(::Val{f₊}, ::Type{Komplex}) = Komplex(0.0, 0.0)
Base.identity(::Val{fₓ}, ::Type{Komplex}) = Komplex(1.0, 0.0)
```

then we can create `Dioid{f₊,fₓ,Komplex}` or `Dioid{fₓ,f₊,Komplex}`. Let's see what would happen:

```julia
julia> zero(Dioid{f₊,fₓ,Komplex}), zero(Dioid{fₓ,f₊,Komplex})
(Komplex(0.0, 0.0)ᵧ, Komplex(1.0, 0.0)ᵧ)

julia> one(Dioid{f₊,fₓ,Komplex}), one(Dioid{fₓ,f₊,Komplex})
(Komplex(1.0, 0.0)ᵧ, Komplex(0.0, 0.0)ᵧ)

julia> Dioid{f₊,fₓ}(Komplex(3,4)) + Dioid{f₊,fₓ}(Komplex(3,-4))
Komplex(6.0, 0.0)ᵧ

julia> Dioid{f₊,fₓ}(Komplex(3,4)) * Dioid{f₊,fₓ}(Komplex(3,-4))
Komplex(25.0, 0.0)ᵧ
```

Notice that calling `zero` equals calling `identity` with input operation at the addition position, and calling `one` is equivalent to calling `identity` with input operation at the multiplication position. Give an example: calling `zero(Dioid{fₓ,f₊,Komplex})` equals calling `identity(Val(fₓ), Komplex)`, because `fₓ` is at the addition position.

### 2.2.2 Customizing via User Defined Binary Functions 👩‍💻

For a structure with many variables, we can directly use Julia's tuple data structure, and define the addition and multiplication operations on it. For demonstration purposes, let's define two binary op `c₊` and `cₓ` over a tuple and their corresponding identities

```julia
 function c₊(x::Tuple{Real,Real}, y::Tuple{Real,Real})
    xr, xi = x
    yr, yi = y
    return (xr + yr, xi + yi)
end

function cₓ(x::Tuple{Real,Real}, y::Tuple{Real,Real})
    a,b = x
    c,d = y
    return (a*c - b*d, a*d + b*c)
end

# define neutral elements for c₊ and cₓ over Tuple{T,T}
Base.identity(::Val{c₊}, ::Type{Tuple{T,T}}) where T<:Real = (zero(T), zero(T))
Base.identity(::Val{cₓ}, ::Type{Tuple{T,T}}) where T<:Real = (one(T),  zero(T))

# create an alias constructor
const Komplex{T} = Dioid{c₊,cₓ,Tuple{T,T}} where T

# customize a human-readable output
function Base.show(io::IO, ::MIME"text/plain", C::Komplex)
    x, y = C.data; y ≥ 0 && 
    return print(io, "$x + $(y)im");
    return print(io, "$x - $(-y)im");
end

# add a constructor function like:
function komplex(T::DataType, r::Real, i::Real)
    tp = (T(r), T(i))
    return Dioid{c₊,cₓ}(tp)
end
```

then let's do some test

```julia
julia> zeros(Komplex{Int}, 1,2)
1×2 Matrix{Dioid{c₊, cₓ, Tuple{Int64, Int64}}}:
 0 + 0im  0 + 0im

julia> ones(Komplex{Int}, 1,3)
1×3 Matrix{Dioid{c₊, cₓ, Tuple{Int64, Int64}}}:
 1 + 0im  1 + 0im  1 + 0im

julia> komplex(Int, 3,-4) + komplex(Int, 3,4)
6 + 0im

julia> komplex(Int, 3,-4) * komplex(Int, 3,4)
25 + 0im
```

As we've seen, `Komplex` behaves the same as the data type `Complex`.

### 2.2.3 Customizing via Readymade Data Types 🍕🍟🍦

We can create many common semirings by combining different fundamental data types and two binary operations e.g.

* `Dioid{max, +, Int}`, called max-plus or arctic semiring
* `Dioid{min, +, Float16}`, called min-plus or tropical semiring
* `Dioid{max, min, Float32}`, called bottleneck or fuzzy semiring
* `Dioid{max, *, Float64}`, maybe a possibilistic semring, with [0,1] input domain
* `Dioid{ logadd, +, Float32}`, where `logadd(a,b) = log(exp(a) + exp(b))`
* `Dioid{nlogadd, +, Float64}`, where `nlogadd(a,b) = -logadd(-a,-b)`
* `Dioid{lcprefix, *, String}`, called string semiring
* `Dioid{|, &, Bool}`, called boolean-semiring
* `Dioid{lcm, gcd, Union{Int,Rational}}`, called division-semiring
* `Dioid{+, *, Real}`, called arithmetic-semiring (we already studied it in the primary school)

All the above binary functions already have their own defined identity elements, just use them with no worry.

## 2.3 About the Alias 🌖🌙

We do **NOT** provide alias for any semiring to avoid naming bias. But for domain specific problems, alias are highly recommended for convenience. For example, users could define some `const` as

```julia
const MaxPlus = Dioid{max, +}	          # without data type for flexibility
const BoolSemiring = Dioid{|, &, Bool}    # with data type for accuracy
```

# 3. Function over Semirings 📈

## 3.1 Univariate Function f(x)

```julia
using Plots

f(x::Dioid) = value( (-580)*x^-126 + (-280)*x^10 + (-570)*x^220 )

x  = -10 : 0.1 : 10
yu = @. f( Dioid{max, +}(x) )  # upper bound
yl = @. f( Dioid{min, +}(x) )  # lower bound

plot( x, yu, line=(9, 0.3, :red),  label="upper bound", yrange=(-1500,1500))
plot!(x, yl, line=(9, 0.3, :blue), label="lower bound", xlabel="x", ylabel="y")
plot!(v -> -580 - 126v, x, line=(1.2,:red),   label="y = -580 - 126x", bg_legend=:transparent);
plot!(v -> -280 +  10v, x, line=(1.2,:green), label="y = -280 + 10x",  fg_legend=:transparent);
plot!(v -> -570 + 220v, x, line=(1.2,:blue),  label="y = -570 + 220x", framestyle=:box, grid=nothing)
```

## 3.2 Multivariate Function g(x,y,...)

```julia
using Plots

g(x::Dioid, y::Dioid) = value(18 + x + 2*y + 5*x*y + x^2 + y^2)

S = Dioid{logadd, +}
x = -12 : 0.6 : 16
y =  -9 : 0.7 : 15

X = repeat(S.(x'), length(y), 1)
Y = repeat(S.(y ), 1, length(x))
Z = map(g, X, Y)
wireframe(x, y, Z, camera=(-30,30), linewidth=1)
```

# 4. Array over Semirings ▦❒

General array operations can be extended to semiring arrays, e.g. matrix multiplication and broadcasting.

## 4.1 Identity Elements ⚖️

Identity elements of `Dioid{+, *, Float32}`

```julia
julia> zeros(Dioid{+, *, Float32}, 2,3)
2×3 Matrix{Dioid{+, *, Float32}}:
 0.0ᵧ  0.0ᵧ  0.0ᵧ
 0.0ᵧ  0.0ᵧ  0.0ᵧ

julia> ones(Dioid{+, *, Float32}, 2,3)
2×3 Matrix{Dioid{+, *, Float32}}:
 1.0ᵧ  1.0ᵧ  1.0ᵧ
 1.0ᵧ  1.0ᵧ  1.0ᵧ
```

Identity elements of `Dioid{logadd, +, Float16}`

```julia
julia> zeros(Dioid{logadd, +, Float16}, 2,3)
2×3 Matrix{Dioid{logadd, +, Float16}}:
 -∞  -∞  -∞
 -∞  -∞  -∞

julia> ones(Dioid{logadd, +, Float16}, 2,3)
2×3 Matrix{Dioid{logadd, +, Float16}}:
 0.0ᵧ  0.0ᵧ  0.0ᵧ
 0.0ᵧ  0.0ᵧ  0.0ᵧ
```

## 4.2 Random Elements 🎲

### 4.2.1 Uniform Sampling - rand ▁▇▇▇▁

```julia
# sampling from Int8, equivalent to Dioid{max,+}.(rand(Int8, 2,7,2))
julia> rand(Dioid{max,+,Int8}, 2,7,2)
2×7×2 Array{Dioid{max,+,Int8}, 3}:
[:, :, 1] =
 -17ᵧ  22ᵧ   82ᵧ  107ᵧ  -5ᵧ  110ᵧ  1ᵧ
 30ᵧ   -72ᵧ  72ᵧ  -62ᵧ  89ᵧ  -4ᵧ   53ᵧ

[:, :, 2] =
 -71ᵧ  104ᵧ  -85ᵧ  61ᵧ  -10ᵧ  -13ᵧ  -19ᵧ
 104ᵧ  -86ᵧ  51ᵧ   27ᵧ  -40ᵧ  118ᵧ  -124ᵧ

# sampling from Float16, equivalent to Dioid{max,+}.(rand(Float16, 3,8))
julia> rand(Dioid{max,+,Float16}, 3,8)
3×8 Matrix{Dioid{max,+,Float16}}:
 0.0522ᵧ  0.926ᵧ   0.9ᵧ     0.08105ᵧ  0.6157ᵧ  0.4355ᵧ  0.2417ᵧ   0.1997ᵧ
 0.4941ᵧ  0.0762ᵧ  0.5005ᵧ  0.395ᵧ    0.927ᵧ   0.933ᵧ   0.11035ᵧ  0.818ᵧ
 0.1990ᵧ  0.1362ᵧ  0.417ᵧ   0.351ᵧ    0.3228ᵧ  0.2446ᵧ  0.5493ᵧ   0.0716ᵧ

# sampling from Bool, equivalent to Dioid{|,&}.(rand(Bool, 5,8))
julia> rand(Dioid{|,&,Bool}, 5,8)
5×8 Matrix{Dioid{|,&,Bool}}:
 1  1  1  1  ·  1  ·  1
 ·  ·  1  1  1  1  1  1
 1  1  ·  ·  ·  ·  1  1
 ·  1  1  ·  ·  ·  ·  1
 1  1  ·  1  ·  1  ·  ·
```

### 4.2.2 Normal Sampling - randn ▁▂▃▅▇▅▃▂▁

This is **only** for floating data types i.e. `Float16 Float32 Float64 BigFloat`

```julia
julia> randn(Dioid{max,+,Float64})
0.7140054215169117ᵧ

julia> randn(Dioid{max,+,Float32}, 2)
2-element Vector{Dioid{max,+,Float32}}:
 -0.429939ᵧ
 -0.685833ᵧ

julia> randn(Dioid{max,+,Float16}, 2,7)
2×7 Matrix{Dioid{max,+,Float16}}:
 -1.593ᵧ  0.6343ᵧ  -1.167ᵧ  0.4136ᵧ  -1.103ᵧ  -1.711ᵧ   0.1772ᵧ
 1.006ᵧ   -1.846ᵧ  1.68ᵧ    1.201ᵧ   1.251ᵧ   0.05594ᵧ  0.4812ᵧ
```

## 4.3 Matrix Multiplication

In the context of semiring, matrix multiplication corresponds to composition of relations

$$
C_{ij} = ⨁_{k} A_{ik} ⊗B_{kj}\\
$$

Multiplication between `Dioid{max, min, Int}` matrices.

```julia
julia> w = Dioid{max, min}.([1  2;
                             3 -4]);

julia> x = Dioid{max, min}.([2;
                             0]);

julia> all(value.(w * x) .== [max(min(1,2), min( 2,0));
                              max(min(3,2), min(-4,0))])
true
```

Multiplication between `Dioid{+, <，Int}` matrices.

```julia
julia> a = Dioid{+, <}.([9 1 1])
1×3 Matrix{Dioid{+, <, Int64}}:
 9ᵧ  1ᵧ  1ᵧ

julia> b = Dioid{+, <}.([9 9 6]')
3×1 Matrix{Dioid{+, <, Int64}}:
 9ᵧ
 9ᵧ
 6ᵧ

# there are 2 ordered pairs
julia> a * b
1×1 Matrix{Dioid{+, <, Int64}}:
 2ᵧ
```

# 5. Degenerate into Monoid 🌓

`Dioid{inact, +, Int64}` where `inact` is an empty function not doing anything

```julia
julia> SR = Dioid{inact, +, Float32};
julia> rand(SR, 2,7) .* rand(SR, 2,7)
2×7 Matrix{Dioid{inact, +, Float32}}:
 0.687932ᵧ  0.535139ᵧ  1.15241ᵧ  1.52486ᵧ  0.678784ᵧ  0.999587ᵧ  1.19287ᵧ
 0.954109ᵧ  0.614643ᵧ  1.11546ᵧ  1.12719ᵧ  1.18688ᵧ   1.5886ᵧ    0.693601ᵧ

julia> rand(SR, 2,7) .+ rand(SR, 2,7)
ERROR: MethodError: no method matching inact(::Float32, ::Float32)
```

# 6. Unary Operation over Semirings 🕹️

Sometimes we want to operate on the internal data of a `Dioid` instance while still keeping the result as a `Dioid`, this is the opportunity to use the `unary` function

```julia
julia> unary(sin);

julia> sin(Dioid{max,+}(π))
0.0ᵧ
```

# 7. Why Semirings 🧠

* reduce problem complexity
* enable generic problem solving
* different semirings with different semantics of
  * the same problem
  * the same complexity
  * the same implementation algorithm

# 8. References 📖

* Marc Pouly. *Semirings for Breakfast*
* Baccelli, François et al. *Synchronization and Linearity: An Algebra for Discrete Event Systems*
