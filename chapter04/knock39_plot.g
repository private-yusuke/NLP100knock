set logscale xy
set format y "10^{%L}"
set format x "10^{%L}"
plot "knock39_out.txt" using 1:2 title "Knock39. Zipfの法則"
pause -1 "hit enter key"