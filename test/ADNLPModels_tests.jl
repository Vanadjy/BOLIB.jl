for i in prob_numbers
#bolib_prob = BOLIB.get_bilevel_problem(i)
model = BOLIB.get_bilevel_problem(i)
if i ∈ [79, 80] # Those problems cannot be converted in ADNLPModels as f is defined with an if/then/else statement.
    continue
else
    @testset "$(model.name)" begin
    F(x) = model.F_func(x[1:model.dim[1]], x[model.dim[1]+1:model.dim[1]+model.dim[2]])
    f(x) = model.f_func(x[1:model.dim[1]], x[model.dim[1]+1:model.dim[1]+model.dim[2]])
    G(x) = model.G_func(x[1:model.dim[1]], x[model.dim[1]+1:model.dim[1]+model.dim[2]])
    g(x) = model.g_func(x[1:model.dim[1]], x[model.dim[1]+1:model.dim[1]+model.dim[2]])

    xy0 = model.xy0

    # Variable box-constraints may be changed depending on the problem
    n = model.dim[1] + model.dim[2]
    lvar_lower = -Inf.*ones(n)
    uvar_lower = Inf.*ones(n)

    lvar_upper = -Inf.*ones(n)
    uvar_upper = Inf.*ones(n)

    # Bounds for the constraints
    G_lower = -Inf.*ones(model.dim[3])
    G_upper = zeros(model.dim[3])

    g_lower = -Inf.*ones(model.dim[4])
    g_upper = zeros(model.dim[4])

    nlp_lower = ADNLPModel(f, xy0, lvar_lower, uvar_lower, g, g_lower, g_upper) # Generates an ADNLPModel for the lower-level problem
    nlp_upper = ADNLPModel(F, xy0, lvar_upper, uvar_upper, G, G_lower, G_upper) # Generates an ADNLPModel for the upper-level problem

    meta_lower = nlp_lower.meta
    @test meta_lower.x0 == xy0
    @test meta_lower.nvar == model.dim[1] + model.dim[2]
    @test length(meta_lower.lcon) == model.dim[4]
    @test length(meta_lower.ucon) == model.dim[4]
    @test meta_lower.minimize == true

    meta_upper = nlp_upper.meta
    @test meta_upper.x0 == xy0
    @test meta_upper.nvar == model.dim[1] + model.dim[2]
    @test length(meta_upper.lcon) == model.dim[3]
    @test length(meta_upper.ucon) == model.dim[3]
    @test meta_upper.minimize == true
    end
end
end