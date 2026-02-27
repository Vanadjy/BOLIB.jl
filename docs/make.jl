using BOLIB
using Documenter

DocMeta.setdocmeta!(BOLIB, :DocTestSetup, :(using BOLIB); recursive = true)

makedocs(;
  modules = [BOLIB],
  doctest = true,
  linkcheck = false,
  strict = false,
  authors = "Valentin Dijon <vanadjy@gmail.com> and contributors",
  repo = "https://github.com/Vanadjy/BOLIB.jl/blob/{commit}{path}#{line}",
  sitename = "BOLIB.jl",
  format = Documenter.HTML(;
    prettyurls = get(ENV, "CI", "false") == "true",
    canonical = "https://Vanadjy.github.io/BOLIB.jl",
    assets = ["assets/style.css"],
  ),
  pages = ["Home" => "index.md", "Reference" => "reference.md"],
)

deploydocs(;
  repo = "github.com/Vanadjy/BOLIB.jl",
  push_preview = true,
  devbranch = "main",
)
