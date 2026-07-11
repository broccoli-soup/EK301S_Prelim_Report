# This is a helper script. the function next_point returns the point to the right of x0 on y = ax^2 that is ____ target units away/
# It was used to find the minimal value of parameter a such that 7 members could be placed with minimal (8 in) spacing. 
# The script was also run to find parameter a under the requirement that 6 members should be placed with minimal spacing. 

import math

def next_point(x0, a, target=8.0, tol=1e-6):

    y0 = a * x0 * x0

    def dist(x):
        y = a * x * x
        return math.hypot(x - x0, y - y0)

    # Find an upper bound
    lo = x0
    hi = x0 + target

    while dist(hi) < target:
        hi += target

    # Binary search
    while hi - lo > tol:
        mid = (lo + hi) / 2
        if dist(mid) < target:
            lo = mid
        else:
            hi = mid

    x = (lo + hi) / 2
    y = a * x * x

    return x, y
a = 0.0544
x, y = -17, a * 17 * 17

my_list = [str(-17)]
my_other_list = [str(a*17*17)]
for i in range(6):
    x, y = next_point(x, a)
    my_list.append(str(x))
print(", ".join(my_list))

#print(", ".join(my_other_list))