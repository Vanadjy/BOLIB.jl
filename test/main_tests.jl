n_probs = length(F_data)
for i in prob_numbers
  bolib_prob = BOLIB.get_bilevel_problem(i)
  @testset "Problem $i" begin
    # Test dimensions
    dim_ref = dim_data[i]
    dim_bolib = bolib_prob.dim
    @test dim_bolib == dim_ref

    # Test x0
    x0_ref = x0_data[i]
    x0_bolib = BOLIB.get_x0(bolib_prob)
    @test isapprox(x0_bolib, x0_ref; atol=1e-6)
    @test length(x0_bolib) == dim_ref[1]

    # Test y0
    y0_ref = y0_data[i]
    y0_bolib = BOLIB.get_y0(bolib_prob)
    @test isapprox(y0_bolib, y0_ref; atol=1e-6)
    @test length(y0_bolib) == dim_ref[2]

    # Test xy0
    xy0_bolib = vcat(x0_bolib, y0_bolib)
    @test xy0_bolib == bolib_prob.xy0

    # Test F
    F_ref = F_data[i]
    F_bolib = bolib_prob.F_func(BOLIB.get_x0(bolib_prob), BOLIB.get_y0(bolib_prob))
    @test isapprox(F_bolib, F_ref; atol=1e-6)

    # Test f
    f_ref = f_data[i]
    f_bolib = bolib_prob.f_func(BOLIB.get_x0(bolib_prob), BOLIB.get_y0(bolib_prob))
    @test isapprox(f_bolib, f_ref; atol=1e-6)

    # Test G
    G_ref = G_data[i]
    G_bolib = bolib_prob.G_func(BOLIB.get_x0(bolib_prob), BOLIB.get_y0(bolib_prob))
    @test length(G_bolib) == dim_ref[3]
    if length(G_ref) == 0
      @test G_ref == G_bolib
    else
      @test isapprox(G_bolib, G_ref; atol=1e-6)
    end

    # Test g
    g_ref = g_data[i]
    g_bolib = bolib_prob.g_func(BOLIB.get_x0(bolib_prob), BOLIB.get_y0(bolib_prob))
    @test length(g_bolib) == dim_ref[4]
    if length(g_ref) == 0
      @test g_ref == g_bolib
    else
      @test isapprox(g_bolib, g_ref; atol=1e-6)
    end

    # Test optimal value
    F_star = get_opt_val(bolib_prob)
    F_star_ref = Ff_data[i][1]
    if !isnan(F_star) && !isnan(F_star_ref)
      @test isapprox(F_star, F_star_ref; atol=1e-1)
    end
  end
end