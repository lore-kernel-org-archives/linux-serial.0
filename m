From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: debug tip after earlycon is closed?
Date: Thu, 28 Jul 2016 11:08:13 +0900
Message-ID: <CAK7LNARtm_2uT3nbga4X0dMYs9jhKa8a2FTGJrYbVRg8P3vHQw@mail.gmail.com>
References: <CAK7LNASrqbt+RzD64zcAMjmBjJqa2sc2UG+mnEX8npZ9DBJodQ@mail.gmail.com>
 <3860396.RT1mlU0LAT@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <3860396.RT1mlU0LAT@wuerfel>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Hurley <peter@hurleysoftware.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, linux-serial@vger.kernel.org, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: linux-serial@vger.kernel.org

Hi Arnd,


2016-07-27 16:32 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wednesday, July 27, 2016 10:23:09 AM CEST Masahiro Yamada wrote:
>> [    0.000004] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
>> every 4398046511100ns
>> [    0.008254] Console: colour dummy device 80x25
>> [    0.012700] console [tty0] enabled
>> [    0.016110] bootconsole [uniphier0] disabled
>
> I assume that the original console is on a uart, while the new console
> appears to be on the framebuffer. Maybe you have no screen attached?
>


I use 8250-compat serial console for both.


The following is the full boot log when success.


I am not sure about:
[    0.000141] Console: colour dummy device 80x25
[    0.000550] console [tty0] enabled



This is the UART console I am really using.
[    0.234743] 54006800.serial: ttyS0 at MMIO 0x54006800 (irq = 6,
base_baud = 3676470) is a 16550A
[    0.994393] console [ttyS0] enabled





