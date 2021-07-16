### A Pluto.jl notebook ###
# v0.14.7

using Markdown
using InteractiveUtils

# ╔═╡ 05c280c5-f8d0-4549-b29b-6ada27c2624a
using ControlSystems, Plots

# ╔═╡ 3a73a460-e525-11eb-34aa-df2ed471d8bf
md"""
July 2021
"""

# ╔═╡ a8217a25-b3da-4f54-bec7-4e39536cfaf8
md"""
### 01211433 Homework 2

รูปที่ 1 แสดงการจำลองสมรรถนะการลดทอนการรบกวนที่เอาต์พุตของพลานต์โดย Scilab/xcos 

!["Fig1"](https://drive.google.com/uc?id=1FiFN4_1OXSiubdQ7sgwTRJ7tIqEGbTi8)
รูปที่ 1 การลดทอนการรบกวนที่เอาต์พุตของพลานต์

ต้องการจำลองผลตอบสนองโดย Julia ใช้ฟังก์ชันถ่ายโอนของพลานต์และตัวควบคุม
เหมือนในรูปที่ 1 คือ $P(s) = \frac{1}{10s^2+0.1s}$ และ $C(s) = \frac{20000(s+0.01)}{(s+100)}$ 
โดยสนใจเพียงสมรรถนะการลดทอนการรบกวน ดังนั้นไม่ต้องมี step input เอาต์พุตที่คาดหวัง
คือสำหรับการรบกวนขั้นบันได เอาต์พุตจะเข้าสู่ศูนย์ในสถานะนิ่ง และสำหรับการรบกวนรูปคลื่นไซน์ความถี่ต่ำ เอาต์พุตจะมีขนาดเล็ก
กว่าอินพุต (ในการบ้านนี้ยังไม่กำหนดย่านความถี่และอัตราการลดทอน ซึ่งจะเป็นเนื้อหาของ lecture 3)

**หมายเหตุ :** เพื่อความง่ายสามารถให้การรบกวนเริ่มต้นตั้งแต่ t = 0

##### Solution :

ถ้ายังไม่ได้ติดตั้งแพ็คเกจ ControlSystems ต้องติดตั้งเสียก่อน
"""

# ╔═╡ 35793b56-f55d-4c5a-90d8-67b10ec64b97
#using Pkg
#Pkg.add("ControlSystems")

# ╔═╡ 8e995598-cc50-4f30-89ff-e101e077e8f2
md"""
ประกาศใช้งานแพ็คเกจ
"""

# ╔═╡ be6ca918-f134-47af-a56d-afaf54eda662
md"""
สร้างพลานต์และตัวควบคุม
"""

# ╔═╡ 0a3c07d7-b848-46bd-904d-1985c1199c9f
begin
	# เพิ่มโค้ด
end

# ╔═╡ 47f0e502-573e-4f6f-bfdd-ee7cf01840c9
md"""
สร้างฟังก์ชันถ่ายโอนที่เป็นตัวส่งจากสัญญาณรบกวนที่เอาต์พุต $d_o(s)$ ไปยังเอาต์พุต $y(s)$
"""

# ╔═╡ 3ec2e540-3cfb-404e-9ecb-c66ac371d0f7
begin
	# เพิ่มโค้ด
end

# ╔═╡ 0e51a748-5aad-4620-a27f-48f8a8371733
md"""
ใช้ฟังก์ชันในเซลด้านล่างนี้ในการพล็อต โดยมีอาร์กิวเมนต์ดังนี้
* sys : ฟังก์ชันถ่ายโอนจาก $d_o$ ไปยัง $y$
* u : เวกเตอร์ของสัญญาณ $d_o$ เป็น 1. ค่าคงที่ไม่เท่ากับศูนย์ 2. สัญญาณรูปคลื่นไซน์ความถี่ต่ำ
* t : เวกเตอร์ของเวลา 
"""

