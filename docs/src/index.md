```@meta
CurrentModule = BOLIB
```

# BOLIB

Documentation for [BOLIB](https://github.com/Vanadjy/BOLIB.jl).

## Compatibility

Julia 1.11

## How to Install

````JULIA
pkg> add BOLIB
pkg> test BOLIB
````

## How to use

This package provides an open source access to Bilevel Optimization toy problems available in MATLAB at the original [BOLIB](https://biopt.github.io/bolib/) library. The general structure of these problems is

$$
    \begin{aligned}
    \min_{x \in X, y \in \R^{n_y}} \quad  & F(x,y)  \\
    \st \quad & G(x,y)  \le 0 \\
        & y \in   \argmin {z \in Y} \quad  f(x,z)\\
        & \quad \quad \quad \; \st \quad g(x,z) \le 0. \\
    \end{aligned}
$$

To generate a bilevel problem with the BilevelProblem structure, one can use either the problem number or its name.

````JULIA
problem_number = 1 # Problem number can be from 1 to 172
model = get_bilevel_problem(problem_number)

problem_name = "AiyoshiShimizu1984Ex2"
model = get_bilevel_problem(problem_name)
````

The available starting point $(x_0, y_0)$ given by the BOLIB library can be get from the structure itself or by using the functions `get_x0` or `get_y0`.

````JULIA
x0 = get_x0(model)
y0 = get_y0(model)
xy0 = model.xy0
@assert xy0 == vcat(x0, y0)
````

Functions of a bilevel problem can be evaluated separately through the fields of the BilevelProblem structure.

````JULIA
F = model.F_func
F(x0, y0) # Returns a value

g = model.g_func
g(x0, y0) # Returns a vector
````

It is also possible to generate an ADNLPModel for both upper-level and lower-level problems to have access to automatically generated derivatives for objective functions and constraints. Since this package is initialy designed for a DFO setting, ADNLPModels allow to use first and second order methods to solve BOLIB problems.