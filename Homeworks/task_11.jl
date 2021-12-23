using HorizonSideRobots
include("Functions.jl")
include("Structs.jl")

function cross_border(robot::Robot)
    cross_robot = MarkerBorderRobot(robot)
    sides = [Nord, West, Sud, Ost]
    for side in sides
        marker_to_edge!(cross_robot, side)
    end
end