# ╔═╡ 68a4086a-0052-4e88-ab16-f8b3bc801d2d
# โค้ดในฟังก์ชันนี้สมบูรณ์แล้ว ไม่ต้องแก้ไขเพิ่มเติมใดๆ
function plot_response(sys,u,t, plottitle="disturbance")
	y, tout, x = lsim(sys, u, t,method=:zoh)
	t_idx = 150  # get rid of transient
	tout1 = tout[t_idx:end]
	y1 = y[t_idx:end]
	u1 = u[t_idx:end]
	
	uplt = plot(tout1,u1, label = plottitle*" input",title=plottitle*" response")
	yplt=plot(tout1,y1, label = "plant output",xlabel="time (sec)",ylabel="y(t)")
	plot(uplt, yplt, layout=(2,1))
	
end

# ╔═╡ 23d8674f-5ae7-4fdc-b8a4-3fbe08331a23
md"""
1. สร้างเวกเตอร์เวลา และเวกเตอร์การรบกวนเอาต์พุตที่เป็นค่าคงที่
"""

# ╔═╡ 3ba3d60d-40de-41de-a890-fd30117118b0
begin
	tvec = # เวกเตอร์เวลา
	uvec = # สร้างเวกเตอร์สำหรับ d_o เป็นค่าคงที่
end

# ╔═╡ 005bbb17-38f9-42b3-87b5-ee1a0bc173a2
md"""
พล็อตผลตอบสนองโดยฟังก์ชัน plot_response()
"""

# ╔═╡ 848715da-c712-415c-927d-394ef6dea2e1
plot_response(?,uvec,tvec) # แทนค่าเครื่องหมายคำถามด้วยฟังก์ชันถ่ายโอนที่ถูกต้อง

# ╔═╡ c1064429-49bb-4a96-ab4a-8dc07ea8cd39
md"""
2. ใช้เวกเตอร์เวลาเดิมที่สร้างในข้อ 1. สร้างเวกเตอร์อินพุตเป็นรูปคลื่นไซน์ความถี่ต่ำ (เช่น 1 rad/s)
"""

# ╔═╡ 225817cb-e136-4741-96c2-92be1364ecf6
begin
	w = 1 # rad/s
	uvec2 = # สร้างเวกเตอร์สำหรับ d_o เป็นรูปคลื่นไซน์
end

# ╔═╡ afb5617d-2a38-451d-9ee9-860f50269c5e
md"""
พล็อตผลตอบสนองโดยฟังก์ชัน plot_response()




"""

# ╔═╡ 6dc9c3fe-e2cc-4e79-ae23-95775b944ea1
plot_response(?,uvec2,tvec) # แทนค่าเครื่องหมายคำถามด้วยฟังก์ชันถ่ายโอนที่ถูกต้อง

# ╔═╡ Cell order:
# ╟─3a73a460-e525-11eb-34aa-df2ed471d8bf
# ╟─a8217a25-b3da-4f54-bec7-4e39536cfaf8
# ╠═35793b56-f55d-4c5a-90d8-67b10ec64b97
# ╟─8e995598-cc50-4f30-89ff-e101e077e8f2
# ╠═05c280c5-f8d0-4549-b29b-6ada27c2624a
# ╟─be6ca918-f134-47af-a56d-afaf54eda662
# ╠═0a3c07d7-b848-46bd-904d-1985c1199c9f
# ╟─47f0e502-573e-4f6f-bfdd-ee7cf01840c9
# ╠═3ec2e540-3cfb-404e-9ecb-c66ac371d0f7
# ╟─0e51a748-5aad-4620-a27f-48f8a8371733
# ╠═68a4086a-0052-4e88-ab16-f8b3bc801d2d
# ╟─23d8674f-5ae7-4fdc-b8a4-3fbe08331a23
# ╠═3ba3d60d-40de-41de-a890-fd30117118b0
# ╟─005bbb17-38f9-42b3-87b5-ee1a0bc173a2
# ╠═848715da-c712-415c-927d-394ef6dea2e1
# ╟─c1064429-49bb-4a96-ab4a-8dc07ea8cd39
# ╠═225817cb-e136-4741-96c2-92be1364ecf6
# ╟─afb5617d-2a38-451d-9ee9-860f50269c5e
# ╠═6dc9c3fe-e2cc-4e79-ae23-95775b944ea1
