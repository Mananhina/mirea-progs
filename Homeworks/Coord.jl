using HorizonSideRobots

mutable struct Coord
    x::Int
    y::Int
    Coord() = new(0,0)
    Coord(x::Int,y::Int) = new(x,y)
end

function move_coords!(coord::Coord, side::HorizonSide)
    if side==Nord
        coord.y += 1
    elseif side==Sud
        coord.y -= 1
    elseif side==Ost
        coord.x += 1
    else
        coord.x -= 1
    end
end

get_coords(coord::Coord) = (coord.x, coord.y)
