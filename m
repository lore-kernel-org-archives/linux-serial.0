From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: debug tip after earlycon is closed?
Date: Wed, 27 Jul 2016 10:23:09 +0900
Message-ID: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robh+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi.


When the kernel fails to boot and its log console is silent,
I use earlycon and I often find the cause of error with it.


But, I have been wondering if there is an easy-to-use
debug tip which is available after earlycon is disabled.


I noticed the current mainline would not boot on my ARMv8 board.
According to the following log, I am guessing something wrong
is happening after the "bootconsole [uniphier0] disabled" log.

Is there a good practice to see more log?





[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.7.0-02346-g3601fbc-dirty
(yamada@beagle) (gcc version 4.9.4 20151028 (prerelease) (Linaro GCC
4.9-2016.02) ) #19 SMP PREEMPT Wed Jul 27 10:01:35 JST 2016
[    0.000000] Boot CPU: AArch64 Processor [410fd034]
[    0.000000] earlycon: uniphier0 at MMIO 0x0000000054006800 (options
'115200n8')
[    0.000000] bootconsole [uniphier0] enabled
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 16 MiB at 0x00000000bec00000
[    0.000000] percpu: Embedded 21 pages/cpu @ffff80003ffb3000 s48128
r8192 d29696 u86016
[    0.000000] Detected VIPT I-cache on CPU0
[    0.000000] CPU features: enabling workaround for ARM erratum 845719
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 258048
[    0.000000] Kernel command line: earlycon
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 7, 524288 bytes)
[    0.000000] software IO TLB [mem 0xb9c00000-0xbdc00000] (64MB)
mapped at [ffff800039c00000-ffff80003dbfffff]
[    0.000000] Memory: 933680K/1048576K available (7512K kernel code,
648K rwdata, 3172K rodata, 960K init, 259K bss, 98512K reserved,
16384K cma-reserved)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     modules : 0xffff000000000000 - 0xffff000008000000
(   128 MB)
[    0.000000]     vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000
(129022 GB)
[    0.000000]       .text : 0xffff000008080000 - 0xffff0000087d0000
(  7488 KB)
[    0.000000]     .rodata : 0xffff0000087d0000 - 0xffff000008af0000
(  3200 KB)
[    0.000000]       .init : 0xffff000008af0000 - 0xffff000008be0000
(   960 KB)
[    0.000000]       .data : 0xffff000008be0000 - 0xffff000008c82000
(   648 KB)
[    0.000000]        .bss : 0xffff000008c82000 - 0xffff000008cc2d40
(   260 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000
(  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000
(    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000
(  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0001000000
(    16 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff800040000000
(  1024 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=2, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=2
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000005fe40000
[    0.000000] Architected cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000004] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
every 4398046511100ns
[    0.008254] Console: colour dummy device 80x25
[    0.012700] console [tty0] enabled
[    0.016110] bootconsole [uniphier0] disabled


-- 
Best Regards
Masahiro Yamada
