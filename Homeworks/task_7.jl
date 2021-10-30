using HorizonSideRobots
include("BackPath.jl")
include("Coord.jl")

function print_chess(r::Robot)
    back_path = BackPath(r)
    coord = Coord(0, 0)
    parity = sum(back_path.path) % 2
    side = Ost
    nord_border = false
    side_border = false
    while !nord_border
        while !side_border
            if (coord.x + coord.y) % 2 == parity
                putmarker!(r)
            end
            if !isborder(r, side)
                move_coords!(coord, side)
                move!(r, side)
            else
                side_border = true
            end
        end
        if !isborder(r, Nord)
            move_coords!(coord, Nord)
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
