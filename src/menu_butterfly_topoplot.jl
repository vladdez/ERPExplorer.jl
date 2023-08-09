function menu_butterfly_topoplot(data, pos; title="Interactive topoplot", interpolation=ClaughTochter(),
    sensornum=64, startpoint=-0.2, steps=100)
    N = 1:sensornum
    onset = 0.0
    steps = 1 ./ steps
    times = range(startpoint, length=size(data, 2), step=steps)
    endpoint = times[end]

    f = Figure(backgroundcolor=RGBf(0.98, 0.98, 0.98), resolution=(1500, 700))
    ax = Axis(f[1:3, 1], xlabel="Time [s]", ylabel="Voltage amplitude [µV]")

    N = 1:length(pos)
    hidespines!(ax, :t, :r)
    xlims!(startpoint, endpoint)
    hlines!(0, color=:gray, linewidth=1)
    vlines!(0, color=:gray, linewidth=1)

    datl = [mean(data[i, :, :], dims=2)[:, 1] for i = 1:sensornum]
    datl2 = reduce(hcat, datl)'
    datl2 = datl2 .- mean(datl2[:, times.<onset], dims=2) # basline correction

    num = Observable(1)

    begin
        tmp1 = repeat([0], sensornum)
        mark_color = @lift begin
            tmp1[1:end] .= 0
            if $num != 0
                tmp1[$num] = 1
            end
            return tmp1
        end
        red_line = @lift begin
            datl3 = datl2'
            tmp2 = datl3[:, 1]
            if $num != 0
                tmp2 = datl3[:, $num]
            end
            return tmp2
        end
    end

    series!(ax, times, datl2, solid_color="#4d4d4d")

    hidedecorations!(ax, label=false, ticks=false, ticklabels=false)
    topo_axis = Axis(f[1:2, 2], width=345, height=345, aspect=DataAspect(),
        limits=(-0.2, 1.2, -0.2, 1.2))

    cmap = collect(ColorScheme(range(colorant"black", colorant"red", length=2)))

    mark_size = repeat([21], sensornum)

    labels = ["s$i" for i in 1:sensornum]
    menu = Menu(f[3, 2], options=labels, default=nothing)
    topo = eeg_topoplot!(topo_axis, mark_color, N,
        labels;
        positions=pos[1:sensornum],
        interpolation=NullInterpolator(),
        enlarge=1,
        colormap=cmap,
        markersize=mark_size,
        label_text=false
    )

    lc = nothing
    on(menu.selection) do selected
        if selected != nothing
            if lc != nothing
                lc.color = "#4d4d4d"
                lc.linewidth = 1.5
            end
            num[] = findfirst(x -> x == menu.selection[], labels)
            lc = lines!(ax, times, red_line[], color="red", linewidth=5)
            notify(mark_color)
            notify(red_line)
        end
    end
    notify(menu.selection)
    hidedecorations!(topo_axis)
    hidespines!(topo_axis)
    f

end