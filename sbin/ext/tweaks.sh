#!/sbin/busybox sh
# thanks to hardcore and nexxx
# some parameters are taken from http://forum.xda-developers.com/showthread.php?t=1292743 (highly recommended to read)

. /res/customconfig/customconfig-helper
read_defaults
read_config

#apply default config, delay for 5 secs to make sure that everything is initialized
(
sleep 5
/res/uci.sh apply
) &

# IPv6 privacy tweak
echo "2" > /proc/sys/net/ipv6/conf/all/use_tempaddr

# TCP tweaks
#echo "2" > /proc/sys/net/ipv4/tcp_syn_retries
#echo "2" > /proc/sys/net/ipv4/tcp_synack_retries
#echo "10" > /proc/sys/net/ipv4/tcp_fin_timeout

# disable debugging on some modules
if [ "$logger" == "off" ];then
  echo 0 > /sys/module/ump/parameters/ump_debug_level
  echo 0 > /sys/module/mali/parameters/mali_debug_level
  echo 0 > /sys/module/kernel/parameters/initcall_debug
  echo 0 > /sys//module/lowmemorykiller/parameters/debug_level
  echo 0 > /sys/module/wakelock/parameters/debug_mask
  echo 0 > /sys/module/userwakelock/parameters/debug_mask
  echo 0 > /sys/module/earlysuspend/parameters/debug_mask
  echo 0 > /sys/module/alarm/parameters/debug_mask
  echo 0 > /sys/module/alarm_dev/parameters/debug_mask
  echo 0 > /sys/module/binder/parameters/debug_mask
  echo 0 > /sys/module/xt_qtaguid/parameters/debug_mask
fi

#thanks to pikachu01@XDA
/sbin/busybox sh /sbin/siyah/thunderbolt.sh
#sysctl -w kernel.sched_min_granularity_ns=200000;
#sysctl -w kernel.sched_latency_ns=400000;
#sysctl -w kernel.sched_wakeup_granularity_ns=100000;
#echo NO_GENTLE_FAIR_SLEEPERS > /sys/kernel/debug/sched_features
