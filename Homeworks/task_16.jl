using HorizonSideRobots
include("BackPath.jl")
include("Try_to_move.jl")

function paint_all(r::Robot)
    back_path = BackPath(r)
    putmarker!(r)
    side = Ost
    while !isborder(r, Nord)
        while try_move!(r, side)
            putmarker!(r)
        end
        side = HorizonSide((Int(side) + 2) % 4)
        move!(r, Nord)
        putmarker!(r)
    end
    while try_move!(r, side)
        putmarker!(r)
    end
    to_sud_west_corner = BackPath(r)
    back!(r, back_path)        
end