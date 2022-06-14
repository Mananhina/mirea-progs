function sortkey(key_values, a)
    indperm=sortperm(key_values)
    return a[indperm]
end

# function slice(A::Matrix,I::Vectot{Int},J::Vector{Int})
#     B=Matrix{eltype(A)}(undef,length(I),length(J))
#     for i in I
#         for j in J
#             B[i,j]=A[I[i],J[j]]
#         end
#     end
#     return B
# end

# B = view(A,:,2)

# # B - это ссылка на срез A[:,2]: