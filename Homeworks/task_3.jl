function paint_inside(robot::Robot)
    w = 0
    while !isborder(robot, West)
        move!(robot, West)
        w += 1
    end
    n = 0
    while !isborder(robot, Nord)
        move!(robot, Nord)
        n += 1
    end

    while !isborder(robot, Sud)
        side = HorizonSide((isborder(robot, West) * 3) + (isborder(robot, Ost) * 1))
        while !isborder(robot, side)
            putmarker!(robot)
            move!(robot, side)
        end
        move!(robot, Sud)
    end
end
