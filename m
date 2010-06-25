From: Gerold Gruber <Gerold.Gruber@edv2g.de>
Subject: kernel oops with  Titan Electronics Inc VScom 800L
Date: Fri, 25 Jun 2010 19:31:24 +0200
Message-ID: <4C24E7EC.4010604@edv2g.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020409030203060508060406"
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from support.edv2g.de ([80.152.179.35]:56900 "EHLO support.edv2g.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab0FYRhC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 Jun 2010 13:37:02 -0400
Received: from victoria.privat.edv2g.de ([192.168.41.83]:32884)
	by support.edv2g.de with esmtp (Exim 4.69)
	(envelope-from <Gerold.Gruber@edv2g.de>)
	id 1OSCk5-0003oq-0x
	for linux-serial@vger.kernel.org; Fri, 25 Jun 2010 19:31:05 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by victoria.privat.edv2g.de (Postfix) with ESMTP id 31383110D2
	for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2010 19:31:05 +0200 (CEST)
Received: from victoria.privat.edv2g.de ([127.0.0.1])
	by localhost (victoria.privat.edv2g.de [127.0.0.1]) (amavisd-new, port 10048)
	with ESMTP id 23959-01 for <linux-serial@vger.kernel.org>;
	Fri, 25 Jun 2010 19:31:05 +0200 (CEST)
Received: from [127.0.0.1] (themis.dmz.edv2g.de [192.168.42.195])
	by victoria.privat.edv2g.de (Postfix) with ESMTP id F128D110CF
	for <linux-serial@vger.kernel.org>; Fri, 25 Jun 2010 19:31:04 +0200 (CEST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

This is a multi-part message in MIME format.
--------------020409030203060508060406
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Hi,

I run an older box as server for a couple of serial consoles,
so I equipped it with a  Titan Electronics Inc VScom 800L.

now I installed debian lenny on the box and after some trouble
with this card I compiled a vanilla  2.6.32.15 kernel.

The board is a  ASUS A7V333 ACPI BIOS Revision 1017.
Interrupts are handled by APIC.

The card is recognised properly, setserial on system startup
runs smoothly.

But when I access the first port on the card with minicom
I get a kernel oops:
[  426.358233] irq 17: nobody cared (try booting with the "irqpoll" option)
[  426.358773] Pid: 0, comm: swapper Not tainted 2.6.32.15-1-k7 #1
[  426.359244] Call Trace:
[  426.359453]  [<c103b7b0>] ? __report_bad_irq+0x24/0x69
[  426.359865]  [<c103b7b7>] ? __report_bad_irq+0x2b/0x69
[  426.360001]  [<c103b8dc>] ? note_interrupt+0xe7/0x13f
[  426.360001]  [<c103bd67>] ? handle_fasteoi_irq+0x63/0x75
[  426.360001]  [<c1004177>] ? handle_irq+0x17/0x1c
[  426.360001]  [<c1003d99>] ? do_IRQ+0x2b/0x76
[  426.360001]  [<c1002e29>] ? common_interrupt+0x29/0x30
[  426.360001]  [<c10072cc>] ? default_idle+0x25/0x38
[  426.360001]  [<c1001b4a>] ? cpu_idle+0x19/0x2f
[  426.360001]  [<c12e066e>] ? start_kernel+0x25f/0x262
[  426.360001] handlers:
[  426.360001] [<c113482b>] (serial8250_interrupt+0x0/0xad)
[  426.360001] Disabling IRQ #17

Afterwards I can use all ports of the card.

and /proc/interrupts shows

  0:         44   IO-APIC-edge      timer
  1:       4014   IO-APIC-edge      i8042
  3:         11   IO-APIC-edge
  4:         15   IO-APIC-edge
  6:          3   IO-APIC-edge      floppy
  8:          2   IO-APIC-edge      rtc0
  9:          0   IO-APIC-fasteoi   acpi
 14:      73703   IO-APIC-edge      pata_via
 15:        360   IO-APIC-edge      pata_via
 16:      59904   IO-APIC-fasteoi   eth0
 17:     177327   IO-APIC-fasteoi   serial
 21:          0   IO-APIC-fasteoi   uhci_hcd:usb1, uhci_hcd:usb2
NMI:          0   Non-maskable interrupts
LOC:   21098426   Local timer interrupts
SPU:          0   Spurious interrupts
PMI:          0   Performance monitoring interrupts
PND:          0   Performance pending work
TRM:          0   Thermal event interrupts
THR:          0   Threshold APIC interrupts
MCE:          0   Machine check exceptions
MCP:        265   Machine check polls
ERR:          0
MIS:          0

Use of the suggested irqpoll didn't make things better.

I append my dmesg and lspci.

Could anybody have a look at this, please?
Should I be worried about this?

Best regards

Gerold

--------------020409030203060508060406
Content-Type: text/plain;
 name="dmesg"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dmesg"

[    0.000000] Linux version 2.6.32.15-1-k7 (root@egeria) (gcc version 4.3.2 (Debian 4.3.2-1.1) ) #1 Wed Jun 23 23:27:47 CEST 2010
[    0.000000] KERNEL supported cpus:
[    0.000000]   Intel GenuineIntel
[    0.000000]   AMD AuthenticAMD
[    0.000000]   NSC Geode by NSC
[    0.000000]   Cyrix CyrixInstead
[    0.000000]   Centaur CentaurHauls
[    0.000000]   Transmeta GenuineTMx86
[    0.000000]   Transmeta TransmetaCPU
[    0.000000]   UMC UMC UMC UMC
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
[    0.000000]  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000001fffc000 (usable)
[    0.000000]  BIOS-e820: 000000001fffc000 - 000000001ffff000 (ACPI data)
[    0.000000]  BIOS-e820: 000000001ffff000 - 0000000020000000 (ACPI NVS)
[    0.000000]  BIOS-e820: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  BIOS-e820: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] DMI 2.3 present.
[    0.000000] last_pfn = 0x1fffc max_arch_pfn = 0x100000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-EFFFF uncachable
[    0.000000]   F0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000 mask FE0000000 write-back
[    0.000000]   1 disabled
[    0.000000]   2 disabled
[    0.000000]   3 disabled
[    0.000000]   4 disabled
[    0.000000]   5 disabled
[    0.000000]   6 disabled
[    0.000000]   7 base 0F8000000 mask FFC000000 write-combining
[    0.000000] e820 update range: 0000000000001000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] modified physical RAM map:
[    0.000000]  modified: 0000000000000000 - 0000000000001000 (usable)
[    0.000000]  modified: 0000000000001000 - 0000000000010000 (reserved)
[    0.000000]  modified: 0000000000010000 - 000000000009fc00 (usable)
[    0.000000]  modified: 000000000009fc00 - 00000000000a0000 (reserved)
[    0.000000]  modified: 00000000000f0000 - 0000000000100000 (reserved)
[    0.000000]  modified: 0000000000100000 - 000000001fffc000 (usable)
[    0.000000]  modified: 000000001fffc000 - 000000001ffff000 (ACPI data)
[    0.000000]  modified: 000000001ffff000 - 0000000020000000 (ACPI NVS)
[    0.000000]  modified: 00000000fec00000 - 00000000fec01000 (reserved)
[    0.000000]  modified: 00000000fee00000 - 00000000fee01000 (reserved)
[    0.000000]  modified: 00000000ffff0000 - 0000000100000000 (reserved)
[    0.000000] initial memory mapped : 0 - 01800000
[    0.000000] init_memory_mapping: 0000000000000000-000000001fffc000
[    0.000000]  0000000000 - 0000400000 page 4k
[    0.000000]  0000400000 - 001fc00000 page 2M
[    0.000000]  001fc00000 - 001fffc000 page 4k
[    0.000000] kernel direct mapping tables up to 1fffc000 @ 10000-15000
[    0.000000] RAMDISK: 1fe5e000 - 1ffebd99
[    0.000000] ACPI: RSDP 000f5c10 00014 (v00 ASUS  )
[    0.000000] ACPI: RSDT 1fffc000 00030 (v01 ASUS   A7V333   42302E31 MSFT 31313031)
[    0.000000] ACPI: FACP 1fffc0b2 00074 (v01 ASUS   A7V333   42302E31 MSFT 31313031)
[    0.000000] ACPI: DSDT 1fffc126 02124 (v01   ASUS A7V333   00001000 MSFT 0100000B)
[    0.000000] ACPI: FACS 1ffff000 00040
[    0.000000] ACPI: BOOT 1fffc030 00028 (v01 ASUS   A7V333   42302E31 MSFT 31313031)
[    0.000000] ACPI: APIC 1fffc058 0005A (v01 ASUS   A7V333   42302E31 MSFT 31313031)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] 0MB HIGHMEM available.
[    0.000000] 511MB LOWMEM available.
[    0.000000]   mapped low ram: 0 - 1fffc000
[    0.000000]   low ram: 0 - 1fffc000
[    0.000000]   node 0 low ram: 00000000 - 1fffc000
[    0.000000]   node 0 bootmap 00011000 - 00015000
[    0.000000] (7 early reservations) ==> bootmem [0000000000 - 001fffc000]
[    0.000000]   #0 [0000000000 - 0000001000]   BIOS data page ==> [0000000000 - 0000001000]
[    0.000000]   #1 [0001000000 - 0001375940]    TEXT DATA BSS ==> [0001000000 - 0001375940]
[    0.000000]   #2 [001fe5e000 - 001ffebd99]          RAMDISK ==> [001fe5e000 - 001ffebd99]
[    0.000000]   #3 [000009fc00 - 0000100000]    BIOS reserved ==> [000009fc00 - 0000100000]
[    0.000000]   #4 [0001376000 - 000137c148]              BRK ==> [0001376000 - 000137c148]
[    0.000000]   #5 [0000010000 - 0000011000]          PGTABLE ==> [0000010000 - 0000011000]
[    0.000000]   #6 [0000011000 - 0000015000]          BOOTMAP ==> [0000011000 - 0000015000]
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000000 -> 0x00001000
[    0.000000]   Normal   0x00001000 -> 0x0001fffc
[    0.000000]   HighMem  0x0001fffc -> 0x0001fffc
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[3] active PFN ranges
[    0.000000]     0: 0x00000000 -> 0x00000001
[    0.000000]     0: 0x00000010 -> 0x0000009f
[    0.000000]     0: 0x00000100 -> 0x0001fffc
[    0.000000] On node 0 totalpages: 130956
[    0.000000] free_area_init_node: node 0, pgdat c12dc2cc, node_mem_map c137e000
[    0.000000]   DMA zone: 32 pages used for memmap
[    0.000000]   DMA zone: 0 pages reserved
[    0.000000]   DMA zone: 3952 pages, LIFO batch:0
[    0.000000]   Normal zone: 992 pages used for memmap
[    0.000000]   Normal zone: 125980 pages, LIFO batch:31
[    0.000000] Using APIC driver default
[    0.000000] ACPI: PM-Timer IO Port: 0xe408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x00] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 2, version 2, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl edge)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 low level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] nr_irqs_gsi: 24
[    0.000000] Allocating PCI resources starting at 20000000 (gap: 20000000:dec00000)
[    0.000000] Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 129932
[    0.000000] Kernel command line: root=/dev/sda1 ro vga=791
[    0.000000] PID hash table entries: 2048 (order: 1, 8192 bytes)
[    0.000000] Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
[    0.000000] Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
[    0.000000] Enabling fast FPU save and restore... done.
[    0.000000] Enabling unmasked SIMD FPU exception support... done.
[    0.000000] Initializing CPU#0
[    0.000000] Initializing HighMem for node 0 (00000000:00000000)
[    0.000000] Memory: 513832k/524272k available (1972k kernel code, 9684k reserved, 968k data, 312k init, 0k highmem)
[    0.000000] virtual kernel memory layout:
[    0.000000]     fixmap  : 0xfffa4000 - 0xfffff000   ( 364 kB)
[    0.000000]     pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
[    0.000000]     vmalloc : 0xe07fc000 - 0xff7fe000   ( 496 MB)
[    0.000000]     lowmem  : 0xc0000000 - 0xdfffc000   ( 511 MB)
[    0.000000]       .init : 0xc12e0000 - 0xc132e000   ( 312 kB)
[    0.000000]       .data : 0xc11ed080 - 0xc12df0f0   ( 968 kB)
[    0.000000]       .text : 0xc1000000 - 0xc11ed080   (1972 kB)
[    0.000000] Checking if this processor honours the WP bit even in supervisor mode...Ok.
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:288
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] Fast TSC calibration using PIT
[    0.000000] Detected 1401.727 MHz processor.
[    0.004005] Calibrating delay loop (skipped), value calculated using timer frequency.. 2803.45 BogoMIPS (lpj=5606908)
[    0.004073] Mount-cache hash table entries: 512
[    0.004220] CPU: L1 I Cache: 64K (64 bytes/line), D cache 64K (64 bytes/line)
[    0.004229] CPU: L2 Cache: 256K (64 bytes/line)
[    0.004238] mce: CPU supports 4 MCE banks
[    0.004264] CPU: AMD Athlon(TM) XP 1600+ stepping 02
[    0.004277] Checking 'hlt' instruction... OK.
[    0.020250] ACPI: Core revision 20090903
[    0.024671] Enabling APIC mode:  Flat.  Using 1 I/O APICs
[    0.025696] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.068000] NET: Registered protocol family 16
[    0.068000] ACPI: bus type pci registered
[    0.068000] PCI: PCI BIOS revision 2.10 entry at 0xf17e0, last bus=1
[    0.068000] PCI: Using configuration type 1 for base access
[    0.068864] bio: create slab <bio-0> at 0
[    0.069344] ACPI: EC: Look up EC in DSDT
[    0.074231] ACPI: Interpreter enabled
[    0.074257] ACPI: (supports S0 S1 S5)
[    0.074286] ACPI: Using IOAPIC for interrupt routing
[    0.081530] ACPI: No dock devices found.
[    0.081706] ACPI: PCI Root Bridge [PCI0] (0000:00)
[    0.081810] pci 0000:00:00.0: reg 10 32bit mmio pref: [0xf8000000-0xfbffffff]
[    0.081905] pci 0000:00:01.0: supports D1
[    0.081942] pci 0000:00:05.0: reg 10 io port: [0xd800-0xd8ff]
[    0.081984] pci 0000:00:05.0: supports D1 D2
[    0.082025] pci 0000:00:0d.0: reg 10 io port: [0xd400-0xd4ff]
[    0.082033] pci 0000:00:0d.0: reg 14 32bit mmio: [0xf4800000-0xf48000ff]
[    0.082057] pci 0000:00:0d.0: reg 30 32bit mmio pref: [0x000000-0x00ffff]
[    0.082075] pci 0000:00:0d.0: supports D1 D2
[    0.082079] pci 0000:00:0d.0: PME# supported from D1 D2 D3hot D3cold
[    0.082090] pci 0000:00:0d.0: PME# disabled
[    0.082117] pci 0000:00:0e.0: reg 10 io port: [0xd000-0xd007]
[    0.082125] pci 0000:00:0e.0: reg 14 io port: [0xb800-0xb807]
[    0.082133] pci 0000:00:0e.0: reg 18 io port: [0xb400-0xb407]
[    0.082141] pci 0000:00:0e.0: reg 1c io port: [0xb000-0xb007]
[    0.082150] pci 0000:00:0e.0: reg 20 io port: [0xa800-0xa83f]
[    0.082278] pci 0000:00:11.1: reg 20 io port: [0xa400-0xa40f]
[    0.082349] pci 0000:00:11.2: reg 20 io port: [0xa000-0xa01f]
[    0.082416] pci 0000:00:11.3: reg 20 io port: [0x9800-0x981f]
[    0.082491] pci 0000:01:00.0: reg 10 32bit mmio: [0xf5000000-0xf5ffffff]
[    0.082499] pci 0000:01:00.0: reg 14 32bit mmio pref: [0xf7000000-0xf7ffffff]
[    0.082518] pci 0000:01:00.0: reg 30 32bit mmio pref: [0xf6c00000-0xf6ffffff]
[    0.082563] pci 0000:00:01.0: bridge 32bit mmio: [0xf5000000-0xf6afffff]
[    0.082570] pci 0000:00:01.0: bridge 32bit mmio pref: [0xf6c00000-0xf7ffffff]
[    0.082580] pci_bus 0000:00: on NUMA node 0
[    0.082587] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.082798] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.PCI1._PRT]
[    0.084371] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.084511] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.084641] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.084769] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 4 5 6 7 10 11 12 14 15) *0, disabled.
[    0.084897] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 *12 14)
[    0.085137] vgaarb: device added: PCI:0000:01:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.085148] vgaarb: loaded
[    0.085401] SCSI subsystem initialized
[    0.085446] libata version 3.00 loaded.
[    0.085559] usbcore: registered new interface driver usbfs
[    0.085651] usbcore: registered new interface driver hub
[    0.085713] usbcore: registered new device driver usb
[    0.085935] PCI: Using ACPI for IRQ routing
[    0.086174] Switching to clocksource tsc
[    0.086222] pnp: PnP ACPI init
[    0.086237] ACPI: bus type pnp registered
[    0.089090] pnp: PnP ACPI: found 13 devices
[    0.089101] ACPI: ACPI bus type pnp unregistered
[    0.089110] PnPBIOS: Disabled by ACPI PNP
[    0.089131] system 00:00: iomem range 0x0-0x9ffff could not be reserved
[    0.089141] system 00:00: iomem range 0xf0000-0xfffff could not be reserved
[    0.089151] system 00:00: iomem range 0x100000-0x1fffffff could not be reserved
[    0.089161] system 00:00: iomem range 0xfec00000-0xfec000ff could not be reserved
[    0.089171] system 00:00: iomem range 0xfee00000-0xfee00fff has been reserved
[    0.089186] system 00:02: ioport range 0xe400-0xe47f has been reserved
[    0.089195] system 00:02: ioport range 0xe800-0xe81f has been reserved
[    0.089204] system 00:02: iomem range 0xfff80000-0xffffffff could not be reserved
[    0.089215] system 00:02: iomem range 0xffb80000-0xffbfffff has been reserved
[    0.089229] system 00:03: ioport range 0x4d0-0x4d1 has been reserved
[    0.089243] system 00:0c: ioport range 0x290-0x291 has been reserved
[    0.089252] system 00:0c: ioport range 0x370-0x372 has been reserved
[    0.124519] pci 0000:00:01.0: PCI bridge, secondary bus 0000:01
[    0.124531] pci 0000:00:01.0:   IO window: disabled
[    0.124541] pci 0000:00:01.0:   MEM window: 0xf5000000-0xf6afffff
[    0.124551] pci 0000:00:01.0:   PREFETCH window: 0xf6c00000-0xf7ffffff
[    0.124575] pci 0000:00:01.0: setting latency timer to 64
[    0.124583] pci_bus 0000:00: resource 0 io:  [0x00-0xffff]
[    0.124588] pci_bus 0000:00: resource 1 mem: [0x000000-0xffffffff]
[    0.124594] pci_bus 0000:01: resource 1 mem: [0xf5000000-0xf6afffff]
[    0.124598] pci_bus 0000:01: resource 2 pref mem [0xf6c00000-0xf7ffffff]
[    0.124669] NET: Registered protocol family 2
[    0.124811] IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
[    0.125268] TCP established hash table entries: 16384 (order: 5, 131072 bytes)
[    0.125523] TCP bind hash table entries: 16384 (order: 4, 65536 bytes)
[    0.125677] TCP: Hash tables configured (established 16384 bind 16384)
[    0.125686] TCP reno registered
[    0.125774] NET: Registered protocol family 1
[    0.125803] pci 0000:00:01.0: disabling DAC on VIA PCI bridge
[    0.125879] pci 0000:01:00.0: Boot video device
[    0.125952] Trying to unpack rootfs image as initramfs...
[    0.208623] Freeing initrd memory: 1591k freed
[    0.211713] Simple Boot Flag at 0x3a set to 0x1
[    0.212259] Scanning for low memory corruption every 60 seconds
[    0.212789] HugeTLB registered 4 MB page size, pre-allocated 0 pages
[    0.212876] VFS: Disk quotas dquot_6.5.2
[    0.212931] Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
[    0.213030] msgmni has been set to 1007
[    0.213222] alg: No test for stdrng (krng)
[    0.213295] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 253)
[    0.213307] io scheduler noop registered
[    0.213313] io scheduler anticipatory registered
[    0.213319] io scheduler deadline registered
[    0.213334] io scheduler cfq registered (default)
[    0.213634] vesafb: framebuffer at 0xf7000000, mapped to 0xe0880000, using 3072k, total 4096k
[    0.213647] vesafb: mode is 1024x768x16, linelength=2048, pages=0
[    0.213654] vesafb: protected mode interface info at c000:4d96
[    0.213662] vesafb: pmi: set display start = c00c4dbd, set palette = c00c4e1f
[    0.213669] vesafb: pmi: ports = 3b4 3b5 3ba 3c0 3c1 3c4 3c5 3c6 3c7 3c8 3c9 3cc 3ce 3cf 3d0 3d1 3d2 3d3 3d4 3d5 3da 
[    0.213695] vesafb: scrolling: redraw
[    0.213703] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    0.255810] Console: switching to colour frame buffer device 128x48
[    0.294071] fb0: VESA VGA frame buffer device
[    0.294513] isapnp: Scanning for PnP cards...
[    0.604838] isapnp: No Plug & Play device found
[    0.609060] Serial: 8250/16550 driver, 16 ports, IRQ sharing enabled
[    0.609713] serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.610367] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.611988] 00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
[    0.612627] 00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    0.613234] serial 0000:00:0e.0: enabling device (0000 -> 0001)
[    0.613722] serial 0000:00:0e.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    0.614800] 0000:00:0e.0: ttyS4 at I/O 0xb800 (irq = 17) is a 16550A
[    0.615470] 0000:00:0e.0: ttyS5 at I/O 0xb400 (irq = 17) is a 16550A
[    0.616126] 0000:00:0e.0: ttyS6 at I/O 0xa800 (irq = 17) is a 16550A
[    0.616781] 0000:00:0e.0: ttyS7 at I/O 0xa808 (irq = 17) is a 16550A
[    0.617435] 0000:00:0e.0: ttyS8 at I/O 0xa810 (irq = 17) is a 16550A
[    0.618104] 0000:00:0e.0: ttyS9 at I/O 0xa818 (irq = 17) is a 16550A
[    0.618760] 0000:00:0e.0: ttyS10 at I/O 0xa820 (irq = 17) is a 16550A
[    0.619421] 0000:00:0e.0: ttyS11 at I/O 0xa828 (irq = 17) is a 16550A
[    0.634331] brd: module loaded
[    0.646800] Uniform Multi-Platform E-IDE driver
[    0.659519] pata_via 0000:00:11.1: version 0.3.4
[    0.659542] pata_via 0000:00:11.1: can't derive routing for PCI INT A
[    0.672472] scsi0 : pata_via
[    0.685089] scsi1 : pata_via
[    0.698171] ata1: PATA max UDMA/133 cmd 0x1f0 ctl 0x3f6 bmdma 0xa400 irq 14
[    0.710621] ata2: PATA max UDMA/133 cmd 0x170 ctl 0x376 bmdma 0xa408 irq 15
[    0.722971] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    0.735356] ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
[    0.747625] uhci_hcd: USB Universal Host Controller Interface driver
[    0.759775] uhci_hcd 0000:00:11.2: PCI INT D -> GSI 21 (level, low) -> IRQ 21
[    0.772086] uhci_hcd 0000:00:11.2: UHCI Host Controller
[    0.784375] uhci_hcd 0000:00:11.2: new USB bus registered, assigned bus number 1
[    0.796989] uhci_hcd 0000:00:11.2: irq 21, io base 0x0000a000
[    0.809655] usb usb1: New USB device found, idVendor=1d6b, idProduct=0001
[    0.822356] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.834908] usb usb1: Product: UHCI Host Controller
[    0.847258] usb usb1: Manufacturer: Linux 2.6.32.15-1-k7 uhci_hcd
[    0.859693] usb usb1: SerialNumber: 0000:00:11.2
[    0.872056] usb usb1: configuration #1 chosen from 1 choice
[    0.884381] hub 1-0:1.0: USB hub found
[    0.896370] hub 1-0:1.0: 2 ports detected
[    0.908358] uhci_hcd 0000:00:11.3: PCI INT D -> GSI 21 (level, low) -> IRQ 21
[    0.920627] uhci_hcd 0000:00:11.3: UHCI Host Controller
[    0.932628] uhci_hcd 0000:00:11.3: new USB bus registered, assigned bus number 2
[    0.944706] uhci_hcd 0000:00:11.3: irq 21, io base 0x00009800
[    0.956755] usb usb2: New USB device found, idVendor=1d6b, idProduct=0001
[    0.969052] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    0.981321] usb usb2: Product: UHCI Host Controller
[    0.993447] usb usb2: Manufacturer: Linux 2.6.32.15-1-k7 uhci_hcd
[    1.005924] usb usb2: SerialNumber: 0000:00:11.3
[    1.018338] usb usb2: configuration #1 chosen from 1 choice
[    1.031011] hub 2-0:1.0: USB hub found
[    1.043437] hub 2-0:1.0: 2 ports detected
[    1.055980] PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
[    1.068388] PNP: PS/2 appears to have AUX port disabled, if this is incorrect please boot with i8042.nopnp
[    1.082409] serio: i8042 KBD port at 0x60,0x64 irq 1
[    1.096006] mice: PS/2 mouse device common for all mice
[    1.109753] rtc_cmos 00:05: RTC can wake from S4
[    1.123740] rtc_cmos 00:05: rtc core: registered rtc_cmos as rtc0
[    1.137986] rtc0: alarms up to one month, 242 bytes nvram
[    1.152247] cpuidle: using governor ladder
[    1.167226] TCP cubic registered
[    1.181418] NET: Registered protocol family 17
[    1.195695] Using IPI Shortcut mode
[    1.210442] rtc_cmos 00:05: setting system clock to 2010-06-24 19:16:40 UTC (1277407000)
[    1.231170] input: AT Translated Set 2 keyboard as /devices/platform/i8042/serio0/input/input0
[    1.247813] ata1.00: ATA-5: WDC WD400BB-00GFA0, 09.01B09, max UDMA/100
[    1.262977] ata1.00: 78165360 sectors, multi 16: LBA 
[    1.278333] ata1.01: ATAPI: _NEC DVD_RW ND-1300A, 1.0B, max UDMA/33
[    1.307200] ata1.00: configured for UDMA/100
[    1.338124] ata1.01: configured for UDMA/33
[    1.353435] scsi 0:0:0:0: Direct-Access     ATA      WDC WD400BB-00GF 09.0 PQ: 0 ANSI: 5
[    1.372068] scsi 0:0:1:0: CD-ROM            _NEC     DVD_RW ND-1300A  1.0B PQ: 0 ANSI: 5
[    1.556479] ata2.00: ATA-7: SAMSUNG SP1604N, TM100-24, max UDMA/100
[    1.571827] ata2.00: 312581808 sectors, multi 16: LBA48 
[    1.587157] ata2.01: ATAPI: SONY    SDX-260V, 0100, max UDMA/100
[    1.608329] ata2.00: configured for UDMA/100
[    1.636325] ata2.01: configured for UDMA/100
[    1.686103] scsi 1:0:0:0: Direct-Access     ATA      SAMSUNG SP1604N  TM10 PQ: 0 ANSI: 5
[    1.702437] scsi 1:0:1:0: Sequential-Access SONY     SDX-260V         0100 PQ: 0 ANSI: 2
[    1.717867] Freeing unused kernel memory: 312k freed
[    1.808234] ide-gd driver 1.18
[    2.168323] sd 0:0:0:0: [sda] 78165360 512-byte logical blocks: (40.0 GB/37.2 GiB)
[    2.190907] sd 1:0:0:0: [sdb] 312581808 512-byte logical blocks: (160 GB/149 GiB)
[    2.313215] sd 0:0:0:0: [sda] Write Protect is off
[    2.329746] sd 0:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    2.352153] sd 1:0:0:0: [sdb] Write Protect is off
[    2.368286] sd 1:0:0:0: [sdb] Mode Sense: 00 3a 00 00
[    2.426272] sd 0:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.442895] sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    2.459258]  sda:
[    2.459656]  sdb: sda1 sda2 < sdb1
[    2.499411] sd 1:0:0:0: [sdb] Attached SCSI disk
[    2.515310]  sda5 >
[    2.533429] sd 0:0:0:0: [sda] Attached SCSI disk
[    2.906989] kjournald starting.  Commit interval 5 seconds
[    2.922789] EXT3-fs: mounted filesystem with ordered data mode.
[    4.655342] udevd version 125 started
[    5.568123] Linux agpgart interface v0.103
[    5.600657] input: PC Speaker as /devices/platform/pcspkr/input/input1
[    5.767907] r8169 Gigabit Ethernet driver 2.3LK-NAPI loaded
[    5.833714] Floppy drive(s): fd0 is 1.44M
[    5.886125] st: Version 20081215, fixed bufsize 32768, s/g segs 256
[    5.934102] sr0: scsi3-mmc drive: 40x/40x writer cd/rw xa/form2 cdda tray
[    5.950852] Uniform CD-ROM driver Revision: 3.20
[    6.000418] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    6.018043] processor LNXCPU:00: registered as cooling_device0
[    6.084130] r8169 0000:00:0d.0: enabling device (0014 -> 0017)
[    6.101104] r8169 0000:00:0d.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    6.175788] FDC 0 is a post-1991 82077
[    6.248132] ACPI: Power Button [PWRB]
[    6.480202] sr 0:0:1:0: Attached scsi CD-ROM sr0
[    6.480502] st 1:0:1:0: Attached scsi tape st0
[    6.497422] st 1:0:1:0: st0: try direct i/o: yes (alignment 4 B)
[    6.532194] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    6.640551] r8169 0000:00:0d.0: no PCI Express capability
[    6.776113] ACPI: Power Button [PWRF]
[    6.844709] eth0: RTL8110s at 0xe0ca4000, 00:11:6b:35:bb:77, XID 04000000 IRQ 16
[    6.904315] sd 0:0:0:0: Attached scsi generic sg0 type 0
[    7.024535] osst :I: Tape driver with OnStream support version 0.99.4
[    7.024538] osst :I: $Id: osst.c,v 1.73 2005/01/01 21:13:34 wriede Exp $
[    7.100157] sr 0:0:1:0: Attached scsi generic sg1 type 5
[    7.116873] agpgart: Detected VIA KT266/KY266x/KT333 chipset
[    7.273813] sd 1:0:0:0: Attached scsi generic sg2 type 0
[    7.292097] agpgart-via 0000:00:00.0: AGP aperture is 64M @ 0xf8000000
[    7.484783] st 1:0:1:0: Attached scsi generic sg3 type 1
[    8.702518] Adding 1510068k swap on /dev/sda5.  Priority:-1 extents:1 across:1510068k 
[    9.187772] EXT3 FS on sda1, internal journal
[    9.715330] loop: module loaded
[   10.414382] kjournald starting.  Commit interval 5 seconds
[   10.431758] EXT3 FS on sdb1, internal journal
[   10.448988] EXT3-fs: mounted filesystem with ordered data mode.
[   11.652404] r8169: eth0: link up

