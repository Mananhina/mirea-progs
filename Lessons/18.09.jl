function movements!(r:: Robot, side::HorizonSide)
    """Move robot to reach the end."""
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c += 1
    end
    return c
end


function movements!(r::Robot, side::HorizonSide, num::Integer)
    """Move robot num steps in side direction."""
    while num > 0
        move!(r, side)
        num -= 1
    end
end


function to_corner(r:: Robot, side1::HorizonSide, side2::HorizonSide)
    """Move robot to the corner of side1 & side2"""
    s1s2 = [0, 0]
    while !isborder(r, side1) || !isborder(r, side2)
        s1s2[1] += movements!(r, side1)
        s1s2[2] += movements!(r, side2)
    end
    return s1s2
end


sw, no = to_corner(r, Sud, West), [0, 0]

for sides in [[Sud, West], [Nord, Ost]]
    for i = 1:2
        movements!(r, HorizonSide((Int(sides[i]) + 2) % 4), abs(sw[i] - no[i]))
        putmarker!(r)
        movements!(r, sides[i], abs(sw[i] - no[i]))
    end
    global no = to_corner(r, Nord, Ost)
end

movements!(r, Sud, abs(no[1] - sw[1]))
movements!(r, West, abs(no[2] - sw[2]))
