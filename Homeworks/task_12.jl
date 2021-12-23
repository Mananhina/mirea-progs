using HorizonSideRobots
include("BackPath.jl")
include("Coord.jl")

import HorizonSideRobots: move!

function print_chess(r::Robot, n::Int)
    back_path = BackPath(r)
    coord = Coord(0, 0)
    side = Ost
    nord_border = false
    side_border = false
    while !nord_border
        while !side_border
            if (coord.x ÷ n + coord.y ÷ n) % 2 == 0
                putmarker!(r)
            end
            if !isborder(r, side)
                move!(coord, side)
                move!(r, side)
            else
                side_border = true
            end
        end
        if !isborder(r, Nord)
            move!(coord, Nord)
            move!(r, Nord)
            side = inverse(side)
            side_border = false
        else
            nord_border = true
        end
    end
    to_sud_west_corner = BackPath(r)
    back!(r, back_path)
end