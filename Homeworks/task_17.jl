using HorizonSideRobots
include("BackPath.jl")
include("Try_to_move.jl")

function left(side::HorizonSide)
    return(HorizonSide((Int(side) + 1) % 4))
end


function try_move!(r::Robot,side::HorizonSide)::Int
    ort_side = left(side)
    n=0
    while isborder(r,side)
        if !isborder(r,ort_side)
            move!(r,ort_side)
            n += 1
        else
            break
        end
    end
    if isborder(r,side)
        movements!(r,inverse(ort_side),n)
        return -2
    end
    move!(r,side)
    m = 0
    while (isborder(r,inverse(ort_side)) && n != 0)
        move!(r,side)
        m += 1
    end
    movements!(r,inverse(ort_side),n)
    return m
end

function try_move_to_wall!(r::Robot, side::HorizonSide)
    while (try_move!(r, side) != -2)
    end
end

function move_n_steps_putmarkers!(r::Robot, side::HorizonSide, n::Int)
    putmarker!(r)
    while n > 0
        m = try_move!(r, side)
        n = n - 1 - m
        if n > -1
            putmarker!(r)
        end
    end
end

function paint_stair(r::Robot)
    back_path = BackPath(r)
    len_cur_step = movements!(r, Ost) 
    movements!(r, West, len_cur_step)
    while (!isborder(r, Nord) || !isborder(r, West)) && (len_cur_step > 0)
        move_n_steps_putmarkers!(r, Ost, len_cur_step)
        len_cur_step -= 1
        try_move!(r, Nord)
        try_move_to_wall!(r, West)
    end
    if isborder(r, Nord)
        move_n_steps_putmarkers!(r, Ost, len_cur_step)
    end

    to_sud_west_corner = BackPath(r)
    back!(r, back_path)        
end