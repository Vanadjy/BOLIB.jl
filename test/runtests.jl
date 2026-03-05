using BOLIB
using Test
using ADNLPModels
using JLD2

issued_probs = [2, 3, 4, 5, 49, 51, 110, 113, 120, 123, 126, 131, 133, 134, 135, 138, 148, 162, 173]
prob_numbers = setdiff(collect(1:173), issued_probs)
prob_numbers = JLD2.load_object("prob_numbers.jld2")
#prob_numbers = setdiff(prob_numbers, issued_probs)
@testset "BOLIB.jl" begin
  include("data.jl")

  include("main_tests.jl")
  #include("ADNLPModels_tests.jl")
end
