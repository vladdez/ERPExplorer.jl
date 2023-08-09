function toggle_butterfly_topoplot(data, pos; title="Interactive topoplot", interpolation=ClaughTochter(),
    sensornum=64, startpoint=-0.2, steps=100)
    N = 1:sensornum
    onset = 0.0
    steps = 1 ./ steps
    times = range(startpoint, length=size(data, 2), step=steps)
    endpoint = times[end]

    running = Observable(false)
    function toggle_running()
        running[] = !running[]
    end

    f = Figure(backgroundcolor=RGBf(0.98, 0.98, 0.98), resolution=(1500, 700))
    ax = Axis(f[1:3, 1], xlabel="Time [s]", ylabel="Voltage amplitude [µV]")

    hidespines!(ax, :t, :r)
    xlims!(startpoint, endpoint)
    hlines!(onset, color=:gray, linewidth=1)
    vlines!(onset, color=:gray, linewidth=1)

    index = Observable(2)
    multicolor = ColorScheme(vcat(RGB(1, 1, 1.0), [posToColorRomaO(pos) for pos in pos[N]]...))[2:sensornum+1]
    solidcolor = collect(ColorScheme(range(colorant"#4d4d4d", colorant"#4d4d4d", length=sensornum)))
    specialColors = @lift($running ? multicolor : solidcolor)

    datl = [mean(data[i, :, :], dims=2)[:, 1] for i = 1:sensornum]
    datl2 = reduce(hcat, datl)'
    datl2 = datl2 .- mean(datl2[:, times.<onset], dims=2) # basline correction !!!!
    ser = series!(ax, times, datl2, color=specialColors)

    hidedecorations!(ax, label=false, ticks=false, ticklabels=false)

    topo_axis = Axis(f[1:2, 2], width=345, height=345, aspect=DataAspect(),
        limits=(-0.2, 1.2, -0.2, 1.2))

    topo = eeg_topoplot!(topo_axis, N, pos[1:sensornum];
        positions=pos[1:sensornum],
        interpolation=NullInterpolator(),
        #colorrange = (0, sensornum), # add the 0 for the white-first color
        colormap=specialColors,
        label_scatter=(markersize=20, strokewidth=0.5)
    )


    hidedecorations!(topo_axis)
    hidespines!(topo_axis)

    f[3, 2] = buttongrid = GridLayout(tellwidth=false)
    btn = Button(f, label=@lift($running ? "COLORED" : "SOLID"))
    buttongrid[1, 1:1] = [btn]

    on(btn.clicks) do _
        toggle_running()
    end
    f
end