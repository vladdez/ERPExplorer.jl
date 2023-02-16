function click_topoplot(data, pos; interpolation=ClaughTochter(),
    sensornum=64) 

    f = Figure(backgroundcolor = RGBf(0.98, 0.98, 0.98))
    N = 1:length(pos)

    topo_axis = Axis(f[1, 1],  aspect = DataAspect())
    
	xlims!(low = -0.2, high = 1.2)
	ylims!(low = -0.2, high = 1.2)
    
    mark_size = repeat([21], sensornum)
    mark_color = repeat([1], sensornum)
    labels = ["s$i" for i in 1:sensornum]
    topo = eeg_topoplot!(topo_axis, data[:, 340, 1], labels;
        mark_color,  N, 
        positions=pos[1:sensornum], 
        interpolation=NullInterpolator(),
        enlarge=1,
        label_text=false, 
        label_scatter=(markersize=mark_size, color=:black)
    ) 
    hidedecorations!(current_axis())
    hidespines!(current_axis())

    i = Observable(1)
    str = lift((i, labels) -> "$(labels[i])", i, labels)
    text!(topo_axis, 1, 1, text = str,  align = (:center, :center))
    on(events(f).mousebutton, priority = 2) do event
        if event.button == Mouse.left && event.action == Mouse.press
            plt, p = pick(topo_axis)
            i[] = p
        end
    end
    f
end