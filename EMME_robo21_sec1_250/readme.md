## วิชา 01211433 Vision and Control of Industrial Robots Sec 1, 250

ภาคต้น ปีการศึกษา 2564

ดร.วโรดม ตู้จินดา
<br>สาขาวิชาไฟฟ้าเครื่องกลการผลิต
<br>ภาควิชาวิศวกรรมเครื่องกล คณะวิศวกรรมศาสตร์ ม.เกษตรศาสตร์

<hr>

### เวลาเรียน (ออนไลน์)

เข้าเรียนจากลิงก์ของ cisco webex ที่โพสต์ใน facebook group และ Google classroom
<ul>
  <li />Sec 1 : ศุกร์ 1 - 4 PM 
  <li />Sec 250 : อังคาร 1 - 4 PM
</ul>

หมายเหตุ : 
<ul>
  <li />ในการเรียนแต่ละครั้งประกอบด้วยการสอนสด และ/หรือ วีดีโอที่บันทึกล่วงหน้า
  <li />ในแต่ละสัปดาห์จะมีการบันทึกไว้เพื่อรับชมย้อนหลังได้ (แนะนำให้ดาวน์โหลดทั้งไฟล์ไปก่อนและเปิดในเครื่อง จะได้ความชัดเจนมากกว่าเปิดดูในเบราเซอร์แบบออนไลน์)
  <li />เนื้อหารวมของทั้ง Sec 1 และ 250 คือวีดีโอที่บันทึกจากทั้งวันอังคารและวันศุกร์รวมกัน
</ul>

### การให้คะแนน

<ul>
  <li />Homework: 20 %
  <li />Midterm : 20 %
  <li />Final : 30 %
  <li />Project : 30 %
</ul>

### Lecture 0 : แนะนำวิชาและซอฟต์แวร์

#### หัวข้อ

<ul>
  <li />Course syllabus
  <li />ซอฟต์แวร์ที่ใช้และการติดตั้ง
</ul>

#### วีดีโอ

<ul>
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EZYSyVDM4DxBuxAwJ5lVqNkBUSo1Ct44PY5aUOQ_BwWnPA?e=Jc1rTq">Part 1 : แนะนำวิชาและการติดตั้งซอฟต์แวร์</a> อังคาร 29 มิย. 64
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EVgmYBhMwBVPmsyXP24d3YcBZZd4K4W5LxRdTnMIFtbVug?e=exTGMd">Part 2: แนะนำการเขียนโปรแกรม Python และ Julia บน Jupyter notebook และ Pluto notebook</a> ศุกร์ 2 กค. 64
</ul>

  
#### วีดีโอเสริม

<ul>
  <li /><a href="https://www.youtube.com/watch?v=xNY-W9vLowo">การติดตั้ง Julia และใช้งานสมุดบันทึก Pluto เบื้องต้น</a>
  <li />หากต้องการติดตั้ง Jupyter notebook บนเครื่องคอมพิวเตอร์ที่ใช้ แนะนำวีดีโอที่ติดตั้งพร้อม tensorflow สำหรับ deep learning หลังจากนั้นเพิ่มแพ็คเกจ Python Control Library ใน environment ที่สร้างขึ้นโดยคำสั่ง pip install slycot และ pip install control
  <ul>
    <li /><a href="https://www.youtube.com/watch?v=RgO8BBNGB8w&t=38s">2020, Installing TensorFlow 2.0, Keras, & Python 3.7 in Windows 10 </a> by Jeff Heaton
    <li /><a href="https://www.youtube.com/watch?v=MpUvdLD932c&t=487s">2020, Installing TensorFlow 2.0, Keras, & Python 3.7 in Mac OSX</a> by Jeff Heaton
  </ul>
</ul>

### Lecture 1 : การกำเนิดแนววิถี

#### สไลด์
<ul>
  <li /><a href="https://drive.google.com/file/d/1-MsfY1JF7d56F3E92_kGjyWKGSz8wd0I/view?usp=sharing">Robot trajectory generation</a>
</ul>

#### วีดีโอ
<ul>
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/Ef-ZaWeGfvhDkkWFalv-I0ABCyDGGtHAlwZqooYz9NmQRw?e=99cWGF">Part I :</a> อังคาร 6 กค. 2564
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EW5hHdiBFCdMgp9IZ0JC3-sB1Fvvy3UPNO_mKxYpzqr51g?e=XFrhWa">Part II : </a>ศุกร์ 9 กค. 2564
</ul>

