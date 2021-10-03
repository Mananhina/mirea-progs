function find_marker(robot::Robot)
    sides = [Nord, Ost, Sud, West] 
    c = 0
    while !ismarker(robot)
        move!(robot, West)
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