# butterflyplot with interactiv topoplot
function slider_butterfly_topoplot(data, pos; 
        title="Interactive topoplot", 
        interpolation=ClaughTochter(),
        sensornum=64, startpoint=-0.2, steps=100) 
    N = 1:sensornum
    onset = 0.0
    steps = 1 ./ steps
    times = range(startpoint, length=size(data, 2), step=steps)  
    endpoint = times[end]
    f = Figure(backgroundcolor = RGBf(0.98, 0.98, 0.98), resolution = (1500, 700))

    # interaction
    
    sg = SliderGrid(f[4, 1:3],
        (label="time", range=times, format = "{:.3f} ms", startvalue = 0),
    )
    time = sg.sliders[1].value
    str = lift(t -> "$(round(t, digits = 3)) ms", time)
    topo_slice = lift((t, data) -> mean(data[1:sensornum, indexin(t, times), :], dims=2)[:,1], time, data)

    # butterfly plot
    ax = Axis(f[2:3, 1:3], xlabel = "Time [s]", ylabel = "Voltage amplitude [µV]")

    hidespines!(ax, :t, :r) 
    xlims!(startpoint, endpoint)
    hlines!(0, color = :gray, linewidth = 1)
    vlines!(onset, color = :gray, linewidth = 1)
    specialColors = ColorScheme(vcat(RGB(1,1,1.),[posToColorRomaO(pos) for pos in pos[N]]...))

    datl = [mean(data[i,:,:],dims=2)[:,1] for i = 1:sensornum]
    datl2 = reduce(hcat, datl)'
    datl2 = datl2 .- mean(datl2[:,times .< onset], dims=2)
    series!(ax, times, datl2, color = specialColors[2:sensornum+1])
    
    hidedecorations!(ax, label = false, ticks = false, ticklabels = false) 
    vlines!(time, color = :red, linewidth = 1)

    # topoplot 
    topo_axis = Axis(f[1, 2], width = 178, height = 178, aspect = DataAspect())
    topo = eeg_topoplot!(topo_axis, topo_slice, N, 
        positions=pos[1:sensornum], 
        enlarge=1,
        #colormap= specialColors
    )

    hidedecorations!(topo_axis)
    hidespines!(topo_axis)

    Label(f[1, 2], str,
        textsize =36, font = :bold, padding = (40, 500, 0, 0), halign = :right)

    hidedecorations!(current_axis())
    hidespines!(current_axis())
    f
end