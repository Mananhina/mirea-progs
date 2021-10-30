using HorizonSideRobots

function inverse(side::HorizonSide)
    return HorizonSide((Int(side) + 2) % 4)
end

function average(r::Robot)
    nord_border = false
    side_border = false
    side = Ost
    temp_sum::Int = 0
    mark_num::Int = 0
    while !nord_border
        while !side_border
            if ismarker(r)
                temp_sum += temperature(r)
                mark_num += 1
            end
            if !isborder(r, side)
                move!(r, side)
            else
                side_border = true
            end
        end
        if !isborder(r, Nord)
            move!(r, Nord)
            side = inverse(side)
            side_border = false
        else
            nord_border = true
        end
    end
    print(temp_sum / mark_num)
end