--------------020409030203060508060406
Content-Type: text/plain;
 name="lspci"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="lspci"

00:00.0 Host bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333]
	Subsystem: ASUSTeK Computer Inc. A7V333 Mainboard
	Flags: bus master, 66MHz, medium devsel, latency 0
	Memory at f8000000 (32-bit, prefetchable) [size=64M]
	Capabilities: [a0] AGP version 2.0
	Capabilities: [c0] Power Management version 2
	Kernel driver in use: agpgart-via
	Kernel modules: via-agp

00:01.0 PCI bridge: VIA Technologies, Inc. VT8366/A/7 [Apollo KT266/A/333 AGP] (prog-if 00 [Normal decode])
	Flags: bus master, 66MHz, medium devsel, latency 0
	Bus: primary=00, secondary=01, subordinate=01, sec-latency=0
	Memory behind bridge: f5000000-f6afffff
	Prefetchable memory behind bridge: f6c00000-f7ffffff
	Capabilities: [80] Power Management version 2

00:05.0 Multimedia audio controller: C-Media Electronics Inc CM8738 (rev 10)
	Subsystem: ASUSTeK Computer Inc. CMI8738 6ch-MX
	Flags: bus master, stepping, medium devsel, latency 32, IRQ 255
	I/O ports at d800 [disabled] [size=256]
	Capabilities: [c0] Power Management version 2