Starting kernel ...

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.7.0-01675-g8f09d9b (yamada@beagle) (gcc
version 4.9.4 20151028 (prerelease) (Linaro GCC 4.9-2016.02) ) #24 SMP
PREEMPT Wed Jul 27 14:36:30 JST 2016
[    0.000000] Boot CPU: AArch64 Processor [410fd082]
[    0.000000] efi: Getting EFI parameters from FDT:
[    0.000000] efi: UEFI not found.
[    0.000000] cma: Reserved 16 MiB at 0x00000000fec00000
[    0.000000] percpu: Embedded 21 pages/cpu @ffff8000bff7c000 s48128
r8192 d29696 u86016
[    0.000000] Detected PIPT I-cache on CPU0
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.
Total pages: 774144
[    0.000000] Kernel command line:
[    0.000000] log_buf_len individual max cpu contribution: 4096 bytes
[    0.000000] log_buf_len total cpu_extra contributions: 12288 bytes
[    0.000000] log_buf_len min size: 16384 bytes
[    0.000000] log_buf_len: 32768 bytes
[    0.000000] early log buf free: 15036(91%)
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Dentry cache hash table entries: 524288 (order: 10,
4194304 bytes)
[    0.000000] Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
[    0.000000] software IO TLB [mem 0xfac00000-0xfec00000] (64MB)
mapped at [ffff80007ac00000-ffff80007ebfffff]
[    0.000000] Memory: 2993196K/3145728K available (7516K kernel code,
647K rwdata, 3168K rodata, 960K init, 259K bss, 136148K reserved,
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
[    0.000000]       .data : 0xffff000008be0000 - 0xffff000008c81e00
(   648 KB)
[    0.000000]        .bss : 0xffff000008c81e00 - 0xffff000008cc2d40
(   260 KB)
[    0.000000]     fixed   : 0xffff7dfffe7fd000 - 0xffff7dfffec00000
(  4108 KB)
[    0.000000]     PCI I/O : 0xffff7dfffee00000 - 0xffff7dffffe00000
(    16 MB)
[    0.000000]     vmemmap : 0xffff7e0000000000 - 0xffff800000000000
(  2048 GB maximum)
[    0.000000]               0xffff7e0000000000 - 0xffff7e0003000000
(    48 MB actual)
[    0.000000]     memory  : 0xffff800000000000 - 0xffff8000c0000000
(  3072 MB)
[    0.000000] SLUB: HWalign=64, Order=0-3, MinObjects=0, CPUs=4, Nodes=1
[    0.000000] Preemptible hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=64 to nr_cpu_ids=4.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=4
[    0.000000] NR_IRQS:64 nr_irqs:64 0
[    0.000000] GICv3: GIC: Using split EOI/Deactivate mode
[    0.000000] GICv3: CPU0: found redistributor 0 region 0:0x000000005fe80000
[    0.000000] Architected cp15 timer(s) running at 50.00MHz (phys).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff
max_cycles: 0xb8812736b, max_idle_ns: 440795202655 ns
[    0.000003] sched_clock: 56 bits at 50MHz, resolution 20ns, wraps
every 4398046511100ns
[    0.000141] Console: colour dummy device 80x25
[    0.000550] console [tty0] enabled
[    0.000570] Calibrating delay loop (skipped), value calculated
using timer frequency.. 100.00 BogoMIPS (lpj=200000)
[    0.000591] pid_max: default: 32768 minimum: 301
[    0.000640] Security Framework initialized
[    0.000673] Mount-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.000686] Mountpoint-cache hash table entries: 8192 (order: 4, 65536 bytes)
[    0.001509] ASID allocator initialised with 65536 entries
[    0.024202] EFI services will not be available.
[    0.048076] Detected PIPT I-cache on CPU1
[    0.048097] GICv3: CPU1: found redistributor 1 region 0:0x000000005fea0000
[    0.048113] CPU1: Booted secondary processor [410fd082]
[    0.064093] Detected VIPT I-cache on CPU2
[    0.064098] CPU features: enabling workaround for ARM erratum 845719
[    0.064117] GICv3: CPU2: found redistributor 100 region 0:0x000000005fec0000
[    0.064141] CPU2: Booted secondary processor [410fd034]
[    0.080107] Detected VIPT I-cache on CPU3
[    0.080120] GICv3: CPU3: found redistributor 101 region 0:0x000000005fee0000
[    0.080133] CPU3: Booted secondary processor [410fd034]
[    0.080206] Brought up 4 CPUs
[    0.080306] SMP: Total of 4 processors activated.
[    0.080318] CPU features: detected feature: GIC system register CPU interface
[    0.080330] CPU features: detected feature: 32-bit EL0 Support
[    0.080346] CPU: All CPU(s) started at EL2
[    0.080375] alternatives: patching kernel code
[    0.081358] devtmpfs: initialized
[    0.082795] DMI not present or invalid.
[    0.082921] clocksource: jiffies: mask: 0xffffffff max_cycles:
0xffffffff, max_idle_ns: 7645041785100000 ns
[    0.083246] pinctrl core: initialized pinctrl subsystem
[    0.083974] NET: Registered protocol family 16
[    0.100145] cpuidle: using governor menu
[    0.100188] vdso: 2 pages (1 code @ ffff0000087d6000, 1 data @
ffff000008be4000)
[    0.100216] hw-breakpoint: found 6 breakpoint and 4 watchpoint registers.
[    0.100746] DMA: preallocated 256 KiB pool for atomic allocations
[    0.100868] Serial: AMBA PL011 UART driver
[    0.124480] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    0.125003] ACPI: Interpreter disabled.
[    0.125414] vgaarb: loaded
[    0.125584] SCSI subsystem initialized
[    0.125833] usbcore: registered new interface driver usbfs
[    0.125876] usbcore: registered new interface driver hub
[    0.125914] usbcore: registered new device driver usb
[    0.126131] pps_core: LinuxPPS API ver. 1 registered
[    0.126143] pps_core: Software ver. 5.3.6 - Copyright 2005-2007
Rodolfo Giometti <giometti@linux.it>
[    0.126172] PTP clock support registered
[    0.126258] dmi: Firmware registration failed.
[    0.126304] Advanced Linux Sound Architecture Driver Initialized.
[    0.126759] clocksource: Switched to clocksource arch_sys_counter
[    0.126843] VFS: Disk quotas dquot_6.6.0
[    0.126883] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    0.127052] pnp: PnP ACPI: disabled
[    0.132866] NET: Registered protocol family 2
[    0.133387] TCP established hash table entries: 32768 (order: 6,
262144 bytes)
[    0.133694] TCP bind hash table entries: 32768 (order: 7, 524288 bytes)
[    0.134262] TCP: Hash tables configured (established 32768 bind 32768)
[    0.134351] UDP hash table entries: 2048 (order: 4, 65536 bytes)
[    0.134447] UDP-Lite hash table entries: 2048 (order: 4, 65536 bytes)
[    0.134664] NET: Registered protocol family 1
[    0.134888] RPC: Registered named UNIX socket transport module.
[    0.134906] RPC: Registered udp transport module.
[    0.134921] RPC: Registered tcp transport module.
[    0.134935] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.135130] Unpacking initramfs...
[    0.211416] Freeing initrd memory: 1708K (ffff80001fe54000 -
ffff80001ffff000)
[    0.212279] kvm [1]: 8-bit VMID
[    0.212295] kvm [1]: Hyp mode initialized successfully
[    0.212333] kvm [1]: GICv3: no GICV resource entry
[    0.212348] kvm [1]: disabling GICv2 emulation
[    0.212397] kvm [1]: vgic interrupt IRQ1
[    0.212501] kvm [1]: virtual timer IRQ4
[    0.214016] futex hash table entries: 1024 (order: 5, 131072 bytes)
[    0.214112] audit: initializing netlink subsys (disabled)
[    0.214163] audit: type=2000 audit(0.208:1): initialized
[    0.214514] workingset: timestamp_bits=44 max_order=20 bucket_order=0
[    0.222932] squashfs: version 4.0 (2009/01/31) Phillip Lougher
[    0.223636] NFS: Registering the id_resolver key type
[    0.223686] Key type id_resolver registered
[    0.223701] Key type id_legacy registered
[    0.223874] fuse init (API version 7.25)
[    0.224265] 9p: Installing v9fs 9p2000 file system support
[    0.226426] io scheduler noop registered
[    0.226559] io scheduler cfq registered (default)
[    0.226872] uniphier-system-bus 58c00000.system-bus: could not find
pctldev for node /soc/soc-glue@5f800000/pinctrl/system_bus_grp,
deferring probe
[    0.230392] xenfs: not registering filesystem on non-xen platform
[    0.233387] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    0.234743] 54006800.serial: ttyS0 at MMIO 0x54006800 (irq = 6,
base_baud = 3676470) is a 16550A
[    0.994393] console [ttyS0] enabled
[    0.998261] SuperH (H)SCI(F) driver initialized
[    1.003021] msm_serial: driver initialized
[    1.007444] Unable to detect cache hierarchy from DT for CPU 0
[    1.017234] loop: module loaded
[    1.021818] tun: Universal TUN/TAP device driver, 1.6
[    1.026910] tun: (C) 1999-2004 Max Krasnyansky <maxk@qualcomm.com>
[    1.033392] e1000e: Intel(R) PRO/1000 Network Driver - 3.2.6-k
[    1.039259] e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
[    1.045248] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.3.0-k
[    1.052240] igb: Copyright (c) 2007-2014 Intel Corporation.
[    1.057873] igbvf: Intel(R) Gigabit Virtual Function Network Driver
- version 2.0.2-k
[    1.065748] igbvf: Copyright (c) 2009 - 2012 Intel Corporation.
[    1.071734] sky2: driver version 1.30
[    1.075722] VFIO - User Level meta-driver version: 0.3
[    1.082416] uniphier-dwc3 65b00000.usb: Failed to map clock register
[    1.100499] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    1.107086] ehci-pci: EHCI PCI platform driver
[    1.111591] ehci-platform: EHCI generic platform driver
[    1.116901] ehci-msm: Qualcomm On-Chip EHCI Host Controller
[    1.122542] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    1.128758] ohci-pci: OHCI PCI platform driver
[    1.133264] ohci-platform: OHCI generic platform driver
[    1.138694] xhci-hcd: probe of xhci-hcd.0.auto failed with error -5
[    1.145064] usbcore: registered new interface driver usb-storage
[    1.151795] mousedev: PS/2 mouse device common for all mice
[    1.157926] i2c /dev entries driver
[    1.163385] sdhci: Secure Digital Host Controller Interface driver
[    1.169600] sdhci: Copyright(c) Pierre Ossman
[    1.174007] Synopsys Designware Multimedia Card Interface Driver
[    1.180271] sdhci-pltfm: SDHCI platform and OF driver helper
[    1.230787] mmc0: SDHCI controller on 5a000200.sdhc [5a000200.sdhc]
using ADMA 64-bit
[    1.239009] ledtrig-cpu: registered to indicate activity on CPUs
[    1.247106] usbcore: registered new interface driver usbhid
[    1.252715] usbhid: USB HID core driver
[    1.257593] NET: Registered protocol family 17
[    1.262173] 9pnet: Installing 9P2000 support
[    1.266555] Key type dns_resolver registered
[    1.271253] registered taskstats version 1
[    1.280365] 43f00000.ethernet supply vdd33a not found, using dummy regulator
[    1.287478] 43f00000.ethernet supply vddvario not found, using
dummy regulator
[    1.321295] libphy: smsc911x-mdio: probed
[    1.335238] mmc0: new high speed MMC card at address 0001
[    1.341056] mmcblk0: mmc0:0001 H4G2a 3.64 GiB
[    1.345810] mmcblk0boot0: mmc0:0001 H4G2a partition 1 4.00 MiB
[    1.351897] mmcblk0boot1: mmc0:0001 H4G2a partition 2 4.00 MiB
[    1.357964] mmcblk0rpmb: mmc0:0001 H4G2a partition 3 4.00 MiB
[    1.394910] Generic PHY 43f00000.etherne:01: attached PHY driver
[Generic PHY] (mii_bus:phy_addr=43f00000.etherne:01, irq=-1)
[    1.406518] smsc911x 43f00000.ethernet eth0: MAC Address: 7a:a5:8c:dc:ff:3e
[    1.413700] hctosys: unable to open rtc device (rtc0)
[    1.418919] ALSA device list:
[    1.421893]   No soundcards found.
[    1.425968] Freeing unused kernel memory: 960K (ffff800000af0000 -
ffff800000be0000)
Starting logging: OK
Initializing random number generator... [    1.467525] random: dd
urandom read with 1 bits of entropy available
done.
Starting network...

Welcome to Buildroot
buildroot login:




-- 
Best Regards
Masahiro Yamada
