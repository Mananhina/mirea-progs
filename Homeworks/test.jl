using HorizonSideRobots
include("BackPath.jl")
include("Structs.jl")

function chess_putmarker!(robot::Robot)
    back_path = BackPath(robot)
    r = ChessRobot(robot)
    if sum(back_path.path) % 2 == r.flag
        r.flag = (r.flag - 1) * (-1)
    else
        putmarker!(robot)
    end

    snake(r)
    to_sud_west_corner = BackPath(robot)
    back!(robot, back_path)    
end