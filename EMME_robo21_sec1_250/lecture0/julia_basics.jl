### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# This Pluto notebook uses @bind for interactivity. When running this notebook outside of Pluto, the following 'mock version' of @bind gives bound variables a default value (instead of an error).
macro bind(def, element)
    quote
        local el = $(esc(element))
        global $(esc(def)) = Core.applicable(Base.get, el) ? Base.get(el) : missing
        el
    end
end

# ╔═╡ 389db9de-dac7-11eb-3f5c-ed0fe6ce0a44
begin
	import Pkg
	Pkg.activate(mktempdir())
	Pkg.add([
		Pkg.PackageSpec(name="PlutoUI", version="0.7"), 
		Pkg.PackageSpec(name="Plots"),
	])

	using PlutoUI, Plots
end

# ╔═╡ 148061e1-3a4d-4d76-aef5-ab460efea9fe
A = [1 2;-4 0.5]

# ╔═╡ 01ffc7ca-e275-4193-9448-64251c7a7890
A_inv = inv(A)

# ╔═╡ 0e799db7-85ac-4e56-8ff5-0386c7ef37f7
C = A*A_inv

# ╔═╡ 0383a736-1325-451b-af98-2a7e2670d750
tvec = collect(0:0.01:2)

# ╔═╡ bbcdd458-ea15-4abc-88a5-6adc3195401c
f₁(x) = x.^3

# ╔═╡ e0e3ece0-0455-46b1-966e-5a00af5f4989
yvec=f₁(tvec)

# ╔═╡ 2e233eae-7945-4158-b607-21a11cd879e2
plot(tvec,yvec,xlabel="time (sec)",ylabel="output")

# ╔═╡ 5844fb96-deed-4470-bcd0-2dc6e23d9192
md"""
α = $(@bind α Slider(0:10, show_value=true, default = 0))
"""

# ╔═╡ ed2e587e-7757-46e2-8dbc-83826df05c74
α

# ╔═╡ 36f5f6dd-00af-47d7-8c76-8b5ef3e24cfd
f₂(x) = x.^α

# ╔═╡ c2b19859-09a6-49b9-856d-cb7f2ea56435
tvec1 = collect(-2:0.01:2)

# ╔═╡ 1ff7e2ed-6955-4172-8471-46bee78bd8eb
y1 = f₂(tvec1)

# ╔═╡ 9d31a008-0af6-4b81-82ac-3cf0460b0185
plot(tvec1,y1)

# ╔═╡ Cell order:
# ╠═389db9de-dac7-11eb-3f5c-ed0fe6ce0a44
# ╠═148061e1-3a4d-4d76-aef5-ab460efea9fe
# ╠═01ffc7ca-e275-4193-9448-64251c7a7890
# ╠═0e799db7-85ac-4e56-8ff5-0386c7ef37f7
# ╠═0383a736-1325-451b-af98-2a7e2670d750
# ╠═bbcdd458-ea15-4abc-88a5-6adc3195401c
# ╠═e0e3ece0-0455-46b1-966e-5a00af5f4989
# ╠═2e233eae-7945-4158-b607-21a11cd879e2
# ╠═ed2e587e-7757-46e2-8dbc-83826df05c74
# ╠═36f5f6dd-00af-47d7-8c76-8b5ef3e24cfd
# ╠═c2b19859-09a6-49b9-856d-cb7f2ea56435
# ╠═1ff7e2ed-6955-4172-8471-46bee78bd8eb
# ╠═5844fb96-deed-4470-bcd0-2dc6e23d9192
# ╠═9d31a008-0af6-4b81-82ac-3cf0460b0185
