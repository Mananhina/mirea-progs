using HorizonSideRobots

function reverse_side(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function draw_cross(robot::Robot)
    sides = [Nord, West, Sud, Ost]
    for side in sides
        while !isborder(robot, side)
            move!(robot, side)
            putmarker!(robot)
        end

        rside = reverse_side(side)

        while ismarker(robot)
            move!(robot, rside)
        end
    end
    putmarker!(robot)
end

