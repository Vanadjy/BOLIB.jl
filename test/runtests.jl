using BOLIB
using Test
using ADNLPModels
using JLD2

issued_probs = [2, 3, 17, 25, 51, 113, 120, 123, 126, 131, 132, 138, 148, 162, 173]
prob_numbers = setdiff(collect(1:173), issued_probs)
@testset "BOLIB.jl" begin
  include("data.jl")

  include("main_tests.jl")
  include("ADNLPModels_tests.jl")
end
