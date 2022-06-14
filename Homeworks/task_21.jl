using HorizonSideRobots
include("BackPath.jl")

function left(side::HorizonSide)
    return(HorizonSide((Int(side) + 1) % 4))
end

function try_move!(r::Robot,side::HorizonSide)::Bool
    ort_side = left(side)
    n=0
    check = 0
    while isborder(r,side)
        if !isborder(r,ort_side)
            move!(r,ort_side)
            n += 1
            check = 1
        else
            break
        end
    end
    if isborder(r,side)
        movements!(r,inverse(ort_side),n)
        check = 0
        return check
    end
    move!(r,side)
    while (isborder(r,inverse(ort_side)) && n != 0)
        move!(r,side)
    end
    movements!(r,inverse(ort_side),n)
    return check
end

function count(r::Robot)
    back_path = BackPath(r)
    numb = 0
    side = Ost
    while (!isborder(r, Nord) || !isborder(r, West)) && (!isborder(r, Nord) || !isborder(r, Ost))
        flag = 0
        while !isborder(r, side)
            move!(r, side)
            if isborder(r, Nord) && (flag == 0)
                flag = 1
            end
            if !isborder(r, Nord) && (flag == 1)
                numb += 1
                flag = 0
            end
        end
        side = inverse(side)
        move!(r, Nord)
    end
    to_sud_west_corner = BackPath(r)
    back!(r, back_path)
    print(numb)
end
