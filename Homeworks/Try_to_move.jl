using HorizonSideRobots
include("BackPath.jl")

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
        movements!(r,inverse(ort_side),n)
        return false
    end
    move!(r,side)
    while (isborder(r,inverse(ort_side)) && n != 0)
        move!(r,side)
    end
    movements!(r,inverse(ort_side),n)
    return true
end