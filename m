From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v2 3/4] serial: samsung: introduce
 s3c24xx_serial_rx_drain_fifo() function
Date: Fri, 11 Sep 2015 15:15:51 +0900
Message-ID: <55F27197.8020402@samsung.com>
References: <1441892476-14273-1-git-send-email-r.baldyga@samsung.com>
 <1441892476-14273-4-git-send-email-r.baldyga@samsung.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=------------040505090800000202050801
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1441892476-14273-4-git-send-email-r.baldyga@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Baldyga <r.baldyga@samsung.com>, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, m.szyprowski@samsung.com
List-Id: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505090800000202050801
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit

On 10.09.2015 22:41, Robert Baldyga wrote:
> This patch introduces s3c24xx_serial_rx_drain_fifo() which reads data
> from RX FIFO and writes it to tty buffer. It also checks for special
> conditions (such as 'break') and handles it. This function has been
> separated from s3c24xx_serial_rx_chars_pio() as it contains code which
> can be used also in DMA mode.

Much better, thanks! Now it is also easier to spot the difference (see
below).

> 
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>  drivers/tty/serial/samsung.c | 23 +++++++++++++----------
>  1 file changed, 13 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> index dc4be54..1d7dd86 100644
> --- a/drivers/tty/serial/samsung.c
> +++ b/drivers/tty/serial/samsung.c
> @@ -621,16 +621,12 @@ finish:
>  	return IRQ_HANDLED;
>  }
>  
> -static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
> +static void s3c24xx_serial_rx_drain_fifo(struct s3c24xx_uart_port *ourport)
>  {
> -	struct s3c24xx_uart_port *ourport = dev_id;
>  	struct uart_port *port = &ourport->port;
>  	unsigned int ufcon, ch, flag, ufstat, uerstat;
> -	unsigned long flags;
>  	int max_count = port->fifosize;
>  
> -	spin_lock_irqsave(&port->lock, flags);
> -
>  	while (max_count-- > 0) {
>  		ufcon = rd_regl(port, S3C2410_UFCON);
>  		ufstat = rd_regl(port, S3C2410_UFSTAT);
> @@ -654,9 +650,7 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  					ufcon |= S3C2410_UFCON_RESETRX;
>  					wr_regl(port, S3C2410_UFCON, ufcon);
>  					rx_enabled(port) = 1;
> -					spin_unlock_irqrestore(&port->lock,
> -							flags);
> -					goto out;
> +					return;
>  				}
>  				continue;
>  			}
> @@ -702,10 +696,19 @@ static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
>  				 ch, flag);
>  	}
>  
> -	spin_unlock_irqrestore(&port->lock, flags);
>  	tty_flip_buffer_push(&port->state->port);

Here is a difference - previously this was outside of spinlock. I think
moving it inside spin lock is okay, just the interrupts won't be
disabled before unlock and queue_work() from tty_flip_buffer_push().

However after testing this patchset (entire) on:
next-20150910 + my dt-for-next branch (dma for serial) + this patchset
you can see quite complicated lockdep warning:

[    3.568657] =========================================================
[    3.575079] [ INFO: possible irq lock inversion dependency detected ]
[    3.581506] 4.2.0-next-20150910-00009-g65fd5a9cff54 #218 Not tainted
[    3.587838] ---------------------------------------------------------
[    3.594263] swapper/0/0 just changed the state of lock:
[    3.599470]  (&port_lock_key){..-...}, at: [<c02a8fac>]
s3c24xx_serial_tx_dma_complete+0x8c/0xfc
[    3.608237] but this lock took another, SOFTIRQ-unsafe lock in the past:
[    3.614919]  (&(&ctx->lock)->rlock){+.+...}
[    3.614919]
[    3.614919] and interrupts could create inverse lock ordering between
them.
[    3.614919]
[    3.625076]
[    3.625076] other info that might help us debug this:
[    3.631586]  Possible interrupt unsafe locking scenario:
[    3.631586]
[    3.638356]        CPU0                    CPU1
[    3.642870]        ----                    ----
[    3.647382]   lock(&(&ctx->lock)->rlock);
[    3.651376]                                local_irq_disable();
[    3.657278]                                lock(&port_lock_key);
[    3.663267]                                lock(&(&ctx->lock)->rlock);
[    3.669777]   <Interrupt>
[    3.672381]     lock(&port_lock_key);


Config: exynos, disabled MMC_CLKGATE, enabled usual testing stuff
Board: Trats2

Didn't you notice it?


Additionally the SysRq "Show backtrace of all active CPUs" on this
linux-next (without additional patches, pure next) has significant delay
(like 5 seconds) and a:
[  169.221223] s3c-i2c 138d0000.i2c: timeout waiting for bus idle

That's weird. But as I said this occurs on pure next as well.

Dmesgs and config attached.

Best regards,
Krzysztof


> +}
> +
> +static irqreturn_t s3c24xx_serial_rx_chars_pio(void *dev_id)
> +{
> +	struct s3c24xx_uart_port *ourport = dev_id;
> +	struct uart_port *port = &ourport->port;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&port->lock, flags);
> +	s3c24xx_serial_rx_drain_fifo(ourport);
> +	spin_unlock_irqrestore(&port->lock, flags);
>  
> -out:
>  	return IRQ_HANDLED;
>  }
>  
> 


--------------040505090800000202050801
Content-Type: text/plain; charset=UTF-8;
 name="trats2-backtrace-stall-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trats2-backtrace-stall-dmesg.txt"

-sh-4.1# [  164.160601] sysrq: SysRq : Show backtrace of all active CPUs
[  164.164815] Sending NMI to all CPUs:
[  169.221223] s3c-i2c 138d0000.i2c: timeout waiting for bus idle
[  174.175570] NMI backtrace for cpu 1
[  174.177607] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-next-20150910 #264
[  174.184810] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.190885] task: ee8b0000 ti: ee8b8000 task.ti: ee8b8000
[  174.196266] PC is at cpuidle_enter_state+0x1d4/0x268
[  174.201214] LR is at cpuidle_enter_state+0x1d0/0x268
[  174.206162] pc : [<c0419cb8>]    lr : [<c0419cb4>]    psr: 600f0013
[  174.212411] sp : ee8b9fb0  ip : 00000001  fp : c08eaf38
[  174.217619] r10: c08eaf38  r9 : 00000026  r8 : 3927e343
[  174.222828] r7 : 00000000  r6 : eef77568  r5 : 00000025  r4 : e74ebaa3
[  174.229338] r3 : 00000000  r2 : 2e6c0000  r1 : 00000000  r0 : c0419cb4
[  174.231223] s3c-i2c 138d0000.i2c: timeout waiting for bus idle
[  174.241664] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  174.248781] Control: 10c5387d  Table: 6da3404a  DAC: 00000051
[  174.254511] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.2.0-next-20150910 #264
[  174.261714] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.267791] [<c0016630>] (unwind_backtrace) from [<c0013148>] (show_stack+0x10/0x14)
[  174.275516] [<c0013148>] (show_stack) from [<c022371c>] (dump_stack+0x70/0xbc)
[  174.282721] [<c022371c>] (dump_stack) from [<c022781c>] (nmi_cpu_backtrace+0xa4/0xf4)
[  174.290533] [<c022781c>] (nmi_cpu_backtrace) from [<c0015664>] (handle_IPI+0x100/0x1c0)
[  174.298518] [<c0015664>] (handle_IPI) from [<c0009524>] (gic_handle_irq+0x88/0x94)
[  174.306069] [<c0009524>] (gic_handle_irq) from [<c0013cb8>] (__irq_svc+0x58/0x98)
[  174.313533] Exception stack(0xee8b9f60 to 0xee8b9fa8)
[  174.318569] 9f60: c0419cb4 00000000 2e6c0000 00000000 e74ebaa3 00000025 eef77568 00000000
[  174.326729] 9f80: 3927e343 00000026 c08eaf38 c08eaf38 00000001 ee8b9fb0 c0419cb4 c0419cb8
[  174.334885] 9fa0: 600f0013 ffffffff
[  174.338360] [<c0013cb8>] (__irq_svc) from [<c0419cb8>] (cpuidle_enter_state+0x1d4/0x268)
[  174.346433] [<c0419cb8>] (cpuidle_enter_state) from [<c0062a64>] (cpu_startup_entry+0x158/0x26c)
[  174.355198] [<c0062a64>] (cpu_startup_entry) from [<400095cc>] (0x400095cc)
[  174.362141] NMI backtrace for cpu 2
[  174.365615] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.2.0-next-20150910 #264
[  174.372818] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.378894] task: ee8b0ac0 ti: ee8ba000 task.ti: ee8ba000
[  174.384275] PC is at cpuidle_enter_state+0x1d4/0x268
[  174.389222] LR is at cpuidle_enter_state+0x1d0/0x268
[  174.394171] pc : [<c0419cb8>]    lr : [<c0419cb4>]    psr: 60030013
[  174.400420] sp : ee8bbfb0  ip : 00000001  fp : c08eaf38
[  174.405628] r10: c08eaf38  r9 : 00000026  r8 : 3927e3c0
[  174.410837] r7 : 00000000  r6 : eef83568  r5 : 00000026  r4 : 1bb82f4a
[  174.417347] r3 : 00000000  r2 : 2e6cc000  r1 : 00000000  r0 : c0419cb4
[  174.423858] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  174.430974] Control: 10c5387d  Table: 6ded404a  DAC: 00000051
[  174.436704] CPU: 2 PID: 0 Comm: swapper/2 Not tainted 4.2.0-next-20150910 #264
[  174.443908] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.449985] [<c0016630>] (unwind_backtrace) from [<c0013148>] (show_stack+0x10/0x14)
[  174.457709] [<c0013148>] (show_stack) from [<c022371c>] (dump_stack+0x70/0xbc)
[  174.464914] [<c022371c>] (dump_stack) from [<c022781c>] (nmi_cpu_backtrace+0xa4/0xf4)
[  174.472726] [<c022781c>] (nmi_cpu_backtrace) from [<c0015664>] (handle_IPI+0x100/0x1c0)
[  174.480712] [<c0015664>] (handle_IPI) from [<c0009524>] (gic_handle_irq+0x88/0x94)
[  174.488262] [<c0009524>] (gic_handle_irq) from [<c0013cb8>] (__irq_svc+0x58/0x98)
[  174.495726] Exception stack(0xee8bbf60 to 0xee8bbfa8)
[  174.500762] bf60: c0419cb4 00000000 2e6cc000 00000000 1bb82f4a 00000026 eef83568 00000000
[  174.508921] bf80: 3927e3c0 00000026 c08eaf38 c08eaf38 00000001 ee8bbfb0 c0419cb4 c0419cb8
[  174.517078] bfa0: 60030013 ffffffff
[  174.520553] [<c0013cb8>] (__irq_svc) from [<c0419cb8>] (cpuidle_enter_state+0x1d4/0x268)
[  174.528626] [<c0419cb8>] (cpuidle_enter_state) from [<c0062a64>] (cpu_startup_entry+0x158/0x26c)
[  174.537391] [<c0062a64>] (cpu_startup_entry) from [<400095cc>] (0x400095cc)
[  174.544335] NMI backtrace for cpu 3
[  174.547808] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.2.0-next-20150910 #264
[  174.555012] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.561087] task: ee8b1580 ti: ee8bc000 task.ti: ee8bc000
[  174.566468] PC is at cpuidle_enter_state+0x1d4/0x268
[  174.571416] LR is at cpuidle_enter_state+0x1d0/0x268
[  174.576364] pc : [<c0419cb8>]    lr : [<c0419cb4>]    psr: 60060013
[  174.582613] sp : ee8bdfb0  ip : 00000001  fp : c08eaf38
[  174.587821] r10: c08eaf38  r9 : 00000026  r8 : 3927e36d
[  174.593030] r7 : 00000000  r6 : eef8f568  r5 : 00000026  r4 : 38657a62
[  174.599540] r3 : 00000000  r2 : 2e6d8000  r1 : 00000000  r0 : c0419cb4
[  174.606050] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
[  174.613167] Control: 10c5387d  Table: 6dabc04a  DAC: 00000051
[  174.618898] CPU: 3 PID: 0 Comm: swapper/3 Not tainted 4.2.0-next-20150910 #264
[  174.626101] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[  174.632178] [<c0016630>] (unwind_backtrace) from [<c0013148>] (show_stack+0x10/0x14)
[  174.639902] [<c0013148>] (show_stack) from [<c022371c>] (dump_stack+0x70/0xbc)
[  174.647107] [<c022371c>] (dump_stack) from [<c022781c>] (nmi_cpu_backtrace+0xa4/0xf4)
[  174.654919] [<c022781c>] (nmi_cpu_backtrace) from [<c0015664>] (handle_IPI+0x100/0x1c0)
[  174.662905] [<c0015664>] (handle_IPI) from [<c0009524>] (gic_handle_irq+0x88/0x94)
[  174.670456] [<c0009524>] (gic_handle_irq) from [<c0013cb8>] (__irq_svc+0x58/0x98)
[  174.677919] Exception stack(0xee8bdf60 to 0xee8bdfa8)
[  174.682955] df60: c0419cb4 00000000 2e6d8000 00000000 38657a62 00000026 eef8f568 00000000
[  174.691115] df80: 3927e36d 00000026 c08eaf38 c08eaf38 00000001 ee8bdfb0 c0419cb4 c0419cb8
[  174.699271] dfa0: 60060013 ffffffff
[  174.702746] [<c0013cb8>] (__irq_svc) from [<c0419cb8>] (cpuidle_enter_state+0x1d4/0x268)
[  174.710819] [<c0419cb8>] (cpuidle_enter_state) from [<c0062a64>] (cpu_startup_entry+0x158/0x26c)
[  174.719584] [<c0062a64>] (cpu_startup_entry) from [<400095cc>] (0x400095cc)


--------------040505090800000202050801
Content-Type: text/plain; charset=UTF-8;
 name="trats2-serial-lockdep-issue-config.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trats2-serial-lockdep-issue-config.txt"

#
# Automatically generated file; DO NOT EDIT.
# Linux/arm 4.2.0 Kernel Configuration
#
CONFIG_ARM=y
CONFIG_ARM_HAS_SG_CHAIN=y
CONFIG_MIGHT_HAVE_PCI=y
CONFIG_SYS_SUPPORTS_APM_EMULATION=y
CONFIG_HAVE_PROC_CPU=y
CONFIG_NO_IOPORT_MAP=y
CONFIG_STACKTRACE_SUPPORT=y
CONFIG_LOCKDEP_SUPPORT=y
CONFIG_TRACE_IRQFLAGS_SUPPORT=y
CONFIG_RWSEM_XCHGADD_ALGORITHM=y
CONFIG_ARCH_HAS_BANDGAP=y
CONFIG_FIX_EARLYCON_MEM=y
CONFIG_GENERIC_HWEIGHT=y
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_NEED_DMA_MAP_STATE=y
CONFIG_ARCH_SUPPORTS_UPROBES=y
CONFIG_VECTORS_BASE=0xffff0000
CONFIG_ARM_PATCH_PHYS_VIRT=y
CONFIG_GENERIC_BUG=y
CONFIG_PGTABLE_LEVELS=2
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_IRQ_WORK=y
CONFIG_BUILDTIME_EXTABLE_SORT=y

#
# General setup
#
CONFIG_INIT_ENV_ARG_LIMIT=32
CONFIG_CROSS_COMPILE=""
# CONFIG_COMPILE_TEST is not set
CONFIG_LOCALVERSION=""
CONFIG_LOCALVERSION_AUTO=y
CONFIG_HAVE_KERNEL_GZIP=y
CONFIG_HAVE_KERNEL_LZMA=y
CONFIG_HAVE_KERNEL_XZ=y
CONFIG_HAVE_KERNEL_LZO=y
CONFIG_HAVE_KERNEL_LZ4=y
CONFIG_KERNEL_GZIP=y
# CONFIG_KERNEL_LZMA is not set
# CONFIG_KERNEL_XZ is not set
# CONFIG_KERNEL_LZO is not set
# CONFIG_KERNEL_LZ4 is not set
CONFIG_DEFAULT_HOSTNAME="(none)"
CONFIG_SWAP=y
CONFIG_SYSVIPC=y
CONFIG_SYSVIPC_SYSCTL=y
# CONFIG_POSIX_MQUEUE is not set
# CONFIG_KDBUS is not set
CONFIG_CROSS_MEMORY_ATTACH=y
CONFIG_FHANDLE=y
CONFIG_USELIB=y
# CONFIG_AUDIT is not set
CONFIG_HAVE_ARCH_AUDITSYSCALL=y

#
# IRQ subsystem
#
CONFIG_GENERIC_IRQ_PROBE=y
CONFIG_GENERIC_IRQ_SHOW=y
CONFIG_GENERIC_IRQ_SHOW_LEVEL=y
CONFIG_HARDIRQS_SW_RESEND=y
CONFIG_GENERIC_IRQ_CHIP=y
CONFIG_IRQ_DOMAIN=y
CONFIG_IRQ_DOMAIN_HIERARCHY=y
CONFIG_HANDLE_DOMAIN_IRQ=y
# CONFIG_IRQ_DOMAIN_DEBUG is not set
CONFIG_IRQ_FORCED_THREADING=y
CONFIG_SPARSE_IRQ=y
CONFIG_GENERIC_TIME_VSYSCALL=y
CONFIG_GENERIC_CLOCKEVENTS=y
CONFIG_ARCH_HAS_TICK_BROADCAST=y
CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=y

#
# Timers subsystem
#
CONFIG_TICK_ONESHOT=y
CONFIG_NO_HZ_COMMON=y
# CONFIG_HZ_PERIODIC is not set
CONFIG_NO_HZ_IDLE=y
# CONFIG_NO_HZ_FULL is not set
CONFIG_NO_HZ=y
CONFIG_HIGH_RES_TIMERS=y

#
# CPU/Task time and stats accounting
#
CONFIG_TICK_CPU_ACCOUNTING=y
# CONFIG_VIRT_CPU_ACCOUNTING_GEN is not set
# CONFIG_IRQ_TIME_ACCOUNTING is not set
# CONFIG_BSD_PROCESS_ACCT is not set
# CONFIG_TASKSTATS is not set

#
# RCU Subsystem
#
CONFIG_PREEMPT_RCU=y
# CONFIG_RCU_EXPERT is not set
CONFIG_SRCU=y
# CONFIG_TASKS_RCU is not set
CONFIG_RCU_STALL_COMMON=y
# CONFIG_TREE_RCU_TRACE is not set
# CONFIG_RCU_EXPEDITE_BOOT is not set
CONFIG_BUILD_BIN2C=y
CONFIG_IKCONFIG=y
CONFIG_IKCONFIG_PROC=y
CONFIG_LOG_BUF_SHIFT=17
CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
CONFIG_GENERIC_SCHED_CLOCK=y
CONFIG_CGROUPS=y
# CONFIG_CGROUP_DEBUG is not set
# CONFIG_CGROUP_FREEZER is not set
# CONFIG_CGROUP_PIDS is not set
# CONFIG_CGROUP_DEVICE is not set
# CONFIG_CPUSETS is not set
# CONFIG_CGROUP_CPUACCT is not set
# CONFIG_MEMCG is not set
# CONFIG_CGROUP_SCHED is not set
# CONFIG_BLK_CGROUP is not set
# CONFIG_CHECKPOINT_RESTORE is not set
CONFIG_NAMESPACES=y
CONFIG_UTS_NS=y
CONFIG_IPC_NS=y
# CONFIG_USER_NS is not set
CONFIG_PID_NS=y
CONFIG_NET_NS=y
# CONFIG_SCHED_AUTOGROUP is not set
# CONFIG_SYSFS_DEPRECATED is not set
# CONFIG_RELAY is not set
CONFIG_BLK_DEV_INITRD=y
CONFIG_INITRAMFS_SOURCE=""
CONFIG_RD_GZIP=y
CONFIG_RD_BZIP2=y
CONFIG_RD_LZMA=y
CONFIG_RD_XZ=y
CONFIG_RD_LZO=y
CONFIG_RD_LZ4=y
# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
CONFIG_SYSCTL=y
CONFIG_ANON_INODES=y
CONFIG_HAVE_UID16=y
CONFIG_BPF=y
# CONFIG_EXPERT is not set
CONFIG_UID16=y
CONFIG_MULTIUSER=y
# CONFIG_SGETMASK_SYSCALL is not set
CONFIG_SYSFS_SYSCALL=y
# CONFIG_SYSCTL_SYSCALL is not set
CONFIG_KALLSYMS=y
CONFIG_KALLSYMS_ALL=y
CONFIG_PRINTK=y
CONFIG_BUG=y
CONFIG_ELF_CORE=y
CONFIG_BASE_FULL=y
CONFIG_FUTEX=y
CONFIG_EPOLL=y
CONFIG_SIGNALFD=y
CONFIG_TIMERFD=y
CONFIG_EVENTFD=y
# CONFIG_BPF_SYSCALL is not set
CONFIG_SHMEM=y
CONFIG_AIO=y
CONFIG_ADVISE_SYSCALLS=y
CONFIG_USERFAULTFD=y
CONFIG_MEMBARRIER=y
# CONFIG_EMBEDDED is not set
CONFIG_HAVE_PERF_EVENTS=y
CONFIG_PERF_USE_VMALLOC=y

#
# Kernel Performance Events And Counters
#
# CONFIG_PERF_EVENTS is not set
CONFIG_VM_EVENT_COUNTERS=y
CONFIG_SLUB_DEBUG=y
CONFIG_COMPAT_BRK=y
# CONFIG_SLAB is not set
CONFIG_SLUB=y
CONFIG_SLUB_CPU_PARTIAL=y
# CONFIG_SYSTEM_DATA_VERIFICATION is not set
# CONFIG_PROFILING is not set
CONFIG_HAVE_OPROFILE=y
# CONFIG_KPROBES is not set
# CONFIG_JUMP_LABEL is not set
# CONFIG_UPROBES is not set
# CONFIG_HAVE_64BIT_ALIGNED_ACCESS is not set
CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=y
CONFIG_ARCH_USE_BUILTIN_BSWAP=y
CONFIG_HAVE_KPROBES=y
CONFIG_HAVE_KRETPROBES=y
CONFIG_HAVE_OPTPROBES=y
CONFIG_HAVE_ARCH_TRACEHOOK=y
CONFIG_HAVE_DMA_ATTRS=y
CONFIG_HAVE_DMA_CONTIGUOUS=y
CONFIG_GENERIC_SMP_IDLE_THREAD=y
CONFIG_GENERIC_IDLE_POLL_SETUP=y
CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=y
CONFIG_HAVE_CLK=y
CONFIG_HAVE_DMA_API_DEBUG=y
CONFIG_HAVE_PERF_REGS=y
CONFIG_HAVE_PERF_USER_STACK_DUMP=y
CONFIG_HAVE_ARCH_JUMP_LABEL=y
CONFIG_ARCH_WANT_IPC_PARSE_VERSION=y
CONFIG_HAVE_ARCH_SECCOMP_FILTER=y
CONFIG_HAVE_CC_STACKPROTECTOR=y
# CONFIG_CC_STACKPROTECTOR is not set
CONFIG_CC_STACKPROTECTOR_NONE=y
# CONFIG_CC_STACKPROTECTOR_REGULAR is not set
# CONFIG_CC_STACKPROTECTOR_STRONG is not set
CONFIG_HAVE_CONTEXT_TRACKING=y
CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=y
CONFIG_HAVE_IRQ_TIME_ACCOUNTING=y
CONFIG_HAVE_MOD_ARCH_SPECIFIC=y
CONFIG_MODULES_USE_ELF_REL=y
CONFIG_ARCH_HAS_ELF_RANDOMIZE=y
CONFIG_CLONE_BACKWARDS=y
CONFIG_OLD_SIGSUSPEND3=y
CONFIG_OLD_SIGACTION=y

#
# GCOV-based kernel profiling
#
# CONFIG_GCOV_KERNEL is not set
CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=y
CONFIG_HAVE_GENERIC_DMA_COHERENT=y
CONFIG_SLABINFO=y
CONFIG_RT_MUTEXES=y
CONFIG_BASE_SMALL=0
CONFIG_MODULES=y
# CONFIG_MODULE_FORCE_LOAD is not set
CONFIG_MODULE_UNLOAD=y
# CONFIG_MODULE_FORCE_UNLOAD is not set
# CONFIG_MODVERSIONS is not set
# CONFIG_MODULE_SRCVERSION_ALL is not set
# CONFIG_MODULE_SIG is not set
# CONFIG_MODULE_COMPRESS is not set
CONFIG_STOP_MACHINE=y
CONFIG_BLOCK=y
CONFIG_LBDAF=y
# CONFIG_BLK_DEV_BSG is not set
# CONFIG_BLK_DEV_BSGLIB is not set
# CONFIG_BLK_DEV_INTEGRITY is not set
# CONFIG_BLK_CMDLINE_PARSER is not set

#
# Partition Types
#
CONFIG_PARTITION_ADVANCED=y
# CONFIG_ACORN_PARTITION is not set
# CONFIG_AIX_PARTITION is not set
# CONFIG_OSF_PARTITION is not set
# CONFIG_AMIGA_PARTITION is not set
# CONFIG_ATARI_PARTITION is not set
# CONFIG_MAC_PARTITION is not set
CONFIG_MSDOS_PARTITION=y
# CONFIG_BSD_DISKLABEL is not set
# CONFIG_MINIX_SUBPARTITION is not set
# CONFIG_SOLARIS_X86_PARTITION is not set
# CONFIG_UNIXWARE_DISKLABEL is not set
# CONFIG_LDM_PARTITION is not set
# CONFIG_SGI_PARTITION is not set
# CONFIG_ULTRIX_PARTITION is not set
# CONFIG_SUN_PARTITION is not set
# CONFIG_KARMA_PARTITION is not set
CONFIG_EFI_PARTITION=y
# CONFIG_SYSV68_PARTITION is not set
# CONFIG_CMDLINE_PARTITION is not set

