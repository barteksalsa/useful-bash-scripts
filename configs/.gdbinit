define rh
monitor reset halt
end

define connect
target remote localhost:3333
interrupt
rh
end

set prompt \033[31mgdb$ \033[0m
set height 0
set width 0
set output-radix 0x10
set input-radix 0x10
set confirm off

