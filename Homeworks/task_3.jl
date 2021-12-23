using HorizonSideRobots
include("Functions.jl")

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
    movements!(robot, Ost, w)
    movements!(robot, Sud, n)
end