#
# IO Schedulers
#
CONFIG_IOSCHED_NOOP=y
CONFIG_IOSCHED_DEADLINE=y
CONFIG_IOSCHED_CFQ=y
# CONFIG_DEFAULT_DEADLINE is not set
CONFIG_DEFAULT_CFQ=y
# CONFIG_DEFAULT_NOOP is not set
CONFIG_DEFAULT_IOSCHED="cfq"
CONFIG_UNINLINE_SPIN_UNLOCK=y
CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=y
CONFIG_RWSEM_SPIN_ON_OWNER=y
CONFIG_LOCK_SPIN_ON_OWNER=y
CONFIG_FREEZER=y

#
# System Type
#
CONFIG_MMU=y
CONFIG_ARCH_MULTIPLATFORM=y
# CONFIG_ARCH_REALVIEW is not set
# CONFIG_ARCH_VERSATILE is not set
# CONFIG_ARCH_CLPS711X is not set
# CONFIG_ARCH_GEMINI is not set
# CONFIG_ARCH_EBSA110 is not set
# CONFIG_ARCH_EP93XX is not set
# CONFIG_ARCH_FOOTBRIDGE is not set
# CONFIG_ARCH_NETX is not set
# CONFIG_ARCH_IOP13XX is not set
# CONFIG_ARCH_IOP32X is not set
# CONFIG_ARCH_IOP33X is not set
# CONFIG_ARCH_IXP4XX is not set
# CONFIG_ARCH_DOVE is not set
# CONFIG_ARCH_MV78XX0 is not set
# CONFIG_ARCH_ORION5X is not set
# CONFIG_ARCH_MMP is not set
# CONFIG_ARCH_KS8695 is not set
# CONFIG_ARCH_W90X900 is not set
# CONFIG_ARCH_LPC32XX is not set
# CONFIG_ARCH_PXA is not set
# CONFIG_ARCH_SHMOBILE_LEGACY is not set
# CONFIG_ARCH_RPC is not set
# CONFIG_ARCH_SA1100 is not set
# CONFIG_ARCH_S3C24XX is not set
# CONFIG_ARCH_S3C64XX is not set
# CONFIG_ARCH_DAVINCI is not set
# CONFIG_ARCH_OMAP1 is not set

#
# Multiple platform selection
#

#
# CPU Core family selection
#
# CONFIG_ARCH_MULTI_V6 is not set
CONFIG_ARCH_MULTI_V7=y
CONFIG_ARCH_MULTI_V6_V7=y
# CONFIG_ARCH_MULTI_CPU_AUTO is not set
# CONFIG_ARCH_VIRT is not set
# CONFIG_ARCH_MVEBU is not set
# CONFIG_ARCH_ALPINE is not set
# CONFIG_ARCH_AT91 is not set
# CONFIG_ARCH_BCM is not set
# CONFIG_ARCH_BERLIN is not set
# CONFIG_ARCH_DIGICOLOR is not set
# CONFIG_ARCH_HIGHBANK is not set
# CONFIG_ARCH_HISI is not set
# CONFIG_ARCH_KEYSTONE is not set
# CONFIG_ARCH_MESON is not set
# CONFIG_ARCH_MXC is not set
# CONFIG_ARCH_MEDIATEK is not set

#
# TI OMAP/AM/DM/DRA Family
#
# CONFIG_ARCH_OMAP3 is not set
# CONFIG_ARCH_OMAP4 is not set
# CONFIG_SOC_OMAP5 is not set
# CONFIG_SOC_AM33XX is not set
# CONFIG_SOC_AM43XX is not set
# CONFIG_SOC_DRA7XX is not set
# CONFIG_ARCH_QCOM is not set
# CONFIG_ARCH_ROCKCHIP is not set
# CONFIG_ARCH_SOCFPGA is not set
# CONFIG_PLAT_SPEAR is not set
# CONFIG_ARCH_STI is not set
# CONFIG_ARCH_S5PV210 is not set
CONFIG_ARCH_EXYNOS=y
CONFIG_S5P_DEV_MFC=y
CONFIG_ARCH_EXYNOS3=y
CONFIG_ARCH_EXYNOS4=y
CONFIG_ARCH_EXYNOS5=y

#
# EXYNOS SoCs
#
CONFIG_SOC_EXYNOS3250=y
CONFIG_CPU_EXYNOS4210=y
CONFIG_SOC_EXYNOS4212=y
CONFIG_SOC_EXYNOS4412=y
CONFIG_SOC_EXYNOS4415=y
CONFIG_SOC_EXYNOS5250=y
CONFIG_SOC_EXYNOS5260=y
CONFIG_SOC_EXYNOS5410=y
CONFIG_SOC_EXYNOS5420=y
CONFIG_SOC_EXYNOS5440=y
CONFIG_SOC_EXYNOS5800=y
CONFIG_EXYNOS5420_MCPM=y
CONFIG_EXYNOS_CPU_SUSPEND=y
CONFIG_PLAT_SAMSUNG=y

#
# Samsung Common options
#

#
# Boot options
#

#
# Power management
#
# CONFIG_SAMSUNG_PM_CHECK is not set
# CONFIG_ARCH_SHMOBILE_MULTI is not set
# CONFIG_ARCH_SUNXI is not set
# CONFIG_ARCH_SIRF is not set
# CONFIG_ARCH_TEGRA is not set
# CONFIG_ARCH_UNIPHIER is not set
# CONFIG_ARCH_U8500 is not set
# CONFIG_ARCH_VEXPRESS is not set
# CONFIG_ARCH_WM8850 is not set
# CONFIG_ARCH_ZX is not set
# CONFIG_ARCH_ZYNQ is not set

#
# Processor Type
#
CONFIG_CPU_V7=y
CONFIG_CPU_32v6K=y
CONFIG_CPU_32v7=y
CONFIG_CPU_ABRT_EV7=y
CONFIG_CPU_PABRT_V7=y
CONFIG_CPU_CACHE_V7=y
CONFIG_CPU_CACHE_VIPT=y
CONFIG_CPU_COPY_V6=y
CONFIG_CPU_TLB_V7=y
CONFIG_CPU_HAS_ASID=y
CONFIG_CPU_CP15=y
CONFIG_CPU_CP15_MMU=y

#
# Processor Features
#
# CONFIG_ARM_LPAE is not set
# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
CONFIG_ARM_THUMB=y
# CONFIG_ARM_THUMBEE is not set
CONFIG_ARM_VIRT_EXT=y
CONFIG_SWP_EMULATE=y
# CONFIG_CPU_ICACHE_DISABLE is not set
# CONFIG_CPU_BPREDICT_DISABLE is not set
CONFIG_KUSER_HELPERS=y
CONFIG_VDSO=y
CONFIG_OUTER_CACHE=y
CONFIG_OUTER_CACHE_SYNC=y
CONFIG_MIGHT_HAVE_CACHE_L2X0=y
CONFIG_CACHE_L2X0=y
# CONFIG_PL310_ERRATA_588369 is not set
# CONFIG_PL310_ERRATA_727915 is not set
# CONFIG_PL310_ERRATA_753970 is not set
# CONFIG_PL310_ERRATA_769419 is not set
CONFIG_ARM_L1_CACHE_SHIFT_6=y
CONFIG_ARM_L1_CACHE_SHIFT=6
CONFIG_ARM_DMA_MEM_BUFFERABLE=y
CONFIG_ARM_HEAVY_MB=y
# CONFIG_ARM_KERNMEM_PERMS is not set
CONFIG_MULTI_IRQ_HANDLER=y
# CONFIG_ARM_ERRATA_430973 is not set
CONFIG_ARM_ERRATA_643719=y
# CONFIG_ARM_ERRATA_720789 is not set
# CONFIG_ARM_ERRATA_754322 is not set
# CONFIG_ARM_ERRATA_754327 is not set
# CONFIG_ARM_ERRATA_764369 is not set
# CONFIG_ARM_ERRATA_775420 is not set
# CONFIG_ARM_ERRATA_798181 is not set
# CONFIG_ARM_ERRATA_773022 is not set

#
# Bus support
#
# CONFIG_PCI is not set
# CONFIG_PCI_DOMAINS_GENERIC is not set
# CONFIG_PCI_SYSCALL is not set
# CONFIG_PCCARD is not set

#
# Kernel Features
#
CONFIG_HAVE_SMP=y
CONFIG_SMP=y
CONFIG_SMP_ON_UP=y
CONFIG_ARM_CPU_TOPOLOGY=y
# CONFIG_SCHED_MC is not set
# CONFIG_SCHED_SMT is not set
CONFIG_HAVE_ARM_SCU=y
CONFIG_HAVE_ARM_ARCH_TIMER=y
CONFIG_MCPM=y
CONFIG_BIG_LITTLE=y
CONFIG_BL_SWITCHER=y
CONFIG_BL_SWITCHER_DUMMY_IF=y
CONFIG_VMSPLIT_3G=y
# CONFIG_VMSPLIT_2G is not set
# CONFIG_VMSPLIT_1G is not set
CONFIG_PAGE_OFFSET=0xC0000000
CONFIG_NR_CPUS=8
CONFIG_HOTPLUG_CPU=y
# CONFIG_ARM_PSCI is not set
CONFIG_ARCH_NR_GPIO=512
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=y
CONFIG_PREEMPT_COUNT=y
CONFIG_HZ_FIXED=200
CONFIG_HZ=200
CONFIG_SCHED_HRTICK=y
# CONFIG_THUMB2_KERNEL is not set
CONFIG_AEABI=y
# CONFIG_OABI_COMPAT is not set
CONFIG_ARCH_HAS_HOLES_MEMORYMODEL=y
# CONFIG_ARCH_SPARSEMEM_DEFAULT is not set
# CONFIG_ARCH_SELECT_MEMORY_MODEL is not set
CONFIG_HAVE_ARCH_PFN_VALID=y
CONFIG_HIGHMEM=y
# CONFIG_HIGHPTE is not set
CONFIG_CPU_SW_DOMAIN_PAN=y
CONFIG_ARCH_WANT_GENERAL_HUGETLB=y
# CONFIG_ARM_MODULE_PLTS is not set
CONFIG_FLATMEM=y
CONFIG_FLAT_NODE_MEM_MAP=y
CONFIG_HAVE_MEMBLOCK=y
CONFIG_NO_BOOTMEM=y
CONFIG_MEMORY_ISOLATION=y
# CONFIG_HAVE_BOOTMEM_INFO_NODE is not set
CONFIG_PAGEFLAGS_EXTENDED=y
CONFIG_SPLIT_PTLOCK_CPUS=4
CONFIG_COMPACTION=y
CONFIG_MIGRATION=y
# CONFIG_PHYS_ADDR_T_64BIT is not set
CONFIG_ZONE_DMA_FLAG=0
CONFIG_BOUNCE=y
# CONFIG_KSM is not set
CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
# CONFIG_CLEANCACHE is not set
# CONFIG_FRONTSWAP is not set
CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
# CONFIG_CMA_DEBUGFS is not set
CONFIG_CMA_AREAS=7
# CONFIG_ZPOOL is not set
# CONFIG_ZBUD is not set
# CONFIG_ZSMALLOC is not set
# CONFIG_IDLE_PAGE_TRACKING is not set
CONFIG_FORCE_MAX_ZONEORDER=11
CONFIG_ALIGNMENT_TRAP=y
# CONFIG_UACCESS_WITH_MEMCPY is not set
# CONFIG_SECCOMP is not set
CONFIG_SWIOTLB=y
CONFIG_IOMMU_HELPER=y
# CONFIG_XEN is not set

#
# Boot options
#
CONFIG_USE_OF=y
CONFIG_ATAGS=y
# CONFIG_DEPRECATED_PARAM_STRUCT is not set
CONFIG_ZBOOT_ROM_TEXT=0x0
CONFIG_ZBOOT_ROM_BSS=0x0
CONFIG_ARM_APPENDED_DTB=y
CONFIG_ARM_ATAG_DTB_COMPAT=y
CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_ARM_ATAG_DTB_COMPAT_CMDLINE_EXTEND is not set
CONFIG_CMDLINE="root=/dev/ram0 rw ramdisk=8192 initrd=0x41000000,8M console=ttySAC1,115200 init=/linuxrc mem=256M"
CONFIG_CMDLINE_FROM_BOOTLOADER=y
# CONFIG_CMDLINE_EXTEND is not set
# CONFIG_CMDLINE_FORCE is not set
# CONFIG_KEXEC is not set
# CONFIG_CRASH_DUMP is not set
CONFIG_AUTO_ZRELADDR=y

#
# CPU Power Management
#

#
# CPU Frequency scaling
#
CONFIG_CPU_FREQ=y
CONFIG_CPU_FREQ_GOV_COMMON=y
CONFIG_CPU_FREQ_STAT=y
# CONFIG_CPU_FREQ_STAT_DETAILS is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
# CONFIG_CPU_FREQ_GOV_POWERSAVE is not set
# CONFIG_CPU_FREQ_GOV_USERSPACE is not set
CONFIG_CPU_FREQ_GOV_ONDEMAND=y
# CONFIG_CPU_FREQ_GOV_CONSERVATIVE is not set

#
# CPU frequency scaling drivers
#
CONFIG_CPUFREQ_DT=y
# CONFIG_ARM_BIG_LITTLE_CPUFREQ is not set
CONFIG_ARM_EXYNOS5440_CPUFREQ=y
# CONFIG_ARM_KIRKWOOD_CPUFREQ is not set
# CONFIG_QORIQ_CPUFREQ is not set

#
# CPU Idle
#
CONFIG_CPU_IDLE=y
CONFIG_CPU_IDLE_GOV_LADDER=y
CONFIG_CPU_IDLE_GOV_MENU=y

#
# ARM CPU Idle Drivers
#
# CONFIG_ARM_CPUIDLE is not set
# CONFIG_ARM_BIG_LITTLE_CPUIDLE is not set
CONFIG_ARM_EXYNOS_CPUIDLE=y
CONFIG_ARCH_NEEDS_CPU_IDLE_COUPLED=y

#
# Floating point emulation
#

#
# At least one emulation must be selected
#
CONFIG_VFP=y
CONFIG_VFPv3=y
CONFIG_NEON=y
# CONFIG_KERNEL_MODE_NEON is not set

#
# Userspace binary formats
#
CONFIG_BINFMT_ELF=y
CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
CONFIG_BINFMT_SCRIPT=y
# CONFIG_HAVE_AOUT is not set
# CONFIG_BINFMT_MISC is not set
CONFIG_COREDUMP=y

#
# Power management options
#
CONFIG_SUSPEND=y
CONFIG_SUSPEND_FREEZER=y
# CONFIG_HIBERNATION is not set
CONFIG_PM_SLEEP=y
CONFIG_PM_SLEEP_SMP=y
# CONFIG_PM_AUTOSLEEP is not set
# CONFIG_PM_WAKELOCKS is not set
CONFIG_PM=y
CONFIG_PM_DEBUG=y
CONFIG_PM_ADVANCED_DEBUG=y
# CONFIG_PM_TEST_SUSPEND is not set
CONFIG_PM_SLEEP_DEBUG=y
# CONFIG_APM_EMULATION is not set
CONFIG_PM_OPP=y
CONFIG_PM_CLK=y
CONFIG_PM_GENERIC_DOMAINS=y
# CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
CONFIG_PM_GENERIC_DOMAINS_SLEEP=y
CONFIG_PM_GENERIC_DOMAINS_OF=y
CONFIG_CPU_PM=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_ARM_CPU_SUSPEND=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_NET=y

#
# Networking options
#
CONFIG_PACKET=y
# CONFIG_PACKET_DIAG is not set
CONFIG_UNIX=y
# CONFIG_UNIX_DIAG is not set
CONFIG_XFRM=y
CONFIG_XFRM_ALGO=y
# CONFIG_XFRM_USER is not set
# CONFIG_XFRM_SUB_POLICY is not set
# CONFIG_XFRM_MIGRATE is not set
# CONFIG_XFRM_STATISTICS is not set
CONFIG_NET_KEY=y
# CONFIG_NET_KEY_MIGRATE is not set
CONFIG_INET=y
# CONFIG_IP_MULTICAST is not set
# CONFIG_IP_ADVANCED_ROUTER is not set
CONFIG_IP_PNP=y
CONFIG_IP_PNP_DHCP=y
CONFIG_IP_PNP_BOOTP=y
CONFIG_IP_PNP_RARP=y
# CONFIG_NET_IPIP is not set
# CONFIG_NET_IPGRE_DEMUX is not set
CONFIG_NET_IP_TUNNEL=y
# CONFIG_SYN_COOKIES is not set
# CONFIG_NET_IPVTI is not set
# CONFIG_NET_UDP_TUNNEL is not set
# CONFIG_NET_FOU is not set
# CONFIG_NET_FOU_IP_TUNNELS is not set
# CONFIG_INET_AH is not set
# CONFIG_INET_ESP is not set
# CONFIG_INET_IPCOMP is not set
# CONFIG_INET_XFRM_TUNNEL is not set
CONFIG_INET_TUNNEL=y
CONFIG_INET_XFRM_MODE_TRANSPORT=y
CONFIG_INET_XFRM_MODE_TUNNEL=y
CONFIG_INET_XFRM_MODE_BEET=y
CONFIG_INET_LRO=y
CONFIG_INET_DIAG=y
CONFIG_INET_TCP_DIAG=y
# CONFIG_INET_UDP_DIAG is not set
# CONFIG_TCP_CONG_ADVANCED is not set
CONFIG_TCP_CONG_CUBIC=y
CONFIG_DEFAULT_TCP_CONG="cubic"
# CONFIG_TCP_MD5SIG is not set
CONFIG_IPV6=y
# CONFIG_IPV6_ROUTER_PREF is not set
# CONFIG_IPV6_OPTIMISTIC_DAD is not set
# CONFIG_INET6_AH is not set
# CONFIG_INET6_ESP is not set
# CONFIG_INET6_IPCOMP is not set
# CONFIG_IPV6_MIP6 is not set
# CONFIG_IPV6_ILA is not set
# CONFIG_INET6_XFRM_TUNNEL is not set
# CONFIG_INET6_TUNNEL is not set
CONFIG_INET6_XFRM_MODE_TRANSPORT=y
CONFIG_INET6_XFRM_MODE_TUNNEL=y
CONFIG_INET6_XFRM_MODE_BEET=y
# CONFIG_INET6_XFRM_MODE_ROUTEOPTIMIZATION is not set
# CONFIG_IPV6_VTI is not set
CONFIG_IPV6_SIT=y
# CONFIG_IPV6_SIT_6RD is not set
CONFIG_IPV6_NDISC_NODETYPE=y
# CONFIG_IPV6_TUNNEL is not set
# CONFIG_IPV6_GRE is not set
# CONFIG_IPV6_MULTIPLE_TABLES is not set
# CONFIG_IPV6_MROUTE is not set
# CONFIG_NETWORK_SECMARK is not set
# CONFIG_NET_PTP_CLASSIFY is not set
# CONFIG_NETWORK_PHY_TIMESTAMPING is not set
# CONFIG_NETFILTER is not set
# CONFIG_IP_DCCP is not set
# CONFIG_IP_SCTP is not set
# CONFIG_RDS is not set
# CONFIG_TIPC is not set
# CONFIG_ATM is not set
# CONFIG_L2TP is not set
# CONFIG_BRIDGE is not set
CONFIG_HAVE_NET_DSA=y
# CONFIG_VLAN_8021Q is not set
# CONFIG_DECNET is not set
# CONFIG_LLC2 is not set
# CONFIG_IPX is not set
# CONFIG_ATALK is not set
# CONFIG_X25 is not set
# CONFIG_LAPB is not set
# CONFIG_PHONET is not set
# CONFIG_6LOWPAN is not set
# CONFIG_IEEE802154 is not set
# CONFIG_NET_SCHED is not set
# CONFIG_DCB is not set
# CONFIG_BATMAN_ADV is not set
# CONFIG_OPENVSWITCH is not set
# CONFIG_VSOCKETS is not set
# CONFIG_NETLINK_MMAP is not set
# CONFIG_NETLINK_DIAG is not set
# CONFIG_MPLS is not set
# CONFIG_HSR is not set
# CONFIG_NET_SWITCHDEV is not set
CONFIG_RPS=y
CONFIG_RFS_ACCEL=y
CONFIG_XPS=y
# CONFIG_CGROUP_NET_PRIO is not set
# CONFIG_CGROUP_NET_CLASSID is not set
CONFIG_NET_RX_BUSY_POLL=y
CONFIG_BQL=y
# CONFIG_BPF_JIT is not set
CONFIG_NET_FLOW_LIMIT=y

#
# Network testing
#
# CONFIG_NET_PKTGEN is not set
# CONFIG_HAMRADIO is not set
# CONFIG_CAN is not set
# CONFIG_IRDA is not set
# CONFIG_BT is not set
# CONFIG_AF_RXRPC is not set
CONFIG_WIRELESS=y
CONFIG_CFG80211=y
# CONFIG_NL80211_TESTMODE is not set
# CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
# CONFIG_CFG80211_REG_DEBUG is not set
CONFIG_CFG80211_DEFAULT_PS=y
# CONFIG_CFG80211_DEBUGFS is not set
# CONFIG_CFG80211_INTERNAL_REGDB is not set
# CONFIG_CFG80211_WEXT is not set
# CONFIG_LIB80211 is not set
# CONFIG_MAC80211 is not set
CONFIG_MAC80211_STA_HASH_MAX_SIZE=0
# CONFIG_WIMAX is not set
# CONFIG_RFKILL is not set
CONFIG_RFKILL_REGULATOR=y
# CONFIG_NET_9P is not set
# CONFIG_CAIF is not set
# CONFIG_CEPH_LIB is not set
# CONFIG_NFC is not set
# CONFIG_LWTUNNEL is not set
CONFIG_HAVE_BPF_JIT=y

#
# Device Drivers
#
CONFIG_ARM_AMBA=y
# CONFIG_TEGRA_AHB is not set

#
# Generic Driver Options
#
CONFIG_UEVENT_HELPER=y
CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
CONFIG_DEVTMPFS=y
CONFIG_DEVTMPFS_MOUNT=y
CONFIG_STANDALONE=y
CONFIG_PREVENT_FIRMWARE_BUILD=y
CONFIG_FW_LOADER=y
CONFIG_FIRMWARE_IN_KERNEL=y
CONFIG_EXTRA_FIRMWARE=""
# CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
CONFIG_WANT_DEV_COREDUMP=y
CONFIG_ALLOW_DEV_COREDUMP=y
CONFIG_DEV_COREDUMP=y
# CONFIG_DEBUG_DRIVER is not set
# CONFIG_DEBUG_DEVRES is not set
# CONFIG_SYS_HYPERVISOR is not set
# CONFIG_GENERIC_CPU_DEVICES is not set
CONFIG_REGMAP=y
CONFIG_REGMAP_I2C=y
CONFIG_REGMAP_SPI=y
CONFIG_REGMAP_MMIO=y
CONFIG_REGMAP_IRQ=y
CONFIG_DMA_SHARED_BUFFER=y
# CONFIG_FENCE_TRACE is not set
CONFIG_DMA_CMA=y

#
# Default contiguous memory area size:
#
CONFIG_CMA_SIZE_MBYTES=64
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8

#
# Bus devices
#
CONFIG_ARM_CCI=y
CONFIG_ARM_CCI400_COMMON=y
CONFIG_ARM_CCI400_PORT_CTRL=y
# CONFIG_BRCMSTB_GISB_ARB is not set
# CONFIG_VEXPRESS_CONFIG is not set
# CONFIG_CONNECTOR is not set
# CONFIG_MTD is not set
CONFIG_DTC=y
CONFIG_OF=y
# CONFIG_OF_UNITTEST is not set
CONFIG_OF_FLATTREE=y
CONFIG_OF_EARLY_FLATTREE=y
CONFIG_OF_ADDRESS=y
CONFIG_OF_IRQ=y
CONFIG_OF_NET=y
CONFIG_OF_MDIO=y
CONFIG_OF_RESERVED_MEM=y
# CONFIG_OF_OVERLAY is not set
CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=y
# CONFIG_PARPORT is not set
CONFIG_BLK_DEV=y
# CONFIG_BLK_DEV_NULL_BLK is not set
# CONFIG_BLK_DEV_COW_COMMON is not set
CONFIG_BLK_DEV_LOOP=y
CONFIG_BLK_DEV_LOOP_MIN_COUNT=8
CONFIG_BLK_DEV_CRYPTOLOOP=y
# CONFIG_BLK_DEV_DRBD is not set
# CONFIG_BLK_DEV_NBD is not set
CONFIG_BLK_DEV_RAM=y
CONFIG_BLK_DEV_RAM_COUNT=16
CONFIG_BLK_DEV_RAM_SIZE=8192
# CONFIG_CDROM_PKTCDVD is not set
# CONFIG_ATA_OVER_ETH is not set
# CONFIG_MG_DISK is not set
# CONFIG_BLK_DEV_RBD is not set

#
# Misc devices
#
# CONFIG_SENSORS_LIS3LV02D is not set
# CONFIG_AD525X_DPOT is not set
# CONFIG_DUMMY_IRQ is not set
# CONFIG_ICS932S401 is not set
# CONFIG_ENCLOSURE_SERVICES is not set
# CONFIG_APDS9802ALS is not set
# CONFIG_ISL29003 is not set
# CONFIG_ISL29020 is not set
# CONFIG_SENSORS_TSL2550 is not set
# CONFIG_SENSORS_BH1780 is not set
# CONFIG_SENSORS_BH1770 is not set
# CONFIG_SENSORS_APDS990X is not set
# CONFIG_HMC6352 is not set
# CONFIG_DS1682 is not set
# CONFIG_TI_DAC7512 is not set
# CONFIG_BMP085_I2C is not set
# CONFIG_BMP085_SPI is not set
# CONFIG_USB_SWITCH_FSA9480 is not set
# CONFIG_LATTICE_ECP3_CONFIG is not set
CONFIG_SRAM=y
# CONFIG_C2PORT is not set

