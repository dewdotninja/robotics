### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ a8921cec-4860-422e-8fe9-aeeba0b9fd34
using ControlSystems, Plots

# ╔═╡ 5ef915c2-e842-11eb-1374-03d06f129a6f
md"""
July 2021

#### 01211433 Homework 3

"""

# ╔═╡ 18a40b05-cff6-4c86-b94f-56044290736e
md"""
**Requirement :** Julia with ControlSystems, and Plot packages. To install, in the Julia REPL:

```julia
using Pkg 
Pkg.add("ControlSystems")
Pkg.add("Plots")
```

Packages used.

"""

# ╔═╡ 7d247f23-f825-44cc-bc04-d45999d114c7
md"""
**Problem:** let us design a controller for our same old robot joint driven by DC motor developed since the first module

\begin{equation} 
P(s) = \frac{1}{7s^2 + 0.05s} \tag{1}
\end{equation}

with the following design specs

* steady state error is eliminated 
* low frequency disturbance is attenuated at least 0.05 below 0.5 rad/s 
* high frequency measurement noise is attenuated 0.15 above 80 rad/s 
* closed-loop stable, with phase margin at least 50 degrees 


From the above discussion, this can be translated to stability and performance bounds


* --> $L(s)$ has an integrator. Note that $P(s)$ already has one
* --> $|S(j\omega)| \leq ? \,\, dB \rightarrow |L(j\omega)| \geq ? \,\, dB$ below 0.5 rad/s
* --> $|T(j\omega)| \leq ? \,\, dB \rightarrow |L(j\omega)| \leq ? \,\, dB$ above 80 rad/s
* --> $L(j\omega)$ has at least 50 degrees phase margin


To aid this design problem, we write a function lshape() in the cell below. 

"""

# ╔═╡ a3604e06-04e7-499e-9827-37ed5bf7b888
function lshape(C, P, lf, lfb, hf, hfb, pm)
	vecsize = 1000
	L = C*P
	#S = 1/(1+L)
	#T = L/(1+L)
	lf_log10 = log10(lf)
	hf_log10 = log10(hf)
	w_start = floor(lf_log10) - 1
	w_end = ceil(hf_log10) + 1
	w = exp10.(LinRange(w_start, w_end, vecsize))
	#bodeplot(L,w; title="Bode plot of L(s)",label="\$L(s)\$")
	
	# frequency response of L
	Lmag, Lph, Lom = bode(L,w)
	Lmag_db = 20*log10.(Lmag)
	
	# create bound vectors
	lf_bnd = ifelse.(w.<lf,lfb, 0)
	hf_bnd = ifelse.(w.<hf,0, hfb)
	
	# check whether violation occurs
	lf_idxv = findall(x->x>lf,w)
	lf_idx = lf_idxv[1] # index of low-freq region
	hf_idxv = findall(x->x<hf,w)
	hf_idx = hf_idxv[end] # index of high-freq region
	lfmag = Lmag_db[1:lf_idx]
	hfmag = Lmag_db[hf_idx:end]
	if minimum(lfmag)<lfb
		lf_legend = "LF bound (violated!)"
	else
		lf_legend = "LF bound"
	end
	if maximum(hfmag)>hfb
		hf_legend = "HF bound (violated!)"
	else
		hf_legend = "HF bound"
	end
	# desired phase margin line
	pmvec = (pm -180)*ones(vecsize)
	
	# compute gain/phase margin
	wgm, g_margin, wpm, ph_margin = margin(L)
	ph_at_crossover = (ph_margin.-180)
	
	# loophaping plot
	lmag_db = dropdims(Lmag_db,dims = (2,3))
	
	#return w, lmag_db
	gr()
	lmagplot = plot(w,lmag_db,xaxis=:log, label="|L(s)|",legend=:bottomleft)
	plot!(w,lf_bnd,xaxis=:log, label=lf_legend)
	plot!(w,hf_bnd,xaxis=:log, label=hf_legend,xlabel="frequency (rad/s)",ylabel="magnitude (dB)",title="Bode plot of L(s) v.s. bounds")
	lph = dropdims(Lph, dims = (2,3))
	lphplot = plot(w,lph,xaxis=:log, label = "\$\\angle L(s)\$",legend=:bottomleft)
	plot!(w,pmvec,xaxis=:log, label = "lower bounds for PM")
	ph_margin_int = round(ph_margin[1])
	if ph_margin_int > pm
		ph_legend = "phase margin = $ph_margin_int deg."
	else
		ph_legend = "phase margin = $ph_margin_int deg. (violated!)"
	end
	plot!(wpm, ph_at_crossover, seriestype =:scatter, label=ph_legend)
	Lplot = plot(lmagplot,lphplot,layout=(2,1))

	
end	

# ╔═╡ 86d834fa-413f-4f62-baab-52fbd9fe2de5
md"""
where the arguments are as follows:

* C : Controller
* P : Plant
* lf : Define low frequency region from 0 - lf (rad/s)
* lfb : Low frequency bound for $L(s)$
* hf : Define high frequency region from hf - $\infty$ (rad/s)
* hfb : High frequency bound for $L(s)$
* pm : Phase margin (degrees)

    
"""

# ╔═╡ a8d9375b-03f3-4c2a-adce-220504a01b60
# create plant transfer function
begin
	s = tf("s")
	P = 
end

