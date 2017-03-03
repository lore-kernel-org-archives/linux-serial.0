From: Marc Gonzalez <marc_gonzalez@sigmadesigns.com>
Subject: No output on console despite ignore_loglevel earlyprintk
Date: Fri, 3 Mar 2017 17:42:02 +0100
Message-ID: <6d16a384-1a4c-bf27-fd81-ea3caf3de6b0@sigmadesigns.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, Arnd Bergmann <arnd@arndb.de>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Hello,

I'm confused about early consoles and earlyprintk, and all that good stuff.
When my kernel panics, I don't get the expected output.

Using "mem=256M ignore_loglevel earlyprintk"

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.7-1-rc2 (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #153 SMP PREEMPT Fri Mar 3 17:31:37 CET 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c10234c0, node_mem_map cfdf9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 14 pages/cpu @cfdd7000 s24960 r8192 d24192 u57344
[    0.000000] pcpu-alloc: s24960 r8192 d24192 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: mem=256M ignore_loglevel earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 243980K/262144K available (4096K kernel code, 146K rwdata, 876K rodata, 10240K init, 233K bss, 18164K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc1000000   (10240 kB)
[    0.000000]       .data : 0xc1000000 - 0xc1024860   ( 147 kB)
[    0.000000]        .bss : 0xc1024860 - 0xc105ed40   ( 234 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
[    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
[    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
[    0.007960] Switching to timer-based delay loop, resolution 37ns
[    0.014325] Console: colour dummy device 80x30
[    0.018885] console [tty0] enabled
[    0.022396] bootconsole [earlycon0] disabled

And it hangs there.


If I use an explicit console= configuration, I do see the panic.
Using "mem=256M ignore_loglevel console=ttyS0,115200 earlyprintk"

Uncompressing Linux... done, booting the kernel.
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.9.7-1-rc2 (gcc version 5.3.1 20160113 (Linaro GCC 5.3-2016.02) ) #153 SMP PREEMPT Fri Mar 3 17:31:37 CET 2017
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing instruction cache
[    0.000000] OF: fdt:Machine model: Sigma Designs SMP8758 Vantage-1172 Rev E1
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] bootconsole [earlycon0] enabled
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 65536
[    0.000000] free_area_init_node: node 0, pgdat c10234c0, node_mem_map cfdf9000
[    0.000000]   Normal zone: 512 pages used for memmap
[    0.000000]   Normal zone: 0 pages reserved
[    0.000000]   Normal zone: 65536 pages, LIFO batch:15
[    0.000000] percpu: Embedded 14 pages/cpu @cfdd7000 s24960 r8192 d24192 u57344
[    0.000000] pcpu-alloc: s24960 r8192 d24192 u57344 alloc=14*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
[    0.000000] Kernel command line: mem=256M ignore_loglevel console=ttyS0,115200 earlyprintk
[    0.000000] PID hash table entries: 1024 (order: 0, 4096 bytes)
[    0.000000] Dentry cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Inode-cache hash table entries: 16384 (order: 4, 65536 bytes)
[    0.000000] Memory: 243980K/262144K available (4096K kernel code, 146K rwdata, 876K rodata, 10240K init, 233K bss, 18164K reserved, 0K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xd0800000 - 0xff800000   ( 752 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xd0000000   ( 256 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0500000   (5088 kB)
[    0.000000]       .init : 0xc0600000 - 0xc1000000   (10240 kB)
[    0.000000]       .data : 0xc1000000 - 0xc1024860   ( 147 kB)
[    0.000000]        .bss : 0xc1024860 - 0xc105ed40   ( 234 kB)
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=4 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] L2C-310 enabling early BRESP for Cortex-A9
[    0.000000] L2C-310 ID prefetch enabled, offset 4 lines
[    0.000000] L2C-310 dynamic clock gating enabled, standby mode enabled
[    0.000000] L2C-310 cache controller enabled, 8 ways, 512 kB
[    0.000000] L2C-310: CACHE_ID 0x410000c8, AUX_CTRL 0x72860401
[    0.000000] clocksource: tango-xtal: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 70787423951 ns
[    0.000004] sched_clock: 32 bits at 27MHz, resolution 37ns, wraps every 79536431085ns
[    0.007961] Switching to timer-based delay loop, resolution 37ns
[    0.014325] Console: colour dummy device 80x30
[    0.018899] Calibrating delay loop (skipped), value calculated using timer frequency.. 54.25 BogoMIPS (lpj=90000)
[    0.029316] pid_max: default: 32768 minimum: 301
[    0.034135] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.040876] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.048527] CPU: Testing write buffer coherency: ok
[    0.053736] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.059560] Setting up static identity map for 0x80100000 - 0x80100034
[    0.120467] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.120530] Brought up 2 CPUs
[    0.129381] SMP: Total of 2 processors activated (108.50 BogoMIPS).
[    0.135771] CPU: All CPU(s) started in SVC mode.
[    0.141062] devtmpfs: initialized
[    0.145393] VFP support v0.3: implementor 41 architecture 3 part 30 variant 9 rev 4
[    0.153490] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 6370867519511994 ns
[    0.163772] NET: Registered protocol family 16
[    0.169026] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.177030] Kernel panic - not syncing: FAKE PANIC
[    0.177030] 
[    0.183510] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 4.9.7-1-rc2 #153
[    0.190154] Hardware name: Sigma Tango DT
[    0.194301] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
[    0.202176] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
[    0.209527] [<c02cecc0>] (dump_stack) from [<c018b634>] (panic+0xdc/0x248)
[    0.216530] [<c018b634>] (panic) from [<c0607acc>] (xenv_lookup.constprop.1+0x0/0x64)
[    0.224493] [<c0607acc>] (xenv_lookup.constprop.1) from [<c0220830>] (proc_create_data+0x74/0xb8)
[    0.233501] [<c0220830>] (proc_create_data) from [<c050fa08>] (0xc050fa08)
[    0.240499] CPU1: stopping
[    0.243303] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.9.7-1-rc2 #153
[    0.249946] Hardware name: Sigma Tango DT
[    0.254065] [<c010ed94>] (unwind_backtrace) from [<c010ae24>] (show_stack+0x10/0x14)
[    0.261937] [<c010ae24>] (show_stack) from [<c02cecc0>] (dump_stack+0x78/0x8c)
[    0.269283] [<c02cecc0>] (dump_stack) from [<c010dc10>] (handle_IPI+0x198/0x1ac)
[    0.276803] [<c010dc10>] (handle_IPI) from [<c01014a4>] (gic_handle_irq+0x88/0x8c)
[    0.284499] [<c01014a4>] (gic_handle_irq) from [<c010b90c>] (__irq_svc+0x6c/0xa8)
[    0.292104] Exception stack(0xcf859f98 to 0xcf859fe0)
[    0.297263] 9f80:                                                       00000001 00000000
[    0.305568] 9fa0: 000002d8 c0114620 cf858000 c1002fe4 c1003048 00000002 c100ba2e 413fc090
[    0.313874] 9fc0: 00000000 00000000 32dcd555 cf859fe8 c0108220 c0108224 60000013 ffffffff
[    0.322182] [<c010b90c>] (__irq_svc) from [<c0108224>] (arch_cpu_idle+0x38/0x3c)
[    0.329707] [<c0108224>] (arch_cpu_idle) from [<c0151f4c>] (cpu_startup_entry+0xcc/0x144)
[    0.338015] [<c0151f4c>] (cpu_startup_entry) from [<8010154c>] (0x8010154c)
[    0.345103] ---[ end Kernel panic - not syncing: FAKE PANIC


I suppose this is related to my DT description?

	chosen {
		stdout-path = "serial:115200n8";
	};

Isn't stdout-path = "serial:115200n8" supposed to be equivalent to
console=ttyS0,115200 ?

I must be missing something.

Regards.
