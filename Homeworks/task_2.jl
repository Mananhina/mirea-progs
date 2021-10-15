using HorizonSideRobots
r = Robot()
function paint_perimeter(robot::Robot)
    c = 0
    while !isborder(robot, West)
        move!(robot, West)
        c += 1
    end

    sides = [Nord, Ost, Sud, West]
    for side in sides
        while !isborder(robot, side)
            putmarker!(robot)
            move!(robot, side)
        end
    end

    while !ismarker(robot)
        putmarker!(robot)
        move!(robot, Nord)
    end

    while c > 0
        move!(robot, Ost)
        c -= 1
    end
end
