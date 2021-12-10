using HorizonSideRobots
include("BackPath.jl")

function put_marker_in_corners!(r::Robot)
    back_path = BackPath(r)
    sides = [Nord, Ost, Sud, West]
    for side in sides
        while !isborder(r, side)
            move!(r, side)
        end
        putmarker!(r)
    end
    back!(r, back_path)
end