using HorizonSideRobots
include("BackPath.jl")
include("Try_to_move.jl")

function paint_stair(r::Robot)
    back_path = BackPath(r)

    to_sud_west_corner = BackPath(r)
    back!(r, back_path)        
end