#
# EEPROM support
#
# CONFIG_EEPROM_AT24 is not set
# CONFIG_EEPROM_AT25 is not set
# CONFIG_EEPROM_LEGACY is not set
# CONFIG_EEPROM_MAX6875 is not set
# CONFIG_EEPROM_93CX6 is not set
# CONFIG_EEPROM_93XX46 is not set

#
# Texas Instruments shared transport line discipline
#
# CONFIG_TI_ST is not set
# CONFIG_SENSORS_LIS3_SPI is not set
# CONFIG_SENSORS_LIS3_I2C is not set

#
# Altera FPGA firmware download module
#
# CONFIG_ALTERA_STAPL is not set

#
# Intel MIC Bus Driver
#

#
# SCIF Bus Driver
#

#
# Intel MIC Host Driver
#

#
# Intel MIC Card Driver
#

#
# SCIF Driver
#
# CONFIG_ECHO is not set
# CONFIG_CXL_BASE is not set
# CONFIG_CXL_KERNEL_API is not set
# CONFIG_CXL_EEH is not set

#
# SCSI device support
#
CONFIG_SCSI_MOD=y
# CONFIG_RAID_ATTRS is not set
CONFIG_SCSI=y
CONFIG_SCSI_DMA=y
# CONFIG_SCSI_NETLINK is not set
# CONFIG_SCSI_MQ_DEFAULT is not set
CONFIG_SCSI_PROC_FS=y

#
# SCSI support type (disk, tape, CD-ROM)
#
CONFIG_BLK_DEV_SD=y
# CONFIG_CHR_DEV_ST is not set
# CONFIG_CHR_DEV_OSST is not set
# CONFIG_BLK_DEV_SR is not set
CONFIG_CHR_DEV_SG=y
# CONFIG_CHR_DEV_SCH is not set
# CONFIG_SCSI_CONSTANTS is not set
# CONFIG_SCSI_LOGGING is not set
# CONFIG_SCSI_SCAN_ASYNC is not set

#
# SCSI Transports
#
# CONFIG_SCSI_SPI_ATTRS is not set
# CONFIG_SCSI_FC_ATTRS is not set
# CONFIG_SCSI_ISCSI_ATTRS is not set
# CONFIG_SCSI_SAS_ATTRS is not set
# CONFIG_SCSI_SAS_LIBSAS is not set
# CONFIG_SCSI_SRP_ATTRS is not set
CONFIG_SCSI_LOWLEVEL=y
# CONFIG_ISCSI_TCP is not set
# CONFIG_ISCSI_BOOT_SYSFS is not set
# CONFIG_SCSI_UFSHCD is not set
# CONFIG_SCSI_DEBUG is not set
# CONFIG_SCSI_DH is not set
# CONFIG_SCSI_OSD_INITIATOR is not set
# CONFIG_ATA is not set
CONFIG_MD=y
# CONFIG_BLK_DEV_MD is not set
# CONFIG_BCACHE is not set
CONFIG_BLK_DEV_DM_BUILTIN=y
CONFIG_BLK_DEV_DM=y
# CONFIG_DM_MQ_DEFAULT is not set
# CONFIG_DM_DEBUG is not set
CONFIG_DM_CRYPT=m
# CONFIG_DM_SNAPSHOT is not set
# CONFIG_DM_THIN_PROVISIONING is not set
# CONFIG_DM_CACHE is not set
# CONFIG_DM_ERA is not set
# CONFIG_DM_MIRROR is not set
# CONFIG_DM_RAID is not set
# CONFIG_DM_ZERO is not set
# CONFIG_DM_MULTIPATH is not set
# CONFIG_DM_DELAY is not set
# CONFIG_DM_UEVENT is not set
# CONFIG_DM_FLAKEY is not set
# CONFIG_DM_VERITY is not set
# CONFIG_DM_SWITCH is not set
# CONFIG_DM_LOG_WRITES is not set
# CONFIG_TARGET_CORE is not set
CONFIG_NETDEVICES=y
CONFIG_MII=y
CONFIG_NET_CORE=y
# CONFIG_BONDING is not set
# CONFIG_DUMMY is not set
# CONFIG_EQUALIZER is not set
# CONFIG_NET_TEAM is not set
# CONFIG_MACVLAN is not set
# CONFIG_IPVLAN is not set
# CONFIG_VXLAN is not set
# CONFIG_NETCONSOLE is not set
# CONFIG_NETPOLL is not set
# CONFIG_NET_POLL_CONTROLLER is not set
# CONFIG_TUN is not set
# CONFIG_TUN_VNET_CROSS_LE is not set
# CONFIG_VETH is not set
# CONFIG_NLMON is not set

#
# CAIF transport drivers
#

#
# Distributed Switch Architecture drivers
#
# CONFIG_NET_DSA_MV88E6XXX is not set
# CONFIG_NET_DSA_MV88E6XXX_NEED_PPU is not set
CONFIG_ETHERNET=y
# CONFIG_ALTERA_TSE is not set
CONFIG_NET_VENDOR_ARC=y
# CONFIG_ARC_EMAC is not set
# CONFIG_EMAC_ROCKCHIP is not set
CONFIG_NET_CADENCE=y
# CONFIG_MACB is not set
CONFIG_NET_VENDOR_BROADCOM=y
# CONFIG_B44 is not set
# CONFIG_BCMGENET is not set
# CONFIG_SYSTEMPORT is not set
CONFIG_NET_VENDOR_CIRRUS=y
# CONFIG_CS89x0 is not set
# CONFIG_DM9000 is not set
# CONFIG_DNET is not set
CONFIG_NET_VENDOR_EZCHIP=y
# CONFIG_EZCHIP_NPS_MANAGEMENT_ENET is not set
CONFIG_NET_VENDOR_FARADAY=y
# CONFIG_FTMAC100 is not set
# CONFIG_FTGMAC100 is not set
CONFIG_NET_VENDOR_HISILICON=y
# CONFIG_HIX5HD2_GMAC is not set
# CONFIG_HIP04_ETH is not set
CONFIG_NET_VENDOR_INTEL=y
CONFIG_NET_VENDOR_I825XX=y
CONFIG_NET_VENDOR_MARVELL=y
# CONFIG_MVMDIO is not set
CONFIG_NET_VENDOR_MICREL=y
# CONFIG_KS8842 is not set
# CONFIG_KS8851 is not set
# CONFIG_KS8851_MLL is not set
CONFIG_NET_VENDOR_MICROCHIP=y
# CONFIG_ENC28J60 is not set
CONFIG_NET_VENDOR_NATSEMI=y
CONFIG_NET_VENDOR_8390=y
# CONFIG_AX88796 is not set
# CONFIG_ETHOC is not set
CONFIG_NET_VENDOR_QUALCOMM=y
# CONFIG_QCA7000 is not set
CONFIG_NET_VENDOR_RENESAS=y
CONFIG_NET_VENDOR_ROCKER=y
CONFIG_NET_VENDOR_SAMSUNG=y
# CONFIG_SXGBE_ETH is not set
CONFIG_NET_VENDOR_SEEQ=y
CONFIG_NET_VENDOR_SMSC=y
# CONFIG_SMC91X is not set
# CONFIG_SMC911X is not set
CONFIG_SMSC911X=y
# CONFIG_SMSC911X_ARCH_HOOKS is not set
CONFIG_NET_VENDOR_STMICRO=y
# CONFIG_STMMAC_ETH is not set
CONFIG_NET_VENDOR_SYNOPSYS=y
# CONFIG_SYNOPSYS_DWC_ETH_QOS is not set
CONFIG_NET_VENDOR_VIA=y
# CONFIG_VIA_RHINE is not set
# CONFIG_VIA_VELOCITY is not set
CONFIG_NET_VENDOR_WIZNET=y
# CONFIG_WIZNET_W5100 is not set
# CONFIG_WIZNET_W5300 is not set
CONFIG_PHYLIB=y

#
# MII PHY device drivers
#
# CONFIG_AQUANTIA_PHY is not set
# CONFIG_AT803X_PHY is not set
# CONFIG_AMD_PHY is not set
# CONFIG_MARVELL_PHY is not set
# CONFIG_DAVICOM_PHY is not set
# CONFIG_QSEMI_PHY is not set
# CONFIG_LXT_PHY is not set
# CONFIG_CICADA_PHY is not set
# CONFIG_VITESSE_PHY is not set
# CONFIG_TERANETICS_PHY is not set
# CONFIG_SMSC_PHY is not set
# CONFIG_BROADCOM_PHY is not set
# CONFIG_BCM7XXX_PHY is not set
# CONFIG_BCM87XX_PHY is not set
# CONFIG_ICPLUS_PHY is not set
# CONFIG_REALTEK_PHY is not set
# CONFIG_NATIONAL_PHY is not set
# CONFIG_STE10XP is not set
# CONFIG_LSI_ET1011C_PHY is not set
# CONFIG_MICREL_PHY is not set
# CONFIG_DP83867_PHY is not set
# CONFIG_FIXED_PHY is not set
# CONFIG_MDIO_BITBANG is not set
# CONFIG_MDIO_BUS_MUX_GPIO is not set
# CONFIG_MDIO_BUS_MUX_MMIOREG is not set
# CONFIG_MDIO_BCM_UNIMAC is not set
# CONFIG_MICREL_KS8995MA is not set
# CONFIG_PPP is not set
# CONFIG_SLIP is not set
CONFIG_USB_NET_DRIVERS=y
# CONFIG_USB_CATC is not set
# CONFIG_USB_KAWETH is not set
# CONFIG_USB_PEGASUS is not set
# CONFIG_USB_RTL8150 is not set
# CONFIG_USB_RTL8152 is not set
# CONFIG_USB_LAN78XX is not set
CONFIG_USB_USBNET=y
CONFIG_USB_NET_AX8817X=y
CONFIG_USB_NET_AX88179_178A=y
CONFIG_USB_NET_CDCETHER=y
# CONFIG_USB_NET_CDC_EEM is not set
CONFIG_USB_NET_CDC_NCM=y
# CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
# CONFIG_USB_NET_CDC_MBIM is not set
# CONFIG_USB_NET_DM9601 is not set
# CONFIG_USB_NET_SR9700 is not set
# CONFIG_USB_NET_SR9800 is not set
CONFIG_USB_NET_SMSC75XX=y
CONFIG_USB_NET_SMSC95XX=y
# CONFIG_USB_NET_GL620A is not set
CONFIG_USB_NET_NET1080=y
# CONFIG_USB_NET_PLUSB is not set
# CONFIG_USB_NET_MCS7830 is not set
# CONFIG_USB_NET_RNDIS_HOST is not set
CONFIG_USB_NET_CDC_SUBSET=y
# CONFIG_USB_ALI_M5632 is not set
# CONFIG_USB_AN2720 is not set
CONFIG_USB_BELKIN=y
CONFIG_USB_ARMLINUX=y
# CONFIG_USB_EPSON2888 is not set
# CONFIG_USB_KC2190 is not set
CONFIG_USB_NET_ZAURUS=y
# CONFIG_USB_NET_CX82310_ETH is not set
# CONFIG_USB_NET_KALMIA is not set
# CONFIG_USB_NET_QMI_WWAN is not set
# CONFIG_USB_NET_INT51X1 is not set
# CONFIG_USB_IPHETH is not set
# CONFIG_USB_SIERRA_NET is not set
# CONFIG_USB_VL600 is not set
CONFIG_WLAN=y
# CONFIG_USB_ZD1201 is not set
# CONFIG_USB_NET_RNDIS_WLAN is not set
# CONFIG_ATH_CARDS is not set
# CONFIG_BRCMFMAC is not set
# CONFIG_HOSTAP is not set
# CONFIG_LIBERTAS is not set
# CONFIG_WL_MEDIATEK is not set
# CONFIG_WL_TI is not set
CONFIG_MWIFIEX=y
CONFIG_MWIFIEX_SDIO=y
# CONFIG_MWIFIEX_USB is not set

#
# Enable WiMAX (Networking options) to see the WiMAX drivers
#
# CONFIG_WAN is not set
# CONFIG_ISDN is not set

#
# Input device support
#
CONFIG_INPUT=y
CONFIG_INPUT_LEDS=y
# CONFIG_INPUT_FF_MEMLESS is not set
# CONFIG_INPUT_POLLDEV is not set
# CONFIG_INPUT_SPARSEKMAP is not set
CONFIG_INPUT_MATRIXKMAP=y

#
# Userland interfaces
#
CONFIG_INPUT_MOUSEDEV=y
CONFIG_INPUT_MOUSEDEV_PSAUX=y
CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
# CONFIG_INPUT_JOYDEV is not set
CONFIG_INPUT_EVDEV=y
# CONFIG_INPUT_EVBUG is not set

#
# Input Device Drivers
#
CONFIG_INPUT_KEYBOARD=y
# CONFIG_KEYBOARD_ADP5588 is not set
# CONFIG_KEYBOARD_ADP5589 is not set
CONFIG_KEYBOARD_ATKBD=y
# CONFIG_KEYBOARD_QT1070 is not set
# CONFIG_KEYBOARD_QT2160 is not set
# CONFIG_KEYBOARD_LKKBD is not set
CONFIG_KEYBOARD_GPIO=y
# CONFIG_KEYBOARD_GPIO_POLLED is not set
# CONFIG_KEYBOARD_TCA6416 is not set
# CONFIG_KEYBOARD_TCA8418 is not set
# CONFIG_KEYBOARD_MATRIX is not set
# CONFIG_KEYBOARD_LM8323 is not set
# CONFIG_KEYBOARD_LM8333 is not set
# CONFIG_KEYBOARD_MAX7359 is not set
# CONFIG_KEYBOARD_MCS is not set
# CONFIG_KEYBOARD_MPR121 is not set
# CONFIG_KEYBOARD_NEWTON is not set
# CONFIG_KEYBOARD_OPENCORES is not set
CONFIG_KEYBOARD_SAMSUNG=y
# CONFIG_KEYBOARD_STOWAWAY is not set
# CONFIG_KEYBOARD_SUNKBD is not set
# CONFIG_KEYBOARD_OMAP4 is not set
# CONFIG_KEYBOARD_XTKBD is not set
CONFIG_KEYBOARD_CROS_EC=y
# CONFIG_KEYBOARD_CAP11XX is not set
# CONFIG_KEYBOARD_BCM is not set
CONFIG_INPUT_MOUSE=y
# CONFIG_MOUSE_PS2 is not set
# CONFIG_MOUSE_SERIAL is not set
# CONFIG_MOUSE_APPLETOUCH is not set
# CONFIG_MOUSE_BCM5974 is not set
CONFIG_MOUSE_CYAPA=y
# CONFIG_MOUSE_ELAN_I2C is not set
# CONFIG_MOUSE_VSXXXAA is not set
# CONFIG_MOUSE_GPIO is not set
# CONFIG_MOUSE_SYNAPTICS_I2C is not set
# CONFIG_MOUSE_SYNAPTICS_USB is not set
# CONFIG_INPUT_JOYSTICK is not set
# CONFIG_INPUT_TABLET is not set
CONFIG_INPUT_TOUCHSCREEN=y
CONFIG_TOUCHSCREEN_PROPERTIES=y
# CONFIG_TOUCHSCREEN_ADS7846 is not set
# CONFIG_TOUCHSCREEN_AD7877 is not set
# CONFIG_TOUCHSCREEN_AD7879 is not set
# CONFIG_TOUCHSCREEN_AR1021_I2C is not set
CONFIG_TOUCHSCREEN_ATMEL_MXT=y
# CONFIG_TOUCHSCREEN_AUO_PIXCIR is not set
# CONFIG_TOUCHSCREEN_BU21013 is not set
# CONFIG_TOUCHSCREEN_CHIPONE_ICN8318 is not set
# CONFIG_TOUCHSCREEN_CY8CTMG110 is not set
# CONFIG_TOUCHSCREEN_CYTTSP_CORE is not set
# CONFIG_TOUCHSCREEN_CYTTSP4_CORE is not set
# CONFIG_TOUCHSCREEN_DYNAPRO is not set
# CONFIG_TOUCHSCREEN_HAMPSHIRE is not set
# CONFIG_TOUCHSCREEN_EETI is not set
# CONFIG_TOUCHSCREEN_EGALAX is not set
# CONFIG_TOUCHSCREEN_FUJITSU is not set
# CONFIG_TOUCHSCREEN_GOODIX is not set
# CONFIG_TOUCHSCREEN_ILI210X is not set
# CONFIG_TOUCHSCREEN_GUNZE is not set
# CONFIG_TOUCHSCREEN_ELAN is not set
# CONFIG_TOUCHSCREEN_ELO is not set
# CONFIG_TOUCHSCREEN_WACOM_W8001 is not set
# CONFIG_TOUCHSCREEN_WACOM_I2C is not set
# CONFIG_TOUCHSCREEN_MAX11801 is not set
# CONFIG_TOUCHSCREEN_MCS5000 is not set
# CONFIG_TOUCHSCREEN_MMS114 is not set
# CONFIG_TOUCHSCREEN_MTOUCH is not set
# CONFIG_TOUCHSCREEN_IMX6UL_TSC is not set
# CONFIG_TOUCHSCREEN_INEXIO is not set
# CONFIG_TOUCHSCREEN_MK712 is not set
# CONFIG_TOUCHSCREEN_PENMOUNT is not set
# CONFIG_TOUCHSCREEN_EDT_FT5X06 is not set
# CONFIG_TOUCHSCREEN_TOUCHRIGHT is not set
# CONFIG_TOUCHSCREEN_TOUCHWIN is not set
# CONFIG_TOUCHSCREEN_PIXCIR is not set
# CONFIG_TOUCHSCREEN_WDT87XX_I2C is not set
# CONFIG_TOUCHSCREEN_USB_COMPOSITE is not set
# CONFIG_TOUCHSCREEN_TOUCHIT213 is not set
# CONFIG_TOUCHSCREEN_TSC_SERIO is not set
# CONFIG_TOUCHSCREEN_TSC2005 is not set
# CONFIG_TOUCHSCREEN_TSC2007 is not set
# CONFIG_TOUCHSCREEN_ST1232 is not set
# CONFIG_TOUCHSCREEN_SX8654 is not set
# CONFIG_TOUCHSCREEN_TPS6507X is not set
# CONFIG_TOUCHSCREEN_ZFORCE is not set
CONFIG_INPUT_MISC=y
# CONFIG_INPUT_AD714X is not set
# CONFIG_INPUT_BMA150 is not set
# CONFIG_INPUT_E3X0_BUTTON is not set
# CONFIG_INPUT_MAX77693_HAPTIC is not set
# CONFIG_INPUT_MAX8997_HAPTIC is not set
# CONFIG_INPUT_MMA8450 is not set
# CONFIG_INPUT_MPU3050 is not set
# CONFIG_INPUT_GP2A is not set
# CONFIG_INPUT_GPIO_BEEPER is not set
# CONFIG_INPUT_GPIO_TILT_POLLED is not set
# CONFIG_INPUT_ATI_REMOTE2 is not set
# CONFIG_INPUT_KEYSPAN_REMOTE is not set
# CONFIG_INPUT_KXTJ9 is not set
# CONFIG_INPUT_POWERMATE is not set
# CONFIG_INPUT_YEALINK is not set
# CONFIG_INPUT_CM109 is not set
# CONFIG_INPUT_REGULATOR_HAPTIC is not set
# CONFIG_INPUT_UINPUT is not set
# CONFIG_INPUT_PCF8574 is not set
# CONFIG_INPUT_PWM_BEEPER is not set
# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
# CONFIG_INPUT_ADXL34X is not set
# CONFIG_INPUT_IMS_PCU is not set
# CONFIG_INPUT_CMA3000 is not set
# CONFIG_INPUT_SOC_BUTTON_ARRAY is not set
# CONFIG_INPUT_DRV260X_HAPTICS is not set
# CONFIG_INPUT_DRV2665_HAPTICS is not set
# CONFIG_INPUT_DRV2667_HAPTICS is not set

#
# Hardware I/O ports
#
CONFIG_SERIO=y
CONFIG_SERIO_SERPORT=y
# CONFIG_SERIO_AMBAKMI is not set
CONFIG_SERIO_LIBPS2=y
# CONFIG_SERIO_RAW is not set
# CONFIG_SERIO_ALTERA_PS2 is not set
# CONFIG_SERIO_PS2MULT is not set
# CONFIG_SERIO_ARC_PS2 is not set
# CONFIG_SERIO_APBPS2 is not set
# CONFIG_GAMEPORT is not set

#
# Character devices
#
CONFIG_TTY=y
CONFIG_VT=y
CONFIG_CONSOLE_TRANSLATIONS=y
CONFIG_VT_CONSOLE=y
CONFIG_VT_CONSOLE_SLEEP=y
CONFIG_HW_CONSOLE=y
CONFIG_VT_HW_CONSOLE_BINDING=y
CONFIG_UNIX98_PTYS=y
# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
CONFIG_LEGACY_PTYS=y
CONFIG_LEGACY_PTY_COUNT=256
# CONFIG_SERIAL_NONSTANDARD is not set
# CONFIG_N_GSM is not set
# CONFIG_TRACE_SINK is not set
CONFIG_DEVMEM=y
CONFIG_DEVKMEM=y

#
# Serial drivers
#
CONFIG_SERIAL_EARLYCON=y
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_DEPRECATED_OPTIONS=y
# CONFIG_SERIAL_8250_CONSOLE is not set
CONFIG_SERIAL_8250_DMA=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_RUNTIME_UARTS=4
# CONFIG_SERIAL_8250_EXTENDED is not set
# CONFIG_SERIAL_8250_DW is not set
# CONFIG_SERIAL_8250_EM is not set

#
# Non-8250 serial port support
#
# CONFIG_SERIAL_AMBA_PL010 is not set
# CONFIG_SERIAL_AMBA_PL011 is not set
# CONFIG_SERIAL_EARLYCON_ARM_SEMIHOST is not set
CONFIG_SERIAL_SAMSUNG=y
CONFIG_SERIAL_SAMSUNG_UARTS_4=y
CONFIG_SERIAL_SAMSUNG_UARTS=4
CONFIG_SERIAL_SAMSUNG_CONSOLE=y
# CONFIG_SERIAL_MAX3100 is not set
# CONFIG_SERIAL_MAX310X is not set
# CONFIG_SERIAL_UARTLITE is not set
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_OF_PLATFORM=y
# CONFIG_SERIAL_SCCNXP is not set
# CONFIG_SERIAL_SC16IS7XX is not set
# CONFIG_SERIAL_BCM63XX is not set
# CONFIG_SERIAL_ALTERA_JTAGUART is not set
# CONFIG_SERIAL_ALTERA_UART is not set
# CONFIG_SERIAL_IFX6X60 is not set
# CONFIG_SERIAL_XILINX_PS_UART is not set
# CONFIG_SERIAL_ARC is not set
# CONFIG_SERIAL_FSL_LPUART is not set
# CONFIG_SERIAL_CONEXANT_DIGICOLOR is not set
# CONFIG_SERIAL_ST_ASC is not set
# CONFIG_SERIAL_STM32 is not set
# CONFIG_HVC_DCC is not set
# CONFIG_IPMI_HANDLER is not set
CONFIG_HW_RANDOM=y
# CONFIG_HW_RANDOM_TIMERIOMEM is not set
CONFIG_HW_RANDOM_EXYNOS=y
CONFIG_HW_RANDOM_TPM=y
# CONFIG_R3964 is not set
# CONFIG_RAW_DRIVER is not set
CONFIG_TCG_TPM=y
# CONFIG_TCG_TIS_I2C_ATMEL is not set
CONFIG_TCG_TIS_I2C_INFINEON=y
# CONFIG_TCG_TIS_I2C_NUVOTON is not set
# CONFIG_TCG_TIS_ST33ZP24 is not set
# CONFIG_XILLYBUS is not set

#
# I2C support
#
CONFIG_I2C=y
CONFIG_I2C_BOARDINFO=y
CONFIG_I2C_COMPAT=y
CONFIG_I2C_CHARDEV=y
CONFIG_I2C_MUX=y

#
# Multiplexer I2C Chip support
#
CONFIG_I2C_ARB_GPIO_CHALLENGE=y
# CONFIG_I2C_MUX_GPIO is not set
# CONFIG_I2C_MUX_PCA9541 is not set
# CONFIG_I2C_MUX_PCA954x is not set
# CONFIG_I2C_MUX_PINCTRL is not set
# CONFIG_I2C_MUX_REG is not set
CONFIG_I2C_HELPER_AUTO=y
CONFIG_I2C_ALGOBIT=y

#
# I2C Hardware Bus support
#

#
# I2C system bus drivers (mostly embedded / system-on-chip)
#
# CONFIG_I2C_CBUS_GPIO is not set
# CONFIG_I2C_DESIGNWARE_PLATFORM is not set
# CONFIG_I2C_EMEV2 is not set
CONFIG_I2C_EXYNOS5=y
CONFIG_I2C_GPIO=y
# CONFIG_I2C_NOMADIK is not set
# CONFIG_I2C_OCORES is not set
# CONFIG_I2C_PCA_PLATFORM is not set
# CONFIG_I2C_PXA_PCI is not set
# CONFIG_I2C_RK3X is not set
CONFIG_HAVE_S3C2410_I2C=y
CONFIG_I2C_S3C2410=y
# CONFIG_I2C_SIMTEC is not set
# CONFIG_I2C_XILINX is not set

#
# External I2C/SMBus adapter drivers
#
# CONFIG_I2C_DIOLAN_U2C is not set
# CONFIG_I2C_PARPORT_LIGHT is not set
# CONFIG_I2C_ROBOTFUZZ_OSIF is not set
# CONFIG_I2C_TAOS_EVM is not set
# CONFIG_I2C_TINY_USB is not set

#
# Other I2C/SMBus bus drivers
#
CONFIG_I2C_CROS_EC_TUNNEL=y
# CONFIG_I2C_STUB is not set
# CONFIG_I2C_SLAVE is not set
# CONFIG_I2C_DEBUG_CORE is not set
# CONFIG_I2C_DEBUG_ALGO is not set
# CONFIG_I2C_DEBUG_BUS is not set
CONFIG_SPI=y
# CONFIG_SPI_DEBUG is not set
CONFIG_SPI_MASTER=y

