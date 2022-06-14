function index_value(v, values::Vector{Int64})
    for i in 1:length(values)
        if values[i] == v
            return i
        end
    end
end

function calcsort!(a, values)
    num_val = zeros(Int, size(values))
    for v in a
        num_val[index_value(v, values)] += 1
    end
    k = 1
    for (i, num) in enumerate(num_val)
        a[k:k+num-1] .= values[i]
        k += num
    end
    return a
end


# function calcsort!(a::Vector{Int})
#     min_val, max_value = extrema(a)
#     num_val = zeros(Int, max_value-min_val+1)
#     for v in a
#         num_val[v-min_val+1] += 1
#     end
#     k = 1
#     for (i, num) in enumerate(num_val)
#         a[k:k+num-1] .= min_val + i - 1
#         k += num
#     end

# end