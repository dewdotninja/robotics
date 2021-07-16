### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 3bd23244-d730-4019-bea6-714efa0c615b
#import Pkg
#Pkg.add("Plots")
using Plots

# ╔═╡ d84c1704-db92-11eb-25c2-8f93dc230802
md"""
July 2021
"""

# ╔═╡ 286f6465-5b4a-4f36-8d87-3bc832f4523f
md"""
### 01211433 Homework # 1

Using RTSX toolbox, below is Scilab script to plot 3-segment quintic polynomial trajectory in Figure 1

!["Fig1"](https://drive.google.com/uc?id=1--OfmHoZrsxn7S1lJXVLUuI00Rh2cUeC)

Figure 1 3-segment quintic polynomial trajectory
"""

# ╔═╡ 98d71306-3c56-41f7-a261-0bd0c1c51ce0
md"""
```c
// #Scilab script example. Do not run this cell in notebook.
// #command trajectory generation

t1=0:0.01:1.99;
t2 = 0:0.01:0.99;

// joint 1 trajectory
[q11,qd11,qdd11]=qpoly(0,10,t1,0,10);  // segment 1
[q12,qd12,qdd12]=qpoly(10,-5,t1,10,-5);  // segment 2
[q13,qd13,qdd13]=qpoly(-5,0,t2,-5,0);  // segment 3

q1 = [q11;q12;q13];     // position (angles)
qd1 = [qd11;qd12;qd13];  // velocity
qdd1 = [qdd11;qdd12;qdd13];  // acceleration

t=0:0.01:4.99;
t=t';

figure(1);
subplot(311), plot(t, q1,'r-')
//xlabel('time (sec)')
ylabel('angles')

subplot(312), plot(t, qd1,'b-')
//xlabel('time (sec)')
ylabel('velocity')

subplot(313), plot(t, qdd1, 'g-')
xlabel('time (sec)')
ylabel('acceleration')
```

"""

# ╔═╡ 76b40852-ca3b-481d-ac2b-ad32d6ec736c
md"""
Here is Scilab script for qpoly function
```c
// #Scilab script. Do not run this cell in notebook.
function [s,sd,sdd] = qpoly(q0, qf, t, qd0, qdf)

    t0 = t;
    nargin=argn(2);
    nargout = argn(1);
    if isscalar(t)
		t = (0:t-1)';
    else
        t = t(:);
    end
    if nargin < 4
        qd0 = 0;
    end
    if nargin < 5
        qdf = 0;
    end
    
    tf = max(t);
    
    // solve for the polynomial coefficients using least squares
    X = [
        0           0           0         0       0   1
        tf^5        tf^4        tf^3      tf^2    tf  1
        0           0           0         0       1   0
        5*tf^4      4*tf^3      3*tf^2    2*tf    1   0
        0           0           0         2       0   0
        20*tf^3     12*tf^2     6*tf      2       0   0
    ];
    b = [q0 qf qd0 qdf 0 0]';
    coeffs = (inv(X)*b)';    
    // coefficients of derivatives 
    coeffs_d = coeffs(1:5) .* (5:-1:1);
    coeffs_dd = coeffs_d(1:4) .* (4:-1:1);

    // evaluate the polynomials
    p = polyval(coeffs, t);
    pd = polyval(coeffs_d, t);
    pdd = polyval(coeffs_dd, t);

    select nargout

        case 1
            s = p;
        case 2
            s = p;
            sd = pd;
        case 3
            s = p;
            sd = pd;
            sdd = pdd;
    end
    
endfunction
```
"""

# ╔═╡ d778c378-04f7-4d65-905f-12ab9d2a5619
md"""
Use Julia to generate the same trajectory. The position, velocity, and acceleration plot should resemble Figure 1. For simplicity, assume that t argument is always a vector in qpoly() function

### Solution
"""

# ╔═╡ 302b768b-9553-4a08-9b9c-27e3b8a127c6
function polyval(P,X)
	Y = zeros(size(X))
	n = size(P,1)
	for i=1:n
		Y = Y + P[i]*X.^(n-i)
	end
	return Y
end

# ╔═╡ 73d4511b-ecdc-4351-ac74-6272ded63073
function qpoly(q0,qf,t,qd0=0,qdf=0)
	tf = t[end]
	T = # your code here
	b = # your code here
	coeffs = # your code here
	
	# coefficients of derivative
	coeffs_d = coeffs[1:5].*reverse(collect(1:5))
	coeffs_dd = coeffs_d[1:4].*reverse(collect(1:4))
	
	q = polyval(coeffs, t)
	q_d = polyval(coeffs_d,t)
	q_dd = polyval(coeffs_dd, t)
	return q, q_d, q_dd
