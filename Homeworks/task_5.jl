using HorizonSideRobots

function move_n_steps!(r::Robot, side::HorizonSide, n::Int)
    while n > 0
        move!(r, side)
        n -= 1
    end
end

function put_marker_in_corners!(r::Robot)
    order = []
    s1, s2 = 0, 0
    while !isborder(r, Ost) || !isborder(r, Sud)
        while !isborder(r, Ost)
            move!(r, Ost)
            s1 += 1
        end
        push!(order, s1)
        s1 = 0
        while !isborder(r, Sud)
            move!(r, Sud)
            s2 += 1
        end
        push!(order, s2)
        s2 = 0
    end

    sides = [West, Nord, Ost, Sud]
    for side in sides
        while !isborder(r, side)
            move!(r, side)
        end
        putmarker!(r)
    end

    for i in 1:length(order)
        move_n_steps!(r, HorizonSide((length(order) - i) % 2), order[length(order) - i])
    end
end