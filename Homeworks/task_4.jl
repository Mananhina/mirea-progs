using HorizonSideRobots
robot = Robot()

function movements!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
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

function move_n_steps_putmarkers!(r::Robot, side::HorizonSide, n::Int)
    putmarker!(r)
    while n > 0
        move!(r, side)
        putmarker!(r)
        n -= 1
    end
end

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
    move_n_steps!(r, Ost, len - o)
    move_n_steps!(r, Nord, s)
end