#
# SPI Master Controller Drivers
#
# CONFIG_SPI_ALTERA is not set
# CONFIG_SPI_BITBANG is not set
# CONFIG_SPI_CADENCE is not set
# CONFIG_SPI_GPIO is not set
# CONFIG_SPI_FSL_SPI is not set
# CONFIG_SPI_OC_TINY is not set
# CONFIG_SPI_PL022 is not set
# CONFIG_SPI_PXA2XX_PCI is not set
# CONFIG_SPI_ROCKCHIP is not set
CONFIG_SPI_S3C64XX=y
# CONFIG_SPI_SC18IS602 is not set
# CONFIG_SPI_XCOMM is not set
# CONFIG_SPI_XILINX is not set
# CONFIG_SPI_ZYNQMP_GQSPI is not set
# CONFIG_SPI_DESIGNWARE is not set

#
# SPI Protocol Masters
#
# CONFIG_SPI_SPIDEV is not set
# CONFIG_SPI_TLE62X0 is not set
# CONFIG_SPMI is not set
# CONFIG_HSI is not set

#
# PPS support
#
# CONFIG_PPS is not set

#
# PPS generators support
#

#
# PTP clock support
#
# CONFIG_PTP_1588_CLOCK is not set

#
# Enable PHYLIB and NETWORK_PHY_TIMESTAMPING to see the additional clocks.
#
CONFIG_PINCTRL=y

#
# Pin controllers
#
CONFIG_PINMUX=y
CONFIG_PINCONF=y
# CONFIG_DEBUG_PINCTRL is not set
# CONFIG_PINCTRL_AMD is not set
# CONFIG_PINCTRL_SINGLE is not set
CONFIG_PINCTRL_SAMSUNG=y
CONFIG_PINCTRL_EXYNOS=y
CONFIG_PINCTRL_EXYNOS5440=y
CONFIG_ARCH_HAVE_CUSTOM_GPIO_H=y
CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
CONFIG_ARCH_REQUIRE_GPIOLIB=y
CONFIG_GPIOLIB=y
CONFIG_GPIO_DEVRES=y
CONFIG_OF_GPIO=y
CONFIG_DEBUG_GPIO=y
CONFIG_GPIO_SYSFS=y

#
# Memory mapped GPIO drivers
#
# CONFIG_GPIO_74XX_MMIO is not set
# CONFIG_GPIO_ALTERA is not set
# CONFIG_GPIO_DWAPB is not set
# CONFIG_GPIO_EM is not set
# CONFIG_GPIO_GENERIC_PLATFORM is not set
# CONFIG_GPIO_GRGPIO is not set
# CONFIG_GPIO_PL061 is not set
# CONFIG_GPIO_SCH311X is not set
# CONFIG_GPIO_SYSCON is not set
# CONFIG_GPIO_ZEVIO is not set

#
# I2C GPIO expanders
#
# CONFIG_GPIO_ADP5588 is not set
# CONFIG_GPIO_ADNP is not set
# CONFIG_GPIO_MAX7300 is not set
# CONFIG_GPIO_MAX732X is not set
# CONFIG_GPIO_PCA953X is not set
# CONFIG_GPIO_PCF857X is not set
# CONFIG_GPIO_SX150X is not set

#
# MFD GPIO expanders
#

#
# SPI GPIO expanders
#
# CONFIG_GPIO_74X164 is not set
# CONFIG_GPIO_MAX7301 is not set
# CONFIG_GPIO_MCP23S08 is not set
# CONFIG_GPIO_MC33880 is not set
# CONFIG_GPIO_ZX is not set

#
# USB GPIO expanders
#
# CONFIG_W1 is not set
CONFIG_POWER_SUPPLY=y
# CONFIG_POWER_SUPPLY_DEBUG is not set
# CONFIG_PDA_POWER is not set
# CONFIG_GENERIC_ADC_BATTERY is not set
# CONFIG_TEST_POWER is not set
# CONFIG_BATTERY_DS2780 is not set
# CONFIG_BATTERY_DS2781 is not set
# CONFIG_BATTERY_DS2782 is not set
CONFIG_BATTERY_SBS=y
# CONFIG_BATTERY_BQ27x00 is not set
CONFIG_BATTERY_MAX17040=y
CONFIG_BATTERY_MAX17042=y
# CONFIG_CHARGER_MAX8903 is not set
# CONFIG_CHARGER_LP8727 is not set
# CONFIG_CHARGER_GPIO is not set
# CONFIG_CHARGER_MANAGER is not set
CONFIG_CHARGER_MAX14577=y
CONFIG_CHARGER_MAX77693=y
# CONFIG_CHARGER_MAX8997 is not set
# CONFIG_CHARGER_BQ2415X is not set
# CONFIG_CHARGER_BQ24190 is not set
# CONFIG_CHARGER_BQ24257 is not set
# CONFIG_CHARGER_BQ24735 is not set
# CONFIG_CHARGER_BQ25890 is not set
# CONFIG_CHARGER_SMB347 is not set
CONFIG_CHARGER_TPS65090=y
# CONFIG_BATTERY_GAUGE_LTC2941 is not set
# CONFIG_CHARGER_RT9455 is not set
# CONFIG_POWER_RESET is not set
# CONFIG_POWER_AVS is not set
CONFIG_HWMON=y
# CONFIG_HWMON_VID is not set
# CONFIG_HWMON_DEBUG_CHIP is not set

#
# Native drivers
#
# CONFIG_SENSORS_AD7314 is not set
# CONFIG_SENSORS_AD7414 is not set
# CONFIG_SENSORS_AD7418 is not set
# CONFIG_SENSORS_ADM1021 is not set
# CONFIG_SENSORS_ADM1025 is not set
# CONFIG_SENSORS_ADM1026 is not set
# CONFIG_SENSORS_ADM1029 is not set
# CONFIG_SENSORS_ADM1031 is not set
# CONFIG_SENSORS_ADM9240 is not set
# CONFIG_SENSORS_ADT7310 is not set
# CONFIG_SENSORS_ADT7410 is not set
# CONFIG_SENSORS_ADT7411 is not set
# CONFIG_SENSORS_ADT7462 is not set
# CONFIG_SENSORS_ADT7470 is not set
# CONFIG_SENSORS_ADT7475 is not set
# CONFIG_SENSORS_ASC7621 is not set
# CONFIG_SENSORS_ATXP1 is not set
# CONFIG_SENSORS_DS620 is not set
# CONFIG_SENSORS_DS1621 is not set
# CONFIG_SENSORS_F71805F is not set
# CONFIG_SENSORS_F71882FG is not set
# CONFIG_SENSORS_F75375S is not set
# CONFIG_SENSORS_GL518SM is not set
# CONFIG_SENSORS_GL520SM is not set
# CONFIG_SENSORS_G760A is not set
# CONFIG_SENSORS_G762 is not set
# CONFIG_SENSORS_GPIO_FAN is not set
# CONFIG_SENSORS_HIH6130 is not set
# CONFIG_SENSORS_IIO_HWMON is not set
# CONFIG_SENSORS_IT87 is not set
# CONFIG_SENSORS_JC42 is not set
# CONFIG_SENSORS_POWR1220 is not set
# CONFIG_SENSORS_LINEAGE is not set
# CONFIG_SENSORS_LTC2945 is not set
# CONFIG_SENSORS_LTC4151 is not set
# CONFIG_SENSORS_LTC4215 is not set
# CONFIG_SENSORS_LTC4222 is not set
# CONFIG_SENSORS_LTC4245 is not set
# CONFIG_SENSORS_LTC4260 is not set
# CONFIG_SENSORS_LTC4261 is not set
# CONFIG_SENSORS_MAX1111 is not set
# CONFIG_SENSORS_MAX16065 is not set
# CONFIG_SENSORS_MAX1619 is not set
# CONFIG_SENSORS_MAX1668 is not set
# CONFIG_SENSORS_MAX197 is not set
# CONFIG_SENSORS_MAX6639 is not set
# CONFIG_SENSORS_MAX6642 is not set
# CONFIG_SENSORS_MAX6650 is not set
# CONFIG_SENSORS_MAX6697 is not set
# CONFIG_SENSORS_HTU21 is not set
# CONFIG_SENSORS_MCP3021 is not set
# CONFIG_SENSORS_ADCXX is not set
# CONFIG_SENSORS_LM63 is not set
# CONFIG_SENSORS_LM70 is not set
# CONFIG_SENSORS_LM73 is not set
# CONFIG_SENSORS_LM75 is not set
# CONFIG_SENSORS_LM77 is not set
# CONFIG_SENSORS_LM78 is not set
# CONFIG_SENSORS_LM80 is not set
# CONFIG_SENSORS_LM83 is not set
# CONFIG_SENSORS_LM85 is not set
# CONFIG_SENSORS_LM87 is not set
CONFIG_SENSORS_LM90=y
# CONFIG_SENSORS_LM92 is not set
# CONFIG_SENSORS_LM93 is not set
# CONFIG_SENSORS_LM95234 is not set
# CONFIG_SENSORS_LM95241 is not set
# CONFIG_SENSORS_LM95245 is not set
# CONFIG_SENSORS_PC87360 is not set
# CONFIG_SENSORS_PC87427 is not set
CONFIG_SENSORS_NTC_THERMISTOR=y
# CONFIG_SENSORS_NCT6683 is not set
# CONFIG_SENSORS_NCT6775 is not set
# CONFIG_SENSORS_NCT7802 is not set
# CONFIG_SENSORS_NCT7904 is not set
# CONFIG_SENSORS_PCF8591 is not set
# CONFIG_PMBUS is not set
CONFIG_SENSORS_PWM_FAN=y
# CONFIG_SENSORS_SHT15 is not set
# CONFIG_SENSORS_SHT21 is not set
# CONFIG_SENSORS_SHTC1 is not set
# CONFIG_SENSORS_DME1737 is not set
# CONFIG_SENSORS_EMC1403 is not set
# CONFIG_SENSORS_EMC2103 is not set
# CONFIG_SENSORS_EMC6W201 is not set
# CONFIG_SENSORS_SMSC47M1 is not set
# CONFIG_SENSORS_SMSC47M192 is not set
# CONFIG_SENSORS_SMSC47B397 is not set
# CONFIG_SENSORS_SCH56XX_COMMON is not set
# CONFIG_SENSORS_SCH5627 is not set
# CONFIG_SENSORS_SCH5636 is not set
# CONFIG_SENSORS_SMM665 is not set
# CONFIG_SENSORS_ADC128D818 is not set
# CONFIG_SENSORS_ADS1015 is not set
# CONFIG_SENSORS_ADS7828 is not set
# CONFIG_SENSORS_ADS7871 is not set
# CONFIG_SENSORS_AMC6821 is not set
# CONFIG_SENSORS_INA209 is not set
CONFIG_SENSORS_INA2XX=y
# CONFIG_SENSORS_TC74 is not set
# CONFIG_SENSORS_THMC50 is not set
# CONFIG_SENSORS_TMP102 is not set
# CONFIG_SENSORS_TMP103 is not set
# CONFIG_SENSORS_TMP401 is not set
# CONFIG_SENSORS_TMP421 is not set
# CONFIG_SENSORS_VT1211 is not set
# CONFIG_SENSORS_W83781D is not set
# CONFIG_SENSORS_W83791D is not set
# CONFIG_SENSORS_W83792D is not set
# CONFIG_SENSORS_W83793 is not set
# CONFIG_SENSORS_W83795 is not set
# CONFIG_SENSORS_W83L785TS is not set
# CONFIG_SENSORS_W83L786NG is not set
# CONFIG_SENSORS_W83627HF is not set
# CONFIG_SENSORS_W83627EHF is not set
CONFIG_THERMAL=y
CONFIG_THERMAL_HWMON=y
CONFIG_THERMAL_OF=y
# CONFIG_THERMAL_WRITABLE_TRIPS is not set
CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=y
# CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
# CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
# CONFIG_THERMAL_DEFAULT_GOV_POWER_ALLOCATOR is not set
# CONFIG_THERMAL_GOV_FAIR_SHARE is not set
CONFIG_THERMAL_GOV_STEP_WISE=y
# CONFIG_THERMAL_GOV_BANG_BANG is not set
# CONFIG_THERMAL_GOV_USER_SPACE is not set
# CONFIG_THERMAL_GOV_POWER_ALLOCATOR is not set
CONFIG_CPU_THERMAL=y
# CONFIG_CLOCK_THERMAL is not set
CONFIG_THERMAL_EMULATION=y
# CONFIG_IMX_THERMAL is not set

#
# Texas Instruments thermal drivers
#
# CONFIG_TI_SOC_THERMAL is not set

#
# Samsung thermal drivers
#
CONFIG_EXYNOS_THERMAL=y
CONFIG_WATCHDOG=y
CONFIG_WATCHDOG_CORE=y
# CONFIG_WATCHDOG_NOWAYOUT is not set

#
# Watchdog Device Drivers
#
# CONFIG_SOFT_WATCHDOG is not set
# CONFIG_GPIO_WATCHDOG is not set
# CONFIG_XILINX_WATCHDOG is not set
# CONFIG_ARM_SP805_WATCHDOG is not set
# CONFIG_CADENCE_WATCHDOG is not set
CONFIG_HAVE_S3C2410_WATCHDOG=y
CONFIG_S3C2410_WATCHDOG=y
# CONFIG_DW_WATCHDOG is not set
# CONFIG_MAX63XX_WATCHDOG is not set
# CONFIG_MEN_A21_WDT is not set

#
# USB-based Watchdog Cards
#
# CONFIG_USBPCWATCHDOG is not set
CONFIG_SSB_POSSIBLE=y

#
# Sonics Silicon Backplane
#
# CONFIG_SSB is not set
CONFIG_BCMA_POSSIBLE=y

#
# Broadcom specific AMBA
#
# CONFIG_BCMA is not set

#
# Multifunction device drivers
#
CONFIG_MFD_CORE=y
# CONFIG_MFD_AS3711 is not set
# CONFIG_MFD_AS3722 is not set
# CONFIG_PMIC_ADP5520 is not set
# CONFIG_MFD_AAT2870_CORE is not set
# CONFIG_MFD_ATMEL_HLCDC is not set
# CONFIG_MFD_BCM590XX is not set
# CONFIG_MFD_AXP20X is not set
CONFIG_MFD_CROS_EC=y
CONFIG_MFD_CROS_EC_I2C=y
CONFIG_MFD_CROS_EC_SPI=y
# CONFIG_MFD_ASIC3 is not set
# CONFIG_PMIC_DA903X is not set
# CONFIG_MFD_DA9052_SPI is not set
# CONFIG_MFD_DA9052_I2C is not set
# CONFIG_MFD_DA9055 is not set
# CONFIG_MFD_DA9062 is not set
# CONFIG_MFD_DA9063 is not set
# CONFIG_MFD_DA9150 is not set
# CONFIG_MFD_DLN2 is not set
# CONFIG_MFD_MC13XXX_SPI is not set
# CONFIG_MFD_MC13XXX_I2C is not set
# CONFIG_MFD_HI6421_PMIC is not set
# CONFIG_HTC_EGPIO is not set
# CONFIG_HTC_PASIC3 is not set
# CONFIG_HTC_I2CPLD is not set
# CONFIG_INTEL_SOC_PMIC is not set
# CONFIG_MFD_KEMPLD is not set
# CONFIG_MFD_88PM800 is not set
# CONFIG_MFD_88PM805 is not set
# CONFIG_MFD_88PM860X is not set
CONFIG_MFD_MAX14577=y
CONFIG_MFD_MAX77686=y
CONFIG_MFD_MAX77693=y
# CONFIG_MFD_MAX77843 is not set
# CONFIG_MFD_MAX8907 is not set
# CONFIG_MFD_MAX8925 is not set
CONFIG_MFD_MAX8997=y
# CONFIG_MFD_MAX8998 is not set
# CONFIG_MFD_MT6397 is not set
# CONFIG_MFD_MENF21BMC is not set
# CONFIG_EZX_PCAP is not set
# CONFIG_MFD_VIPERBOARD is not set
# CONFIG_MFD_RETU is not set
# CONFIG_MFD_PCF50633 is not set
# CONFIG_MFD_PM8921_CORE is not set
# CONFIG_MFD_RT5033 is not set
# CONFIG_MFD_RTSX_USB is not set
# CONFIG_MFD_RC5T583 is not set
# CONFIG_MFD_RK808 is not set
# CONFIG_MFD_RN5T618 is not set
CONFIG_MFD_SEC_CORE=y
# CONFIG_MFD_SI476X_CORE is not set
# CONFIG_MFD_SM501 is not set
# CONFIG_MFD_SKY81452 is not set
# CONFIG_MFD_SMSC is not set
# CONFIG_ABX500_CORE is not set
# CONFIG_MFD_STMPE is not set
CONFIG_MFD_SYSCON=y
# CONFIG_MFD_TI_AM335X_TSCADC is not set
# CONFIG_MFD_LP3943 is not set
# CONFIG_MFD_LP8788 is not set
# CONFIG_MFD_PALMAS is not set
# CONFIG_TPS6105X is not set
# CONFIG_TPS65010 is not set
# CONFIG_TPS6507X is not set
CONFIG_MFD_TPS65090=y
# CONFIG_MFD_TPS65217 is not set
# CONFIG_MFD_TPS65218 is not set
# CONFIG_MFD_TPS6586X is not set
# CONFIG_MFD_TPS65910 is not set
# CONFIG_MFD_TPS65912 is not set
# CONFIG_MFD_TPS65912_I2C is not set
# CONFIG_MFD_TPS65912_SPI is not set
# CONFIG_MFD_TPS80031 is not set
# CONFIG_TWL4030_CORE is not set
# CONFIG_TWL6040_CORE is not set
# CONFIG_MFD_WL1273_CORE is not set
# CONFIG_MFD_LM3533 is not set
# CONFIG_MFD_TC3589X is not set
# CONFIG_MFD_TMIO is not set
# CONFIG_MFD_T7L66XB is not set
# CONFIG_MFD_TC6387XB is not set
# CONFIG_MFD_TC6393XB is not set
# CONFIG_MFD_ARIZONA_I2C is not set
# CONFIG_MFD_ARIZONA_SPI is not set
# CONFIG_MFD_WM8400 is not set
# CONFIG_MFD_WM831X_I2C is not set
# CONFIG_MFD_WM831X_SPI is not set
# CONFIG_MFD_WM8350_I2C is not set
# CONFIG_MFD_WM8994 is not set
CONFIG_REGULATOR=y
# CONFIG_REGULATOR_DEBUG is not set
CONFIG_REGULATOR_FIXED_VOLTAGE=y
# CONFIG_REGULATOR_VIRTUAL_CONSUMER is not set
# CONFIG_REGULATOR_USERSPACE_CONSUMER is not set
# CONFIG_REGULATOR_ACT8865 is not set
# CONFIG_REGULATOR_AD5398 is not set
# CONFIG_REGULATOR_ANATOP is not set
# CONFIG_REGULATOR_DA9210 is not set
# CONFIG_REGULATOR_DA9211 is not set
# CONFIG_REGULATOR_FAN53555 is not set
CONFIG_REGULATOR_GPIO=y
# CONFIG_REGULATOR_ISL9305 is not set
# CONFIG_REGULATOR_ISL6271A is not set
# CONFIG_REGULATOR_LP3971 is not set
# CONFIG_REGULATOR_LP3972 is not set
# CONFIG_REGULATOR_LP872X is not set
# CONFIG_REGULATOR_LP8755 is not set
# CONFIG_REGULATOR_LTC3589 is not set
CONFIG_REGULATOR_MAX14577=y
# CONFIG_REGULATOR_MAX1586 is not set
# CONFIG_REGULATOR_MAX8649 is not set
# CONFIG_REGULATOR_MAX8660 is not set
# CONFIG_REGULATOR_MAX8952 is not set
# CONFIG_REGULATOR_MAX8973 is not set
CONFIG_REGULATOR_MAX8997=y
CONFIG_REGULATOR_MAX77686=y
CONFIG_REGULATOR_MAX77693=y
CONFIG_REGULATOR_MAX77802=y
# CONFIG_REGULATOR_MT6311 is not set
# CONFIG_REGULATOR_PFUZE100 is not set
# CONFIG_REGULATOR_PWM is not set
CONFIG_REGULATOR_S2MPA01=y
CONFIG_REGULATOR_S2MPS11=y
CONFIG_REGULATOR_S5M8767=y
# CONFIG_REGULATOR_TPS51632 is not set
# CONFIG_REGULATOR_TPS62360 is not set
# CONFIG_REGULATOR_TPS65023 is not set
# CONFIG_REGULATOR_TPS6507X is not set
CONFIG_REGULATOR_TPS65090=y
# CONFIG_REGULATOR_TPS6524X is not set
# CONFIG_MEDIA_SUPPORT is not set

#
# Graphics support
#
CONFIG_DRM=y
CONFIG_DRM_MIPI_DSI=y
CONFIG_DRM_KMS_HELPER=y
CONFIG_DRM_KMS_FB_HELPER=y
CONFIG_DRM_FBDEV_EMULATION=y
# CONFIG_DRM_LOAD_EDID_FIRMWARE is not set

#
# I2C encoder or helper chips
#
# CONFIG_DRM_I2C_ADV7511 is not set
# CONFIG_DRM_I2C_CH7006 is not set
# CONFIG_DRM_I2C_SIL164 is not set
# CONFIG_DRM_I2C_NXP_TDA998X is not set
# CONFIG_DRM_VGEM is not set
CONFIG_DRM_EXYNOS=y
CONFIG_DRM_EXYNOS_FIMD=y
# CONFIG_DRM_EXYNOS5433_DECON is not set
# CONFIG_DRM_EXYNOS7_DECON is not set
# CONFIG_DRM_EXYNOS_DPI is not set
CONFIG_DRM_EXYNOS_DSI=y
CONFIG_DRM_EXYNOS_DP=y
CONFIG_DRM_EXYNOS_HDMI=y
# CONFIG_DRM_EXYNOS_VIDI is not set
# CONFIG_DRM_EXYNOS_G2D is not set
# CONFIG_DRM_EXYNOS_IPP is not set
# CONFIG_DRM_UDL is not set
# CONFIG_DRM_ARMADA is not set
# CONFIG_DRM_TILCDC is not set
# CONFIG_DRM_FSL_DCU is not set
CONFIG_DRM_PANEL=y

#
# Display Panels
#
CONFIG_DRM_PANEL_SIMPLE=y
# CONFIG_DRM_PANEL_SAMSUNG_LD9040 is not set
# CONFIG_DRM_PANEL_LG_LG4573 is not set
CONFIG_DRM_PANEL_SAMSUNG_S6E8AA0=y
# CONFIG_DRM_PANEL_SHARP_LQ101R1SX01 is not set
CONFIG_DRM_BRIDGE=y

#
# Display Interface Bridges
#
CONFIG_DRM_NXP_PTN3460=y
CONFIG_DRM_PARADE_PS8622=y
# CONFIG_DRM_STI is not set

#
# Frame buffer Devices
#
CONFIG_FB=y
# CONFIG_FIRMWARE_EDID is not set
CONFIG_FB_CMDLINE=y
# CONFIG_FB_DDC is not set
# CONFIG_FB_BOOT_VESA_SUPPORT is not set
CONFIG_FB_CFB_FILLRECT=y
CONFIG_FB_CFB_COPYAREA=y
CONFIG_FB_CFB_IMAGEBLIT=y
# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
CONFIG_FB_SYS_FILLRECT=y
CONFIG_FB_SYS_COPYAREA=y
CONFIG_FB_SYS_IMAGEBLIT=y
# CONFIG_FB_FOREIGN_ENDIAN is not set
CONFIG_FB_SYS_FOPS=y
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_MACMODES is not set
# CONFIG_FB_BACKLIGHT is not set
CONFIG_FB_MODE_HELPERS=y
# CONFIG_FB_TILEBLITTING is not set

#
# Frame buffer hardware drivers
#
# CONFIG_FB_ARMCLCD is not set
# CONFIG_FB_OPENCORES is not set
# CONFIG_FB_S1D13XXX is not set
# CONFIG_FB_S3C is not set
# CONFIG_FB_SMSCUFX is not set
# CONFIG_FB_UDL is not set
# CONFIG_FB_VIRTUAL is not set
# CONFIG_FB_METRONOME is not set
# CONFIG_FB_BROADSHEET is not set
# CONFIG_FB_AUO_K190X is not set
CONFIG_FB_SIMPLE=y
CONFIG_EXYNOS_VIDEO=y
CONFIG_EXYNOS_MIPI_DSI=y
# CONFIG_EXYNOS_LCD_S6E8AX0 is not set
# CONFIG_FB_SSD1307 is not set
CONFIG_BACKLIGHT_LCD_SUPPORT=y
CONFIG_LCD_CLASS_DEVICE=y
# CONFIG_LCD_L4F00242T03 is not set
# CONFIG_LCD_LMS283GF05 is not set
# CONFIG_LCD_LTV350QV is not set
# CONFIG_LCD_ILI922X is not set
# CONFIG_LCD_ILI9320 is not set
# CONFIG_LCD_TDO24M is not set
# CONFIG_LCD_VGG2432A4 is not set
CONFIG_LCD_PLATFORM=y
# CONFIG_LCD_S6E63M0 is not set
# CONFIG_LCD_LD9040 is not set
# CONFIG_LCD_AMS369FG06 is not set
# CONFIG_LCD_LMS501KF03 is not set
# CONFIG_LCD_HX8357 is not set
CONFIG_BACKLIGHT_CLASS_DEVICE=y
CONFIG_BACKLIGHT_GENERIC=y
CONFIG_BACKLIGHT_PWM=y
# CONFIG_BACKLIGHT_PM8941_WLED is not set
# CONFIG_BACKLIGHT_ADP8860 is not set
# CONFIG_BACKLIGHT_ADP8870 is not set
# CONFIG_BACKLIGHT_LM3630A is not set
# CONFIG_BACKLIGHT_LM3639 is not set
# CONFIG_BACKLIGHT_LP855X is not set
# CONFIG_BACKLIGHT_GPIO is not set
# CONFIG_BACKLIGHT_LV5207LP is not set
# CONFIG_BACKLIGHT_BD6107 is not set
# CONFIG_VGASTATE is not set
CONFIG_VIDEOMODE_HELPERS=y
CONFIG_HDMI=y

