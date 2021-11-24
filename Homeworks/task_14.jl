using HorizonSideRobots
include("Try_to_move.jl")

function cross_border(robot::Robot)
    sides = [Nord, West, Sud, Ost]
    for side in sides
        while try_move!(robot, side)
            putmarker!(robot)
        end

        rside = inverse(side)

        while ismarker(robot)
            try_move!(robot, rside)
        end
    end
    putmarker!(robot)
end


