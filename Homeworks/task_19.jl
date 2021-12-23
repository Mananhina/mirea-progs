using HorizonSideRobots
include("Functions.jl")
include("Structs.jl")

function find_marker(r::Robot)
    i = 3
    keep_const = 0
    counter = 0
    robot = MarkerBoundlessRobot(r)
    while !ismarker(robot)
        movements!(robot, HorizonSide(i % 4), counter + keep_const)
        i += 1
        keep_const = 1 - 1 * keep_const
        counter += keep_const
    end
end