#
# Console display driver support
#
CONFIG_DUMMY_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE=y
CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=y
# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
CONFIG_LOGO=y
CONFIG_LOGO_LINUX_MONO=y
CONFIG_LOGO_LINUX_VGA16=y
CONFIG_LOGO_LINUX_CLUT224=y
CONFIG_SOUND=y
# CONFIG_SOUND_OSS_CORE is not set
CONFIG_SND=y
CONFIG_SND_TIMER=y
CONFIG_SND_PCM=y
CONFIG_SND_DMAENGINE_PCM=y
CONFIG_SND_COMPRESS_OFFLOAD=y
CONFIG_SND_JACK=y
# CONFIG_SND_SEQUENCER is not set
# CONFIG_SND_MIXER_OSS is not set
# CONFIG_SND_PCM_OSS is not set
# CONFIG_SND_HRTIMER is not set
# CONFIG_SND_DYNAMIC_MINORS is not set
CONFIG_SND_SUPPORT_OLD_API=y
CONFIG_SND_PROC_FS=y
CONFIG_SND_VERBOSE_PROCFS=y
# CONFIG_SND_VERBOSE_PRINTK is not set
# CONFIG_SND_DEBUG is not set
# CONFIG_SND_RAWMIDI_SEQ is not set
# CONFIG_SND_OPL3_LIB_SEQ is not set
# CONFIG_SND_OPL4_LIB_SEQ is not set
# CONFIG_SND_SBAWE_SEQ is not set
# CONFIG_SND_EMU10K1_SEQ is not set
CONFIG_SND_DRIVERS=y
# CONFIG_SND_DUMMY is not set
# CONFIG_SND_ALOOP is not set
# CONFIG_SND_MTPAV is not set
# CONFIG_SND_SERIAL_U16550 is not set
# CONFIG_SND_MPU401 is not set

#
# HD-Audio
#
CONFIG_SND_HDA_PREALLOC_SIZE=64
CONFIG_SND_ARM=y
# CONFIG_SND_ARMAACI is not set
CONFIG_SND_SPI=y
CONFIG_SND_USB=y
# CONFIG_SND_USB_AUDIO is not set
# CONFIG_SND_USB_UA101 is not set
# CONFIG_SND_USB_CAIAQ is not set
# CONFIG_SND_USB_6FIRE is not set
# CONFIG_SND_USB_HIFACE is not set
# CONFIG_SND_BCD2000 is not set
# CONFIG_SND_USB_POD is not set
# CONFIG_SND_USB_PODHD is not set
# CONFIG_SND_USB_TONEPORT is not set
# CONFIG_SND_USB_VARIAX is not set
CONFIG_SND_SOC=y
CONFIG_SND_SOC_GENERIC_DMAENGINE_PCM=y
# CONFIG_SND_ATMEL_SOC is not set
# CONFIG_SND_DESIGNWARE_I2S is not set

#
# SoC Audio for Freescale CPUs
#

#
# Common SoC Audio options for Freescale CPUs:
#
# CONFIG_SND_SOC_FSL_ASRC is not set
# CONFIG_SND_SOC_FSL_SAI is not set
# CONFIG_SND_SOC_FSL_SSI is not set
# CONFIG_SND_SOC_FSL_SPDIF is not set
# CONFIG_SND_SOC_FSL_ESAI is not set
# CONFIG_SND_SOC_IMX_AUDMUX is not set
CONFIG_SND_SOC_SAMSUNG=y
CONFIG_SND_SAMSUNG_I2S=y
# CONFIG_SND_SOC_SAMSUNG_SMDK_WM8994 is not set
# CONFIG_SND_SOC_SAMSUNG_SMDK_SPDIF is not set
# CONFIG_SND_SOC_SMDK_WM8994_PCM is not set
CONFIG_SND_SOC_SNOW=y
CONFIG_SND_SOC_ODROIDX2=y
# CONFIG_SND_SOC_ARNDALE_RT5631_ALC5631 is not set
# CONFIG_SND_SOC_XTFPGA_I2S is not set
CONFIG_SND_SOC_I2C_AND_SPI=y

#
# CODEC drivers
#
# CONFIG_SND_SOC_AC97_CODEC is not set
# CONFIG_SND_SOC_ADAU1701 is not set
# CONFIG_SND_SOC_AK4104 is not set
# CONFIG_SND_SOC_AK4554 is not set
# CONFIG_SND_SOC_AK4642 is not set
# CONFIG_SND_SOC_AK5386 is not set
# CONFIG_SND_SOC_ALC5623 is not set
# CONFIG_SND_SOC_CS35L32 is not set
# CONFIG_SND_SOC_CS42L51_I2C is not set
# CONFIG_SND_SOC_CS42L52 is not set
# CONFIG_SND_SOC_CS42L56 is not set
# CONFIG_SND_SOC_CS42L73 is not set
# CONFIG_SND_SOC_CS4265 is not set
# CONFIG_SND_SOC_CS4270 is not set
# CONFIG_SND_SOC_CS4271_I2C is not set
# CONFIG_SND_SOC_CS4271_SPI is not set
# CONFIG_SND_SOC_CS42XX8_I2C is not set
# CONFIG_SND_SOC_CS4349 is not set
# CONFIG_SND_SOC_HDMI_CODEC is not set
# CONFIG_SND_SOC_ES8328 is not set
# CONFIG_SND_SOC_GTM601 is not set
CONFIG_SND_SOC_MAX98090=y
CONFIG_SND_SOC_MAX98095=y
# CONFIG_SND_SOC_PCM1681 is not set
# CONFIG_SND_SOC_PCM1792A is not set
# CONFIG_SND_SOC_PCM512x_I2C is not set
# CONFIG_SND_SOC_PCM512x_SPI is not set
# CONFIG_SND_SOC_RT5631 is not set
# CONFIG_SND_SOC_RT5677_SPI is not set
# CONFIG_SND_SOC_SGTL5000 is not set
# CONFIG_SND_SOC_SIRF_AUDIO_CODEC is not set
# CONFIG_SND_SOC_SPDIF is not set
# CONFIG_SND_SOC_SSM2602_SPI is not set
# CONFIG_SND_SOC_SSM2602_I2C is not set
# CONFIG_SND_SOC_SSM4567 is not set
# CONFIG_SND_SOC_STA32X is not set
# CONFIG_SND_SOC_STA350 is not set
# CONFIG_SND_SOC_STI_SAS is not set
# CONFIG_SND_SOC_TAS2552 is not set
# CONFIG_SND_SOC_TAS5086 is not set
# CONFIG_SND_SOC_TAS571X is not set
# CONFIG_SND_SOC_TFA9879 is not set
# CONFIG_SND_SOC_TLV320AIC23_I2C is not set
# CONFIG_SND_SOC_TLV320AIC23_SPI is not set
# CONFIG_SND_SOC_TLV320AIC31XX is not set
# CONFIG_SND_SOC_TLV320AIC3X is not set
# CONFIG_SND_SOC_TS3A227E is not set
# CONFIG_SND_SOC_WM8510 is not set
# CONFIG_SND_SOC_WM8523 is not set
# CONFIG_SND_SOC_WM8580 is not set
# CONFIG_SND_SOC_WM8711 is not set
# CONFIG_SND_SOC_WM8728 is not set
# CONFIG_SND_SOC_WM8731 is not set
# CONFIG_SND_SOC_WM8737 is not set
# CONFIG_SND_SOC_WM8741 is not set
# CONFIG_SND_SOC_WM8750 is not set
# CONFIG_SND_SOC_WM8753 is not set
# CONFIG_SND_SOC_WM8770 is not set
# CONFIG_SND_SOC_WM8776 is not set
# CONFIG_SND_SOC_WM8804_I2C is not set
# CONFIG_SND_SOC_WM8804_SPI is not set
# CONFIG_SND_SOC_WM8903 is not set
# CONFIG_SND_SOC_WM8962 is not set
# CONFIG_SND_SOC_WM8978 is not set
# CONFIG_SND_SOC_TPA6130A2 is not set
CONFIG_SND_SIMPLE_CARD=y
# CONFIG_SOUND_PRIME is not set

#
# HID support
#
CONFIG_HID=y
# CONFIG_HID_BATTERY_STRENGTH is not set
# CONFIG_HIDRAW is not set
# CONFIG_UHID is not set
CONFIG_HID_GENERIC=y

#
# Special HID drivers
#
CONFIG_HID_A4TECH=y
# CONFIG_HID_ACRUX is not set
CONFIG_HID_APPLE=y
# CONFIG_HID_APPLEIR is not set
# CONFIG_HID_AUREAL is not set
CONFIG_HID_BELKIN=y
# CONFIG_HID_BETOP_FF is not set
CONFIG_HID_CHERRY=y
CONFIG_HID_CHICONY=y
# CONFIG_HID_PRODIKEYS is not set
# CONFIG_HID_CP2112 is not set
CONFIG_HID_CYPRESS=y
# CONFIG_HID_DRAGONRISE is not set
# CONFIG_HID_EMS_FF is not set
# CONFIG_HID_ELECOM is not set
# CONFIG_HID_ELO is not set
CONFIG_HID_EZKEY=y
# CONFIG_HID_GEMBIRD is not set
# CONFIG_HID_HOLTEK is not set
# CONFIG_HID_GT683R is not set
# CONFIG_HID_KEYTOUCH is not set
# CONFIG_HID_KYE is not set
# CONFIG_HID_UCLOGIC is not set
# CONFIG_HID_WALTOP is not set
# CONFIG_HID_GYRATION is not set
# CONFIG_HID_ICADE is not set
# CONFIG_HID_TWINHAN is not set
CONFIG_HID_KENSINGTON=y
# CONFIG_HID_LCPOWER is not set
# CONFIG_HID_LENOVO is not set
CONFIG_HID_LOGITECH=y
# CONFIG_HID_LOGITECH_HIDPP is not set
# CONFIG_LOGITECH_FF is not set
# CONFIG_LOGIRUMBLEPAD2_FF is not set
# CONFIG_LOGIG940_FF is not set
# CONFIG_LOGIWHEELS_FF is not set
# CONFIG_HID_MAGICMOUSE is not set
CONFIG_HID_MICROSOFT=y
CONFIG_HID_MONTEREY=y
# CONFIG_HID_MULTITOUCH is not set
# CONFIG_HID_NTRIG is not set
# CONFIG_HID_ORTEK is not set
# CONFIG_HID_PANTHERLORD is not set
# CONFIG_HID_PENMOUNT is not set
# CONFIG_HID_PETALYNX is not set
# CONFIG_HID_PICOLCD is not set
# CONFIG_HID_PLANTRONICS is not set
# CONFIG_HID_PRIMAX is not set
# CONFIG_HID_ROCCAT is not set
# CONFIG_HID_SAITEK is not set
# CONFIG_HID_SAMSUNG is not set
# CONFIG_HID_SONY is not set
# CONFIG_HID_SPEEDLINK is not set
# CONFIG_HID_STEELSERIES is not set
# CONFIG_HID_SUNPLUS is not set
# CONFIG_HID_RMI is not set
# CONFIG_HID_GREENASIA is not set
# CONFIG_HID_SMARTJOYPLUS is not set
# CONFIG_HID_TIVO is not set
# CONFIG_HID_TOPSEED is not set
# CONFIG_HID_THINGM is not set
# CONFIG_HID_THRUSTMASTER is not set
# CONFIG_HID_WACOM is not set
# CONFIG_HID_WIIMOTE is not set
# CONFIG_HID_XINMO is not set
# CONFIG_HID_ZEROPLUS is not set
# CONFIG_HID_ZYDACRON is not set
# CONFIG_HID_SENSOR_HUB is not set

#
# USB HID support
#
CONFIG_USB_HID=y
# CONFIG_HID_PID is not set
# CONFIG_USB_HIDDEV is not set

#
# I2C HID support
#
# CONFIG_I2C_HID is not set
CONFIG_USB_OHCI_LITTLE_ENDIAN=y
CONFIG_USB_SUPPORT=y
CONFIG_USB_COMMON=y
CONFIG_USB_ARCH_HAS_HCD=y
CONFIG_USB=y
CONFIG_USB_ANNOUNCE_NEW_DEVICES=y

#
# Miscellaneous USB options
#
CONFIG_USB_DEFAULT_PERSIST=y
# CONFIG_USB_DYNAMIC_MINORS is not set
# CONFIG_USB_OTG is not set
# CONFIG_USB_OTG_WHITELIST is not set
# CONFIG_USB_OTG_FSM is not set
# CONFIG_USB_ULPI_BUS is not set
# CONFIG_USB_MON is not set
# CONFIG_USB_WUSB_CBAF is not set

#
# USB Host Controller Drivers
#
# CONFIG_USB_C67X00_HCD is not set
CONFIG_USB_XHCI_HCD=y
CONFIG_USB_XHCI_PLATFORM=y
CONFIG_USB_EHCI_HCD=y
# CONFIG_USB_EHCI_ROOT_HUB_TT is not set
CONFIG_USB_EHCI_TT_NEWSCHED=y
CONFIG_USB_EHCI_EXYNOS=y
# CONFIG_USB_EHCI_HCD_PLATFORM is not set
# CONFIG_USB_OXU210HP_HCD is not set
# CONFIG_USB_ISP116X_HCD is not set
# CONFIG_USB_ISP1362_HCD is not set
# CONFIG_USB_FUSBH200_HCD is not set
# CONFIG_USB_FOTG210_HCD is not set
# CONFIG_USB_MAX3421_HCD is not set
CONFIG_USB_OHCI_HCD=y
CONFIG_USB_OHCI_EXYNOS=y
# CONFIG_USB_OHCI_HCD_PLATFORM is not set
# CONFIG_USB_SL811_HCD is not set
# CONFIG_USB_R8A66597_HCD is not set
# CONFIG_USB_HCD_TEST_MODE is not set

#
# USB Device Class drivers
#
# CONFIG_USB_ACM is not set
# CONFIG_USB_PRINTER is not set
# CONFIG_USB_WDM is not set
# CONFIG_USB_TMC is not set

#
# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
#

#
# also be needed; see USB_STORAGE Help for more info
#
CONFIG_USB_STORAGE=y
# CONFIG_USB_STORAGE_DEBUG is not set
# CONFIG_USB_STORAGE_REALTEK is not set
# CONFIG_USB_STORAGE_DATAFAB is not set
# CONFIG_USB_STORAGE_FREECOM is not set
# CONFIG_USB_STORAGE_ISD200 is not set
# CONFIG_USB_STORAGE_USBAT is not set
# CONFIG_USB_STORAGE_SDDR09 is not set
# CONFIG_USB_STORAGE_SDDR55 is not set
# CONFIG_USB_STORAGE_JUMPSHOT is not set
# CONFIG_USB_STORAGE_ALAUDA is not set
# CONFIG_USB_STORAGE_ONETOUCH is not set
# CONFIG_USB_STORAGE_KARMA is not set
# CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
# CONFIG_USB_STORAGE_ENE_UB6250 is not set
# CONFIG_USB_UAS is not set

#
# USB Imaging devices
#
# CONFIG_USB_MDC800 is not set
# CONFIG_USB_MICROTEK is not set
# CONFIG_USBIP_CORE is not set
# CONFIG_USB_MUSB_HDRC is not set
CONFIG_USB_DWC3=y
# CONFIG_USB_DWC3_HOST is not set
# CONFIG_USB_DWC3_GADGET is not set
CONFIG_USB_DWC3_DUAL_ROLE=y

#
# Platform Glue Driver Support
#
CONFIG_USB_DWC3_EXYNOS=y
# CONFIG_USB_DWC2 is not set
# CONFIG_USB_CHIPIDEA is not set
# CONFIG_USB_ISP1760 is not set

#
# USB port drivers
#
# CONFIG_USB_SERIAL is not set

#
# USB Miscellaneous drivers
#
# CONFIG_USB_EMI62 is not set
# CONFIG_USB_EMI26 is not set
# CONFIG_USB_ADUTUX is not set
# CONFIG_USB_SEVSEG is not set
# CONFIG_USB_RIO500 is not set
# CONFIG_USB_LEGOTOWER is not set
# CONFIG_USB_LCD is not set
# CONFIG_USB_LED is not set
# CONFIG_USB_CYPRESS_CY7C63 is not set
# CONFIG_USB_CYTHERM is not set
# CONFIG_USB_IDMOUSE is not set
# CONFIG_USB_FTDI_ELAN is not set
# CONFIG_USB_APPLEDISPLAY is not set
# CONFIG_USB_SISUSBVGA is not set
# CONFIG_USB_LD is not set
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_USB_IOWARRIOR is not set
# CONFIG_USB_TEST is not set
# CONFIG_USB_EHSET_TEST_FIXTURE is not set
# CONFIG_USB_ISIGHTFW is not set
# CONFIG_USB_YUREX is not set
# CONFIG_USB_EZUSB_FX2 is not set
CONFIG_USB_HSIC_USB3503=y
# CONFIG_USB_LINK_LAYER_TEST is not set
# CONFIG_USB_CHAOSKEY is not set

#
# USB Physical Layer drivers
#
# CONFIG_USB_PHY is not set
# CONFIG_NOP_USB_XCEIV is not set
# CONFIG_AM335X_PHY_USB is not set
# CONFIG_USB_GPIO_VBUS is not set
# CONFIG_USB_ISP1301 is not set
# CONFIG_USB_ULPI is not set
CONFIG_USB_GADGET=y
# CONFIG_USB_GADGET_DEBUG is not set
# CONFIG_USB_GADGET_DEBUG_FILES is not set
# CONFIG_USB_GADGET_DEBUG_FS is not set
CONFIG_USB_GADGET_VBUS_DRAW=2
CONFIG_USB_GADGET_STORAGE_NUM_BUFFERS=2

#
# USB Peripheral Controller
#
# CONFIG_USB_FUSB300 is not set
# CONFIG_USB_FOTG210_UDC is not set
# CONFIG_USB_GR_UDC is not set
# CONFIG_USB_R8A66597 is not set
# CONFIG_USB_PXA27X is not set
# CONFIG_USB_MV_UDC is not set
# CONFIG_USB_MV_U3D is not set
# CONFIG_USB_M66592 is not set
# CONFIG_USB_BDC_UDC is not set
# CONFIG_USB_NET2272 is not set
# CONFIG_USB_GADGET_XILINX is not set
# CONFIG_USB_DUMMY_HCD is not set
# CONFIG_USB_CONFIGFS is not set
# CONFIG_USB_ZERO is not set
# CONFIG_USB_AUDIO is not set
# CONFIG_USB_ETH is not set
# CONFIG_USB_G_NCM is not set
# CONFIG_USB_GADGETFS is not set
# CONFIG_USB_FUNCTIONFS is not set
# CONFIG_USB_MASS_STORAGE is not set
# CONFIG_USB_G_SERIAL is not set
# CONFIG_USB_MIDI_GADGET is not set
# CONFIG_USB_G_PRINTER is not set
# CONFIG_USB_CDC_COMPOSITE is not set
# CONFIG_USB_G_ACM_MS is not set
# CONFIG_USB_G_MULTI is not set
# CONFIG_USB_G_HID is not set
# CONFIG_USB_G_DBGP is not set
# CONFIG_UWB is not set
CONFIG_MMC=y
# CONFIG_MMC_DEBUG is not set
# CONFIG_MMC_CLKGATE is not set

#
# MMC/SD/SDIO Card Drivers
#
CONFIG_MMC_BLOCK=y
CONFIG_MMC_BLOCK_MINORS=16
CONFIG_MMC_BLOCK_BOUNCE=y
# CONFIG_SDIO_UART is not set
# CONFIG_MMC_TEST is not set

#
# MMC/SD/SDIO Host Controller Drivers
#
# CONFIG_MMC_ARMMMCI is not set
CONFIG_MMC_SDHCI=y
# CONFIG_MMC_SDHCI_PLTFM is not set
CONFIG_MMC_SDHCI_S3C=y
CONFIG_MMC_SDHCI_S3C_DMA=y
CONFIG_MMC_DW=y
CONFIG_MMC_DW_IDMAC=y
CONFIG_MMC_DW_PLTFM=y
CONFIG_MMC_DW_EXYNOS=y
# CONFIG_MMC_DW_K3 is not set
# CONFIG_MMC_VUB300 is not set
# CONFIG_MMC_USHC is not set
# CONFIG_MMC_USDHI6ROL0 is not set
# CONFIG_MMC_MTK is not set
# CONFIG_MEMSTICK is not set
CONFIG_NEW_LEDS=y
CONFIG_LEDS_CLASS=y
CONFIG_LEDS_CLASS_FLASH=y

#
# LED drivers
#
# CONFIG_LEDS_AAT1290 is not set
# CONFIG_LEDS_BCM6328 is not set
# CONFIG_LEDS_BCM6358 is not set
# CONFIG_LEDS_LM3530 is not set
# CONFIG_LEDS_LM3642 is not set
# CONFIG_LEDS_PCA9532 is not set
# CONFIG_LEDS_GPIO is not set
# CONFIG_LEDS_LP3944 is not set
# CONFIG_LEDS_LP5521 is not set
# CONFIG_LEDS_LP5523 is not set
# CONFIG_LEDS_LP5562 is not set
# CONFIG_LEDS_LP8501 is not set
# CONFIG_LEDS_LP8860 is not set
# CONFIG_LEDS_PCA955X is not set
# CONFIG_LEDS_PCA963X is not set
# CONFIG_LEDS_DAC124S085 is not set
# CONFIG_LEDS_PWM is not set
# CONFIG_LEDS_REGULATOR is not set
# CONFIG_LEDS_BD2802 is not set
# CONFIG_LEDS_LT3593 is not set
# CONFIG_LEDS_TCA6507 is not set
# CONFIG_LEDS_TLC591XX is not set
# CONFIG_LEDS_MAX77693 is not set
# CONFIG_LEDS_MAX8997 is not set
# CONFIG_LEDS_LM355x is not set
# CONFIG_LEDS_KTD2692 is not set

#
# LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_THINGM)
#
# CONFIG_LEDS_BLINKM is not set
# CONFIG_LEDS_SYSCON is not set

#
# LED Triggers
#
# CONFIG_LEDS_TRIGGERS is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_EDAC_ATOMIC_SCRUB=y
CONFIG_EDAC_SUPPORT=y
# CONFIG_EDAC is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_CLASS=y
CONFIG_RTC_HCTOSYS=y
CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
CONFIG_RTC_SYSTOHC=y
CONFIG_RTC_SYSTOHC_DEVICE="rtc0"
# CONFIG_RTC_DEBUG is not set

#
# RTC interfaces
#
CONFIG_RTC_INTF_SYSFS=y
CONFIG_RTC_INTF_PROC=y
CONFIG_RTC_INTF_DEV=y
# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
# CONFIG_RTC_DRV_TEST is not set

#
# I2C RTC drivers
#
# CONFIG_RTC_DRV_ABB5ZES3 is not set
# CONFIG_RTC_DRV_ABX80X is not set
# CONFIG_RTC_DRV_DS1307 is not set
# CONFIG_RTC_DRV_DS1374 is not set
# CONFIG_RTC_DRV_DS1672 is not set
# CONFIG_RTC_DRV_DS3232 is not set
# CONFIG_RTC_DRV_HYM8563 is not set
# CONFIG_RTC_DRV_MAX6900 is not set
# CONFIG_RTC_DRV_MAX8997 is not set
CONFIG_RTC_DRV_MAX77686=y
CONFIG_RTC_DRV_MAX77802=y
# CONFIG_RTC_DRV_RS5C372 is not set
# CONFIG_RTC_DRV_ISL1208 is not set
# CONFIG_RTC_DRV_ISL12022 is not set
# CONFIG_RTC_DRV_ISL12057 is not set
# CONFIG_RTC_DRV_X1205 is not set
# CONFIG_RTC_DRV_PCF2127 is not set
# CONFIG_RTC_DRV_PCF8523 is not set
# CONFIG_RTC_DRV_PCF8563 is not set
# CONFIG_RTC_DRV_PCF85063 is not set
# CONFIG_RTC_DRV_PCF8583 is not set
# CONFIG_RTC_DRV_M41T80 is not set
# CONFIG_RTC_DRV_BQ32K is not set
# CONFIG_RTC_DRV_S35390A is not set
# CONFIG_RTC_DRV_FM3130 is not set
# CONFIG_RTC_DRV_RX8581 is not set
# CONFIG_RTC_DRV_RX8025 is not set
# CONFIG_RTC_DRV_EM3027 is not set
# CONFIG_RTC_DRV_RV3029C2 is not set
CONFIG_RTC_DRV_S5M=y

#
# SPI RTC drivers
#
# CONFIG_RTC_DRV_M41T93 is not set
# CONFIG_RTC_DRV_M41T94 is not set
# CONFIG_RTC_DRV_DS1305 is not set
# CONFIG_RTC_DRV_DS1343 is not set
# CONFIG_RTC_DRV_DS1347 is not set
# CONFIG_RTC_DRV_DS1390 is not set
# CONFIG_RTC_DRV_MAX6902 is not set
# CONFIG_RTC_DRV_R9701 is not set
# CONFIG_RTC_DRV_RS5C348 is not set
# CONFIG_RTC_DRV_DS3234 is not set
# CONFIG_RTC_DRV_PCF2123 is not set
# CONFIG_RTC_DRV_RX4581 is not set
# CONFIG_RTC_DRV_MCP795 is not set

