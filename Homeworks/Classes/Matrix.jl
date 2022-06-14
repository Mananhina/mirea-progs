function shellsort!(a;
    step_series = filter(n -> (n < length(a)), [1750, 701, 301, 132, 57, 23, 10, 4, 1]))
    for step in step_series
        for i in firstindex(a):lastindex(a)-step
            j = i
            while j >= firstindex(a) && a[j] > a[j + step]
                a[j], a[j + step] = a[j + step], a[j]
                j -= step
            end
        end
    end
    return a
end


function shell_sort(data: list[int]) -> list[int]
    last_index = len(data)
    step = len(data)//2
    while step > 0
        for i in step:last_index
            j = i
            delta = j - step
            while delta >= 0 && data[delta] > data[j]
                data[delta], data[j] = data[j], data[delta]
                j = delta
                delta = j - step
            end
        step //= 2
        end
    end
    return data
end

z, t, y = x, 1, 0
while z > a || z < 1/a || t > ε   
    if z > a
        z /= a
        y += t # т.к. z^t = (z/a)^t * a^t
    elseif z < 1/a
        z *= a
        y -= t # т.к. z^t = (z*a)^t * a^-t
    else # t > ε
        t /= 2
        z *= z # т.к. z^t = (z*z)^(t/2)
    end
end


function bisect(f::Funcnion, a, b, ε)
    y_a=f(a)
    # ИНВАРИАНТ: f(a)*f(b) < 0 (т.е. (a,b) - содержит корень)
    while b-a > ε
        x_m = (a+b)/2
        y_m=f(x_m)
        if y_m==0
            return x_m
        end
        if y_m*y_a > 0 
            a=x_m
        else
            b=x_m
        end
    end
    return (a+b)/2
end



# m, n - заданные целые
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