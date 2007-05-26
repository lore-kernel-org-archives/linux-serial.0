From: "Dr. Hans-Peter Budek" <peter.budek@gmx.de>
Subject: serial8250_interrupt in 2.6.22-rc3
Date: Sun, 27 May 2007 00:38:24 +0200
Message-ID: <4658B6E0.6060903@gmx.de>
Reply-To: budek@wtal.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail.gmx.net ([213.165.64.20]:49747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750740AbXEZWid (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sat, 26 May 2007 18:38:33 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org

Hi,

irq 3: nobody cared (try booting with the "irqpoll" option)
  [<c01332b4>] __report_bad_irq+0x24/0x90
  [<c01333e2>] note_interrupt+0x92/0xd0
  [<c0132b17>] handle_IRQ_event+0x27/0x60
  [<c0133a0b>] handle_level_irq+0x9b/0xc0
  [<c0104356>] do_IRQ+0x36/0x80
  [<c01029f7>] common_interrupt+0x23/0x28
  [<c011703e>] __do_softirq+0x2e/0x90
  [<c01170c6>] do_softirq+0x26/0x30
  [<c010435b>] do_IRQ+0x3b/0x80
  [<c01029f7>] common_interrupt+0x23/0x28
  [<c01d9b93>] serial_out+0x43/0xc0
  [<c01db5e1>] serial8250_startup+0x2a1/0x490
  [<c01d7493>] uart_startup+0x83/0x120
  [<c01d8e41>] uart_open+0x91/0x100
  [<c01c76a6>] tty_open+0x1d6/0x260
  [<c0150857>] chrdev_open+0xa7/0x140
  [<c01507b0>] chrdev_open+0x0/0x140
  [<c014d488>] __dentry_open+0xa8/0x1b0
  [<c014d698>] nameidata_to_filp+0x28/0x40
  [<c014d5db>] do_filp_open+0x4b/0x50
  [<c01a43db>] strncpy_from_user+0x3b/0x70
  [<c014d773>] get_unused_fd+0x53/0xa0
  [<c014d886>] do_sys_open+0x46/0x90
  [<c014d8ec>] sys_open+0x1c/0x20
  [<c010285c>] syscall_call+0x7/0xb
  [<c0270000>] unix_shutdown+0x90/0x120
  =======================
handlers:
[<c01dae40>] (serial8250_interrupt+0x0/0x100)
Disabling IRQ #3

boot.msg:
klogd 1.3-3, log source = /proc/kmsg started.
<5>Linux version 2.6.22-rc3 (root@mega) (gcc version 3.3.6) #28 Sat May 26 16:0$
<6>BIOS-provided physical RAM map:
<4> BIOS-e820: 0000000000000000 - 000000000009f800 (usable)
<4> BIOS-e820: 000000000009f800 - 00000000000a0000 (reserved)
<4> BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
<4> BIOS-e820: 0000000000100000 - 000000003bff0000 (usable)
<4> BIOS-e820: 000000003bff0000 - 000000003bff3000 (ACPI NVS)
<4> BIOS-e820: 000000003bff3000 - 000000003c000000 (ACPI data)
<4> BIOS-e820: 00000000fec00000 - 0000000100000000 (reserved)
<5>63MB HIGHMEM available.
<5>896MB LOWMEM available.
<7>Entering add_active_range(0, 0, 245744) 0 entries of 256 used
<4>Zone PFN ranges:
<4>  DMA             0 ->     4096
<4>  Normal       4096 ->   229376
<4>  HighMem    229376 ->   245744
<4>early_node_map[1] active PFN ranges
<4>    0:        0 ->   245744
<7>On node 0 totalpages: 245744
<7>  DMA zone: 32 pages used for memmap
<7>  DMA zone: 0 pages reserved
<7>  DMA zone: 4064 pages, LIFO batch:0
<7>  Normal zone: 1760 pages used for memmap
<7>  Normal zone: 223520 pages, LIFO batch:31
<7>  HighMem zone: 127 pages used for memmap
<7>  HighMem zone: 16241 pages, LIFO batch:3
<6>DMI 2.3 present.
<4>Allocating PCI resources starting at 40000000 (gap: 3c000000:c2c00000)
<4>Built 1 zonelists.  Total pages: 243825
<5>Kernel command line: auto vga=785 splash=silent initrd=ramimage.gz root=/dev$
<6>bootsplash: silent mode.
<6>Enabling fast FPU save and restore... done.
<6>Enabling unmasked SIMD FPU exception support... done.
<6>Initializing CPU#0
<4>PID hash table entries: 4096 (order: 12, 16384 bytes)
<4>Detected 3192.502 MHz processor.
<4>Console: colour dummy device 80x25
<4>Dentry cache hash table entries: 131072 (order: 7, 524288 bytes)
<4>Inode-cache hash table entries: 65536 (order: 6, 262144 bytes)
<6>Memory: 967984k/982976k available (1496k kernel code, 14372k reserved, 548k $
<4>virtual kernel memory layout:
<4>    fixmap  : 0xffff0000 - 0xfffff000   (  60 kB)
<4>    pkmap   : 0xff800000 - 0xffc00000   (4096 kB)
<4>    vmalloc : 0xf8800000 - 0xff7fe000   ( 111 MB)
<4>    lowmem  : 0xc0000000 - 0xf8000000   ( 896 MB)
<4>      .init : 0xc0302000 - 0xc0328000   ( 152 kB)
<4>      .data : 0xc02760f0 - 0xc02ff3b4   ( 548 kB)
<4>      .text : 0xc0100000 - 0xc02760f0   (1496 kB)
<4>Checking if this processor honours the WP bit even in supervisor mode... Ok.
<4>Calibrating delay using timer specific routine.. 6391.56 BogoMIPS (lpj=10648$
<4>Mount-cache hash table entries: 512
<7>CPU: After generic identify, caps: bfebfbff 20100000 00000000 00000000 00006$
<4>monitor/mwait feature present.
<4>using mwait in idle threads.
<6>CPU: Trace cache: 12K uops, L1 D cache: 16K
<6>CPU: L2 cache: 256K
<7>CPU: After all inits, caps: bfebfbff 20100000 00000000 0000b180 0000651d 000$
<6>Intel machine check architecture supported.
<6>Intel machine check reporting enabled on CPU#0.
<6>CPU0: Intel P4/Xeon Extended MCE MSRs (24) available
<4>Compat vDSO mapped to ffffe000.
<4>CPU: Intel(R) Celeron(R) CPU 3.20GHz stepping 09
<6>Checking 'hlt' instruction... OK.
<6>NET: Registered protocol family 16
<6>PCI: PCI BIOS revision 2.10 entry at 0xf2600, last bus=1
<6>PCI: Using configuration type 1
<4>Setting up standard PCI resources
<5>SCSI subsystem initialized
<4>PCI: Probing PCI hardware
<7>PCI: Probing PCI hardware (bus 00)
<6>PCI: MSI-K8T-Neo2Fir, attempting to turn soundcard ON
<6>PCI: MSI-K8T-Neo2Fir, soundcard on
<6>PCI: enabled onboard AC97/MC97 devices
<6>PCI: Using IRQ router VIA [1106/3227] at 0000:00:11.0
<7>PCI: setting IRQ 5 as level-triggered
<6>PCI: Found IRQ 5 for device 0000:00:11.6
<6>PCI: Sharing IRQ 5 with 0000:00:10.4
<6>PCI: Sharing IRQ 5 with 0000:00:11.5
<6>PCI: Bridge: 0000:00:01.0
<6>  IO window: disabled.
<6>  MEM window: f4000000-f5ffffff
<6>  PREFETCH window: f0000000-f3ffffff
<7>PCI: Setting latency timer of device 0000:00:01.0 to 64
<6>NET: Registered protocol family 2
Kernel logging (proc) stopped.



2.6.20.7 worked fine...

Peter