#
# Platform RTC drivers
#
# CONFIG_RTC_DRV_CMOS is not set
# CONFIG_RTC_DRV_DS1286 is not set
# CONFIG_RTC_DRV_DS1511 is not set
# CONFIG_RTC_DRV_DS1553 is not set
# CONFIG_RTC_DRV_DS1685_FAMILY is not set
# CONFIG_RTC_DRV_DS1742 is not set
# CONFIG_RTC_DRV_DS2404 is not set
# CONFIG_RTC_DRV_STK17TA8 is not set
# CONFIG_RTC_DRV_M48T86 is not set
# CONFIG_RTC_DRV_M48T35 is not set
# CONFIG_RTC_DRV_M48T59 is not set
# CONFIG_RTC_DRV_MSM6242 is not set
# CONFIG_RTC_DRV_BQ4802 is not set
# CONFIG_RTC_DRV_RP5C01 is not set
# CONFIG_RTC_DRV_V3020 is not set
# CONFIG_RTC_DRV_ZYNQMP is not set

#
# on-CPU RTC drivers
#
CONFIG_HAVE_S3C_RTC=y
CONFIG_RTC_DRV_S3C=y
# CONFIG_RTC_DRV_PL030 is not set
# CONFIG_RTC_DRV_PL031 is not set
# CONFIG_RTC_DRV_SNVS is not set

#
# HID Sensor RTC drivers
#
# CONFIG_RTC_DRV_HID_SENSOR_TIME is not set
CONFIG_DMADEVICES=y
# CONFIG_DMADEVICES_DEBUG is not set

#
# DMA Devices
#
CONFIG_DMA_ENGINE=y
CONFIG_DMA_OF=y
# CONFIG_AMBA_PL08X is not set
# CONFIG_FSL_EDMA is not set
# CONFIG_IDMA64 is not set
# CONFIG_NBPFAXI_DMA is not set
CONFIG_PL330_DMA=y
# CONFIG_DW_DMAC is not set

#
# DMA Clients
#
# CONFIG_ASYNC_TX_DMA is not set
# CONFIG_DMATEST is not set
# CONFIG_AUXDISPLAY is not set
# CONFIG_UIO is not set
# CONFIG_VIRT_DRIVERS is not set

#
# Virtio drivers
#
# CONFIG_VIRTIO_MMIO is not set

#
# Microsoft Hyper-V guest support
#
# CONFIG_STAGING is not set
CONFIG_CHROME_PLATFORMS=y
CONFIG_CROS_EC_CHARDEV=y
CONFIG_CROS_EC_PROTO=y
CONFIG_CLKDEV_LOOKUP=y
CONFIG_HAVE_CLK_PREPARE=y
CONFIG_COMMON_CLK=y

#
# Common Clock Framework
#
CONFIG_COMMON_CLK_MAX_GEN=y
CONFIG_COMMON_CLK_MAX77686=y
CONFIG_COMMON_CLK_MAX77802=y
# CONFIG_COMMON_CLK_SI5351 is not set
# CONFIG_COMMON_CLK_SI570 is not set
# CONFIG_COMMON_CLK_CDCE925 is not set
CONFIG_COMMON_CLK_S2MPS11=y
# CONFIG_CLK_QORIQ is not set
# CONFIG_COMMON_CLK_PWM is not set
# CONFIG_COMMON_CLK_PXA is not set
# CONFIG_COMMON_CLK_CDCE706 is not set
CONFIG_COMMON_CLK_SAMSUNG=y

#
# Hardware Spinlock drivers
#

#
# Clock Source drivers
#
CONFIG_CLKSRC_OF=y
CONFIG_ARM_ARCH_TIMER=y
CONFIG_ARM_ARCH_TIMER_EVTSTREAM=y
# CONFIG_ARM_TIMER_SP804 is not set
# CONFIG_ATMEL_PIT is not set
CONFIG_CLKSRC_EXYNOS_MCT=y
CONFIG_CLKSRC_SAMSUNG_PWM=y
# CONFIG_SH_TIMER_CMT is not set
# CONFIG_SH_TIMER_MTU2 is not set
# CONFIG_SH_TIMER_TMU is not set
# CONFIG_EM_TIMER_STI is not set
# CONFIG_MAILBOX is not set
CONFIG_IOMMU_SUPPORT=y

#
# Generic IOMMU Pagetable Support
#
# CONFIG_IOMMU_IO_PGTABLE_LPAE is not set
# CONFIG_EXYNOS_IOMMU is not set
# CONFIG_ARM_SMMU is not set

#
# Remoteproc drivers
#
# CONFIG_STE_MODEM_RPROC is not set

#
# Rpmsg drivers
#

#
# SOC (System On Chip) specific Drivers
#
# CONFIG_SUNXI_SRAM is not set
# CONFIG_SOC_TI is not set
# CONFIG_PM_DEVFREQ is not set
CONFIG_EXTCON=y

#
# Extcon Device Drivers
#
# CONFIG_EXTCON_ADC_JACK is not set
# CONFIG_EXTCON_GPIO is not set
CONFIG_EXTCON_MAX14577=y
CONFIG_EXTCON_MAX77693=y
# CONFIG_EXTCON_MAX8997 is not set
# CONFIG_EXTCON_RT8973A is not set
# CONFIG_EXTCON_SM5502 is not set
# CONFIG_EXTCON_USB_GPIO is not set
# CONFIG_MEMORY is not set
CONFIG_IIO=y
# CONFIG_IIO_BUFFER is not set
# CONFIG_IIO_TRIGGER is not set

#
# Accelerometers
#
# CONFIG_BMA180 is not set
# CONFIG_BMC150_ACCEL is not set
# CONFIG_IIO_ST_ACCEL_3AXIS is not set
# CONFIG_KXSD9 is not set
# CONFIG_KXCJK1013 is not set
# CONFIG_MMA8452 is not set
# CONFIG_MMA9551 is not set
# CONFIG_MMA9553 is not set
# CONFIG_STK8312 is not set
# CONFIG_STK8BA50 is not set

#
# Analog to digital converters
#
# CONFIG_AD7266 is not set
# CONFIG_AD7291 is not set
# CONFIG_AD7298 is not set
# CONFIG_AD7476 is not set
# CONFIG_AD7791 is not set
# CONFIG_AD7793 is not set
# CONFIG_AD7887 is not set
# CONFIG_AD7923 is not set
# CONFIG_AD799X is not set
# CONFIG_CC10001_ADC is not set
CONFIG_EXYNOS_ADC=y
# CONFIG_MAX1027 is not set
# CONFIG_MAX1363 is not set
# CONFIG_MCP320X is not set
# CONFIG_MCP3422 is not set
# CONFIG_NAU7802 is not set
# CONFIG_TI_ADC081C is not set
# CONFIG_TI_ADC128S052 is not set
# CONFIG_VF610_ADC is not set

#
# Amplifiers
#
# CONFIG_AD8366 is not set

#
# Hid Sensor IIO Common
#

#
# SSP Sensor Common
#
# CONFIG_IIO_SSP_SENSORHUB is not set

#
# Digital to analog converters
#
# CONFIG_AD5064 is not set
# CONFIG_AD5360 is not set
# CONFIG_AD5380 is not set
# CONFIG_AD5421 is not set
# CONFIG_AD5446 is not set
# CONFIG_AD5449 is not set
# CONFIG_AD5504 is not set
# CONFIG_AD5624R_SPI is not set
# CONFIG_AD5686 is not set
# CONFIG_AD5755 is not set
# CONFIG_AD5764 is not set
# CONFIG_AD5791 is not set
# CONFIG_AD7303 is not set
# CONFIG_M62332 is not set
# CONFIG_MAX517 is not set
# CONFIG_MAX5821 is not set
# CONFIG_MCP4725 is not set
# CONFIG_MCP4922 is not set

#
# Frequency Synthesizers DDS/PLL
#

#
# Clock Generator/Distribution
#
# CONFIG_AD9523 is not set

#
# Phase-Locked Loop (PLL) frequency synthesizers
#
# CONFIG_ADF4350 is not set

#
# Digital gyroscope sensors
#
# CONFIG_ADIS16080 is not set
# CONFIG_ADIS16130 is not set
# CONFIG_ADIS16136 is not set
# CONFIG_ADIS16260 is not set
# CONFIG_ADXRS450 is not set
# CONFIG_BMG160 is not set
# CONFIG_IIO_ST_GYRO_3AXIS is not set
# CONFIG_ITG3200 is not set

#
# Humidity sensors
#
# CONFIG_DHT11 is not set
# CONFIG_SI7005 is not set
# CONFIG_SI7020 is not set

#
# Inertial measurement units
#
# CONFIG_ADIS16400 is not set
# CONFIG_ADIS16480 is not set
# CONFIG_KMX61 is not set
# CONFIG_INV_MPU6050_IIO is not set

#
# Light sensors
#
# CONFIG_ADJD_S311 is not set
# CONFIG_AL3320A is not set
# CONFIG_APDS9300 is not set
# CONFIG_BH1750 is not set
# CONFIG_CM32181 is not set
# CONFIG_CM3232 is not set
# CONFIG_CM3323 is not set
# CONFIG_CM36651 is not set
# CONFIG_GP2AP020A00F is not set
# CONFIG_ISL29125 is not set
# CONFIG_JSA1212 is not set
# CONFIG_RPR0521 is not set
# CONFIG_LTR501 is not set
# CONFIG_OPT3001 is not set
# CONFIG_PA12203001 is not set
# CONFIG_STK3310 is not set
# CONFIG_TCS3414 is not set
# CONFIG_TCS3472 is not set
# CONFIG_SENSORS_TSL2563 is not set
# CONFIG_TSL4531 is not set
# CONFIG_VCNL4000 is not set

#
# Magnetometer sensors
#
# CONFIG_AK8975 is not set
# CONFIG_AK09911 is not set
# CONFIG_MAG3110 is not set
# CONFIG_MMC35240 is not set
# CONFIG_IIO_ST_MAGN_3AXIS is not set
# CONFIG_BMC150_MAGN is not set

#
# Inclinometer sensors
#

#
# Pressure sensors
#
# CONFIG_BMP280 is not set
# CONFIG_MPL115 is not set
# CONFIG_MPL3115 is not set
# CONFIG_MS5611 is not set
# CONFIG_IIO_ST_PRESS is not set
# CONFIG_T5403 is not set

#
# Lightning sensors
#
# CONFIG_AS3935 is not set

#
# Proximity sensors
#
# CONFIG_SX9500 is not set

#
# Temperature sensors
#
# CONFIG_MLX90614 is not set
# CONFIG_TMP006 is not set
CONFIG_PWM=y
CONFIG_PWM_SYSFS=y
# CONFIG_PWM_FSL_FTM is not set
# CONFIG_PWM_PCA9685 is not set
CONFIG_PWM_SAMSUNG=y
CONFIG_IRQCHIP=y
CONFIG_ARM_GIC=y
CONFIG_GIC_NON_BANKED=y
# CONFIG_IPACK_BUS is not set
# CONFIG_RESET_CONTROLLER is not set
# CONFIG_FMC is not set

#
# PHY Subsystem
#
CONFIG_GENERIC_PHY=y
CONFIG_PHY_EXYNOS_MIPI_VIDEO=y
# CONFIG_PHY_PXA_28NM_HSIC is not set
# CONFIG_PHY_PXA_28NM_USB2 is not set
CONFIG_PHY_EXYNOS_DP_VIDEO=y
# CONFIG_BCM_KONA_USB2_PHY is not set
CONFIG_PHY_EXYNOS5250_SATA=y
CONFIG_PHY_SAMSUNG_USB2=y
CONFIG_PHY_EXYNOS4210_USB2=y
CONFIG_PHY_EXYNOS4X12_USB2=y
CONFIG_PHY_EXYNOS5250_USB2=y
CONFIG_PHY_EXYNOS5_USBDRD=y
# CONFIG_POWERCAP is not set
# CONFIG_MCB is not set

#
# Performance monitor support
#
# CONFIG_RAS is not set

#
# Android
#
# CONFIG_ANDROID is not set
# CONFIG_NVMEM is not set

#
# Firmware Drivers
#
# CONFIG_FIRMWARE_MEMMAP is not set

#
# File systems
#
CONFIG_DCACHE_WORD_ACCESS=y
CONFIG_EXT2_FS=y
# CONFIG_EXT2_FS_XATTR is not set
CONFIG_EXT3_FS=y
# CONFIG_EXT3_FS_POSIX_ACL is not set
# CONFIG_EXT3_FS_SECURITY is not set
CONFIG_EXT4_FS=y
# CONFIG_EXT4_FS_POSIX_ACL is not set
# CONFIG_EXT4_FS_SECURITY is not set
# CONFIG_EXT4_ENCRYPTION is not set
# CONFIG_EXT4_DEBUG is not set
CONFIG_JBD2=y
# CONFIG_JBD2_DEBUG is not set
CONFIG_FS_MBCACHE=y
# CONFIG_REISERFS_FS is not set
# CONFIG_JFS_FS is not set
# CONFIG_XFS_FS is not set
# CONFIG_GFS2_FS is not set
# CONFIG_BTRFS_FS is not set
# CONFIG_NILFS2_FS is not set
# CONFIG_F2FS_FS is not set
CONFIG_FS_POSIX_ACL=y
CONFIG_EXPORTFS=y
CONFIG_FILE_LOCKING=y
CONFIG_FSNOTIFY=y
CONFIG_DNOTIFY=y
CONFIG_INOTIFY_USER=y
# CONFIG_FANOTIFY is not set
# CONFIG_QUOTA is not set
# CONFIG_QUOTACTL is not set
# CONFIG_AUTOFS4_FS is not set
# CONFIG_FUSE_FS is not set
# CONFIG_OVERLAY_FS is not set

#
# Caches
#
# CONFIG_FSCACHE is not set

#
# CD-ROM/DVD Filesystems
#
# CONFIG_ISO9660_FS is not set
# CONFIG_UDF_FS is not set

#
# DOS/FAT/NT Filesystems
#
CONFIG_FAT_FS=y
CONFIG_MSDOS_FS=y
CONFIG_VFAT_FS=y
CONFIG_FAT_DEFAULT_CODEPAGE=437
CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
# CONFIG_NTFS_FS is not set

#
# Pseudo filesystems
#
CONFIG_PROC_FS=y
CONFIG_PROC_SYSCTL=y
CONFIG_PROC_PAGE_MONITOR=y
# CONFIG_PROC_CHILDREN is not set
CONFIG_KERNFS=y
CONFIG_SYSFS=y
CONFIG_TMPFS=y
CONFIG_TMPFS_POSIX_ACL=y
CONFIG_TMPFS_XATTR=y
# CONFIG_HUGETLB_PAGE is not set
# CONFIG_CONFIGFS_FS is not set
CONFIG_MISC_FILESYSTEMS=y
# CONFIG_ORANGEFS_FS is not set
# CONFIG_ADFS_FS is not set
# CONFIG_AFFS_FS is not set
# CONFIG_HFS_FS is not set
# CONFIG_HFSPLUS_FS is not set
# CONFIG_BEFS_FS is not set
# CONFIG_BFS_FS is not set
# CONFIG_EFS_FS is not set
# CONFIG_LOGFS is not set
CONFIG_CRAMFS=y
# CONFIG_SQUASHFS is not set
# CONFIG_VXFS_FS is not set
# CONFIG_MINIX_FS is not set
# CONFIG_OMFS_FS is not set
# CONFIG_HPFS_FS is not set
# CONFIG_QNX4FS_FS is not set
# CONFIG_QNX6FS_FS is not set
CONFIG_ROMFS_FS=y
CONFIG_ROMFS_BACKED_BY_BLOCK=y
CONFIG_ROMFS_ON_BLOCK=y
# CONFIG_PSTORE is not set
# CONFIG_SYSV_FS is not set
# CONFIG_UFS_FS is not set
CONFIG_NETWORK_FILESYSTEMS=y
CONFIG_NFS_FS=y
CONFIG_NFS_V2=y
CONFIG_NFS_V3=y
# CONFIG_NFS_V3_ACL is not set
# CONFIG_NFS_V4 is not set
# CONFIG_NFS_SWAP is not set
CONFIG_ROOT_NFS=y
# CONFIG_NFSD is not set
CONFIG_GRACE_PERIOD=y
CONFIG_LOCKD=y
CONFIG_LOCKD_V4=y
CONFIG_NFS_COMMON=y
CONFIG_SUNRPC=y
# CONFIG_SUNRPC_DEBUG is not set
# CONFIG_CEPH_FS is not set
# CONFIG_CIFS is not set
# CONFIG_NCP_FS is not set
# CONFIG_CODA_FS is not set
# CONFIG_AFS_FS is not set
CONFIG_NLS=y
CONFIG_NLS_DEFAULT="iso8859-1"
CONFIG_NLS_CODEPAGE_437=y
# CONFIG_NLS_CODEPAGE_737 is not set
# CONFIG_NLS_CODEPAGE_775 is not set
# CONFIG_NLS_CODEPAGE_850 is not set
# CONFIG_NLS_CODEPAGE_852 is not set
# CONFIG_NLS_CODEPAGE_855 is not set
# CONFIG_NLS_CODEPAGE_857 is not set
# CONFIG_NLS_CODEPAGE_860 is not set
# CONFIG_NLS_CODEPAGE_861 is not set
# CONFIG_NLS_CODEPAGE_862 is not set
# CONFIG_NLS_CODEPAGE_863 is not set
# CONFIG_NLS_CODEPAGE_864 is not set
# CONFIG_NLS_CODEPAGE_865 is not set
# CONFIG_NLS_CODEPAGE_866 is not set
# CONFIG_NLS_CODEPAGE_869 is not set
# CONFIG_NLS_CODEPAGE_936 is not set
# CONFIG_NLS_CODEPAGE_950 is not set
# CONFIG_NLS_CODEPAGE_932 is not set
# CONFIG_NLS_CODEPAGE_949 is not set
# CONFIG_NLS_CODEPAGE_874 is not set
# CONFIG_NLS_ISO8859_8 is not set
# CONFIG_NLS_CODEPAGE_1250 is not set
# CONFIG_NLS_CODEPAGE_1251 is not set
CONFIG_NLS_ASCII=y
CONFIG_NLS_ISO8859_1=y
# CONFIG_NLS_ISO8859_2 is not set
# CONFIG_NLS_ISO8859_3 is not set
# CONFIG_NLS_ISO8859_4 is not set
# CONFIG_NLS_ISO8859_5 is not set
# CONFIG_NLS_ISO8859_6 is not set
# CONFIG_NLS_ISO8859_7 is not set
# CONFIG_NLS_ISO8859_9 is not set
# CONFIG_NLS_ISO8859_13 is not set
# CONFIG_NLS_ISO8859_14 is not set
# CONFIG_NLS_ISO8859_15 is not set
# CONFIG_NLS_KOI8_R is not set
# CONFIG_NLS_KOI8_U is not set
# CONFIG_NLS_MAC_ROMAN is not set
# CONFIG_NLS_MAC_CELTIC is not set
# CONFIG_NLS_MAC_CENTEURO is not set
# CONFIG_NLS_MAC_CROATIAN is not set
# CONFIG_NLS_MAC_CYRILLIC is not set
# CONFIG_NLS_MAC_GAELIC is not set
# CONFIG_NLS_MAC_GREEK is not set
# CONFIG_NLS_MAC_ICELAND is not set
# CONFIG_NLS_MAC_INUIT is not set
# CONFIG_NLS_MAC_ROMANIAN is not set
# CONFIG_NLS_MAC_TURKISH is not set
# CONFIG_NLS_UTF8 is not set

#
# Kernel hacking
#

#
# printk and dmesg options
#
CONFIG_PRINTK_TIME=y
CONFIG_MESSAGE_LOGLEVEL_DEFAULT=4
# CONFIG_BOOT_PRINTK_DELAY is not set
CONFIG_DYNAMIC_DEBUG=y

#
# Compile-time checks and compiler options
#
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_INFO_REDUCED is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_GDB_SCRIPTS is not set
CONFIG_ENABLE_WARN_DEPRECATED=y
CONFIG_ENABLE_MUST_CHECK=y
CONFIG_FRAME_WARN=1024
# CONFIG_STRIP_ASM_SYMS is not set
# CONFIG_READABLE_ASM is not set
# CONFIG_UNUSED_SYMBOLS is not set
# CONFIG_PAGE_OWNER is not set
CONFIG_DEBUG_FS=y
# CONFIG_HEADERS_CHECK is not set
CONFIG_DEBUG_SECTION_MISMATCH=y
# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
CONFIG_MAGIC_SYSRQ=y
CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=0x1
CONFIG_DEBUG_KERNEL=y

#
# Memory Debugging
#
CONFIG_PAGE_EXTENSION=y
CONFIG_DEBUG_PAGEALLOC=y
CONFIG_PAGE_POISONING=y
# CONFIG_DEBUG_OBJECTS is not set
# CONFIG_SLUB_DEBUG_ON is not set
# CONFIG_SLUB_STATS is not set
CONFIG_HAVE_DEBUG_KMEMLEAK=y
# CONFIG_DEBUG_KMEMLEAK is not set
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_DEBUG_VM is not set
CONFIG_DEBUG_MEMORY_INIT=y
# CONFIG_DEBUG_PER_CPU_MAPS is not set
# CONFIG_DEBUG_HIGHMEM is not set
# CONFIG_DEBUG_SHIRQ is not set

#
# Debug Lockups and Hangs
#
CONFIG_LOCKUP_DETECTOR=y
# CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=0
CONFIG_DETECT_HUNG_TASK=y
CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=120
# CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=0
# CONFIG_PANIC_ON_OOPS is not set
CONFIG_PANIC_ON_OOPS_VALUE=0
CONFIG_PANIC_TIMEOUT=0
CONFIG_SCHED_DEBUG=y
# CONFIG_SCHED_INFO is not set
# CONFIG_SCHEDSTATS is not set
CONFIG_SCHED_STACK_END_CHECK=y
# CONFIG_DEBUG_TIMEKEEPING is not set
# CONFIG_TIMER_STATS is not set
CONFIG_DEBUG_PREEMPT=y

#
# Lock Debugging (spinlocks, mutexes, etc...)
#
CONFIG_DEBUG_RT_MUTEXES=y
CONFIG_DEBUG_SPINLOCK=y
CONFIG_DEBUG_MUTEXES=y
# CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
CONFIG_DEBUG_LOCK_ALLOC=y
CONFIG_PROVE_LOCKING=y
CONFIG_LOCKDEP=y
# CONFIG_LOCK_STAT is not set
# CONFIG_DEBUG_LOCKDEP is not set
CONFIG_DEBUG_ATOMIC_SLEEP=y
# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
# CONFIG_LOCK_TORTURE_TEST is not set
CONFIG_TRACE_IRQFLAGS=y
CONFIG_STACKTRACE=y
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_BUGVERBOSE=y
CONFIG_DEBUG_LIST=y
# CONFIG_DEBUG_PI_LIST is not set
# CONFIG_DEBUG_SG is not set
CONFIG_DEBUG_NOTIFIERS=y
# CONFIG_DEBUG_CREDENTIALS is not set

#
# RCU Debugging
#
CONFIG_PROVE_RCU=y
# CONFIG_PROVE_RCU_REPEATEDLY is not set
CONFIG_SPARSE_RCU_POINTER=y
# CONFIG_TORTURE_TEST is not set
# CONFIG_RCU_TORTURE_TEST is not set
CONFIG_RCU_CPU_STALL_TIMEOUT=21
# CONFIG_RCU_TRACE is not set
# CONFIG_RCU_EQS_DEBUG is not set
# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
# CONFIG_NOTIFIER_ERROR_INJECTION is not set
# CONFIG_FAULT_INJECTION is not set
CONFIG_HAVE_FUNCTION_TRACER=y
CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
CONFIG_HAVE_DYNAMIC_FTRACE=y
CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
CONFIG_HAVE_SYSCALL_TRACEPOINTS=y
CONFIG_HAVE_C_RECORDMCOUNT=y
CONFIG_TRACING_SUPPORT=y
CONFIG_FTRACE=y
# CONFIG_FUNCTION_TRACER is not set
# CONFIG_IRQSOFF_TRACER is not set
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_SCHED_TRACER is not set
# CONFIG_ENABLE_DEFAULT_TRACERS is not set
# CONFIG_FTRACE_SYSCALLS is not set
# CONFIG_TRACER_SNAPSHOT is not set
CONFIG_BRANCH_PROFILE_NONE=y
# CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
# CONFIG_PROFILE_ALL_BRANCHES is not set
# CONFIG_STACK_TRACER is not set
# CONFIG_BLK_DEV_IO_TRACE is not set
# CONFIG_PROBE_EVENTS is not set
# CONFIG_TRACEPOINT_BENCHMARK is not set

#
# Runtime Testing
#
# CONFIG_LKDTM is not set
# CONFIG_TEST_LIST_SORT is not set
# CONFIG_BACKTRACE_SELF_TEST is not set
# CONFIG_RBTREE_TEST is not set
# CONFIG_INTERVAL_TREE_TEST is not set
# CONFIG_PERCPU_TEST is not set
# CONFIG_ATOMIC64_SELFTEST is not set
# CONFIG_TEST_HEXDUMP is not set
# CONFIG_TEST_STRING_HELPERS is not set
# CONFIG_TEST_PARSE_INTEGER is not set
# CONFIG_TEST_KSTRTOX is not set
# CONFIG_TEST_RHASHTABLE is not set
# CONFIG_DMA_API_DEBUG is not set
# CONFIG_TEST_LKM is not set
# CONFIG_TEST_USER_COPY is not set
# CONFIG_TEST_BPF is not set
# CONFIG_TEST_FIRMWARE is not set
# CONFIG_TEST_UDELAY is not set
# CONFIG_MEMTEST is not set
# CONFIG_TEST_STATIC_KEYS is not set
# CONFIG_SAMPLES is not set
CONFIG_HAVE_ARCH_KGDB=y
# CONFIG_KGDB is not set
# CONFIG_ARM_PTDUMP is not set
# CONFIG_STRICT_DEVMEM is not set
CONFIG_ARM_UNWIND=y
CONFIG_DEBUG_USER=y
# CONFIG_DEBUG_LL is not set
CONFIG_DEBUG_LL_INCLUDE="mach/debug-macro.S"
# CONFIG_DEBUG_UART_8250 is not set
# CONFIG_DEBUG_UART_BCM63XX is not set
CONFIG_UNCOMPRESS_INCLUDE="debug/uncompress.h"
# CONFIG_PID_IN_CONTEXTIDR is not set
# CONFIG_DEBUG_SET_MODULE_RONX is not set
# CONFIG_CORESIGHT is not set

