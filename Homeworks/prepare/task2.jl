# function find_all(f, a)
#     res = []
#     for i in 1:length(a)
#         if f(a[i])
#             push!(res, i)
#         end
#     end
#     return res
# end

# function find_first(f, a)
#     for i in 1:length(a)
#         if f(a[i])
#             return i
#         end
#     end
# end

# function find_last(f, a)
#     for i in length(a):-1:1
#         if f(a[i])
#             return i
#         end
#     end
# end

# function filt(f, a)
#     res = []
#     for i in eachindex(a)
#         if f(a[i])
#             push!(res, a[i])
#         end
#     end
#     return res
# end