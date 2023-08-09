function click_butterfly_topoplot(data, pos; title="Interactive topoplot", interpolation=ClaughTochter(),
    sensornum=64, startpoint=-0.2, steps=100)  

    N = 1:sensornum
    onset = 0.0
    steps = 1 ./ steps
    times = range(startpoint, length=size(data, 2), step=steps)  
    endpoint = times[end]

    f = Figure(backgroundcolor = RGBf(0.98, 0.98, 0.98), resolution = (1500, 700))
    ax = Axis(f[1:3, 1], xlabel = "Time [s]", ylabel = "Voltage amplitude [µV]")

    hidespines!(ax, :t, :r) 
    xlims!(startpoint, endpoint)
    hlines!(0, color = :gray, linewidth = 1)
    vlines!(0, color = :gray, linewidth = 1)
    
    datl = [mean(data[i,:,:], dims=2)[:,1] for i = 1:sensornum]
    datl2 = reduce(hcat, datl)'
    datl2 = datl2 .- mean(datl2[:,times .< onset], dims=2) # basline correction

    i = Observable(15)
    begin
        tmp1 = repeat([0], sensornum)
        mark_color = @lift begin
            tmp1[1:end] .= 0
            if $i != 0
                tmp1[$i] = 1
            end
            return tmp1

        end
        red_line = @lift begin
            datl3 = datl2'
            tmp2 = datl3[:, 1]  
                if $i != 0
                    tmp2 = datl3[:, $i]
                end
                return tmp2
        end
    end

    series!(ax, times, datl2, solid_color="#4d4d4d")
    topo_axis = Axis(f[2:3, 2], width = 345, height = 345, aspect = DataAspect(),
        limits=(0.2, 0.8, 0.2, 0.8))
 
    cmap = collect(ColorScheme(range(colorant"black", colorant"red", length=2)))
    mark_size = repeat([21], sensornum)

    topo = eeg_topoplot!(topo_axis, mark_color,  N, 
        pos[1:sensornum]; 
        positions=pos[1:sensornum], # produced  automatically from ch_names
        interpolation=NullInterpolator(),
        enlarge=1,
        colormap = cmap,
        markersize = mark_size,
        label_text=false
    ) 
    
    labels = ["s$i" for i in 1:sensornum]
    str = lift((i, labels) -> "$(labels[i])", i, labels)
    Label(f[1, 2], str,
        fontsize =36, font = :bold, padding = (0, 0, 0, 50), halign = :center)

    lc = nothing
    on(events(f).mousebutton, priority = 2) do event
        if event.button == Mouse.left && event.action == Mouse.press

            plt, p = pick(topo_axis)
            i[] = p
            if lc != nothing
                lc.color  = "#4d4d4d"
                lc.linewidth  = 1.5
            end
            lc = lines!(ax, times, red_line[], color = "red", linewidth = 5)

        end
    end
    hidedecorations!(ax, label = false, ticks = false, ticklabels = false) 
    hidedecorations!(topo_axis)    
    hidespines!(topo_axis)
    f
end
