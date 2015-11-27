From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: The console log is doubled if earlycon is enabled
Date: Fri, 27 Nov 2015 19:21:06 +0900
Message-ID: <CAK7LNAT5L2uxJ6i-QEYqw9qFLyvADu_E0F5VVTOPqyHbLodTCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Peter Hurley <peter@hurleysoftware.com>, Rob Herring <robherring2@gmail.com>
List-Id: linux-serial@vger.kernel.org

Hi,


If I add "earlycon" to the kernel parameter, the log message
on the earlycon is also displayed to the regular console.
In other words, the same log messages are displayed twice.

I noticed this problem on v4.4-rc1.
It has not been fixed in the mainline yet, I think.

Anybody who has a clue?
(I have not done git-bisect yet.)

I attached my log below:




[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.0-rc1-00003-gc590deb-dirty
(yamada@beagle) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) )
#249 SMP Fri Nov 27 19:09:26 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: UniPhier PH1-LD4 Reference Board
[    0.000000] bootconsole [uart0] enabled
[    0.000000] cma: Reserved 64 MiB at 0x9b800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 12 pages/cpu @dfbc5000 s19136 r8192
d21824 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: earlycon
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 436816K/524288K available (8235K kernel code,
1040K rwdata, 3816K rodata, 1048K init, 340K bss, 21936K reserved,
65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0dcdc40   (12056 kB)
[    0.000000]       .init : 0xc0dce000 - 0xc0ed4000   (1048 kB)
[    0.000000]       .data : 0xc0ed4000 - 0xc0fd82e0   (1041 kB)
[    0.000000]        .bss : 0xc0fdb000 - 0xc10303e8   ( 341 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] uniphier: enabled outer cache (cache level: 2)
[    0.000009] sched_clock: 64 bits at 50MHz, resolution 20ns, wraps
every 4398046511100ns
[    0.007999] clocksource: arm_global_timer: mask: 0xffffffffffffffff
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.019168] Console: colour dummy device 80x30
[    0.023602] console [tty0] enabled
[    0.027030] bootconsole [uart0] disabled
[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.4.0-rc1-00003-gc590deb-dirty
(yamada@beagle) (gcc version 4.7.3 (Ubuntu/Linaro 4.7.3-12ubuntu1) )
#249 SMP Fri Nov 27 19:09:26 JST 2015
[    0.000000] CPU: ARMv7 Processor [413fc090] revision 0 (ARMv7), cr=10c5387d
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, VIPT aliasing
instruction cache
[    0.000000] Machine model: UniPhier PH1-LD4 Reference Board
[    0.000000] bootconsole [uart0] enabled
[    0.000000] cma: Reserved 64 MiB at 0x9b800000
[    0.000000] Memory policy: Data cache writeback
[    0.000000] CPU: All CPU(s) started in SVC mode.
[    0.000000] PERCPU: Embedded 12 pages/cpu @dfbc5000 s19136 r8192
d21824 u49152
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 130048
[    0.000000] Kernel command line: earlycon
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Memory: 436816K/524288K available (8235K kernel code,
1040K rwdata, 3816K rodata, 1048K init, 340K bss, 21936K reserved,
65536K cma-reserved, 0K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xe0800000 - 0xff800000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xe0000000   ( 512 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]     modules : 0xbf000000 - 0xbfe00000   (  14 MB)
[    0.000000]       .text : 0xc0208000 - 0xc0dcdc40   (12056 kB)
[    0.000000]       .init : 0xc0dce000 - 0xc0ed4000   (1048 kB)
[    0.000000]       .data : 0xc0ed4000 - 0xc0fd82e0   (1041 kB)
[    0.000000]        .bss : 0xc0fdb000 - 0xc10303e8   ( 341 kB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=1, Nodes=1
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 32.
[    0.000000]  RCU restricting CPUs from NR_CPUS=16 to nr_cpu_ids=1.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=1
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] uniphier: enabled outer cache (cache level: 2)
[    0.000009] sched_clock: 64 bits at 50MHz, resolution 20ns, wraps
every 4398046511100ns
[    0.007999] clocksource: arm_global_timer: mask: 0xffffffffffffffff
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.019168] Console: colour dummy device 80x30
[    0.023602] console [tty0] enabled
[    0.027030] bootconsole [uart0] disabled
[    0.030963] Calibrating delay loop... 1590.88 BogoMIPS (lpj=3977216)
[    0.049045] pid_max: default: 32768 minimum: 301
[    0.049161] Mount-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.049178] Mountpoint-cache hash table entries: 1024 (order: 0, 4096 bytes)
[    0.049891] CPU: Testing write buffer coherency: ok
[    0.050097] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.050180] Setting up static identity map for 0x80209000 - 0x80209098
[    0.051503] Brought up 1 CPUs
[    0.051520] SMP: Total of 1 processors activated (1590.88 BogoMIPS).
[    0.051533] CPU: All CPU(s) started in SVC mode.
[    0.052170] devtmpfs: initialized
[    0.053754] VFP support v0.3: implementor 41 architecture 3 part 30
variant 9 rev 4
[    0.054146] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 9556302231375000 ns
[    0.057309] pinctrl core: initialized pinctrl subsystem
[    0.058708] NET: Registered protocol family 16
[    0.060829] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.062237] cpuidle: using governor ladder
[    0.062259] cpuidle: using governor menu
[    0.065567] No ATAGs?
[    0.065599] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
watchpoint registers.
[    0.065616] hw-breakpoint: maximum watchpoint size is 4 bytes.
[    0.067452] Serial: AMBA PL011 UART driver
[    0.079287] vgaarb: loaded
[    0.080102] SCSI subsystem initialized
[    0.080575] usbcore: registered new interface driver usbfs
[    0.080666] usbcore: registered new interface driver hub
[    0.080729] usbcore: registered new device driver usb
[    0.081506] pps_core: LinuxPPS API ver. 1 registered
[    0.081531] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.081583] PTP clock support registered
[    0.081736] EDAC MC: Ver: 3.0.0
[    0.083594] clocksource: Switched to clocksource arm_global_timer
[    0.093107] NET: Registered protocol family 2
[    0.093671] TCP established hash table entries: 4096 (order: 2, 16384 bytes)
[    0.093741] TCP bind hash table entries: 4096 (order: 3, 32768 bytes)
[    0.093829] TCP: Hash tables configured (established 4096 bind 4096)
[    0.093928] UDP hash table entries: 256 (order: 1, 8192 bytes)
[    0.093966] UDP-Lite hash table entries: 256 (order: 1, 8192 bytes)
[    0.094167] NET: Registered protocol family 1
[    0.094500] RPC: Registered named UNIX socket transport module.
[    0.094527] RPC: Registered udp transport module.
[    0.094545] RPC: Registered tcp transport module.
[    0.094561] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.094979] Unpacking initramfs...
[    0.322686] Freeing initrd memory: 2696K (df8a9000 - dfb4b000)
[    0.323993] futex hash table entries: 256 (order: 2, 16384 bytes)
[    0.334409] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.335242] NFS: Registering the id_resolver key type
[    0.335292] Key type id_resolver registered
[    0.335312] Key type id_legacy registered
[    0.335399] ntfs: driver 2.1.32 [Flags: R/O].
[    0.336856] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 249)
[    0.336904] io scheduler noop registered
[    0.336931] io scheduler deadline registered
[    0.336978] io scheduler cfq registered (default)
[    0.401831] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.404147] 54006800.serial: ttyS0 at MMIO 0x54006800 (irq = 20,
base_baud = 2304000) is a 16550A
[    0.951091] console [ttyS0] enabled
[    0.955379] 54006a00.serial: ttyS2 at MMIO 0x54006a00 (irq = 21,
base_baud = 2304000) is a 16550A
[    0.965022] 54006b00.serial: ttyS3 at MMIO 0x54006b00 (irq = 22,
base_baud = 2304000) is a 16550A
[    0.974424] SuperH (H)SCI(F) driver initialized
[    0.979508] msm_serial: driver initialized
[    0.983874] STMicroelectronics ASC driver initialized
[    0.989910] [drm] Initialized drm 1.1.0 20060810
[    1.001899] loop: module loaded
[    1.010147] libphy: Fixed MDIO Bus: probed
[    1.014941] CAN device driver interface
[    1.019517] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    1.026502] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.033741] pegasus: v0.9.3 (2013/04/25), Pegasus/Pegasus II USB
Ethernet driver
[    1.041240] usbcore: registered new interface driver pegasus
[    1.046982] usbcore: registered new interface driver asix
[    1.052454] usbcore: registered new interface driver ax88179_178a
[    1.058618] usbcore: registered new interface driver cdc_ether
[    1.064534] usbcore: registered new interface driver smsc75xx
[    1.070356] usbcore: registered new interface driver smsc95xx
[    1.076166] usbcore: registered new interface driver net1080
[    1.081893] usbcore: registered new interface driver cdc_subset
[    1.087873] usbcore: registered new interface driver zaurus
[    1.093549] usbcore: registered new interface driver cdc_ncm
[    1.100256] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.106808] ehci-pci: EHCI PCI platform driver
[    1.111318] ehci-platform: EHCI generic platform driver
[    1.116775] ehci-platform 5a800100.usb: EHCI Host Controller
[    1.122482] ehci-platform 5a800100.usb: new USB bus registered,
assigned bus number 1
[    1.133312] ehci-platform 5a800100.usb: can't setup: -110
[    1.138735] ehci-platform 5a800100.usb: USB bus 1 deregistered
[    1.144607] ehci-platform: probe of 5a800100.usb failed with error -110
[    1.151342] ehci-platform 5a810100.usb: EHCI Host Controller
[    1.157037] ehci-platform 5a810100.usb: new USB bus registered,
assigned bus number 1
[    1.167674] ehci-platform 5a810100.usb: can't setup: -110
[    1.173089] ehci-platform 5a810100.usb: USB bus 1 deregistered
[    1.178951] ehci-platform: probe of 5a810100.usb failed with error -110
[    1.185626] ehci-omap: OMAP-EHCI Host Controller driver
[    1.190993] ehci-orion: EHCI orion driver
[    1.195108] SPEAr-ehci: EHCI SPEAr driver
[    1.199225] ehci-st: EHCI STMicroelectronics driver
[    1.204208] ehci-exynos: EHCI EXYNOS driver
[    1.208486] ehci-atmel: EHCI Atmel driver
[    1.212595] tegra-ehci: Tegra EHCI driver
[    1.216729] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.222942] ohci-pci: OHCI PCI platform driver
[    1.227467] ohci-platform: OHCI generic platform driver
[    1.232801] ohci-omap3: OHCI OMAP3 driver
[    1.236912] SPEAr-ohci: OHCI SPEAr driver
[    1.241024] ohci-st: OHCI STMicroelectronics driver
[    1.246008] ohci-atmel: OHCI Atmel driver
[    1.250357] usbcore: registered new interface driver usb-storage
[    1.257408] mousedev: PS/2 mouse device common for all mice
[    1.265660] i2c /dev entries driver
[    1.275568] sdhci: Secure Digital Host Controller Interface driver
[    1.281778] sdhci: Copyright(c) Pierre Ossman
[    1.286997] Synopsys Designware Multimedia Card Interface Driver
[    1.293653] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.300493] ledtrig-cpu: registered to indicate activity on CPUs
[    1.306752] usbcore: registered new interface driver usbhid
[    1.312342] usbhid: USB HID core driver
[    1.319662] NET: Registered protocol family 10
[    1.324929] sit: IPv6 over IPv4 tunneling driver
[    1.330198] NET: Registered protocol family 17
[    1.334677] can: controller area network core (rev 20120528 abi 9)
[    1.340946] NET: Registered protocol family 29
[    1.345410] can: raw protocol (rev 20120528)
[    1.349693] can: broadcast manager protocol (rev 20120528 t)
[    1.355367] can: netlink gateway (rev 20130117) max_hops=1
[    1.361312] Key type dns_resolver registered
[    1.365708] ThumbEE CPU extension supported.
[    1.370010] Registering SWP/SWPB emulation handler
[    1.376863] hctosys: unable to open rtc device (rtc0)
[    1.384956] Freeing unused kernel memory: 1048K (c0dce000 - c0ed4000)
Starting logging: OK
Initializing random number generator... [    1.453460] random: dd
urandom read with 0 bits of entropy available
done.
Waiting for network interfaces to appear ok
Starting network...

Welcome to Buildroot
buildroot login:

-- 
Best Regards
Masahiro Yamada