# ╔═╡ 9a79e8de-b3ca-4996-9f33-d54e2892706e
begin
	lf = # low frequency here
	lfb = # your answer 
	hf = # high frequency here
	hfb = # your answer
	pm =  # phase margin
end

# ╔═╡ bb4e28a0-af0c-44f4-9e4d-2062650721e6
C = # your controller

# ╔═╡ 1a1309ed-9804-4443-a590-372ad599d8f5
lshape(C, P, lf, lfb, hf, hfb, pm) # call loopshaping funciton

# ╔═╡ f9a7c007-5a1d-4e0c-b33a-819a269c34b9
md"""
Iterate the above cell until you achieve a controller that meets the specs.

Then plot the closed-loop step response (adjust tvec if necessary)
"""

# ╔═╡ 7813b7d9-9827-41c7-bcc6-d36c962bc142
begin
	L = C*P
	T = minreal(L/(1+L))
	tvec1 = collect(Float64,0:0.001:1)
	y1,t1,x1 = step(T,tvec1)
	r1 = ones(size(t1))
	plot(t1,r1, label="step ref")
	plot!(t1,y1, label="plant output",xlabel="time (sec)",ylabel="y(t)",title="Step response of C(s)",legend=:bottomright)
end

# ╔═╡ d4c4f50d-a531-4fbf-8cc1-7fff67ff10cc
md"""
To make sure that this design meets all the specification, the disturbance and noise responses in the time-domain need to be evaluated. Create a function to plot output response of arbitrary function.
"""

# ╔═╡ c61058d7-f974-4e06-a9a1-111470d77729
function plot_response(sys,u,t,ampbnd, plottitle)
	y, tout, x = lsim(sys, u, t,method=:zoh)
	t_idx = 150  # get rid of transient
	tout1 = tout[t_idx:end]
	y1 = y[t_idx:end]
	u1 = u[t_idx:end]
	
	pbnd = ampbnd*ones(size(tout1))
	nbnd = -ampbnd*ones(size(tout1))
	uplt = plot(tout1,u1, label = plottitle*" input",title=plottitle*" response")
	yplt=plot(tout1,y1, label = "plant output")
	plot!(tout1,pbnd, label = "positive bound")
	plot!(tout1, nbnd, label = "negative bound",xlabel="time (sec)",ylabel="y(t)")
	plot(uplt, yplt, layout=(2,1))
	
end

# ╔═╡ d7cbded0-9f33-42b1-b52f-9d8ca0db4c7a
md"""
From the design specifications, the required disturbance attenuation is at least 0.05 for frequency below 0.5 rad/s.
Since the attenuatiton is the least at $\omega = 0.5$ rad/s, we use this frequency as our test point.

Recall that the closed-loop transfer function for the output disturbance response is $S(s)$.
The plot from this cell must confirm that the controller meets this attenuation performance.
"""

# ╔═╡ 12df3b8d-f072-4f46-bd0f-52d022211436
begin
	df = # specify disturbance frequency in rad/s
	S = minreal(1/(1+L))
	tvec2 = collect(Float64,0:0.01:20)
	u2 = sin.(df*tvec2)
	abnd = 0.05
	plot_response(S,u2,tvec2,abnd,"disturbance")
end

# ╔═╡ 03943f5d-e746-435d-a276-1dd19f7c2ccd
md"""
Note : The output magnitude must swing within 0.05

Use the same plot function on the complementary sensitivity $T(s)$ to verify that, with a noise input $u(t)=\sin(\omega t)$ 
where $\omega = 80$ rad/s, the output should swing within $\pm 0.15$ unit.

"""

# ╔═╡ 337fac73-4bb0-4cd2-944f-b6963366799c
begin
	nf = # specify noise frequency in rad/s
	tvec3 = collect(Float64,0:0.001:2)
	u3 = sin.(nf*tvec3)
	nbnd = 0.15*na
	plot_response(T,u3,tvec3,nbnd,"Noise")
end

# ╔═╡ Cell order:
# ╟─5ef915c2-e842-11eb-1374-03d06f129a6f
# ╟─18a40b05-cff6-4c86-b94f-56044290736e
# ╠═a8921cec-4860-422e-8fe9-aeeba0b9fd34
# ╟─7d247f23-f825-44cc-bc04-d45999d114c7
# ╠═a3604e06-04e7-499e-9827-37ed5bf7b888
# ╟─86d834fa-413f-4f62-baab-52fbd9fe2de5
# ╠═a8d9375b-03f3-4c2a-adce-220504a01b60
# ╠═9a79e8de-b3ca-4996-9f33-d54e2892706e
# ╠═bb4e28a0-af0c-44f4-9e4d-2062650721e6
# ╠═1a1309ed-9804-4443-a590-372ad599d8f5
# ╟─f9a7c007-5a1d-4e0c-b33a-819a269c34b9
# ╠═7813b7d9-9827-41c7-bcc6-d36c962bc142
# ╟─d4c4f50d-a531-4fbf-8cc1-7fff67ff10cc
# ╠═c61058d7-f974-4e06-a9a1-111470d77729
# ╟─d7cbded0-9f33-42b1-b52f-9d8ca0db4c7a
# ╠═12df3b8d-f072-4f46-bd0f-52d022211436
# ╟─03943f5d-e746-435d-a276-1dd19f7c2ccd
# ╠═337fac73-4bb0-4cd2-944f-b6963366799c
