#!/bin/bash
# WangKai 编写于 2018/12/9

# 变量赋值
ps=event_2018_162_22_04_24_000.ps
lon=119.581
lat=33.58

# GMT 参数配置
gmt set FONT_LABEL 12 FONT_TITLE 12 FONT_ANNOT_PRIMARY 10p

######################### 台站图 ##############################
# 底图
gmt pscoast -R100/133/22/46 -Xf2c -Yf18c -JB116.5/24/22/46/8c -Ggreen -Swhite -A250 -Dl -Ba5WSEN -K -Wthinnest -P -N1p,black > $ps

# 画大圆
gmt psxy -R -J -O -K -W0.1p,red -Fr$lon/$lat stations >> $ps

# 画台站
gmt psxy -R -J -O -K -St0.3 -Gblue -Wthinnest stations >> $ps
gmt pstext -R -J -O -K -Dj0.15/0 -F+f6p,4,red+j -N stations >> $ps

# 画震中
echo "$lon $lat" | gmt psxy -R -J -O -K -Sa0.2i -Gyellow -Wthin >> $ps

# 图名
gmt pslegend -O -K -Dx2c/7.5c+w5.6i+jBL+l1.5 << EOF >> $ps
H 22 Times-Roman Event 2018 162 22 04 24 000 UTC
H 16 Times-Roman M=3.0 Depth=16.98 km Latitude=33.5800 Longitude=119.5810
EOF

######################### 时频分析图 ##############################
# 底图
gmt psbasemap -JX5.8c -R0.64/751.76/0/50 -Bxa200+l'Time(s)' -Bya10+l'Frequence(Hz)' -BWSen+tWEC -Xf12.5c -Yf18.5c -O -K >> $ps

# 制作色标文件
gmt makecpt -T-3.0722/5.8196/1.5 > 1.cpt

# 画图像
gmt grdimage -J -R -B TF.grd -C1.cpt -O -K >> $ps

# 画色标刻度
gmt psscale -C1.cpt -Dx6.3c/2.9c/5.8c/0.5c -B1/:"log(A)": -O -K >> $ps

######################### Record Section ##############################
#SAC="./Data/*SAC"  SAC文件的存放位置，*SAC表示该目录下所有的SAC文件
#SAC="./bin_data/*SAC"
SAC="./data/*SAC"
#time_window=""1600/2000" 画图的时间范围
time_window="45/725"
#dist_range="59/141"      画图的震中距范围
dist_range="7.2/10.1"
#dist_afg="a10f5g0"      震中距轴的轴标注 a为标注，f为刻度，g为刻度线 数字代表出现的间隔
dist_afg="a0.2f0.1g0"
#time_afg="a50f25g0"      时间轴的轴标注 
time_afg="a50f25g0"

J=X18.2c/15c
time_window=${time_window}
dist_range=${dist_range}
R="${time_window}"/"${dist_range}"

#-Xf2.3c和-Yf2c控制底图的位置
gmt psxy -J$J -R$R -Xf1.8c -Yf2c -T -O -K -P >> $ps

#-M1c为归一化选项，1c为归一化后振幅在底图上的大小
gmt pssac  ${SAC} -J$J -R$R -Ed -M1c -K -O -P >> $ps

gmt psbasemap -J$J -R$R -By${dist_afg}+l"Distance(deg)" -BWS -K -O -P >> $ps
	
gmt psbasemap -J$J -R$R -Bx${time_afg}+l"Time(s)" -BWS -K -O -P >> $ps

gmt psbasemap -J$J -R$R -B0 -Ben -K -O -P >> $ps
 
gmt psxy -J$J -R$R -T -O -K -P >> $ps

# 同相轴
gmt psxy -J -R -W1p,red -O -K << EOF >> $ps
270 7.2
360 10.1
EOF

# 水印
gmt pslegend -O -Dx9c/-1.7c+w5.6i+jBL+l1.1 << EOF >> $ps
H 10 Times-Roman Made by K.Wang
H 10 Times-Roman Supported by YL.Chen
EOF

# 打开文件
# open $ps

# 删除临时文件
rm *.cpt gmt.*
