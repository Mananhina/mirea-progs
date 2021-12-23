using HorizonSideRobots
include("BackPath.jl")
include("Structs.jl")

function paint_perimeter(robot::Robot)
    back_path = BackPath(robot)
    r = PutmarkersRobot(robot)
    sides = [Nord, Ost, Sud, West]
    for side in sides
        movements!(r, side)
    end
    back!(robot, back_path)
end
