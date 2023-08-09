include("setup.jl")




@testset "click_butterfly_topoplot" begin
    data, pos = TopoPlots.example_data()
    #Makie.inline!(true)
    click_butterfly_topoplot(data, pos)
end


@testset "click_topoplot" begin
    data, pos = TopoPlots.example_data()
    click_topoplot(data, pos)
end

@testset "menu_butterfly_topoplot" begin
    data, pos = TopoPlots.example_data()
    menu_butterfly_topoplot(data, pos)
end

@testset "slider_butterfly_topoplot" begin
    data, pos = TopoPlots.example_data()
    slider_butterfly_topoplot(data, pos)
end

@testset "slider_topoplot" begin
    data, pos = TopoPlots.example_data()
    slider_topoplot(data, pos)
end


@testset "toggle_butterfly_topoplot" begin
    data, pos = TopoPlots.example_data()
    toggle_butterfly_topoplot(data, pos)
end
