using HorizonSideRobots
include("Functions.jl")

function draw_skew_cross(robot::Robot)
    sides_tuple = [(Nord, Ost), (Nord, West), (Sud, West), (Sud, Ost)]
    for sides in sides_tuple
        while (!isborder(robot, sides[1]) && !isborder(robot, sides[2]))
            move!(robot, sides[1])
            move!(robot, sides[2])
            putmarker!(robot)
        end

        rsides = reverse_side.(sides)

        while ismarker(robot)
            move!(robot, rsides[1])
            move!(robot, rsides[2])
        end
    end
    putmarker!(robot)
end
