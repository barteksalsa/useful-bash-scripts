#-------------------------------------------
# AUTOLOAD PATHS
#
add-auto-load-safe-path /home/barteks/Projects/zephyr/samples/hello_world/build-nrf52840_pca10056/.gdbinit


#-------------------------------------------
# PROMPT
#
set prompt \033[31mgdb$ \033[0m
set radix 16
set confirm no
set height 0
set width 0


#-------------------------------------------
# SHORTCUTS
#

define rh
monitor reset halt
end

define connect
target remote localhost:3333
interrupt
rh
end


#--------------------------------------------
# STARTUP
#
connect
rh