#
# Security options
#
# CONFIG_KEYS is not set
# CONFIG_SECURITY_DMESG_RESTRICT is not set
# CONFIG_SECURITY is not set
CONFIG_SECURITYFS=y
CONFIG_DEFAULT_SECURITY_DAC=y
CONFIG_DEFAULT_SECURITY=""
CONFIG_CRYPTO=y

#
# Crypto core or helper
#
CONFIG_CRYPTO_ALGAPI=y
CONFIG_CRYPTO_ALGAPI2=y
CONFIG_CRYPTO_AEAD=m
CONFIG_CRYPTO_AEAD2=y
CONFIG_CRYPTO_BLKCIPHER=y
CONFIG_CRYPTO_BLKCIPHER2=y
CONFIG_CRYPTO_HASH=y
CONFIG_CRYPTO_HASH2=y
CONFIG_CRYPTO_RNG=m
CONFIG_CRYPTO_RNG2=y
CONFIG_CRYPTO_RNG_DEFAULT=m
CONFIG_CRYPTO_PCOMP2=y
CONFIG_CRYPTO_AKCIPHER2=y
# CONFIG_CRYPTO_RSA is not set
CONFIG_CRYPTO_MANAGER=y
CONFIG_CRYPTO_MANAGER2=y
# CONFIG_CRYPTO_USER is not set
CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y
# CONFIG_CRYPTO_GF128MUL is not set
CONFIG_CRYPTO_NULL=m
CONFIG_CRYPTO_NULL2=y
# CONFIG_CRYPTO_PCRYPT is not set
CONFIG_CRYPTO_WORKQUEUE=y
# CONFIG_CRYPTO_CRYPTD is not set
# CONFIG_CRYPTO_MCRYPTD is not set
# CONFIG_CRYPTO_AUTHENC is not set
# CONFIG_CRYPTO_TEST is not set

#
# Authenticated Encryption with Associated Data
#
# CONFIG_CRYPTO_CCM is not set
# CONFIG_CRYPTO_GCM is not set
# CONFIG_CRYPTO_CHACHA20POLY1305 is not set
# CONFIG_CRYPTO_SEQIV is not set
CONFIG_CRYPTO_ECHAINIV=m

#
# Block modes
#
CONFIG_CRYPTO_CBC=y
# CONFIG_CRYPTO_CTR is not set
# CONFIG_CRYPTO_CTS is not set
# CONFIG_CRYPTO_ECB is not set
# CONFIG_CRYPTO_LRW is not set
# CONFIG_CRYPTO_PCBC is not set
# CONFIG_CRYPTO_XTS is not set

#
# Hash modes
#
# CONFIG_CRYPTO_CMAC is not set
CONFIG_CRYPTO_HMAC=m
# CONFIG_CRYPTO_XCBC is not set
# CONFIG_CRYPTO_VMAC is not set

#
# Digest
#
CONFIG_CRYPTO_CRC32C=y
# CONFIG_CRYPTO_CRC32 is not set
# CONFIG_CRYPTO_CRCT10DIF is not set
# CONFIG_CRYPTO_GHASH is not set
# CONFIG_CRYPTO_POLY1305 is not set
# CONFIG_CRYPTO_MD4 is not set
# CONFIG_CRYPTO_MD5 is not set
# CONFIG_CRYPTO_MICHAEL_MIC is not set
# CONFIG_CRYPTO_RMD128 is not set
# CONFIG_CRYPTO_RMD160 is not set
# CONFIG_CRYPTO_RMD256 is not set
# CONFIG_CRYPTO_RMD320 is not set
# CONFIG_CRYPTO_SHA1 is not set
CONFIG_CRYPTO_SHA256=y
# CONFIG_CRYPTO_SHA512 is not set
# CONFIG_CRYPTO_TGR192 is not set
# CONFIG_CRYPTO_WP512 is not set

#
# Ciphers
#
CONFIG_CRYPTO_AES=y
# CONFIG_CRYPTO_ANUBIS is not set
# CONFIG_CRYPTO_ARC4 is not set
# CONFIG_CRYPTO_BLOWFISH is not set
# CONFIG_CRYPTO_CAMELLIA is not set
# CONFIG_CRYPTO_CAST5 is not set
# CONFIG_CRYPTO_CAST6 is not set
# CONFIG_CRYPTO_DES is not set
# CONFIG_CRYPTO_FCRYPT is not set
# CONFIG_CRYPTO_KHAZAD is not set
# CONFIG_CRYPTO_SALSA20 is not set
# CONFIG_CRYPTO_CHACHA20 is not set
# CONFIG_CRYPTO_SEED is not set
# CONFIG_CRYPTO_SERPENT is not set
# CONFIG_CRYPTO_TEA is not set
# CONFIG_CRYPTO_TWOFISH is not set

#
# Compression
#
# CONFIG_CRYPTO_DEFLATE is not set
# CONFIG_CRYPTO_ZLIB is not set
# CONFIG_CRYPTO_LZO is not set
# CONFIG_CRYPTO_842 is not set
# CONFIG_CRYPTO_LZ4 is not set
# CONFIG_CRYPTO_LZ4HC is not set

#
# Random Number Generation
#
# CONFIG_CRYPTO_ANSI_CPRNG is not set
CONFIG_CRYPTO_DRBG_MENU=m
CONFIG_CRYPTO_DRBG_HMAC=y
# CONFIG_CRYPTO_DRBG_HASH is not set
# CONFIG_CRYPTO_DRBG_CTR is not set
CONFIG_CRYPTO_DRBG=m
CONFIG_CRYPTO_JITTERENTROPY=m
# CONFIG_CRYPTO_USER_API_HASH is not set
# CONFIG_CRYPTO_USER_API_SKCIPHER is not set
# CONFIG_CRYPTO_USER_API_RNG is not set
# CONFIG_CRYPTO_USER_API_AEAD is not set
CONFIG_CRYPTO_HW=y
# CONFIG_CRYPTO_DEV_S5P is not set

#
# Certificates for signature checking
#
# CONFIG_ARM_CRYPTO is not set
# CONFIG_BINARY_PRINTF is not set

#
# Library routines
#
CONFIG_BITREVERSE=y
CONFIG_HAVE_ARCH_BITREVERSE=y
CONFIG_GENERIC_STRNCPY_FROM_USER=y
CONFIG_GENERIC_STRNLEN_USER=y
CONFIG_GENERIC_NET_UTILS=y
CONFIG_GENERIC_PCI_IOMAP=y
CONFIG_GENERIC_IO=y
CONFIG_ARCH_USE_CMPXCHG_LOCKREF=y
CONFIG_CRC_CCITT=y
CONFIG_CRC16=y
# CONFIG_CRC_T10DIF is not set
CONFIG_CRC_ITU_T=y
CONFIG_CRC32=y
# CONFIG_CRC32_SELFTEST is not set
CONFIG_CRC32_SLICEBY8=y
# CONFIG_CRC32_SLICEBY4 is not set
# CONFIG_CRC32_SARWATE is not set
# CONFIG_CRC32_BIT is not set
# CONFIG_CRC7 is not set
# CONFIG_LIBCRC32C is not set
# CONFIG_CRC8 is not set
# CONFIG_CRC64_ECMA is not set
# CONFIG_AUDIT_ARCH_COMPAT_GENERIC is not set
# CONFIG_RANDOM32_SELFTEST is not set
CONFIG_ZLIB_INFLATE=y
CONFIG_LZO_COMPRESS=y
CONFIG_LZO_DECOMPRESS=y
CONFIG_LZ4_DECOMPRESS=y
CONFIG_XZ_DEC=y
CONFIG_XZ_DEC_X86=y
CONFIG_XZ_DEC_POWERPC=y
CONFIG_XZ_DEC_IA64=y
CONFIG_XZ_DEC_ARM=y
CONFIG_XZ_DEC_ARMTHUMB=y
CONFIG_XZ_DEC_SPARC=y
CONFIG_XZ_DEC_BCJ=y
# CONFIG_XZ_DEC_TEST is not set
CONFIG_DECOMPRESS_GZIP=y
CONFIG_DECOMPRESS_BZIP2=y
CONFIG_DECOMPRESS_LZMA=y
CONFIG_DECOMPRESS_XZ=y
CONFIG_DECOMPRESS_LZO=y
CONFIG_DECOMPRESS_LZ4=y
CONFIG_GENERIC_ALLOCATOR=y
CONFIG_HAS_IOMEM=y
CONFIG_HAS_DMA=y
CONFIG_CPU_RMAP=y
CONFIG_DQL=y
CONFIG_NLATTR=y
CONFIG_ARCH_HAS_ATOMIC64_DEC_IF_POSITIVE=y
# CONFIG_CORDIC is not set
# CONFIG_DDR is not set
CONFIG_LIBFDT=y
CONFIG_FONT_SUPPORT=y
CONFIG_FONTS=y
# CONFIG_FONT_8x8 is not set
# CONFIG_FONT_8x16 is not set
# CONFIG_FONT_6x11 is not set
CONFIG_FONT_7x14=y
# CONFIG_FONT_PEARL_8x8 is not set
# CONFIG_FONT_ACORN_8x8 is not set
# CONFIG_FONT_MINI_4x6 is not set
# CONFIG_FONT_6x10 is not set
# CONFIG_FONT_SUN8x16 is not set
# CONFIG_FONT_SUN12x22 is not set
# CONFIG_FONT_10x18 is not set
# CONFIG_SG_SPLIT is not set
CONFIG_ARCH_HAS_SG_CHAIN=y
# CONFIG_VIRTUALIZATION is not set

--------------040505090800000202050801
Content-Type: text/plain; charset=UTF-8;
 name="trats2-serial-lockdep-issue-dmesg.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="trats2-serial-lockdep-issue-dmesg.txt"

