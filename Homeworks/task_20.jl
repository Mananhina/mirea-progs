using HorizonSideRobots
include("BackPath.jl")

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