end	

# ╔═╡ 522e8cae-0b61-40d5-af5a-82832a607f8f
md"""

ต้องการกำเนิดแนววิถี 3 ส่วนย่อยดังนี้
* ส่วนย่อย 1 : เริ่มต้น $t=0$ จากตำแหน่ง $q(0) = 0$ ความเร็ว $\dot{q} = 0$ จบที่ $t = 2, q(2) = 10, \dot{q}(2) = 0$
* ส่วนย่อย 2 : ต่อจากส่วนย่อยแรกโดยใช้ตำแหน่งและความเร็วต้น $q(2) = 10, \dot{q}(2) = 0$ จบที่ $t = 4, q(4) = -5, \dot{q}(4) = -5$
* ส่วนย่อย 3 : ต่อจากส่วนย่อย 2 โดยใช้ตำแหน่งและความเร็วต้น $q(4) = -5, \dot{q}(4) = -5$ จบที่ $t = 5, q(5) = 0, \dot{q}(5) = 0$

สร้างเวกเตอร์ของเวลา t1 สำหรับส่วนย่อย 1,2 (คาบเวลา 2 วินาที) และ t2 สำหรับส่วนย่อย 3 (คาบเวลา 1 วินาที)
"""

# ╔═╡ 69efbea6-f4bd-47d8-8809-982636171c1b
begin
	t1 = collect(0:0.01:2);
	t2 = collect(0:0.01:1);	
end

# ╔═╡ 7f00c0cc-5c1b-4616-b2b0-85e734b47520
md"""
ใช้ฟังก์ชัน qpoly() เพื่อกำเนิดเวกเตอร์เอาต์พุตสำหรับแต่ละส่วนย่อย
"""

# ╔═╡ fd58db16-77c5-46e0-bfa0-0946fb51c8f0
begin
	q1,qd1,qdd1 = qpoly(0,10,t1,0,10)
	q2,qd2,qdd2 = qpoly(10,-5,t1,10,-5)
	q3,qd3,qdd3 = qpoly(-5,0,t2,-5,0)	
end

# ╔═╡ 3fdccead-ef9f-4b1f-9104-95303a37c3f5
md"""
เชื่อมต่อแต่ละส่วนย่อยเข้าด้วยกันเป็นแนววิถีรวม
"""

# ╔═╡ 84aca787-4e5f-4c42-9d4a-49caacffe5da
begin
	q = # your code here
	qd = # your code here
	qdd = # your code here
	tvec = [t1; 2 .+ t1; 4 .+ t2]
end

# ╔═╡ d07171b2-396b-4e57-bfe2-8bf2c1ebb8ff
md"""
พล็อตแนววิถีได้ดังนี้
"""

# ╔═╡ 7a325917-1ce7-4b7e-89b8-668c26cd7fc7
begin
	plot_q = plot(tvec, q, ylabel="position",color="red")
	plot_qd = plot(tvec, qd, ylabel="velocity",color="blue")
	plot_qdd = plot(tvec, qdd, ylabel="acceleration",color="green")
	plotall = plot(plot_q, plot_qd, plot_qdd,layout=(3,1),legend=false)
	xlabel!("time (sec)")
end

# ╔═╡ Cell order:
# ╟─d84c1704-db92-11eb-25c2-8f93dc230802
# ╟─286f6465-5b4a-4f36-8d87-3bc832f4523f
# ╟─98d71306-3c56-41f7-a261-0bd0c1c51ce0
# ╟─76b40852-ca3b-481d-ac2b-ad32d6ec736c
# ╟─d778c378-04f7-4d65-905f-12ab9d2a5619
# ╠═3bd23244-d730-4019-bea6-714efa0c615b
# ╠═73d4511b-ecdc-4351-ac74-6272ded63073
# ╠═302b768b-9553-4a08-9b9c-27e3b8a127c6
# ╟─522e8cae-0b61-40d5-af5a-82832a607f8f
# ╠═69efbea6-f4bd-47d8-8809-982636171c1b
# ╟─7f00c0cc-5c1b-4616-b2b0-85e734b47520
# ╠═fd58db16-77c5-46e0-bfa0-0946fb51c8f0
# ╟─3fdccead-ef9f-4b1f-9104-95303a37c3f5
# ╠═84aca787-4e5f-4c42-9d4a-49caacffe5da
# ╟─d07171b2-396b-4e57-bfe2-8bf2c1ebb8ff
# ╠═7a325917-1ce7-4b7e-89b8-668c26cd7fc7