#### วีดีโอเสริม
<ul>
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EUZuHLf5R1FNvYp9ZKFg8M4BPr0b1_a353Gznh8Dpc8zYg?e=y3mutj">แนวทางการทำ homework 1 โดยภาษาจูเลียบน Pluto notebook</a>
</ul>

### Lecture 2 : พลวัตข้อต่ออิสระและพื้นฐานการควบคุมป้อนกลับ

#### สไลด์
<ul>
  <li /><a href="https://drive.google.com/file/d/1l8Pn2swS02-js1D9dj9hOKjNUtSoSXbL/view?usp=sharing">พลวัตข้อต่ออิสระและพื้นฐานการควบคุมป้อนกลับ </a>
</ul>

#### วีดีโอ
<ul>
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/Edf72la_cqhHvfmjbM0aHwQB_2D2rL1OduFiSksW3ttiJw?e=aibcaE">Part I : </a>อังคาร 13 กค. 64
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EYMRd0axtfxPlLvDSn9w-a8BPgL7Qb33SbnR2Lr18BJGbQ?e=BBGMxO">Part II :</a> ศุกร์ 16 กค. 64
</ul>  

#### วีดีโอเสริม
<ul>
  <li /><a href="https://o365ku-my.sharepoint.com/:f:/g/personal/varodom_t_live_ku_th/El13KwdRAzhJnKSmFSc5rnABvgou7GiwKWlx1ultpHsVLg?e=TP3wSo">การติดตั้งแพ็คเกจ ControlSystems.jl บน Julia</a>
  <li /><a href="https://o365ku-my.sharepoint.com/:v:/g/personal/varodom_t_live_ku_th/EZ04_93-ZyZGtLVBdlC5nvwB_dPALdAa4JUmTRapRkYf7w?e=ukF7uw">แนวทางการทำ homework 2 โดยภาษาจูเลียบน Pluto notebook</a>
</ul>

### Lecture 3 : การออกแบบตัวควบคุมข้อต่ออิสระ

#### สไลด์
<ul>
  <li /><a href="https://drive.google.com/file/d/1_HMnc7jr5lT3ETdaUSwUZ0inok-Rnp89/view?usp=sharing">การออกแบบระบบควบคุมโดยวิธี loopshaping</a>
</ul>

#### วีดีโอ
<ul>
  <li />Part I : อังคาร 20 กค. 64
  <li />Part II : ศุกร์ 23 กค. 64
</ul>


<hr>

### ลิงก์ที่เกี่ยวข้อง
<ul>
  <li /><a href="https://www.chulabook.com/th/product-details/25543-%E0%B8%81%E0%B8%B2%E0%B8%A3%E0%B8%A7%E0%B8%B4%E0%B9%80%E0%B8%84%E0%B8%A3%E0%B8%B2%E0%B8%B0%E0%B8%AB%E0%B9%8C%E0%B9%81%E0%B8%A5%E0%B8%B0%E0%B8%84%E0%B8%A7%E0%B8%9A%E0%B8%84%E0%B8%B8%E0%B8%A1%E0%B8%AB%E0%B8%B8%E0%B9%88%E0%B8%99%E0%B8%A2%E0%B8%99%E0%B8%95%E0%B9%8C%E0%B8%AD%E0%B8%B8%E0%B8%95%E0%B8%AA%E0%B8%B2%E0%B8%AB%E0%B8%81%E0%B8%A3%E0%B8%A3%E0%B8%A1">หนังสือ "การวิเคราะห์และควบคุมหุ่นยนต์อุตสาหกรรม"</a>
  <li /><a href="https://www.scilab.org/">Scilab website</a>
  <li /><a href="https://scilabdotninja.wordpress.com/rtsx/download-rtsx/">RTSX download</a>
  <li /><a href="https://julialang.org/">Julia website</a>
  <li />หน้า github ของผู้สอน 
  <ul>
    <li /><a href="https://github.com/dewdotninja/control_python">control_python</a>
    <li /><a href="https://dewdotninja.github.io/books_th/julia4eng/julia.html">หนังสือ "การโปรแกรมจูเลียสำหรับวิศวกร" (ระหว่างจัดทำ) </a>
  </ul>
</ul>
