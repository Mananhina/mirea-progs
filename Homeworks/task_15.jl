using HorizonSideRobots
include("BackPath.jl")

function paint_perimeter(r::Robot)
    back_path = BackPath(r)
    sides = [Nord, Ost, Sud, West]
    for side in sides
        while !isborder(r, side)
            move!(r, side)
            putmarker!(r)
        end
    end
    back!(r, back_path)
end
