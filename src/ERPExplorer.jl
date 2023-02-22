module ERPExplorer
    
using Colors
using TopoPlots
using StatsBase # mean/std
using Pipe
using ColorSchemes
using LinearAlgebra
using Makie
using GLMakie
using JLD2 # loading data
using DataFrames
using UnfoldMakie

include("slider_topoplot.jl")
include("click_butterfly_topoplot.jl")
include("click_topoplot.jl")
include("menu_butterfly_topoplot.jl")
include("slider_butterfly_topoplot.jl")
include("slider_topoplot.jl")
include("toggle_butterfly_topoplot.jl")

include("topo_color.jl")

export slider_topoplot
export click_butterfly_topoplot
export click_topoplot
export menu_butterfly_topoplot
export slider_butterfly_topoplot
export slider_topoplot
export toggle_butterfly_topoplot

end
