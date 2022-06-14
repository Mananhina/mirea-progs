# m, n - заданные целые
m, n = 156, 44
a, b = m, n
u_a, v_a = 1, 0
u_b, v_b = 0, 1
#=
ИНВАРИАНТ: 
    НОД(m,n)==НОД(a,b)
    a = u_a*m + v_a*n 
    b = u_b*m + v_b*n
=#

while b != 0
    k = a÷b
    a, b = b, a % b 
    #УТВ: a % b = a-k*b - остаток от деления a на b
    u, v = u_a, v_a
    u_a, v_a = u_b, u_a
    u_b, v_b = u-k*u_b, v-k*v_b
end
#УТВ: b == НОД(m,m) == u_a*m + v_a*n