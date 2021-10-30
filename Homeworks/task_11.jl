using HorizonSideRobots
include("BackPath.jl")

function border_markers(r::Robot)
    to_sw_corner = BackPath(r)
    a, b = 0, 0
    for i in 1:length(to_sw_corner.path)
        if i % 2 == 1
            b += to_sw_corner.path[i]
        else
            a += to_sw_corner.path[i]
        end
    end
    to_no_corner = BackPath(r, (Nord, Ost))
    l, h = to_no_corner.path[1], to_no_corner.path[2]
    _ = BackPath(r) # Робот в Юго-Западном углу
    steps = [a, b, h - a, l - b]
    cur_side = Nord
    for st in steps
        movements!(r, cur_side, st)
        putmarker!(r)
        while !isborder(r, cur_side)
            move!(r, cur_side)
        end
        cur_side = HorizonSide((Int(cur_side) + 3) % 4)
    end
    back!(r, to_sw_corner)
end