[    0.000000] Booting Linux on physical CPU 0xa00
[    0.000000] Linux version 4.2.0-next-20150910-00009-g65fd5a9cff54 (kozik@kk-ubuntu) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) ) #218 SMP PREEMPT Fri Sep 11 14:53:16 KST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] Machine model: Samsung Trats 2 based on Exynos4412
[    0.000000] cma: Reserved 64 MiB at 0x7bc00000
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] Samsung CPU ID: 0xe4412211
[    0.000000] On node 0 totalpages: 261888
[    0.000000] free_area_init_node: node 0, pgdat c08fd640, node_mem_map eeff6000
[    0.000000]   Normal zone: 1520 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 194560 pages, LIFO batch:31
[    0.000000]   HighMem zone: 67328 pages, LIFO batch:15
[    0.000000] Running under secure firmware.
[    0.000000] PERCPU: Embedded 12 pages/cpu @eef68000 s19776 r8192 d21184 u49152
[    0.000000] pcpu-alloc: s19776 r8192 d21184 u49152 alloc=12*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 [0] 2 [0] 3
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 260368
[    0.000000] Kernel command line: root=/dev/mmcblk0p11 rw rootfstype=ext4 rootwait console=ttySAC2,115200n8 fbmem=24M@0x52000000 normal lcd=s6e8ax0 pmic_info=3 resume=179:3 csa=/dev/mmcblk0p4 bootloader_log=1067@0x43908010
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 954888K/1047552K available (6224K kernel code, 319K rwdata, 2244K rodata, 432K init, 8224K bss, 27128K reserved, 65536K cma-reserved, 203776K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0000000 - 0xff000000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xef800000   ( 760 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc084d364   (8469 kB)
[    0.000000]       .init : 0xc084e000 - 0xc08ba000   ( 432 kB)
[    0.000000]       .data : 0xc08ba000 - 0xc0909cb8   ( 320 kB)
[    0.000000]        .bss : 0xc090c000 - 0xc1114208   (8225 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Running RCU self tests
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  RCU lockdep checking is enabled.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=4
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] GIC physical location is 0x10490000
[    0.000000] L2C: platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C: platform provided aux values permit register corruption.
[    0.000000] L2C: DT/platform modifies aux control register: 0x02070000 -> 0x3e470001
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310: enabling full line of zeros but not enabled in Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 8 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 16 ways, 1024 kB
[    0.000000] L2C-310: CACHE_ID 0x4100c4c8, AUX_CTRL 0x7e470001
[    0.000000] Exynos4x12 clocks: sclk_apll = 800000000, sclk_mpll = 800000000
[    0.000000]  sclk_epll = 96000000, sclk_vpll = 108000000, arm_clk = 800000000
[    0.000000] Switching to timer-based delay loop, resolution 41ns
[    0.000000] clocksource: mct-frc: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 79635851949 ns
[    0.000006] sched_clock: 32 bits at 24MHz, resolution 41ns, wraps every 89478484971ns
[    0.000497] Console: colour dummy device 80x30
[    0.000538] Lock dependency validator: Copyright (c) 2006 Red Hat, Inc., Ingo Molnar
[    0.000547] ... MAX_LOCKDEP_SUBCLASSES:  8
[    0.000555] ... MAX_LOCK_DEPTH:          48
[    0.000563] ... MAX_LOCKDEP_KEYS:        8191
[    0.000571] ... CLASSHASH_SIZE:          4096
[    0.000578] ... MAX_LOCKDEP_ENTRIES:     32768
[    0.000585] ... MAX_LOCKDEP_CHAINS:      65536
[    0.000593] ... CHAINHASH_SIZE:          32768
[    0.000600]  memory used by lock dependency info: 5167 kB
[    0.000608]  per task-struct memory footprint: 1536 bytes
[    0.000649] Calibrating delay loop (skipped), value calculated using timer frequency.. 48.00 BogoMIPS (lpj=120000)
[    0.000666] pid_max: default: 32768 minimum: 301
[    0.000983] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000999] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.003505] CPU: Testing write buffer coherency: ok
[    0.004830] CPU0: thread -1, cpu 0, socket 10, mpidr 80000a00
[    0.005800] Setting up static identity map for 0x40008280 - 0x400082d8
[    0.050602] CPU1: thread -1, cpu 1, socket 10, mpidr 80000a01
[    0.065406] CPU2: thread -1, cpu 2, socket 10, mpidr 80000a02
[    0.080391] CPU3: thread -1, cpu 3, socket 10, mpidr 80000a03
[    0.080588] Brought up 4 CPUs
[    0.080613] SMP: Total of 4 processors activated (192.00 BogoMIPS).
[    0.080623] CPU: All CPU(s) started in SVC mode.
[    0.083626] devtmpfs: initialized
[    0.167847] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.168941] lcd0-power-domain@10023C80 has as child subdomain: tv-power-domain@10023C20.
[    0.170804] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.173499] pinctrl core: initialized pinctrl subsystem
[    0.178555] NET: Registered protocol family 16
[    0.182542] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.200132] cpuidle: using governor ladder
[    0.215043] cpuidle: using governor menu
[    0.217894] exynos-audss-clk 3810000.clock-controller: setup completed
[    0.260751] gpiochip_add: registered GPIOs 0 to 7 on device: gpa0
[    0.261227] gpiochip_add: registered GPIOs 8 to 13 on device: gpa1
[    0.261700] gpiochip_add: registered GPIOs 14 to 21 on device: gpb
[    0.262159] gpiochip_add: registered GPIOs 22 to 26 on device: gpc0
[    0.262633] gpiochip_add: registered GPIOs 27 to 31 on device: gpc1
[    0.263091] gpiochip_add: registered GPIOs 32 to 35 on device: gpd0
[    0.263550] gpiochip_add: registered GPIOs 36 to 39 on device: gpd1
[    0.264021] gpiochip_add: registered GPIOs 40 to 47 on device: gpf0
[    0.264488] gpiochip_add: registered GPIOs 48 to 55 on device: gpf1
[    0.265053] gpiochip_add: registered GPIOs 56 to 63 on device: gpf2
[    0.265554] gpiochip_add: registered GPIOs 64 to 69 on device: gpf3
[    0.266029] gpiochip_add: registered GPIOs 70 to 77 on device: gpj0
[    0.266491] gpiochip_add: registered GPIOs 78 to 82 on device: gpj1
[    0.273037] gpiochip_add: registered GPIOs 83 to 89 on device: gpk0
[    0.273508] gpiochip_add: registered GPIOs 90 to 96 on device: gpk1
[    0.273982] gpiochip_add: registered GPIOs 97 to 103 on device: gpk2
[    0.274455] gpiochip_add: registered GPIOs 104 to 110 on device: gpk3
[    0.274927] gpiochip_add: registered GPIOs 111 to 117 on device: gpl0
[    0.275519] gpiochip_add: registered GPIOs 118 to 119 on device: gpl1
[    0.275987] gpiochip_add: registered GPIOs 120 to 127 on device: gpl2
[    0.276459] gpiochip_add: registered GPIOs 128 to 135 on device: gpm0
[    0.276914] gpiochip_add: registered GPIOs 136 to 142 on device: gpm1
[    0.277377] gpiochip_add: registered GPIOs 143 to 147 on device: gpm2
[    0.277845] gpiochip_add: registered GPIOs 148 to 155 on device: gpm3
[    0.278317] gpiochip_add: registered GPIOs 156 to 163 on device: gpm4
[    0.278771] gpiochip_add: registered GPIOs 164 to 169 on device: gpy0
[    0.279225] gpiochip_add: registered GPIOs 170 to 173 on device: gpy1
[    0.279696] gpiochip_add: registered GPIOs 174 to 179 on device: gpy2
[    0.280261] gpiochip_add: registered GPIOs 180 to 187 on device: gpy3
[    0.280732] gpiochip_add: registered GPIOs 188 to 195 on device: gpy4
[    0.281191] gpiochip_add: registered GPIOs 196 to 203 on device: gpy5
[    0.281655] gpiochip_add: registered GPIOs 204 to 211 on device: gpy6
[    0.282114] gpiochip_add: registered GPIOs 212 to 219 on device: gpx0
[    0.282574] gpiochip_add: registered GPIOs 220 to 227 on device: gpx1
[    0.283044] gpiochip_add: registered GPIOs 228 to 235 on device: gpx2
[    0.283501] gpiochip_add: registered GPIOs 236 to 243 on device: gpx3
[    0.292796] gpiochip_add: registered GPIOs 244 to 250 on device: gpz
[    0.294934] gpiochip_add: registered GPIOs 251 to 258 on device: gpv0
[    0.295542] gpiochip_add: registered GPIOs 259 to 266 on device: gpv1
[    0.296004] gpiochip_add: registered GPIOs 267 to 274 on device: gpv2
[    0.296471] gpiochip_add: registered GPIOs 275 to 282 on device: gpv3
[    0.296952] gpiochip_add: registered GPIOs 283 to 284 on device: gpv4
[    0.381187] of_get_named_gpiod_flags: parsed 'gpio' property of node '/regulators/voltage-regulator-1[0]' - status (0)
[    0.382294] of_get_named_gpiod_flags: parsed 'gpio' property of node '/regulators/voltage-regulator-2[0]' - status (0)
[    0.383313] of_get_named_gpiod_flags: parsed 'gpio' property of node '/regulators/voltage-regulator-3[0]' - status (0)
[    0.384174] of_get_named_gpiod_flags: parsed 'gpio' property of node '/regulators/voltage-regulator-5[0]' - status (0)
[    0.389029] SCSI subsystem initialized
[    0.389887] usbcore: registered new interface driver usbfs
[    0.390179] usbcore: registered new interface driver hub
[    0.390436] usbcore: registered new device driver usb
[    0.391477] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-1[0]' - status (0)
[    0.391535] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-1[1]' - status (0)
[    0.394419] max77693 11-0066: device ID: 0x4
[    0.412107] i2c-gpio i2c-gpio-1: using pins 143 (SDA) and 144 (SCL)
[    0.412325] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-3[0]' - status (0)
[    0.412366] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-3[1]' - status (0)
[    0.413324] i2c-gpio i2c-gpio-3: using pins 53 (SDA) and 52 (SCL)
[    0.413561] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-0[0]' - status (0)
[    0.413618] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-0[1]' - status (0)
[    0.414572] i2c-gpio i2c-gpio-0: using pins 178 (SDA) and 179 (SCL)
[    0.414756] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-2[0]' - status (0)
[    0.414798] of_get_named_gpiod_flags: parsed 'gpios' property of node '/i2c-gpio-2[1]' - status (0)
[    0.415810] i2c-gpio i2c-gpio-2: using pins 40 (SDA) and 41 (SCL)
[    0.416691] s3c-i2c 13860000.i2c: slave address 0x10
[    0.416712] s3c-i2c 13860000.i2c: bus frequency set to 390 KHz
[    0.417785] s3c-i2c 13860000.i2c: i2c-0: S3C I2C adapter
[    0.418183] s3c-i2c 13890000.i2c: slave address 0x10
[    0.418203] s3c-i2c 13890000.i2c: bus frequency set to 390 KHz
[    0.419217] s3c-i2c 13890000.i2c: i2c-3: S3C I2C adapter
[    0.419594] s3c-i2c 138a0000.i2c: slave address 0x10
[    0.419613] s3c-i2c 138a0000.i2c: bus frequency set to 97 KHz
[    0.420690] s3c-i2c 138a0000.i2c: i2c-4: S3C I2C adapter
[    0.421086] s3c-i2c 138d0000.i2c: slave address 0x10
[    0.421105] s3c-i2c 138d0000.i2c: bus frequency set to 97 KHz
[    0.480144] of_get_named_gpiod_flags: can't parse 'maxim,ena-gpios' property of node '/i2c@138D0000/max77686_pmic@09/voltage-regulators/ldo20[0]'
[    0.482074] of_get_named_gpiod_flags: parsed 'maxim,ena-gpios' property of node '/i2c@138D0000/max77686_pmic@09/voltage-regulators/ldo21[0]' - status (0)
[    0.484528] of_get_named_gpiod_flags: parsed 'maxim,ena-gpios' property of node '/i2c@138D0000/max77686_pmic@09/voltage-regulators/ldo22[0]' - status (0)
[    0.513512] of_get_named_gpiod_flags: parsed 'maxim,ena-gpios' property of node '/i2c@138D0000/max77686_pmic@09/voltage-regulators/buck8[0]' - status (0)
[    0.515979] of_get_named_gpiod_flags: parsed 'maxim,ena-gpios' property of node '/i2c@138D0000/max77686_pmic@09/voltage-regulators/buck9[0]' - status (0)
[    0.519138] s3c-i2c 138d0000.i2c: i2c-7: S3C I2C adapter
[    0.521830] Advanced Linux Sound Architecture Driver Init[   23.043010] max77693-muic max77693-muic: external connector is attached (adc:0x1c, prev_adc:0x1c)
[   23.050808] max77693-muic max77693-muic: external connector is attached (adc:0x1c)
ia[   23.059625] max77693-muic max77693-muic: CONTROL1 : 0x1b, CONTROL2 : 0x04, state : attached
lized.
[    0.527181] clocksource: Switched to clocksource mct-frc
[    0.567222] NET: Registered protocol family 2
[    0.569223] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.569376] TCP bind hash table entries: 8192 (order: 6, 294912 bytes)
[    0.571828] TCP: Hash tables configured (established 8192 bind 8192)
[    0.572036] UDP hash table entries: 512 (order: 3, 40960 bytes)
[    0.572426] UDP-Lite hash table entries: 512 (order: 3, 40960 bytes)
[    0.573492] NET: Registered protocol family 1
[    0.574739] RPC: Registered named UNIX socket transport module.
[    0.574754] RPC: Registered udp transport module.
[    0.574765] RPC: Registered tcp transport module.
[    0.574776] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.580895] futex hash table entries: 1024 (order: 4, 65536 bytes)
[    0.621297] romfs: ROMFS MTD (C) 2007 Red Hat, Inc.
[    0.624572] bounce: pool size: 64 pages
[    0.624672] io scheduler noop registered
[    0.624693] io scheduler deadline registered
[    0.624785] io scheduler cfq registered (default)
[    0.647897] dma-pl330 12680000.pdma: Loaded driver for PL330 DMAC-141330
[    0.647918] dma-pl330 12680000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.659994] dma-pl330 12690000.pdma: Loaded driver for PL330 DMAC-141330
[    0.660014] dma-pl330 12690000.pdma:         DBUFF-32x4bytes Num_Chans-8 Num_Peri-32 Num_Events-32
[    0.663530] dma-pl330 12850000.mdma: Loaded driver for PL330 DMAC-141330
[    0.663549] dma-pl330 12850000.mdma:         DBUFF-64x8bytes Num_Chans-8 Num_Peri-1 Num_Events-32
[    0.884779] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.890839] 13800000.serial: ttySAC0 at MMIO 0x13800000 (irq = 57, base_baud = 0) is a S3C6400/10
[    0.892730] 13810000.serial: ttySAC1 at MMIO 0x13810000 (irq = 58, base_baud = 0) is a S3C6400/10
[    0.894100] 13820000.serial: ttySAC2 at MMIO 0x13820000 (irq = 59, base_baud = 0) is a S3C6400/10
[    1.704287] console [ttySAC2] enabled
[    1.708863] 13830000.serial: ttySAC3 at MMIO 0x13830000 (irq = 60, base_baud = 0) is a S3C6400/10
[    1.720232] [drm] Initialized drm 1.1.0 20060810
[    1.739028] exynos-drm exynos-drm: bound 11c00000.fimd (ops fimd_component_ops)
[    1.746490] exynos-drm exynos-drm: bound 11c80000.dsi (ops exynos_dsi_component_ops)
[    1.752805] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    1.759374] [drm] No driver support for vblank timestamp query.
[    1.765501] [drm] Initialized exynos 1.0.0 20110530 on minor 0
[    1.773824] panel-samsung-s6e8aa0 11c80000.dsi.0: GPIO lookup for consumer reset
[    1.773841] panel-samsung-s6e8aa0 11c80000.dsi.0: using device tree for GPIO lookup
[    1.773904] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node '/dsi@11C80000/panel@0[0]' - status (0)
[    1.987611] panel-samsung-s6e8aa0 11c80000.dsi.0: ID: 0xa2, 0x60, 0x90
[    2.184770] Console: switching to colour frame buffer device 102x91
[    2.228096] exynos-drm exynos-drm: fb0:  frame buffer device
[    2.300693] brd: module loaded
[    2.359373] loop: module loaded
[    2.362829] s3c64xx-spi 13930000.spi: spi bus clock parent not specified, using clock at index 0 as parent
[    2.371165] s3c64xx-spi 13930000.spi: number of chip select lines not specified, assuming 1 chip select line
[    2.381446] of_get_named_gpiod_flags: parsed 'cs-gpios' property of node '/spi@13930000[0]' - status (0)
[    2.385662] usbcore: registered new interface driver asix
[    2.389787] usbcore: registered new interface driver ax88179_178a
[    2.396025] usbcore: registered new interface driver cdc_ether
[    2.401924] usbcore: registered new interface driver smsc75xx
[    2.407580] usbcore: registered new interface driver smsc95xx
[    2.413263] usbcore: registered new interface driver net1080
[    2.418906] usbcore: registered new interface driver cdc_subset
[    2.424806] usbcore: registered new interface driver zaurus
[    2.430435] usbcore: registered new interface driver cdc_ncm
[    2.437853] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.443085] ehci-exynos: EHCI EXYNOS driver
[    2.447812] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.453343] ohci-exynos: OHCI EXYNOS driver
[    2.458420] usbcore: registered new interface driver usb-storage
[    2.466287] mousedev: PS/2 mouse device common for all mice
[    2.473490] max77686-rtc max77686-rtc: max77686_rtc_probe
[    2.579351] max77686-rtc max77686-rtc: rtc core: registered max77686-rtc as rtc0
[    2.588368] s3c-rtc 10070000.rtc: failed to find rtc source clock
[    2.594138] i2c /dev entries driver
[    2.682295] thermal thermal_zone0: failed to read out thermal zone (-22)
[    2.691501] device-mapper: ioctl: 4.33.0-ioctl (2015-8-18) initialised: dm-devel@redhat.com
[    2.714818] sdhci: Secure Digital Host Controller Interface driver
[    2.719562] sdhci: Copyright(c) Pierre Ossman
[    2.724501] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/sdhci@12530000[0]' - status (0)
[    2.724663] s3c-sdhci 12530000.sdhci: clock source 2: mmc_busclk.2 (50000000 Hz)
[    2.731360] s3c-sdhci 12530000.sdhci: GPIO lookup for consumer cd
[    2.731369] s3c-sdhci 12530000.sdhci: using device tree for GPIO lookup
[    2.731405] of_get_named_gpiod_flags: parsed 'cd-gpios' property of node '/sdhci@12530000[0]' - status (0)
[    2.731435] s3c-sdhci 12530000.sdhci: Got CD GPIO
[    2.735966] s3c-sdhci 12530000.sdhci: GPIO lookup for consumer wp
[    2.735975] s3c-sdhci 12530000.sdhci: using device tree for GPIO lookup
[    2.735984] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/sdhci@12530000[0]'
[    2.735993] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/sdhci@12530000[0]'
[    2.736000] s3c-sdhci 12530000.sdhci: using lookup tables for GPIO lookup
[    2.736092] s3c-sdhci 12530000.sdhci: lookup for GPIO wp failed
[    2.736579] s3c-sdhci 12530000.sdhci: No vqmmc regulator found
[    2.772400] mmc0: SDHCI controller on samsung-hsmmc [12530000.sdhci] using ADMA
[    2.778582] Synopsys Designware Multimedia Card Interface Driver
[    2.785545] dwmmc_exynos 12550000.mmc: IDMAC supports 32-bit address mode.
[    2.791240] dwmmc_exynos 12550000.mmc: Using internal DMA controller.
[    2.797584] dwmmc_exynos 12550000.mmc: Version ID is 240a
[    2.802985] dwmmc_exynos 12550000.mmc: DW MMC controller at irq 114,32 bit host data width,128 deep fifo
[    2.812721] dwmmc_exynos 12550000.mmc: No vqmmc regulator found
[    2.818330] dwmmc_exynos 12550000.mmc: GPIO lookup for consumer wp
[    2.818339] dwmmc_exynos 12550000.mmc: using device tree for GPIO lookup
[    2.818350] of_get_named_gpiod_flags: can't parse 'wp-gpios' property of node '/mmc@12550000[0]'
[    2.818359] of_get_named_gpiod_flags: can't parse 'wp-gpio' property of node '/mmc@12550000[0]'
[    2.818367] dwmmc_exynos 12550000.mmc: using lookup tables for GPIO lookup
[    2.818377] dwmmc_exynos 12550000.mmc: lookup for GPIO wp failed
[    2.847254] dwmmc_exynos 12550000.mmc: 1 slots initialized
[    2.853933] usbcore: registered new interface driver usbhid
[    2.858089] usbhid: USB HID core driver
[    2.864074] input: max77693-muic/dock as /devices/platform/i2c-gpio-1/i2c-11/11-0066/max77693-muic/input/input0
[    2.873328] max17042 12-0036: SOC threshold INTR
[    2.905414] mmc1: MAN_BKOPS_EN bit is not set
[    2.909604] mmc_host mmc1: Bus speed (slot 0) = 50000000Hz (slot req 52000000Hz, actual 50000000HZ div = 0)
[    2.927320] mmc_host mmc1: Bus speed (slot 0) = 100000000Hz (slot req 52000000Hz, actual 50000000HZ div = 1)
[    2.937260] mmc1: new DDR MMC card at address 0001
[    2.940735] max77693-muic max77693-muic: CONTROL1 : 0x1b, CONTROL2 : 0x04, state : attached
[    2.942522] mmcblk0: mmc1:0001 VTU00M 14.6 GiB
[    2.942860] mmcblk0boot0: mmc1:0001 VTU00M partition 1 2.00 MiB
[    2.948205] mmcblk0boot1: mmc1:0001 VTU00M partition 2 2.00 MiB
[    2.948557] mmcblk0rpmb: mmc1:0001 VTU00M partition 3 128 KiB
[    2.971775] max77693-muic max77693-muic: device ID : 0x8d
[    2.979315]  mmcblk0: p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12 p13 p14
[    2.993899] NET: Registered protocol family 10
[    3.004057] sit: IPv6 over IPv4 tunneling driver
[    3.008981] NET: Registered protocol family 17
[    3.012000] NET: Registered protocol family 15
[    3.017081] Registering SWP/SWPB emulation handler
[    3.025235] s3c-rtc 10070000.rtc: rtc disabled, re-enabling
[    3.029619] s3c-rtc 10070000.rtc: warning: invalid RTC value so initializing it
[    3.037894] s3c-rtc 10070000.rtc: rtc core: registered s3c as rtc1
[    3.044127] ntc-thermistor thermistor-ap@0: Thermistor type: ncp15wb473 successfully probed.
[    3.052150] ntc-thermistor thermistor-battery@1: Thermistor type: ncp15wb473 successfully probed.
[    3.061240] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio-keys/key-down[0]' - status (0)
[    3.061290] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio-keys/key-up[0]' - status (0)
[    3.061332] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio-keys/key-power[0]' - status (0)
[    3.061372] of_get_named_gpiod_flags: parsed 'gpios' property of node '/gpio-keys/key-ok[0]' - status (0)
[    3.061445] gpio-239 (volume down): gpiod_set_debounce: missing set() or set_debounce() operations
[    3.061609] gpio-230 (volume up): gpiod_set_debounce: missing set() or set_debounce() operations
[    3.061741] gpio-235 (power): gpiod_set_debounce: missing set() or set_debounce() operations
[    3.061875] gpio-213 (ok): gpiod_set_debounce: missing set() or set_debounce() operations
[    3.062561] input: gpio-keys as /devices/platform/gpio-keys/input/input1
[    3.093255] max77686-rtc max77686-rtc: setting system clock to 2000-01-01 01:11:40 UTC (946689100)
[    3.160244] CAM_SENSOR_A: disabling
[    3.162295] CAM_AF: disabling
[    3.165268] LED_A_3.0V: disabling
[    3.169215] ESAFEOUT1: disabling
[    3.173853] CHARGER: disabling
[    3.177951] VUOTG_3.0V: disabling
[    3.181750] VHSIC_1.0V: disabling
[    3.185041] VHSIC_1.8V: disabling
[    3.189878] VDDQ_PRE_1.8V: disabling
[    3.195493] vdd_g3d: disabling
[    3.203255] ALSA device list:
[    3.204745]   No soundcards found.
[    3.348582] EXT4-fs (mmcblk0p11): warning: mounting unchecked fs, running e2fsck is recommended
[    3.359447] EXT4-fs (mmcblk0p11): recovery complete
[    3.365131] EXT4-fs (mmcblk0p11): mounted filesystem with ordered data mode. Opts: (null)
[    3.371992] VFS: Mounted root (ext4 filesystem) on device 179:11.
[    3.379392] devtmpfs: mounted
[    3.381364] Freeing unused kernel memory: 432K (c084e000 - c08ba000)
[    3.543816] random: systemd urandom read with 55 bits of entropy available
[    3.568480]
[    3.568657] =========================================================
[    3.575079] [ INFO: possible irq lock inversion dependency detected ]
[    3.581506] 4.2.0-next-20150910-00009-g65fd5a9cff54 #218 Not tainted
[    3.587838] ---------------------------------------------------------
[    3.594263] swapper/0/0 just changed the state of lock:
[    3.599470]  (&port_lock_key){..-...}, at: [<c02a8fac>] s3c24xx_serial_tx_dma_complete+0x8c/0xfc
[    3.608237] but this lock took another, SOFTIRQ-unsafe lock in the past:
[    3.614919]  (&(&ctx->lock)->rlock){+.+...}
[    3.614919]
[    3.614919] and interrupts could create inverse lock ordering between them.
[    3.614919]
[    3.625076]
[    3.625076] other info that might help us debug this:
[    3.631586]  Possible interrupt unsafe locking scenario:
[    3.631586]
[    3.638356]        CPU0                    CPU1
[    3.642870]        ----                    ----
[    3.647382]   lock(&(&ctx->lock)->rlock);
[    3.651376]                                local_irq_disable();
[    3.657278]                                lock(&port_lock_key);
[    3.663267]                                lock(&(&ctx->lock)->rlock);
[    3.669777]   <Interrupt>
[    3.672381]     lock(&port_lock_key);
[    3.676026]
[    3.676026]  *** DEADLOCK ***
[    3.676026]
[    3.681930] no locks held by swapper/0/0.
[    3.685922]
[    3.685922] the shortest dependencies between 2nd lock and 1st lock:
[    3.693752]  -> (&(&ctx->lock)->rlock){+.+...} ops: 681 {
[    3.699116]     HARDIRQ-ON-W at:
[    3.702328]                       [<c05e9e1c>] _raw_spin_lock+0x3c/0x4c
[    3.708924]                       [<c045a064>] exynos_cpuclk_notifier_cb+0x128/0x240
[    3.716649]                       [<c00440d8>] notifier_call_chain+0x54/0xa4
[    3.723680]                       [<c00441bc>] __srcu_notifier_call_chain+0x70/0xa4
[    3.731318]                       [<c0044208>] srcu_notifier_call_chain+0x18/0x20
[    3.738783]                       [<c045387c>] __clk_notify+0x6c/0x74
[    3.745206]                       [<c0453a20>] clk_propagate_rate_change+0xa4/0xbc
[    3.752758]                       [<c0453a08>] clk_propagate_rate_change+0x8c/0xbc
[    3.760310]                       [<c045558c>] clk_core_set_rate_nolock+0x58/0xe8
[    3.767774]                       [<c0455704>] clk_set_rate+0x20/0x30
[    3.774198]                       [<c04180fc>] set_target+0x16c/0x48c
[    3.780621]                       [<c0412d44>] __cpufreq_driver_target+0x218/0x378
[    3.788172]                       [<c041753c>] dbs_check_cpu+0x188/0x1d0
[    3.794856]                       [<c0417b30>] cpufreq_governor_dbs+0x37c/0x6f0
[    3.802147]                       [<c0413260>] __cpufreq_governor+0x12c/0x218
[    3.809265]                       [<c0414234>] cpufreq_init_policy+0x74/0xac
[    3.816295]                       [<c041460c>] cpufreq_online+0x3a0/0x7c4
[    3.823066]                       [<c02f3c60>] subsys_interface_register+0x78/0xbc
[    3.830617]                       [<c0415014>] cpufreq_register_driver+0x11c/0x210
[    3.838169]                       [<c0418bc4>] dt_cpufreq_probe+0x60/0x84
[    3.844940]                       [<c02f65fc>] platform_drv_probe+0x48/0xa4
[    3.851883]                       [<c02f4e84>] driver_probe_device+0x1e0/0x41c
[    3.859088]                       [<c02f5154>] __driver_attach+0x94/0x98
[    3.865772]                       [<c02f3248>] bus_for_each_dev+0x54/0x88
[    3.872542]                       [<c02f43f8>] bus_add_driver+0x174/0x250
[    3.879312]                       [<c02f5944>] driver_register+0x78/0xf4
[    3.885996]                       [<c00097f0>] do_one_initcall+0xac/0x1f0
[    3.892766]                       [<c084edc4>] kernel_init_freeable+0x11c/0x1e8
[    3.900058]                       [<c05e40dc>] kernel_init+0x8/0xec
[    3.906307]                       [<c00102d0>] ret_from_fork+0x14/0x24
[    3.912818]     SOFTIRQ-ON-W at:
[    3.916029]                       [<c05e9e1c>] _raw_spin_lock+0x3c/0x4c
[    3.922625]                       [<c045a064>] exynos_cpuclk_notifier_cb+0x128/0x240
[    3.930351]                       [<c00440d8>] notifier_call_chain+0x54/0xa4
[    3.937381]                       [<c00441bc>] __srcu_notifier_call_chain+0x70/0xa4
[    3.945020]                       [<c0044208>] srcu_notifier_call_chain+0x18/0x20
[    3.952485]                       [<c045387c>] __clk_notify+0x6c/0x74
[    3.958908]                       [<c0453a20>] clk_propagate_rate_change+0xa4/0xbc
[    3.966460]                       [<c0453a08>] clk_propagate_rate_change+0x8c/0xbc
[    3.974011]                       [<c045558c>] clk_core_set_rate_nolock+0x58/0xe8
[    3.981476]                       [<c0455704>] clk_set_rate+0x20/0x30
[    3.987899]                       [<c04180fc>] set_target+0x16c/0x48c
[    3.994322]                       [<c0412d44>] __cpufreq_driver_target+0x218/0x378
[    4.001874]                       [<c041753c>] dbs_check_cpu+0x188/0x1d0
[    4.008558]                       [<c0417b30>] cpufreq_governor_dbs+0x37c/0x6f0
[    4.015849]                       [<c0413260>] __cpufreq_governor+0x12c/0x218
[    4.022966]                       [<c0414234>] cpufreq_init_policy+0x74/0xac
[    4.029997]                       [<c041460c>] cpufreq_online+0x3a0/0x7c4
[    4.036768]                       [<c02f3c60>] subsys_interface_register+0x78/0xbc
[    4.044319]                       [<c0415014>] cpufreq_register_driver+0x11c/0x210
[    4.051871]                       [<c0418bc4>] dt_cpufreq_probe+0x60/0x84
[    4.058641]                       [<c02f65fc>] platform_drv_probe+0x48/0xa4
[    4.065585]                       [<c02f4e84>] driver_probe_device+0x1e0/0x41c
[    4.072789]                       [<c02f5154>] __driver_attach+0x94/0x98
[    4.079473]                       [<c02f3248>] bus_for_each_dev+0x54/0x88
[    4.086244]                       [<c02f43f8>] bus_add_driver+0x174/0x250
[    4.093014]                       [<c02f5944>] driver_register+0x78/0xf4
[    4.099697]                       [<c00097f0>] do_one_initcall+0xac/0x1f0
[    4.106468]                       [<c084edc4>] kernel_init_freeable+0x11c/0x1e8
[    4.113759]                       [<c05e40dc>] kernel_init+0x8/0xec
[    4.120009]                       [<c00102d0>] ret_from_fork+0x14/0x24
[    4.126519]     INITIAL USE at:
[    4.129644]                      [<c05e9f10>] _raw_spin_lock_irqsave+0x48/0x5c
[    4.136848]                      [<c0457334>] clk_gate_endisable+0x24/0x98
[    4.143705]                      [<c04573bc>] clk_gate_enable+0xc/0x14
[    4.150215]                      [<c0453690>] clk_core_enable+0xa4/0xe0
[    4.156812]                      [<c0453f24>] clk_enable+0x1c/0x30
[    4.162975]                      [<c086d060>] mct_init_dt+0x100/0x320
[    4.169398]                      [<c086cf1c>] clocksource_of_init+0x48/0x8c
[    4.176342]                      [<c084eb38>] start_kernel+0x260/0x3d0
[    4.182852]                      [<4000807c>] 0x4000807c
[    4.188147]   }
[    4.189883]   ... key      at: [<c10faaf8>] __key.15336+0x0/0x8
[    4.195786]   ... acquired at:
[    4.198823]    [<c006bc34>] lock_acquire+0x6c/0x8c
[    4.203597]    [<c05e9f10>] _raw_spin_lock_irqsave+0x48/0x5c
[    4.209239]    [<c02fdee8>] __pm_runtime_resume+0x54/0x90
[    4.214621]    [<c0274838>] pl330_pause+0x28/0x80
[    4.219308]    [<c02a8bc0>] s3c24xx_serial_stop_rx+0x70/0xe8
[    4.224950]    [<c02a091c>] uart_close+0x198/0x214
[    4.229724]    [<c0285644>] tty_release+0xf0/0x47c
[    4.234498]    [<c00f859c>] __fput+0x94/0x1d4
[    4.238837]    [<c004198c>] task_work_run+0x88/0xcc
[    4.243698]    [<c0012b50>] do_work_pending+0xa4/0xc4
[    4.248733]    [<c0010268>] slow_work_pending+0xc/0x20
[    4.253854]
[    4.255330] -> (&port_lock_key){..-...} ops: 87 {
[    4.260018]    IN-SOFTIRQ-W at:
[    4.263142]                     [<c05e9f10>] _raw_spin_lock_irqsave+0x48/0x5c
[    4.270260]                     [<c02a8fac>] s3c24xx_serial_tx_dma_complete+0x8c/0xfc
[    4.278071]                     [<c0275b40>] pl330_tasklet+0x16c/0x4cc
[    4.284581]                     [<c002988c>] tasklet_action+0x8c/0x13c
[    4.291091]                     [<c0028dd8>] __do_softirq+0x134/0x2c0
[    4.297515]                     [<c00292a4>] irq_exit+0xd0/0x114
[    4.303504]                     [<c00761a4>] __handle_domain_irq+0x70/0xe4
[    4.310361]                     [<c00094e8>] gic_handle_irq+0x4c/0x94
[    4.316784]                     [<c0013cb8>] __irq_svc+0x58/0x98
[    4.322773]                     [<c0419bfc>] cpuidle_enter_state+0x1d4/0x268
[    4.329804]                     [<c0419bfc>] cpuidle_enter_state+0x1d4/0x268
[    4.336835]                     [<c0062a64>] cpu_startup_entry+0x158/0x26c
[    4.343692]                     [<c084ec40>] start_kernel+0x368/0x3d0
[    4.350116]    INITIAL USE at:
[    4.353153]                    [<c05e9f10>] _raw_spin_lock_irqsave+0x48/0x5c
[    4.360184]                    [<c029fb50>] uart_add_one_port+0x358/0x498
[    4.366955]                    [<c02a8820>] s3c24xx_serial_probe+0x240/0x3f4
[    4.373985]                    [<c02f65fc>] platform_drv_probe+0x48/0xa4
[    4.380669]                    [<c02f4e84>] driver_probe_device+0x1e0/0x41c
[    4.387613]                    [<c02f5154>] __driver_attach+0x94/0x98
[    4.394036]                    [<c02f3248>] bus_for_each_dev+0x54/0x88
[    4.400546]                    [<c02f43f8>] bus_add_driver+0x174/0x250
[    4.407056]                    [<c02f5944>] driver_register+0x78/0xf4
[    4.413479]                    [<c00097f0>] do_one_initcall+0xac/0x1f0
[    4.419989]                    [<c084edc4>] kernel_init_freeable+0x11c/0x1e8
[    4.427020]                    [<c05e40dc>] kernel_init+0x8/0xec
[    4.433009]                    [<c00102d0>] ret_from_fork+0x14/0x24
[    4.439260]  }
[    4.440909]  ... key      at: [<c10f61d4>] port_lock_key+0x0/0x8
[    4.446898]  ... acquired at:
[    4.449849]    [<c006afa4>] __lock_acquire+0x2a4/0xbbc
[    4.454970]    [<c006bc34>] lock_acquire+0x6c/0x8c
[    4.459744]    [<c05e9f10>] _raw_spin_lock_irqsave+0x48/0x5c
[    4.465386]    [<c02a8fac>] s3c24xx_serial_tx_dma_complete+0x8c/0xfc
[    4.471722]    [<c0275b40>] pl330_tasklet+0x16c/0x4cc
[    4.476756]    [<c002988c>] tasklet_action+0x8c/0x13c
[    4.481791]    [<c0028dd8>] __do_softirq+0x134/0x2c0
[    4.486738]    [<c00292a4>] irq_exit+0xd0/0x114
[    4.491252]    [<c00761a4>] __handle_domain_irq+0x70/0xe4
[    4.496634]    [<c00094e8>] gic_handle_irq+0x4c/0x94
[    4.501581]    [<c0013cb8>] __irq_svc+0x58/0x98
[    4.506095]    [<c0419bfc>] cpuidle_enter_state+0x1d4/0x268
[    4.511650]    [<c0419bfc>] cpuidle_enter_state+0x1d4/0x268
[    4.517205]    [<c0062a64>] cpu_startup_entry+0x158/0x26c
[    4.522587]    [<c084ec40>] start_kernel+0x368/0x3d0
[    4.527534]
[    4.529010]
[    4.529010] stack backtrace:
[    4.533357] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.2.0-next-20150910-00009-g65fd5a9cff54 #218
[    4.542292] Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[    4.548384] [<c0016630>] (unwind_backtrace) from [<c0013148>] (show_stack+0x10/0x14)
[    4.556105] [<c0013148>] (show_stack) from [<c022371c>] (dump_stack+0x70/0xbc)
[    4.563307] [<c022371c>] (dump_stack) from [<c0068c2c>] (print_irq_inversion_bug+0x19c/0x204)
[    4.571812] [<c0068c2c>] (print_irq_inversion_bug) from [<c0068d38>] (check_usage_forwards+0xa4/0x114)
[    4.581098] [<c0068d38>] (check_usage_forwards) from [<c006a828>] (mark_lock+0x1c0/0x698)
[    4.589257] [<c006a828>] (mark_lock) from [<c006afa4>] (__lock_acquire+0x2a4/0xbbc)
[    4.596895] [<c006afa4>] (__lock_acquire) from [<c006bc34>] (lock_acquire+0x6c/0x8c)
[    4.604624] [<c006bc34>] (lock_acquire) from [<c05e9f10>] (_raw_spin_lock_irqsave+0x48/0x5c)
[    4.613043] [<c05e9f10>] (_raw_spin_lock_irqsave) from [<c02a8fac>] (s3c24xx_serial_tx_dma_complete+0x8c/0xfc)
[    4.623025] [<c02a8fac>] (s3c24xx_serial_tx_dma_complete) from [<c0275b40>] (pl330_tasklet+0x16c/0x4cc)
[    4.632399] [<c0275b40>] (pl330_tasklet) from [<c002988c>] (tasklet_action+0x8c/0x13c)
[    4.640296] [<c002988c>] (tasklet_action) from [<c0028dd8>] (__do_softirq+0x134/0x2c0)
[    4.648194] [<c0028dd8>] (__do_softirq) from [<c00292a4>] (irq_exit+0xd0/0x114)
[    4.655485] [<c00292a4>] (irq_exit) from [<c00761a4>] (__handle_domain_irq+0x70/0xe4)
[    4.663297] [<c00761a4>] (__handle_domain_irq) from [<c00094e8>] (gic_handle_irq+0x4c/0x94)
[    4.671630] [<c00094e8>] (gic_handle_irq) from [<c0013cb8>] (__irq_svc+0x58/0x98)
[    4.679090] Exception stack(0xc08bbf28 to 0xc08bbf70)
[    4.684129] bf20:                   00000001 00000001 00000000 c08bf6b8 d4837193 00000000
[    4.692289] bf40: eef6b568 00000000 d48ff9e8 00000000 c08eaf38 c08eaf38 00000000 c08bbf78
[    4.700445] bf60: c006c568 c0419bfc 20000113 ffffffff
[    4.705483] [<c0013cb8>] (__irq_svc) from [<c0419bfc>] (cpuidle_enter_state+0x1d4/0x268)
[    4.713557] [<c0419bfc>] (cpuidle_enter_state) from [<c0062a64>] (cpu_startup_entry+0x158/0x26c)
[    4.722323] [<c0062a64>] (cpu_startup_entry) from [<c084ec40>] (start_kernel+0x368/0x3d0)
[    4.732689] max77693-muic max77693-muic: external connector is detached(chg_type:0x0, prev_chg_type:0x0)
[    5.356586] systemd-udevd[1868]: starting version 216
[    6.035950] EXT4-fs (mmcblk0p4): VFS: Can't find ext4 filesystem
[    6.100843] random: nonblocking pool is initialized
[    6.170730] EXT4-fs (mmcblk0p9): mounted filesystem with ordered data mode. Opts: (null)
[    6.193892] EXT4-fs (mmcblk0p12): mounted filesystem with ordered data mode. Opts: (null)
[    6.912173] EXT4-fs (mmcblk0p14): mounted filesystem with ordered data mode. Opts: (null)
-sh-4.1#
-sh-4.1#
-sh-4.1#
-sh-4.1# [   38.442955] sysrq: SysRq : This sysrq operation is disabled.


--------------040505090800000202050801--
