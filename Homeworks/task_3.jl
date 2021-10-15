using HorizonSideRobots
robot = Robot()

function put_markers_to_border!(r::Robot, side::HorizonSide)
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
    end
end

function move_with_path!(r::Robot, side::HorizonSide)
    c = 0
    while !isborder(r, side)
        move!(r, side)
        c += 1
    end
    return c
end

function move_n_steps!(r::Robot, side::HorizonSide, n::Int)
    while n > 0
        move!(r, side)
        n -= 1
    end
end

function paint_inside(robot::Robot)
    w = move_with_path!(robot, West)
    n = move_with_path!(robot, Nord)

    putmarker!(robot)

    while !isborder(robot, Sud)
        side = HorizonSide((isborder(robot, West) * 3) + (isborder(robot, Ost) * 1))
        put_markers_to_border!(robot, side)
        move!(robot, Sud)
        putmarker!(robot)
    end
    side = HorizonSide((isborder(robot, West) * 3) + (isborder(robot, Ost) * 1))
    put_markers_to_border!(robot, side)

    _ = move_with_path!(robot, West)
    __ = move_with_path!(robot, Nord)
    move_n_steps!(robot, Ost, w)
    move_n_steps!(robot, Sud, n)
end
