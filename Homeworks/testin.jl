using HorizonSideRobots

function go_to_corner!(r::Robot, side1::HorizonSide, side2::HorizonSide)
    return_order = []
    s1, s2 = 0, 0
    while !isborder(r, side1) || !isborder(r, side2)
        while !isborder(r, side1)
            move!(r, side1)
            s1 += 1
        end
        push!(return_order, s1)
        s1 = 0
        while !isborder(r, side2)
            move!(r, side2)
            s2 += 1
        end
        push!(return_order, s2)
        s2 = 0
    end
    return return_order
end

r = Robot()
err = go_to_corner!(r, Ost, Sud)
print(err)