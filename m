From: Niklas =?iso-8859-1?Q?S=F6derlund?=
        <niklas.soderlund@ragnatech.se>
Subject: Problem with 761ed4a (tty: serial_core: convert uart_close to use
 tty_port_close)
Date: Tue, 27 Sep 2016 13:01:40 +0200
Message-ID: <20160927110140.GG16263@bigcity.dyn.berto.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-renesas-soc-owner@vger.kernel.org
To: robh@kernel.org, vinod.koul@intel.com
Cc: linux-renesas-soc@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, peter@hurleysoftware.com
List-Id: linux-serial@vger.kernel.org

Hi Rob and Vinod,

While testing on Renesas Koelsch board Vinods 'next' branch at 

git://git.kernel.org/pub/scm/linux/kernel/git/vkoul/slave-dma.git

I ran into some problems with Robs patch 761ed4a (tty: serial_core: 
convert uart_close to use tty_port_close) and my systemd based init 
system. The kernel starts fine, mounts the NFS root and starts init but 
then the serial console go silent and I'm not able to communicate with 
the system.

[    0.000000] Booting Linux on physical CPU 0x0
[    0.000000] Linux version 4.8.0-rc5-00198-ga77656f (neg@bismarck) (gcc version 6.1.1 20160501 (GCC) ) #25 SMP Tue Sep 27 12:24:06 CEST 2016
[    0.000000] CPU: ARMv7 Processor [413fc0f2] revision 2 (ARMv7), cr=30c5387d
[    0.000000] CPU: div instructions available: patching division code
[    0.000000] CPU: PIPT / VIPT nonaliasing data cache, PIPT instruction cache
[    0.000000] OF: fdt:Machine model: Koelsch
[    0.000000] debug: ignoring loglevel setting.
[    0.000000] Forcing write-allocate cache policy for SMP
[    0.000000] Memory policy: Data cache writealloc
[    0.000000] On node 0 totalpages: 524288
[    0.000000] free_area_init_node: node 0, pgdat c0c30400, node_mem_map ebff9000
[    0.000000]   DMA zone: 1536 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 196608 pages, LIFO batch:31
[    0.000000]   HighMem zone: 327680 pages, LIFO batch:31
[    0.000000] percpu: Embedded 11 pages/cpu @ebfb3000 s24268 r0 d20788 u45056
[    0.000000] pcpu-alloc: s24268 r0 d20788 u45056 alloc=11*4096
[    0.000000] pcpu-alloc: [0] 0 [0] 1 
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 522752
[    0.000000] Kernel command line: ignore_loglevel rw root=/dev/nfs ip=dhcp
[    0.000000] PID hash table entries: 4096 (order: 2, 16384 bytes)
[    0.000000] Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
[    0.000000] Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Memory: 2068856K/2097152K available (6144K kernel code, 199K rwdata, 1436K rodata, 2048K init, 300K bss, 28296K reserved, 0K cma-reserved, 1310720K highmem)
[    0.000000] Virtual kernel memory layout:
[    0.000000]     vector  : 0xffff0000 - 0xffff1000   (   4 kB)
[    0.000000]     fixmap  : 0xffc00000 - 0xfff00000   (3072 kB)
[    0.000000]     vmalloc : 0xf0800000 - 0xff800000   ( 240 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xf0000000   ( 768 MB)
[    0.000000]     pkmap   : 0xbfe00000 - 0xc0000000   (   2 MB)
[    0.000000]       .text : 0xc0008000 - 0xc0800000   (8160 kB)
[    0.000000]       .init : 0xc0a00000 - 0xc0c00000   (2048 kB)
[    0.000000]       .data : 0xc0c00000 - 0xc0c31da0   ( 200 kB)
[    0.000000]        .bss : 0xc0c33000 - 0xc0c7e304   ( 301 kB)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	Build-time adjustment of leaf fanout to 32.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=8 to nr_cpu_ids=2.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=32, nr_cpu_ids=2
[    0.000000] NR_IRQS:16 nr_irqs:16 16
[    0.000000] arm_arch_timer: Architected cp15 timer(s) running at 10.00MHz (virt).
[    0.000000] clocksource: arch_sys_counter: mask: 0xffffffffffffff max_cycles: 0x24e6a1710, max_idle_ns: 440795202120 ns
[    0.000003] sched_clock: 56 bits at 10MHz, resolution 100ns, wraps every 4398046511100ns
[    0.000012] Switching to timer-based delay loop, resolution 100ns
[    0.000505] Console: colour dummy device 80x30
[    0.000786] console [tty0] enabled
[    0.000808] Calibrating delay loop (skipped), value calculated using timer frequency.. 20.00 BogoMIPS (lpj=100000)
[    0.000833] pid_max: default: 32768 minimum: 301
[    0.000938] Mount-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000954] Mountpoint-cache hash table entries: 2048 (order: 1, 8192 bytes)
[    0.001435] CPU: Testing write buffer coherency: ok
[    0.001613] CPU0: update cpu_capacity 1024
[    0.001628] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.002280] Setting up static identity map for 0x40200000 - 0x40200058
[    0.004197] CPU1: update cpu_capacity 1024
[    0.004203] CPU1: thread -1, cpu 1, socket 0, mpidr 80000001
[    0.004304] Brought up 2 CPUs
[    0.004352] SMP: Total of 2 processors activated (40.00 BogoMIPS).
[    0.004366] CPU: All CPU(s) started in SVC mode.
[    0.030137] devtmpfs: initialized
[    0.038972] VFP support v0.3: implementor 41 architecture 4 part 30 variant f rev 0
[    0.039302] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 19112604462750000 ns
[    0.064235] pinctrl core: initialized pinctrl subsystem
[    0.144383] NET: Registered protocol family 16
[    0.144559] DMA: preallocated 256 KiB pool for atomic coherent allocations
[    0.145150] No ATAGs?
[    0.145169] hw-breakpoint: Failed to enable monitor mode on CPU 0.
[    0.145223] IRQ2 is asserted, installing da9063/da9210 regulator quirk
[    0.196965] renesas_irqc e61c0000.interrupt-controller: driving 10 irqs
[    0.199993] sh-pfc e6060000.pfc: r8a77910_pfc support registered
[    0.381498] vgaarb: loaded
[    0.410467] SCSI subsystem initialized
[    0.410609] libata version 3.00 loaded.
[    0.410800] usbcore: registered new interface driver usbfs
[    0.410852] usbcore: registered new interface driver hub
[    0.410909] usbcore: registered new device driver usb
[    0.411639] i2c 6-0058: Masking da9063 interrupt sources
[    0.413396] i2c 6-0068: Masking da9210 interrupt sources
[    0.414232] i2c 6-0068: IRQ2 is not asserted, removing quirk
[    0.414290] i2c-sh_mobile e60b0000.i2c: I2C adapter 6, bus speed 100000 Hz
[    0.414478] media: Linux media interface: v0.10
[    0.414536] Linux video capture interface: v2.00
[    0.414859] sh_cmt ffca0000.timer: ch0: used for clock events
[    0.414880] sh_cmt ffca0000.timer: ch1: used as clock source
[    0.414898] clocksource: ffca0000.timer: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 1911260446275000000 ns
[    0.415492] Advanced Linux Sound Architecture Driver Initialized.
[    0.416149] clocksource: Switched to clocksource arch_sys_counter
[    0.656157] NET: Registered protocol family 2
[    0.736208] TCP established hash table entries: 8192 (order: 3, 32768 bytes)
[    0.736260] TCP bind hash table entries: 8192 (order: 4, 65536 bytes)
[    0.736352] TCP: Hash tables configured (established 8192 bind 8192)
[    0.736399] UDP hash table entries: 512 (order: 2, 16384 bytes)
[    0.736428] UDP-Lite hash table entries: 512 (order: 2, 16384 bytes)
[    0.776160] NET: Registered protocol family 1
[    0.816159] RPC: Registered named UNIX socket transport module.
[    0.816174] RPC: Registered udp transport module.
[    0.816187] RPC: Registered tcp transport module.
[    0.816200] RPC: Registered tcp NFSv4.1 backchannel transport module.
[    0.816217] PCI: CLS 0 bytes, default 64
[    0.856757] futex hash table entries: 512 (order: 3, 32768 bytes)
[    0.857252] workingset: timestamp_bits=30 max_order=19 bucket_order=0
[    1.026173] NFS: Registering the id_resolver key type
[    1.026204] Key type id_resolver registered
[    1.026217] Key type id_legacy registered
[    1.026238] nfs4filelayout_init: NFSv4 File Layout Driver Registering...
[    1.026253] nfs4flexfilelayout_init: NFSv4 Flexfile Layout Driver Registering...
[    1.027655] bounce: pool size: 64 pages
[    1.066219] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 249)
[    1.066242] io scheduler noop registered
[    1.066255] io scheduler deadline registered
[    1.106165] io scheduler cfq registered (default)
[    1.107474] gpio_rcar e6050000.gpio: driving 32 GPIOs
[    1.107887] gpio_rcar e6051000.gpio: driving 26 GPIOs
[    1.108304] gpio_rcar e6052000.gpio: driving 32 GPIOs
[    1.108720] gpio_rcar e6053000.gpio: driving 32 GPIOs
[    1.109133] gpio_rcar e6054000.gpio: driving 32 GPIOs
[    1.109555] gpio_rcar e6055000.gpio: driving 32 GPIOs
[    1.109974] gpio_rcar e6055400.gpio: driving 32 GPIOs
[    1.110364] gpio_rcar e6055800.gpio: driving 26 GPIOs
[    1.111048] pci-rcar-gen2 ee090000.pci: PCI: bus0 revision 11
[    1.111207] pci-rcar-gen2 ee090000.pci: PCI host bridge to bus 0000:00
[    1.111225] pci_bus 0000:00: root bus resource [mem 0xee080000-0xee0810ff]
[    1.111240] pci_bus 0000:00: No busn resource found for root bus, will use [bus 00-ff]
[    1.111284] pci 0000:00:00.0: [1033:0000] type 00 class 0x060000
[    1.111311] pci 0000:00:00.0: reg 0x10: [mem 0xee090800-0xee090bff]
[    1.111330] pci 0000:00:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    1.111533] pci 0000:00:01.0: [1033:0035] type 00 class 0x0c0310
[    1.111561] pci 0000:00:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    1.111638] pci 0000:00:01.0: supports D1 D2
[    1.111652] pci 0000:00:01.0: PME# supported from D0 D1 D2 D3hot
[    1.111848] pci 0000:00:02.0: [1033:00e0] type 00 class 0x0c0320
[    1.111876] pci 0000:00:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    1.111953] pci 0000:00:02.0: supports D1 D2
[    1.111967] pci 0000:00:02.0: PME# supported from D0 D1 D2 D3hot
[    1.112168] PCI: bus0: Fast back to back transfers disabled
[    1.112185] pci_bus 0000:00: busn_res: [bus 00-ff] end is updated to 00
[    1.112268] pci 0000:00:01.0: BAR 0: assigned [mem 0xee080000-0xee080fff]
[    1.112289] pci 0000:00:02.0: BAR 0: assigned [mem 0xee081000-0xee0810ff]
[    1.112333] pci 0000:00:01.0: enabling device (0140 -> 0142)
[    1.112377] pci 0000:00:02.0: enabling device (0140 -> 0142)
[    1.112576] pci-rcar-gen2 ee0d0000.pci: PCI: bus0 revision 11
[    1.112729] pci-rcar-gen2 ee0d0000.pci: PCI host bridge to bus 0001:01
[    1.112746] pci_bus 0001:01: root bus resource [mem 0xee0c0000-0xee0c10ff]
[    1.112761] pci_bus 0001:01: No busn resource found for root bus, will use [bus 01-ff]
[    1.112797] pci 0001:01:00.0: [1033:0000] type 00 class 0x060000
[    1.112821] pci 0001:01:00.0: reg 0x10: [mem 0xee0d0800-0xee0d0bff]
[    1.112839] pci 0001:01:00.0: reg 0x14: [mem 0x40000000-0x7fffffff pref]
[    1.113033] pci 0001:01:01.0: [1033:0035] type 00 class 0x0c0310
[    1.113062] pci 0001:01:01.0: reg 0x10: [mem 0x00000000-0x00000fff]
[    1.113138] pci 0001:01:01.0: supports D1 D2
[    1.113152] pci 0001:01:01.0: PME# supported from D0 D1 D2 D3hot
[    1.113342] pci 0001:01:02.0: [1033:00e0] type 00 class 0x0c0320
[    1.113370] pci 0001:01:02.0: reg 0x10: [mem 0x00000000-0x000000ff]
[    1.113445] pci 0001:01:02.0: supports D1 D2
[    1.113458] pci 0001:01:02.0: PME# supported from D0 D1 D2 D3hot
[    1.113655] PCI: bus1: Fast back to back transfers disabled
[    1.113673] pci_bus 0001:01: busn_res: [bus 01-ff] end is updated to 01
[    1.113801] pci 0001:01:01.0: BAR 0: assigned [mem 0xee0c0000-0xee0c0fff]
[    1.113821] pci 0001:01:02.0: BAR 0: assigned [mem 0xee0c1000-0xee0c10ff]
[    1.113857] pci 0001:01:01.0: enabling device (0140 -> 0142)
[    1.113896] pci 0001:01:02.0: enabling device (0140 -> 0142)
[    1.126306] DA9210: Bringing 1080000uV into 1000000-1000000uV
[    1.131485] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[    1.132596] SuperH (H)SCI(F) driver initialized
[    1.133106] e6e60000.serial: ttySC0 at MMIO 0xe6e60000 (irq = 109, base_baud = 0) is a scif
[    2.089408] console [ttySC0] enabled
[    2.093542] e6e68000.serial: ttySC1 at MMIO 0xe6e68000 (irq = 110, base_baud = 0) is a scif
[    2.102432] [drm] Initialized drm 1.1.0 20060810
[    2.107952] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    2.114573] [drm] No driver support for vblank timestamp query.
[    2.126073] da9063 6-0058: Device detected (chip-ID: 0x61, var-ID: 0x30)
[    2.141274] random: fast init done
[    2.149247] scsi host0: sata_rcar
[    2.152773] ata1: SATA max UDMA/133 irq 112
[    2.157899] renesas_spi e6b10000.spi: DMA available
[    2.163390] m25p80 spi0.0: s25fl512s (65536 Kbytes)
[    2.168325] 3 ofpart partitions found on MTD device spi0.0
[    2.173814] Creating 3 MTD partitions on "spi0.0":
[    2.178625] 0x000000000000-0x000000080000 : "loader"
[    2.184424] 0x000000080000-0x000000600000 : "user"
[    2.190090] 0x000000600000-0x000004000000 : "flash"
[    2.195689] renesas_spi e6b10000.spi: probed
[    2.200856] spi_sh_msiof e6e20000.spi: DMA available
[    2.206772] libphy: Fixed MDIO Bus: probed
[    2.211231] CAN device driver interface
[    2.216043] libphy: sh_mii: probed
[    2.220530] sh-eth ee700000.ethernet eth0: Base address at 0xee700000, 2e:09:0a:00:3d:cf, IRQ 111.
[    2.229789] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    2.236334] ehci-pci: EHCI PCI platform driver
[    2.240904] ehci-pci 0000:00:02.0: EHCI Host Controller
[    2.246161] ehci-pci 0000:00:02.0: new USB bus registered, assigned bus number 1
[    2.253671] ehci-pci 0000:00:02.0: irq 123, io mem 0xee081000
[    2.286155] ehci-pci 0000:00:02.0: USB 2.0 started, EHCI 1.00
[    2.292560] hub 1-0:1.0: USB hub found
[    2.296465] hub 1-0:1.0: 1 port detected
[    2.300800] ehci-pci 0001:01:02.0: EHCI Host Controller
[    2.306044] ehci-pci 0001:01:02.0: new USB bus registered, assigned bus number 2
[    2.313561] ehci-pci 0001:01:02.0: irq 124, io mem 0xee0c1000
[    2.346155] ehci-pci 0001:01:02.0: USB 2.0 started, EHCI 1.00
[    2.352498] hub 2-0:1.0: USB hub found
[    2.356293] hub 2-0:1.0: 1 port detected
[    2.360557] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    2.366758] ohci-pci: OHCI PCI platform driver
[    2.371275] ohci-pci 0000:00:01.0: OHCI PCI host controller
[    2.376881] ohci-pci 0000:00:01.0: new USB bus registered, assigned bus number 3
[    2.384315] ohci-pci 0000:00:01.0: irq 123, io mem 0xee080000
[    2.485366] hub 3-0:1.0: USB hub found
[    2.489163] hub 3-0:1.0: 1 port detected
[    2.493442] ohci-pci 0001:01:01.0: OHCI PCI host controller
[    2.499050] ohci-pci 0001:01:01.0: new USB bus registered, assigned bus number 4
[    2.506496] ohci-pci 0001:01:01.0: irq 124, io mem 0xee0c0000
[    2.596156] ata1: link resume succeeded after 1 retries
[    2.605371] hub 4-0:1.0: USB hub found
[    2.609172] hub 4-0:1.0: 1 port detected
[    2.613758] sh-pfc e6060000.pfc: pin GP_7_23 already requested by ee090000.pci; cannot claim for e6590000.usb
[    2.623704] sh-pfc e6060000.pfc: pin-247 (e6590000.usb) status -22
[    2.629903] sh-pfc e6060000.pfc: could not request pin 247 (GP_7_23) from group usb0  on device sh-pfc
[    2.639225] renesas_usbhs e6590000.usb: Error applying setting, reverse things back
[    2.647131] renesas_usbhs e6590000.usb: no transceiver found
[    2.652939] renesas_usbhs e6590000.usb: gadget probed
[    2.658100] phy phy-e6590100.usb-phy.1: phy init failed --> -16
[    2.664029] renesas_usbhs e6590000.usb: probed
[    2.668685] using random self ethernet address
[    2.673134] using random host ethernet address
[    2.678005] usb0: HOST MAC f6:98:9b:48:9c:1f
[    2.682297] usb0: MAC 46:44:ad:81:38:5a
[    2.686155] using random self ethernet address
[    2.690602] using random host ethernet address
[    2.695094] g_ether gadget: Ethernet Gadget, version: Memorial Day 2008
[    2.701720] g_ether gadget: g_ether ready
[    2.705916] mousedev: PS/2 mouse device common for all mice
[    2.712017] ata1: SATA link down (SStatus 0 SControl 300)
[    2.715942] renesas_usbhs e6590000.usb: fifo select error
[    2.737617] da9063-rtc da9063-rtc: rtc core: registered da9063-rtc as rtc0
[    2.749507] i2c /dev entries driver
[    2.760963] at24 2-0050: 256 byte 24c02 EEPROM, writable, 16 bytes/write
[    2.767716] i2c-rcar e6530000.i2c: probed
[    2.772136] adv7180 2-0020: chip found @ 0x20 (e6530000.i2c)
[    2.797695] rcar_jpu fe980000.jpeg-codec: encoder device registered as /dev/video0
[    2.805277] rcar_jpu fe980000.jpeg-codec: decoder device registered as /dev/video1
[    2.813207] vsp1: probe of fe928000.vsp1 failed with error -38
[    2.819201] vsp1: probe of fe930000.vsp1 failed with error -38
[    2.825153] vsp1: probe of fe938000.vsp1 failed with error -38
[    2.833655] rcar_thermal e61f0000.thermal: 1 sensor probed
[    2.845385] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    2.850326] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    2.855633] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    2.860568] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[    2.865861] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    2.871706] usbcore: registered new interface driver usbhid
[    2.877303] usbhid: USB HID core driver
[    2.887304] rcar_sound ec500000.sound: probed
[    3.056165] NET: Registered protocol family 10
[    3.096201] sit: IPv6, IPv4 and MPLS over IPv4 tunneling driver
[    3.102636] NET: Registered protocol family 17
[    3.107123] can: controller area network core (rev 20120528 abi 9)
[    3.113347] NET: Registered protocol family 29
[    3.117814] can: raw protocol (rev 20120528)
[    3.122089] can: broadcast manager protocol (rev 20160617 t)
[    3.127773] can: netlink gateway (rev 20130117) max_hops=1
[    3.166205] Key type dns_resolver registered
[    3.170550] Registering SWP/SWPB emulation handler
[    3.178178] [drm] Supports vblank timestamp caching Rev 2 (21.10.2013).
[    3.184802] [drm] No driver support for vblank timestamp query.
[    3.192038] rcar-du feb00000.display: No connectors reported connected with modes
[    3.199556] [drm] Cannot find any crtc or sizes - going 1024x768
[    3.212919] Console: switching to colour frame buffer device 128x48
[    3.225245] rcar-du feb00000.display: fb0:  frame buffer device
[    3.231594] [drm] Device feb00000.display probed
[    3.236844] sh_mobile_sdhi ee100000.sd: Got CD GPIO
[    3.241805] sh_mobile_sdhi ee100000.sd: Got WP GPIO
[    3.456344] sh_mobile_sdhi ee100000.sd: mmc0 base at 0xee100000 max clock rate 97 MHz
[    3.464729] sh_mobile_sdhi ee140000.sd: Got CD GPIO
[    3.469712] sh_mobile_sdhi ee140000.sd: Got WP GPIO
[    3.676317] sh_mobile_sdhi ee140000.sd: mmc1 base at 0xee140000 max clock rate 97 MHz
[    3.684715] sh_mobile_sdhi ee160000.sd: Got CD GPIO
[    3.816292] mmc0: new high speed SDHC card at address aaaa
[    3.822157] mmcblk0: mmc0:aaaa SU04G 3.69 GiB 
[    3.842198]  mmcblk0: p1
[    3.896325] sh_mobile_sdhi ee160000.sd: mmc2 base at 0xee160000 max clock rate 97 MHz
[    3.905811] asoc-simple-card sound: ak4642-hifi <-> ec500000.sound mapping ok
[    3.915088] input: keyboard as /devices/platform/keyboard/input/input0
[    3.923717] da9063-rtc da9063-rtc: setting system clock to 2000-01-01 00:00:01 UTC (946684801)
[    4.028329] Micrel KSZ8041RNLI ee700000.etherne:01: attached PHY driver [Micrel KSZ8041RNLI] (mii_bus:phy_addr=ee700000.etherne:01, irq=402)
[    4.043552] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[    4.051879] IPv6: ADDRCONF(NETDEV_UP): usb0: link is not ready
[    7.046091] sh-eth ee700000.ethernet eth0: Link is Up - 100Mbps/Full - flow control rx/tx
[    7.056798] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[    7.086153] Sending DHCP requests ., OK
[    7.166152] IP-Config: Got DHCP answer from 10.0.1.1, my address is 10.0.1.6
[    7.176011] IP-Config: Complete:
[    7.181831]      device=eth0, hwaddr=2e:09:0a:00:3d:cf, ipaddr=10.0.1.6, mask=255.255.255.0, gw=10.0.1.1
[    7.194041]      host=10.0.1.6, domain=dyn.berto.se, nis-domain=(none)
[    7.203338]      bootserver=10.0.1.1, rootserver=10.0.1.1, rootpath=/srv/nfs4/arch     nameserver0=192.168.0.50
[    7.216368] SDHI1 Vcc: disabling
[    7.222445] SDHI2 Vcc: disabling
[    7.228496] SDHI1 VccQ: disabling
[    7.234608] SDHI2 VccQ: disabling
[    7.240892] ALSA device list:
[    7.246604]   #0: rsnd-dai.0-ak4642-hifi
[    7.256753] VFS: Mounted root (nfs filesystem) on device 0:13.
[    7.265560] devtmpfs: mounted
[    7.272433] Freeing unused kernel memory: 2048K (c0a00000 - c0c00000)
[   12.247014] systemd[1]: System time before build time, advancing clock.

<system is dead here, it responds to ping but I'm not able to ssh to it 
or get any other life sign out of the system>

A bisect points to the patch mentioned above and reverting it allows 
systemd to boot the system. I'm running a arm arch linux NFS root using 
systemd version 231. If I instead use a initrd with a busybox init 
system the same kernel boots just fine on the same hardware.

If I dump the network traffic to/from target I see some files being read 
after the NFS root have been mounted but not much. So my conclusion is 
that the init process have halted for some reason, not sure why. Among 
the last files being read are /etc/modprobe.d/ files.

I also tried a earlier commit in the same branch just before the branch 
'topic/iommu' which contains the patches I was aiming to test was 
included with the same result. So as far as I can tell the DMAC+IPMMU 
patches for rcar-dmac play no part in this. I might do something else 
wrong or miss some config option. My config and NFS root have however 
worked in the past.

I don't know much about how systemd works nor the patch in question, so 
I don't know how much help I can be in figuring this out. I'm however 
more then happy to help testing or trying to debug in other ways if it's 
helpful.

-- 
Regards,
Niklas Söderlund