00:0d.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet (rev 10)
	Subsystem: Realtek Semiconductor Co., Ltd. RTL-8169 Gigabit Ethernet
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 16
	I/O ports at d400 [size=256]
	Memory at f4800000 (32-bit, non-prefetchable) [size=256]
	[virtual] Expansion ROM at 20000000 [disabled] [size=64K]
	Capabilities: [dc] Power Management version 2
	Kernel driver in use: r8169
	Kernel modules: r8169

00:0e.0 Serial controller: Titan Electronics Inc VScom 800L 8 port serial adaptor (prog-if 02 [16550])
	Subsystem: Titan Electronics Inc VScom 800L 8 port serial adaptor
	Flags: medium devsel, IRQ 17
	I/O ports at d000 [size=8]
	I/O ports at b800 [size=8]
	I/O ports at b400 [size=8]
	I/O ports at b000 [size=8]
	I/O ports at a800 [size=64]
	Kernel driver in use: serial

00:11.0 ISA bridge: VIA Technologies, Inc. VT8233A ISA Bridge
	Subsystem: ASUSTeK Computer Inc. A7V333 motherboard
	Flags: bus master, stepping, medium devsel, latency 0
	Capabilities: [c0] Power Management version 2
	Kernel modules: i2c-viapro

00:11.1 IDE interface: VIA Technologies, Inc. VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06) (prog-if 8a [Master SecP PriP])
	Subsystem: ASUSTeK Computer Inc. A7V8X / A7V333 motherboard
	Flags: bus master, medium devsel, latency 32
	[virtual] Memory at 000001f0 (32-bit, non-prefetchable) [size=8]
	[virtual] Memory at 000003f0 (type 3, non-prefetchable) [size=1]
	[virtual] Memory at 00000170 (32-bit, non-prefetchable) [size=8]
	[virtual] Memory at 00000370 (type 3, non-prefetchable) [size=1]
	I/O ports at a400 [size=16]
	Capabilities: [c0] Power Management version 2
	Kernel driver in use: pata_via
	Kernel modules: via82cxxx

00:11.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at a000 [size=32]
	Capabilities: [80] Power Management version 2
	Kernel driver in use: uhci_hcd

00:11.3 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 1.1 Controller (rev 23) (prog-if 00 [UHCI])
	Subsystem: ASUSTeK Computer Inc. VT6202 USB2.0 4 port controller
	Flags: bus master, medium devsel, latency 32, IRQ 21
	I/O ports at 9800 [size=32]
	Capabilities: [80] Power Management version 2
	Kernel driver in use: uhci_hcd

01:00.0 VGA compatible controller: NVidia / SGS Thomson (Joint Venture) Riva128 (rev 10) (prog-if 00 [VGA controller])
	Subsystem: Elsa AG VICTORY Erazor
	Flags: bus master, 66MHz, medium devsel, latency 64, IRQ 11
	Memory at f5000000 (32-bit, non-prefetchable) [size=16M]
	Memory at f7000000 (32-bit, prefetchable) [size=16M]
	Expansion ROM at f6c00000 [disabled] [size=4M]
	Capabilities: [44] AGP version 1.0


--------------020409030203060508060406--
