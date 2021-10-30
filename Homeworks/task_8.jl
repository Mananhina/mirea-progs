using HorizonSideRobots

function inverse(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function movements!(r::Robot, side::HorizonSide, n::Int)
    while (n > 0 && isborder(r, Nord))
        move!(r, side)
        n -= 1
    end
end

function find_hole(r::Robot)
    step = 1
    cur_step = step
    side = Ost
    while isborder(r, Nord)
        movements!(r, side, cur_step)
        cur_step += step
        side = inverse(side)
    end    
end