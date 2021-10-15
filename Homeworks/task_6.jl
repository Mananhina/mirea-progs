using HorizonSideRobots

function steps_to_border(r::Robot, side::HorizonSide)
    n = 0
    while !isborder(r, side)
        move!(r, side)
        n += 1
    end
    return n
end

function paint_border(r::Robot, view::HorizonSide, direction::HorizonSide)
    move!(r, direction)
    while isborder(r, view)
        putmarker!(r)
        move!(r, direction)
    end

function move_n_steps!(r::Robot, side::HorizonSide, n::Int)
    while n > 0
        move!(r, side)
        n -= 1
    end
end

function paint_perimeter(r::Robot)
    order = []
    s1, s2 = 0, 0
    while !isborder(r, Ost) || !isborder(r, Sud)
        s1 = steps_to_border(r, Ost)
        push!(order, s1)
        s1 = 0
        s2 = steps_to_border(r, Sud)
        push!(order, s2)
        s2 = 0
    end

    higth = steps_to_border(r, Nord)

    num_side = 2
    c = 0
    while c < higth + 1
        while !isborder(r, HorizonSide(num_side))
            move!(r, HorizonSide(num_side))
            c += 1
        end
        if c != higth
            c = hight + 1
        end
        move!(r, West)
        num_side = num_side + 2 % 4
    end
    move!(r, Ost)
    n1 = (HorizonSide(num_side), West)
    n2 = (Ost, HorizonSide(num_side))
    n3 = (HorizonSide(num_side + 2 % 4), Ost)
    n4 = (West, HorizonSide(num_side + 2 % 4))
    side_tupels = [n1, n2, n3, n4]
    for i in side_tupels
        paint_border(r, i[1], i[2])
    end

    while !isborder(r, Ost)
        move!(r, Ost)
    end
    while !isborder(r, Sud)
        move!(r, Sud)
    end

    for i in 1:length(order)
        move_n_steps!(r, HorizonSide((length(order) - i) % 2), order[length(order) - i])
    end
end