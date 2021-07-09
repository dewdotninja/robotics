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
### 01211433 Homework # 1 Hint

Using RTSX toolbox, below is Scilab script to plot 3-segment cubic polynomial trajectory in Figure 1

!["Fig1"](https://drive.google.com/uc?id=1iNEB5BZ_rUuqS--dUc9JoDazMFVOHl8x)

Figure 1 3-segment cubic polynomial trajectory
"""


# ╔═╡ 98d71306-3c56-41f7-a261-0bd0c1c51ce0
md"""
```c
// #Scilab script example. Do not run this cell in notebook.
// #command trajectory generation

t1=0:0.01:1.99;
t2 = 0:0.01:0.99;

// joint 1 trajectory
[q11,qd11,qdd11]=cpoly(0,10,t1,0,10);  // segment 1
[q12,qd12,qdd12]=cpoly(10,-5,t1,10,-5);  // segment 2
[q13,qd13,qdd13]=cpoly(-5,0,t2,-5,0);  // segment 3

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
Here is Scilab script for cpoly function
```c
// #Scilab script. Do not run this cell in notebook.
function [s,sd,sdd] = cpoly(q0, qf, t, qd0, qdf)

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
        0           0              0        1;
        tf^3        tf^2          tf        1;
        0           0             1         0;
        3*tf^2     2*tf           1         0];

    b = [q0 qf qd0 qdf]';
    //coeffs = (X \ b)';
    //coeffs = lsq(X,b)';
    coeffs = (inv(X)*b)';    
    // coefficients of derivatives 
    coeffs_d = coeffs(1:3) .* (3:-1:1);
    coeffs_dd = coeffs_d(1:2) .* (2:-1:1);

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
Use Julia to generate the same trajectory. The position, velocity, and acceleration plot should resemble Figure 1. For simplicity, assume that t argument is always a vector in cpoly() function

### Solution
"""

# ╔═╡ 4b3ce85c-b455-4b16-90d4-95008aa328f9
md"""
พิจารณาฟังก์ชันกำเนิดแนววิถีแบบพหุนามกำลังสาม

``` math
q(t) = a_0 + a_1t + a_2t^2 + a_3t^3 \tag{5.20}
```

อนุพันธ์ของ (5.20) คือสมการบรรยายความเร็ว	


``` math
\dot{q}(t) = a_1 + 2a_2t + 3a_3t^2 \tag{5.21}
```

โดยมีเงื่อนไขที่เวลาต้น $t_0$ และเวลาปลาย $t_f$ คือ
``` math
q(t_0) = q_0 \tag{5.22} 

```

``` math

\dot{q}(t_0) = v_0 \tag{5.23} 
```

``` math
q(t_f) = q_f \tag{5.24} 

```

``` math

\dot{q}(t_f) = v_f \tag{5.25} 
```

ใช้สมการ (5.20), (5.21) และเงื่อนไขตาม (5.22) – (5.25) สร้างสมการอิสระ 4 สมการสำหรับ 4 ตัวไม่รู้ค่า

```math
\begin{array}{c}
a_0 + a_1t_0 + a_2t_0^2 + a_3t_0^3 = q_0 \\
a_1 + 2a_2t_0 + 3a_3t_0^2 = v_0 \\
a_0 + a_1t_f + a_2t_f^2 + a_3t_f^3 = q_f \\
a_1 + 2a_2t_f + 3a_3t_f^2 = v_f
\end{array}
```
ซึ่งสามารถเขียนในรูปสมการเมทริกซ์ได้เป็น
```math
\left[\begin{array}{cccc}
1 & t_0 & t_0^2 & t_0^3 \\
0 & 1 & 2t_0 & 3t_0^2 \\
1 & t_f & t_f^2 & t_f^3 \\
0 & 1 & 2t_f & 3t_f^2
\end{array}\right]
\left[\begin{array}{c}
a_0 \\
a_1 \\
a_2 \\
a_3
\end{array}\right]
= \left[\begin{array}{c}
q_0 \\
v_0 \\
q_f \\
v_f
\end{array}\right] \tag{5.26}
```
ซึ่งจะเห็นว่าอยู่ในรูปสมการเมทริกซ์เชิงเส้น

```math
Ta = b \tag{5.27}
```

สามารถแสดงได้ว่าดีเทอร์มิแนนต์ของเมทริกซ์ $T$ ในสมการ (5.27) มีค่าเท่ากับ $(t_f - t_0)^4$ ดังนั้น (5.27) จะมีคำตอบที่เป็นได้อย่างเดียวตราบเท่าที่ช่วงเวลาในการกำเนิดแนววิถีไม่เป็นศูนย์ โดยคำตอบคำนวณได้จาก

```math
a = T^{-1}b \tag{5.28}
```

เขียนฟังก์ชัน cpoly() เพื่อสร้างเมทริกซ์ $T$ เวกเตอร์ $b$ และหาคำตอบตามสมการ (5.28)
"""

# ╔═╡ d0d89ba2-3311-4659-b894-83f91120470d
md"""
หมายเหตุ : การเรียงสัมประสิทธิ์ในฟังก์ชัน cpoly() ด้านล่างจะเริ่มจากกำลังสูงสุดของ $t$ ไปยังกำลังต่ำสุด คือ $a = [a_3, a_2, a_1, a_0]^T$ ทำให้การเรียงแถวและคอลัมน์ของเมทริกซ์ $T$ และเวกเตอร์ $b$ มีความแตกต่างจาก (5.26) แต่สมการคำตอบยังคงอยู่ในรูป (5.28)
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
function cpoly(q0,qf,t,qd0=0,qdf=0)
	tf = t[end]
	T = [
        0           0              0        1;
        tf^3        tf^2          tf        1;
        0           0             1         0;
        3*tf^2     2*tf           1         0];# your code here
	b = [q0 qf qd0 qdf]';#your code here 
	coeffs = inv(T)*b# your code here
	coeffs_d = coeffs[1:3].*reverse(collect(1:3))
	coeffs_dd = coeffs_d[1:2].*reverse(collect(1:2))
	
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
	q1,qd1,qdd1 = cpoly(0,10,t1,0,10)
	q2,qd2,qdd2 = cpoly(10,-5,t1,10,-5)
	q3,qd3,qdd3 = cpoly(-5,0,t2,-5,0)	
end

# ╔═╡ 3fdccead-ef9f-4b1f-9104-95303a37c3f5
md"""
เชื่อมต่อแต่ละส่วนย่อยเข้าด้วยกันเป็นแนววิถีรวม
"""

# ╔═╡ 84aca787-4e5f-4c42-9d4a-49caacffe5da
begin
	q = [q1;q2;q3]; # your code here
	qd = [qd1;qd2;qd3];# your code here
	qdd = [qdd1;qdd2;qdd3]# your code here
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
# ╟─4b3ce85c-b455-4b16-90d4-95008aa328f9
# ╟─d0d89ba2-3311-4659-b894-83f91120470d
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
