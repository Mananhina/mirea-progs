function reverse_side(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
    end
end

function put_markers_to_border!(r::Robot, side::HorizonSide)
    while !isborder(r, side)
        move!(r, side)
        putmarker!(r)
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

function movements!(r::Robot, side::HorizonSide, n::Int)
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

function steps_to_border!(r::Robot, side::HorizonSide)
    n = 0
    while !isborder(r, side)
        move!(r, side)
        n += 1
    end
    return n
end

function left(side::HorizonSide)
    return(HorizonSide((Int(side) + 1) % 4))
end

function try_move!(r::Robot,side::HorizonSide)::Bool
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
        movements!(r,reverse_side(ort_side),n)
        return false
    end
    move!(r,side)
    while (isborder(r,reverse_side(ort_side)) && n != 0)
        move!(r,side)
    end
    movements!(r,reverse_side(ort_side),n)
    return true
end