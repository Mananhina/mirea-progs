using HorizonSideRobots
include("Functions.jl")

function paint_stairs!(r::Robot)
    o = move_with_path!(r, Ost)
    s = move_with_path!(r, Sud)
    len = move_with_path!(r, West)
    len_cur_step = len
    num_side = 3

    while (!isborder(r, Nord)) && (len_cur_step > 0)
        move_n_steps_putmarkers!(r, HorizonSide(num_side), len_cur_step)
        len_cur_step -= 1
        move!(r, Nord)
        num_side = (num_side + 2) % 4
        if num_side == 1
            move!(r, West)
        end
    end

    if isborder(r, Nord)
        if num_side == 1
            move!(r, West)
        end
        move_n_steps_putmarkers!(r, HorizonSide(num_side), len_cur_step)
    end

    movements!(r, West)
    movements!(r, Sud)
    movements!(r, Ost, len - o)
    movements!(r, Nord, s)
end