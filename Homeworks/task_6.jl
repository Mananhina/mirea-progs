using HorizonSideRobots
include("BackPath.jl")

function paint_border(r::Robot, side1::HorizonSide, side2::HorizonSide)
    while isborder(r, side1)
        putmarker!(r)
        move!(r, side2)
    end
    move!(r, side1)
end

function paint_perimeter(r::Robot)
    back_path = BackPath(r, (Nord, Ost))
    higth = movements!(r, Sud)

    num_side = 0
    cur = 0

    while cur != higth + 1
        while !isborder(r, HorizonSide(num_side))
            move!(r, HorizonSide(num_side))
            cur += 1
        end
        if cur != higth
            cur = higth + 1
        else
            move!(r, West)
            num_side = (num_side + 2) % 4
        end
    end

    cur_side = num_side
    for i in 0:3
        paint_border(r, HorizonSide(cur_side % 4), HorizonSide((cur_side + 3) % 4))
        cur_side = (cur_side + 1) % 4
    end

    to_nord_ost_corner = BackPath(r, (Nord, Ost))
    back!(r, back_path)
end