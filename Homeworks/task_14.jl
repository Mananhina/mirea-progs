using HorizonSideRobots
include("Functions.jl")
include("Structs.jl")

function cross_border(robot::Robot)
    cross_robot = PutmarkersRobot(robot)
    sides = [Nord, West, Sud, Ost]
    for side in sides
        m = movements!(cross_robot, side)
        rside = reverse_side(side)
        movements!(cross_robot, rside, m)
    end
    putmarker!(robot)
end


