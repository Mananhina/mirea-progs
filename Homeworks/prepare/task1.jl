# function bubblesort(a::Array{Int})
#     res = deepcopy(a)
#     for i in 1:length(a)
#         for j in 1:length(a)-i
#             if res[j] > res[j + 1]
#                 res[j], res[j + 1] = res[j + 1], res[j]
#             end
#         end
#     end
#     return res
# end

# function issort(a::Array{Int})
#     for i in 1:length(a)-1
#         if a[i] > a[i+1]
#             return false
#         end
#     end
#     return true
# end

# function sort_perm(a)
# end

function equal(a)
    return a
end

    
function bubblesort(a::Array{Int}, by=equal)
    res = deepcopy(a)
    for i in 1:length(a)
        for j in 1:length(a)-i
            if by(res[j]) > by(res[j + 1])
                res[j], res[j + 1] = res[j + 1], res[j]
            end
        end
    end
    return res
end