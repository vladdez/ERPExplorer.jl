function slider_topoplot(data, pos;
    title="Interactive topoplot",
    interpolation=ClaughTochter())
    f = Figure(resolution=(1000, 900))
    N = 1:length(pos)
    xs = range(0, length=size(data, 2), step=1 ./ 100)
    sg = SliderGrid(f[2, 1],
        (label="time", range=xs, format="{:.3f} ms", startvalue=0),
    )
    time = sg.sliders[1].value

    topo_slice = lift((t, data) -> mean(data[:, indexin(t, xs), :], dims=2)[:, 1], time, data)
    topo_axis = Axis(f[1, 1], aspect=DataAspect(), title=title, titlesize=36,)

    topo = eeg_topoplot!(topo_axis, topo_slice, N,
        positions=pos,
        interpolation=interpolation,
        enlarge=1.2,
        markersize=10,
    )
    # decrement/increment slider with left/right keys
    on(events(f).keyboardbutton) do btn
        if btn.action in (Keyboard.press, Keyboard.repeat)
            if btn.key == Keyboard.left
                set_close_to!(sg.sliders[1], time[] - 1)
            elseif btn.key == Keyboard.right
                set_close_to!(sg.sliders[1], time[] + 1)
            end
        end
    end
    str = lift(t -> "[$(round(t, digits = 3)) ms]", time)
    text!(topo_axis, 1, 1, text=str, align=(:center, :center))
    hidedecorations!(topo_axis)
    hidespines!(topo_axis)

    f
end