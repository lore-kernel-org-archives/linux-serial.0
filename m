From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Tue, 18 Oct 2016 14:29:30 -0500
Message-ID: <20161018192930.GA207959@stormcage.americas.sgi.com>
References: <20161017144951.GA235535@stormcage.americas.sgi.com>
 <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161018180518.GA28700@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 18, 2016 at 07:05:18PM +0100, Sean Young wrote:
> On Tue, Oct 18, 2016 at 11:40:04AM -0500, Nathan Zimmer wrote:
> > 3.7.0
> > cat /sys/bus/pnp/drivers/serial/*/resources
> > state = active
> > io 0x2f8-0x2ff
> > irq 12
> > dma disabled
> > 
> > 3.6.0
> > :~ # cat /sys/bus/pnp/drivers/serial/*/resources
> > cat: /sys/bus/pnp/drivers/serial/*/resources: No such file or directory
> 
> irq 12 for ttyS1? That should be irq 3. The bios is putting bogus information
> in pnp. Maybe there is rubbish in the bios setup or maybe it's fixed in a 
> newer bios update.
> 
> So before this change, the kernel would assume irq 3. After this change,
> the kernel first uses the information in pnp to see where the serial
> port is. It gets told that it's irq 12 and presumably it runs into all
> sorts of problems then. If memory serves that's the irq for the ps/2 mouse.
> 
> The interesting bit is in 3.6.0:
> 
> setserial
> /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 3
> 
> becomes in 3.7.0:
> 
> setserial
> /dev/ttyS1, UART: 16550A, Port: 0x02f8, IRQ: 12
> 
> You should be able to set the right irq with setserial, but obviously
> that doesn't help you if it fails in early boot. It's not immediately
> obvious to me what can be done in the kernel for this. Maybe the dmesg
> output could inspire, thanks.
> 
> 
> Sean

Yea the changing irq seemed weird to me too but I couldn't manage a guess to why.

Here are the dmesgs.

Nate


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_3.6.0"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.6.0 (root@r1i2n0) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #3 SMP Mon Oct 17 20:43:34 EDT 2016
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008df5dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000008df5e000-0x000000008df8dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008df8e000-0x000000008e0a3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008e0a4000-0x000000008e2c9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008e2ca000-0x000000008f336fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008f337000-0x000000008f7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000090000000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000106fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: SGI.COM ICE-XIP119/S0751-Medina, BIOS ma2e2054 02/05/2014
[    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x1070000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask 3FF000000000 write-back
[    0.000000]   1 base 001000000000 mask 3FFF80000000 write-back
[    0.000000]   2 base 000090000000 mask 3FFFF0000000 uncachable
[    0.000000]   3 base 0000A0000000 mask 3FFFE0000000 uncachable
[    0.000000]   4 base 0000C0000000 mask 3FFFC0000000 uncachable
[    0.000000]   5 base 001070000000 mask 3FFFF0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0x90000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x8df5e max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fdba0-0x000fdbaf] mapped at [ffff8800000fdba0]
[    0.000000] initial memory mapped: [mem 0x00000000-0x1fffffff]
[    0.000000] Base memory trampoline at [ffff880000088000] 88000 size 28672
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x8df5dfff]
[    0.000000]  [mem 0x00000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0x8ddfffff] page 2M
[    0.000000]  [mem 0x8de00000-0x8df5dfff] page 4k
[    0.000000] kernel direct mapping tables up to 0x8df5dfff @ [mem 0x1fbfd000-0x1fffffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x106fffffff]
[    0.000000]  [mem 0x100000000-0x103fffffff] page 1G
[    0.000000]  [mem 0x1040000000-0x106fffffff] page 2M
[    0.000000] kernel direct mapping tables up to 0x106fffffff @ [mem 0x8df5c000-0x8df5dfff]
[    0.000000] RAMDISK: [mem 0x36bc4000-0x37feffff]
[    0.000000] Reserving 128MB of memory at 736MB for crashkernel (System RAM: 65502MB)
[    0.000000] ACPI: RSDP 00000000000f04a0 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 000000008dfc5090 0009C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 000000008dfd1cd0 0010C (v05 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 000000008dfc51b8 0CB14 (v02 ALASKA    A M I 00000201 INTL 20051117)
[    0.000000] ACPI: FACS 000000008e2c1080 00040
[    0.000000] ACPI: APIC 000000008dfd1de0 00224 (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 000000008dfd2008 00044 (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 000000008dfd2050 0003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
[    0.000000] ACPI: SRAT 000000008dfd2090 004B0 (v01 A M I  AMI SRAT 00000001 AMI. 00000000)
[    0.000000] ACPI: SLIT 000000008dfd2540 00030 (v01 A M I  AMI SLIT 00000000 AMI. 00000000)
[    0.000000] ACPI: HPET 000000008dfd2570 00038 (v01 ALASKA    A M I 01072009 AMI. 00000005)
[    0.000000] ACPI: PRAD 000000008dfd25a8 000BE (v02 PRADID  PRADTID 00000001 MSFT 03000001)
[    0.000000] ACPI: SPMI 000000008dfd2668 00040 (v05 A M I   OEMSPMI 00000000 AMI. 00000000)
[    0.000000] ACPI: SSDT 000000008dfd26a8 D0CB0 (v02  INTEL    CpuPm 00004000 INTL 20051117)
[    0.000000] ACPI: EINJ 000000008e0a3358 00130 (v01    AMI AMI EINJ 00000000      00000000)
[    0.000000] ACPI: ERST 000000008e0a3488 00230 (v01  AMIER AMI ERST 00000000      00000000)
[    0.000000] ACPI: HEST 000000008e0a36b8 00068 (v01    AMI AMI HEST 00000000      00000000)
[    0.000000] ACPI: BERT 000000008e0a3720 00030 (v01    AMI AMI BERT 00000000      00000000)
[    0.000000] ACPI: DMAR 000000008e0a3750 00150 (v01 A M I   OEMDMAR 00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x36 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x37 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x38 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x39 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x8fffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x86fffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x870000000-0x106fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x8fffffff] + [mem 0x100000000-0x86fffffff] -> [mem 0x00000000-0x86fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x86fffffff]
[    0.000000]   NODE_DATA [mem 0x86ffda000-0x86fffffff]
[    0.000000] Initmem setup node 1 [mem 0x870000000-0x106fffffff]
[    0.000000]   NODE_DATA [mem 0x106ffd9000-0x106fffefff]
[    0.000000] [ffffea001d880000-ffffea001d9fffff] potential offnode page_structs
[    0.000000]  [ffffea0000000000-ffffea001d9fffff] PMD -> [ffff88084fe00000-ffff88086bffffff] on node 0
[    0.000000]  [ffffea001da00000-ffffea00399fffff] PMD -> [ffff88104f600000-ffff88106b5fffff] on node 1
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x106fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0008efff]
[    0.000000]   node   0: [mem 0x00100000-0x8df5dfff]
[    0.000000]   node   0: [mem 0x100000000-0x86fffffff]
[    0.000000]   node   1: [mem 0x870000000-0x106fffffff]
[    0.000000] On node 0 totalpages: 8380125
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 7 pages reserved
[    0.000000]   DMA zone: 3904 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 563094 pages, LIFO batch:31
[    0.000000]   Normal zone: 106624 pages used for memmap
[    0.000000]   Normal zone: 7692160 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 8388608
[    0.000000]   Normal zone: 114688 pages used for memmap
[    0.000000]   Normal zone: 8273920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x20] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x22] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x24] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x26] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x32] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1a] lapic_id[0x34] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1c] lapic_id[0x36] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1e] lapic_id[0x38] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x09] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x23] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x25] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x27] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x19] lapic_id[0x33] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1b] lapic_id[0x35] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1d] lapic_id[0x37] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1f] lapic_id[0x39] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec40000] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 3, version 32, address 0xfec40000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 88
[    0.000000] PM: Registered nosave memory: 000000000008f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000008df5e000 - 000000008df8e000
[    0.000000] PM: Registered nosave memory: 000000008df8e000 - 000000008e0a4000
[    0.000000] PM: Registered nosave memory: 000000008e0a4000 - 000000008e2ca000
[    0.000000] PM: Registered nosave memory: 000000008e2ca000 - 000000008f337000
[    0.000000] PM: Registered nosave memory: 000000008f337000 - 000000008f800000
[    0.000000] PM: Registered nosave memory: 000000008f800000 - 0000000090000000
[    0.000000] PM: Registered nosave memory: 0000000090000000 - 00000000a0000000
[    0.000000] PM: Registered nosave memory: 00000000a0000000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed40000
[    0.000000] PM: Registered nosave memory: 00000000fed40000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] e820: [mem 0xa0000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:2
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88086fc00000 s79232 r8192 d23168 u131072
[    0.000000] pcpu-alloc: s79232 r8192 d23168 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 16 17 18 19 20 21 22 23 
[    0.000000] pcpu-alloc: [1] 08 09 10 11 12 13 14 15 24 25 26 27 28 29 30 31 
[    0.000000] Built 2 zonelists in Zone order, mobility grouping on.  Total pages: 16533078
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 65919052k/68943872k available (4436k kernel code, 1868940k absent, 1155880k reserved, 6577k data, 1344k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=32.
[    0.000000] NR_IRQS:262400 nr_irqs:1752 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2299.857 MHz processor
[    0.000011] Calibrating delay loop (skipped), value calculated using timer frequency.. 4599.71 BogoMIPS (lpj=9199428)
[    0.000339] pid_max: default: 32768 minimum: 301
[    0.000545] Security Framework initialized
[    0.000715] AppArmor: AppArmor initialized
[    0.005031] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.019266] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.025411] Mount-cache hash table entries: 256
[    0.025840] Initializing cgroup subsys cpuacct
[    0.026001] Initializing cgroup subsys devices
[    0.026161] Initializing cgroup subsys freezer
[    0.026320] Initializing cgroup subsys net_cls
[    0.026479] Initializing cgroup subsys blkio
[    0.026638] Initializing cgroup subsys perf_event
[    0.026837] CPU: Physical Processor ID: 0
[    0.026993] CPU: Processor Core ID: 1
[    0.028026] mce: CPU supports 27 MCE banks
[    0.028234] CPU0: Thermal monitoring enabled (TM1)
[    0.028425] process: using mwait in idle threads
[    0.028588] Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
[    0.028588] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.028588] tlb_flushall_shift is 0x6
[    0.029960] ACPI: Core revision 20120711
[    0.070278] Switched APIC routing to physical flat.
[    0.071354] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.111478] smpboot: CPU0: Genuine Intel(R) CPU  @ 2.80GHz stepping 02
[    0.220005] Performance Events: PEBS fmt1+, generic architected perfmon, Intel PMU driver.
[    0.221078] ... version:                3
[    0.221535] ... bit width:              48
[    0.221993] ... generic registers:      4
[    0.222447] ... value mask:             0000ffffffffffff
[    0.222906] ... max period:             000000007fffffff
[    0.223365] ... fixed-purpose events:   3
[    0.223821] ... event mask:             000000070000000f
[    0.225279] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.226534] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    0.330125] smpboot: Booting Node   1, Processors  #8 #9 #10 #11 #12 #13 #14 #15 OK
[    0.546502] smpboot: Booting Node   0, Processors  #16 #17 #18 #19 #20 #21 #22 #23 OK
[    0.661767] smpboot: Booting Node   1, Processors  #24 #25 #26 #27 #28 #29 #30 #31 OK
[    0.782760] Brought up 32 CPUs
[    0.783220] smpboot: Total of 32 processors activated (147194.08 BogoMIPS)
[    0.862906] devtmpfs: initialized
[    0.871448] PM: Registering ACPI NVS region [mem 0x8e0a4000-0x8e2c9fff] (2252800 bytes)
[    0.872352] PM: Registering ACPI NVS region [mem 0x8f337000-0x8f7fffff] (5017600 bytes)
[    0.873449] dummy: 
[    0.873939] RTC time: 15:37:15, date: 10/18/16
[    0.874546] NET: Registered protocol family 16
[    0.875215] ACPI: bus type pci registered
[    0.875750] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x90000000-0x9fffffff] (base 0x90000000)
[    0.876590] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved in E820
[    0.898105] PCI: Using configuration type 1 for base access
[    0.900753] bio: create slab <bio-0> at 0
[    0.901473] ACPI: Added _OSI(Module Device)
[    0.901929] ACPI: Added _OSI(Processor Device)
[    0.902385] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.902842] ACPI: Added _OSI(Processor Aggregator Device)
[    0.914672] ACPI: EC: Look up EC in DSDT
[    0.915587] \_SB_:_OSC invalid UUID
[    0.916047] _OSC request data:1 1f 
[    0.927451] ACPI: Executed 1 blocks of module-level executable AML code
[    1.195534] ACPI: Dynamic OEM Table Load:
[    1.196146] ACPI: PRAD           (null) 000BE (v02 PRADID  PRADTID 00000001 MSFT 03000001)
[    1.203530] ACPI: Interpreter enabled
[    1.203989] ACPI: (supports S0 S4 S5)
[    1.204686] ACPI: Using IOAPIC for interrupt routing
[    1.227481] ACPI: No dock devices found.
[    1.227953] HEST: Table parsing has been initialized.
[    1.228413] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.229655] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    1.230577] PCI host bridge to bus 0000:00
[    1.231036] pci_bus 0000:00: busn_res: [bus 00-7e] is inserted under domain [bus 00-ff]
[    1.231875] pci_bus 0000:00: root bus resource [bus 00-7e]
[    1.232337] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    1.232798] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    1.233258] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    1.233719] pci_bus 0000:00: root bus resource [io  0x0d00-0x9fff]
[    1.234180] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    1.234643] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    1.235106] pci_bus 0000:00: root bus resource [mem 0x90000000-0xe7ffffff]
[    1.235576] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x380fffffffff]
[    1.236420] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    1.236936] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.237421] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    1.237945] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.238429] pci 0000:00:01.1: [8086:0e03] type 01 class 0x060400
[    1.238953] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    1.239446] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    1.239973] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.240457] pci 0000:00:02.2: [8086:0e06] type 01 class 0x060400
[    1.240980] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    1.241469] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    1.241993] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.242480] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    1.243014] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    1.243550] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    1.244018] pci 0000:00:05.4: reg 10: [mem 0xe7f06000-0xe7f06fff]
[    1.244557] pci 0000:00:07.0: [8086:0e18] type 00 class 0x088000
[    1.245103] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    1.245655] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    1.246150] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    1.246630] pci 0000:00:16.0: reg 10: [mem 0xe7f05000-0xe7f0500f 64bit]
[    1.247163] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.247646] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000
[    1.248127] pci 0000:00:16.1: reg 10: [mem 0xe7f04000-0xe7f0400f 64bit]
[    1.248659] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    1.249152] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    1.249631] pci 0000:00:1a.0: reg 10: [mem 0xe7f02000-0xe7f023ff]
[    1.250180] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.250664] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    1.251203] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.251693] pci 0000:00:1c.4: [8086:1d18] type 01 class 0x060400
[    1.252231] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.252723] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    1.253202] pci 0000:00:1d.0: reg 10: [mem 0xe7f01000-0xe7f013ff]
[    1.253750] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.254233] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.254757] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    1.255341] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    1.255820] pci 0000:00:1f.2: reg 10: [io  0x9070-0x9077]
[    1.256286] pci 0000:00:1f.2: reg 14: [io  0x9060-0x9063]
[    1.256751] pci 0000:00:1f.2: reg 18: [io  0x9050-0x9057]
[    1.257217] pci 0000:00:1f.2: reg 1c: [io  0x9040-0x9043]
[    1.257682] pci 0000:00:1f.2: reg 20: [io  0x9020-0x903f]
[    1.258146] pci 0000:00:1f.2: reg 24: [mem 0xe7f00000-0xe7f007ff]
[    1.258652] pci 0000:00:1f.2: PME# supported from D3hot
[    1.259128] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    1.259604] pci 0000:00:1f.3: reg 10: [mem 0x380ffff01000-0x380ffff010ff 64bit]
[    1.260457] pci 0000:00:1f.3: reg 20: [io  0x9000-0x901f]
[    1.260949] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000
[    1.261429] pci 0000:00:1f.6: reg 10: [mem 0x380ffff00000-0x380ffff00fff 64bit]
[    1.262368] pci_bus 0000:01: busn_res: [bus 01] is inserted under [bus 00-7e]
[    1.262833] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.263335] pci_bus 0000:02: busn_res: [bus 02] is inserted under [bus 00-7e]
[    1.263800] pci 0000:00:01.1: PCI bridge to [bus 02]
[    1.264303] pci_bus 0000:03: busn_res: [bus 03] is inserted under [bus 00-7e]
[    1.264991] pci 0000:03:00.0: [15b3:1003] type 00 class 0x028000
[    1.265703] pci 0000:03:00.0: reg 10: [mem 0xe7e00000-0xe7efffff 64bit]
[    1.266368] pci 0000:03:00.0: reg 18: [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.268788] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.269250] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    1.269716] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.270591] pci_bus 0000:04: busn_res: [bus 04] is inserted under [bus 00-7e]
[    1.271056] pci 0000:00:02.2: PCI bridge to [bus 04]
[    1.271560] pci_bus 0000:05: busn_res: [bus 05] is inserted under [bus 00-7e]
[    1.272031] pci 0000:05:00.0: [8086:2250] type 00 class 0x0b4000
[    1.272500] pci 0000:05:00.0: reg 10: [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.273350] pci 0000:05:00.0: reg 20: [mem 0xe7d00000-0xe7d1ffff 64bit]
[    1.273842] pci 0000:05:00.0: PME# supported from D0
[    1.279465] pci 0000:00:03.0: PCI bridge to [bus 05]
[    1.279942] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    1.280408] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.281294] pci_bus 0000:06: busn_res: [bus 06] is inserted under [bus 00-7e]
[    1.281771] pci 0000:06:00.0: [8086:1d69] type 00 class 0x010700
[    1.282248] pci 0000:06:00.0: reg 10: [mem 0x380e00c7c000-0x380e00c7ffff 64bit pref]
[    1.283097] pci 0000:06:00.0: reg 18: [mem 0x380e00800000-0x380e00bfffff 64bit pref]
[    1.283943] pci 0000:06:00.0: reg 20: [io  0x8000-0x80ff]
[    1.284504] pci 0000:06:00.0: reg 164: [mem 0x380e00c00000-0x380e00c03fff 64bit pref]
[    1.285397] pci 0000:00:11.0: PCI bridge to [bus 06]
[    1.285858] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    1.286322] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    1.286789] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.287671] pci_bus 0000:07: busn_res: [bus 07-08] is inserted under [bus 00-7e]
[    1.288532] pci 0000:07:00.0: [8086:1523] type 00 class 0x020000
[    1.289010] pci 0000:07:00.0: reg 10: [mem 0xe7b00000-0xe7b1ffff]
[    1.289494] pci 0000:07:00.0: reg 18: [io  0x7000-0x701f]
[    1.289965] pci 0000:07:00.0: reg 1c: [mem 0xe7b20000-0xe7b23fff]
[    1.290532] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    1.291053] pci 0000:07:00.0: reg 184: [mem 0x380e00e20000-0x380e00e23fff 64bit pref]
[    1.291918] pci 0000:07:00.0: reg 190: [mem 0x380e00e00000-0x380e00e03fff 64bit pref]
[    1.299456] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    1.299931] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    1.300394] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    1.300861] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.301738] pci_bus 0000:09: busn_res: [bus 09-0a] is inserted under [bus 00-7e]
[    1.302601] pci 0000:09:00.0: [1a03:1150] type 01 class 0x060400
[    1.303207] pci 0000:09:00.0: supports D1 D2
[    1.303666] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.311447] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    1.311922] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    1.312383] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.312847] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.313760] pci_bus 0000:0a: busn_res: [bus 0a] is inserted under [bus 09-0a]
[    1.314241] pci 0000:0a:00.0: [1a03:2000] type 00 class 0x030000
[    1.314731] pci 0000:0a:00.0: reg 10: [mem 0xe7000000-0xe77fffff pref]
[    1.315205] pci 0000:0a:00.0: reg 14: [mem 0xe7a00000-0xe7a1ffff]
[    1.315683] pci 0000:0a:00.0: reg 18: [io  0x6000-0x607f]
[    1.316260] pci 0000:0a:00.0: supports D1 D2
[    1.316714] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.317263] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    1.317725] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    1.318187] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.318654] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.319518] pci_bus 0000:0b: busn_res: [bus 0b] is inserted under [bus 00-7e]
[    1.320016] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    1.320485] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    1.321316] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    1.322146] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    1.322976] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff] (subtractive decode)
[    1.323810] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.324642] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    1.325474] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xe7ffffff] (subtractive decode)
[    1.326305] pci 0000:00:1e.0:   bridge window [mem 0x380000000000-0x380fffffffff] (subtractive decode)
[    1.327173] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    1.327633] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.328259] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    1.328789] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
[    1.329272] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
[    1.329768] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE2._PRT]
[    1.330257] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
[    1.330752] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE5._PRT]
[    1.331248] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
[    1.331864]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.332513]  pci0000:00: ACPI _OSC control (0x1d) granted
[    1.342252] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    1.342773] PCI host bridge to bus 0000:7f
[    1.343228] pci_bus 0000:7f: busn_res: [bus 7f] is inserted under domain [bus 00-ff]
[    1.354083] pci_bus 0000:7f: root bus resource [bus 7f]
[    1.354547] pci 0000:7f:08.0: [8086:0e80] type 00 class 0x088000
[    1.355040] pci 0000:7f:08.3: [8086:0e83] type 00 class 0x088000
[    1.355542] pci 0000:7f:08.4: [8086:0e84] type 00 class 0x088000
[    1.356047] pci 0000:7f:09.0: [8086:0e90] type 00 class 0x088000
[    1.356538] pci 0000:7f:09.3: [8086:0e93] type 00 class 0x088000
[    1.357042] pci 0000:7f:09.4: [8086:0e94] type 00 class 0x088000
[    1.357545] pci 0000:7f:0a.0: [8086:0ec0] type 00 class 0x088000
[    1.358028] pci 0000:7f:0a.1: [8086:0ec1] type 00 class 0x088000
[    1.358513] pci 0000:7f:0a.2: [8086:0ec2] type 00 class 0x088000
[    1.358998] pci 0000:7f:0a.3: [8086:0ec3] type 00 class 0x088000
[    1.359490] pci 0000:7f:0b.0: [8086:0e1e] type 00 class 0x088000
[    1.359976] pci 0000:7f:0b.3: [8086:0e1f] type 00 class 0x088000
[    1.360463] pci 0000:7f:0c.0: [8086:0ee0] type 00 class 0x088000
[    1.360949] pci 0000:7f:0c.1: [8086:0ee2] type 00 class 0x088000
[    1.361436] pci 0000:7f:0c.2: [8086:0ee4] type 00 class 0x088000
[    1.361922] pci 0000:7f:0c.3: [8086:0ee6] type 00 class 0x088000
[    1.362407] pci 0000:7f:0c.4: [8086:0ee8] type 00 class 0x088000
[    1.362894] pci 0000:7f:0d.0: [8086:0ee1] type 00 class 0x088000
[    1.363380] pci 0000:7f:0d.1: [8086:0ee3] type 00 class 0x088000
[    1.363868] pci 0000:7f:0d.2: [8086:0ee5] type 00 class 0x088000
[    1.364354] pci 0000:7f:0d.3: [8086:0ee7] type 00 class 0x088000
[    1.364841] pci 0000:7f:0d.4: [8086:0ee9] type 00 class 0x088000
[    1.365329] pci 0000:7f:0e.0: [8086:0ea0] type 00 class 0x088000
[    1.365820] pci 0000:7f:0e.1: [8086:0e30] type 00 class 0x110100
[    1.366317] pci 0000:7f:0f.0: [8086:0ea8] type 00 class 0x088000
[    1.366815] pci 0000:7f:0f.1: [8086:0e71] type 00 class 0x088000
[    1.367314] pci 0000:7f:0f.2: [8086:0eaa] type 00 class 0x088000
[    1.367815] pci 0000:7f:0f.3: [8086:0eab] type 00 class 0x088000
[    1.368315] pci 0000:7f:0f.4: [8086:0eac] type 00 class 0x088000
[    1.368814] pci 0000:7f:0f.5: [8086:0ead] type 00 class 0x088000
[    1.369314] pci 0000:7f:10.0: [8086:0eb0] type 00 class 0x088000
[    1.369814] pci 0000:7f:10.1: [8086:0eb1] type 00 class 0x088000
[    1.370313] pci 0000:7f:10.2: [8086:0eb2] type 00 class 0x088000
[    1.370810] pci 0000:7f:10.3: [8086:0eb3] type 00 class 0x088000
[    1.371310] pci 0000:7f:10.4: [8086:0eb4] type 00 class 0x088000
[    1.371811] pci 0000:7f:10.5: [8086:0eb5] type 00 class 0x088000
[    1.372312] pci 0000:7f:10.6: [8086:0eb6] type 00 class 0x088000
[    1.372810] pci 0000:7f:10.7: [8086:0eb7] type 00 class 0x088000
[    1.373312] pci 0000:7f:13.0: [8086:0e1d] type 00 class 0x088000
[    1.373796] pci 0000:7f:13.1: [8086:0e34] type 00 class 0x110100
[    1.374284] pci 0000:7f:13.4: [8086:0e81] type 00 class 0x088000
[    1.374775] pci 0000:7f:13.5: [8086:0e36] type 00 class 0x110100
[    1.375267] pci 0000:7f:16.0: [8086:0ec8] type 00 class 0x088000
[    1.375755] pci 0000:7f:16.1: [8086:0ec9] type 00 class 0x088000
[    1.376242] pci 0000:7f:16.2: [8086:0eca] type 00 class 0x088000
[    1.376737] pci_bus 0000:7f: on NUMA node 0 (pxm 0)
[    1.377207]  pci0000:7f: Requesting ACPI _OSC control (0x1d)
[    1.377687]  pci0000:7f: ACPI _OSC control (0x1d) granted
[    1.379210] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    1.380081] PCI host bridge to bus 0000:80
[    1.380536] pci_bus 0000:80: busn_res: [bus 80-fe] is inserted under domain [bus 00-ff]
[    1.381367] pci_bus 0000:80: root bus resource [bus 80-fe]
[    1.381825] pci_bus 0000:80: root bus resource [io  0xa000-0xffff]
[    1.382284] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xfbffffff]
[    1.382744] pci_bus 0000:80: root bus resource [mem 0x381000000000-0x381fffffffff]
[    1.383593] pci 0000:80:00.0: [8086:0e01] type 01 class 0x060400
[    1.384121] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    1.384610] pci 0000:80:01.0: [8086:0e02] type 01 class 0x060400
[    1.385136] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    1.385623] pci 0000:80:01.1: [8086:0e03] type 01 class 0x060400
[    1.386149] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
[    1.386643] pci 0000:80:02.0: [8086:0e04] type 01 class 0x060400
[    1.387170] pci 0000:80:02.0: PME# supported from D0 D3hot D3cold
[    1.387657] pci 0000:80:02.2: [8086:0e06] type 01 class 0x060400
[    1.388185] pci 0000:80:02.2: PME# supported from D0 D3hot D3cold
[    1.388675] pci 0000:80:03.0: [8086:0e08] type 01 class 0x060400
[    1.389203] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    1.389689] pci 0000:80:05.0: [8086:0e28] type 00 class 0x088000
[    1.390230] pci 0000:80:05.2: [8086:0e2a] type 00 class 0x088000
[    1.390770] pci 0000:80:05.4: [8086:0e2c] type 00 class 0x080020
[    1.391235] pci 0000:80:05.4: reg 10: [mem 0xfbf00000-0xfbf00fff]
[    1.391781] pci 0000:80:07.0: [8086:0e18] type 00 class 0x088000
[    1.392370] pci_bus 0000:81: busn_res: [bus 81] is inserted under [bus 80-fe]
[    1.392832] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.393335] pci_bus 0000:82: busn_res: [bus 82] is inserted under [bus 80-fe]
[    1.393795] pci 0000:80:01.0: PCI bridge to [bus 82]
[    1.394299] pci_bus 0000:83: busn_res: [bus 83] is inserted under [bus 80-fe]
[    1.394761] pci 0000:80:01.1: PCI bridge to [bus 83]
[    1.395265] pci_bus 0000:84: busn_res: [bus 84] is inserted under [bus 80-fe]
[    1.395728] pci 0000:80:02.0: PCI bridge to [bus 84]
[    1.396232] pci_bus 0000:85: busn_res: [bus 85] is inserted under [bus 80-fe]
[    1.396694] pci 0000:80:02.2: PCI bridge to [bus 85]
[    1.397196] pci_bus 0000:86: busn_res: [bus 86] is inserted under [bus 80-fe]
[    1.397663] pci 0000:86:00.0: [8086:2250] type 00 class 0x0b4000
[    1.398131] pci 0000:86:00.0: reg 10: [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.398978] pci 0000:86:00.0: reg 20: [mem 0xfbe00000-0xfbe1ffff 64bit]
[    1.399473] pci 0000:86:00.0: PME# supported from D0
[    1.400052] pci 0000:80:03.0: PCI bridge to [bus 86]
[    1.400512] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.400975] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.401830] pci_bus 0000:80: on NUMA node 1 (pxm 1)
[    1.402286] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    1.402981]  pci0000:80: Requesting ACPI _OSC control (0x1d)
[    1.403632]  pci0000:80: ACPI _OSC control (0x1d) granted
[    1.405854] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    1.406375] PCI host bridge to bus 0000:ff
[    1.406831] pci_bus 0000:ff: busn_res: [bus ff] is inserted under domain [bus 00-ff]
[    1.407665] pci_bus 0000:ff: root bus resource [bus ff]
[    1.408131] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    1.408631] pci 0000:ff:08.3: [8086:0e83] type 00 class 0x088000
[    1.409142] pci 0000:ff:08.4: [8086:0e84] type 00 class 0x088000
[    1.409654] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    1.410152] pci 0000:ff:09.3: [8086:0e93] type 00 class 0x088000
[    1.410661] pci 0000:ff:09.4: [8086:0e94] type 00 class 0x088000
[    1.411175] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    1.411671] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    1.412164] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    1.412657] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    1.413153] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    1.413643] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    1.414135] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    1.414625] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    1.415117] pci 0000:ff:0c.2: [8086:0ee4] type 00 class 0x088000
[    1.415610] pci 0000:ff:0c.3: [8086:0ee6] type 00 class 0x088000
[    1.416106] pci 0000:ff:0c.4: [8086:0ee8] type 00 class 0x088000
[    1.416598] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    1.417090] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    1.417582] pci 0000:ff:0d.2: [8086:0ee5] type 00 class 0x088000
[    1.418072] pci 0000:ff:0d.3: [8086:0ee7] type 00 class 0x088000
[    1.418563] pci 0000:ff:0d.4: [8086:0ee9] type 00 class 0x088000
[    1.419057] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    1.419560] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    1.420069] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    1.420579] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    1.421089] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    1.421597] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    1.422106] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    1.422615] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    1.423124] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    1.423636] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    1.424145] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    1.424655] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    1.425162] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    1.425673] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    1.426181] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    1.426691] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    1.427198] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    1.427690] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    1.428183] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    1.428678] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    1.429175] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    1.429666] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    1.430157] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    1.430658] pci_bus 0000:ff: on NUMA node 1 (pxm 1)
[    1.431130]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    1.431611]  pci0000:ff: ACPI _OSC control (0x1d) granted
[    1.432887] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.434304] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    1.435717] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.437051] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    1.438383] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.440240] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.442092] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.443947] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    1.445462] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.446329] vgaarb: loaded
[    1.446780] vgaarb: bridge control possible 0000:0a:00.0
[    1.447359] PCI: Using ACPI for IRQ routing
[    1.452371] PCI: pci_cache_line_size set to 64 bytes
[    1.453132] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    1.453590] e820: reserve RAM buffer [mem 0x8df5e000-0x8fffffff]
[    1.454147] NetLabel: Initializing
[    1.454599] NetLabel:  domain hash size = 128
[    1.455053] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.455522] NetLabel:  unlabeled traffic allowed by default
[    1.455994] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.457131] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.459645] Switching to clocksource hpet
[    1.462039] AppArmor: AppArmor Filesystem Enabled
[    1.462539] pnp: PnP ACPI init
[    1.473070] ACPI: bus type pnp registered
[    1.473804] pnp 00:00: [bus 00-7e]
[    1.474259] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.474714] pnp 00:00: [io  0x0000-0x03af window]
[    1.475170] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    1.475627] pnp 00:00: [io  0x03b0-0x03df window]
[    1.476090] pnp 00:00: [io  0x0d00-0x9fff window]
[    1.476546] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.477006] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    1.477464] pnp 00:00: [mem 0x90000000-0xe7ffffff window]
[    1.477924] pnp 00:00: [mem 0x380000000000-0x380fffffffff window]
[    1.478450] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.479287] pnp 00:01: [mem 0xfc000000-0xfcffffff]
[    1.479744] pnp 00:01: [mem 0xfd000000-0xfdffffff]
[    1.480208] pnp 00:01: [mem 0xfe000000-0xfeafffff]
[    1.480665] pnp 00:01: [mem 0xfeb00000-0xfebfffff]
[    1.481123] pnp 00:01: [mem 0xfed00400-0xfed3ffff]
[    1.481579] pnp 00:01: [mem 0xfed45000-0xfedfffff]
[    1.482124] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    1.482586] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    1.483046] system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
[    1.483507] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    1.483966] system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    1.484429] system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
[    1.484889] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.485409] pnp 00:02: [mem 0xe7ffc000-0xe7ffdfff]
[    1.485944] system 00:02: [mem 0xe7ffc000-0xe7ffdfff] has been reserved
[    1.486405] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.486942] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    1.487401] pnp 00:03: [io  0x0a00-0x0a1f]
[    1.487931] system 00:03: [io  0x0a00-0x0a1f] has been reserved
[    1.488395] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.489055] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    1.489529] pnp 00:05: [dma 4]
[    1.489980] pnp 00:05: [io  0x0000-0x000f]
[    1.490433] pnp 00:05: [io  0x0081-0x0083]
[    1.490885] pnp 00:05: [io  0x0087]
[    1.491337] pnp 00:05: [io  0x0089-0x008b]
[    1.491789] pnp 00:05: [io  0x008f]
[    1.492252] pnp 00:05: [io  0x00c0-0x00df]
[    1.492724] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.493193] pnp 00:06: [io  0x0070-0x0071]
[    1.493653] pnp 00:06: [irq 8]
[    1.494125] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.494593] pnp 00:07: [io  0x0061]
[    1.495065] pnp 00:07: Plug and Play ACPI device, IDs PNP0800 (active)
[    1.495555] pnp 00:08: [io  0x0010-0x001f]
[    1.496010] pnp 00:08: [io  0x0022-0x003f]
[    1.496469] pnp 00:08: [io  0x0044-0x005f]
[    1.496924] pnp 00:08: [io  0x0062-0x0063]
[    1.497377] pnp 00:08: [io  0x0065-0x006f]
[    1.497833] pnp 00:08: [io  0x0072-0x007f]
[    1.498287] pnp 00:08: [io  0x0080]
[    1.498742] pnp 00:08: [io  0x0084-0x0086]
[    1.499195] pnp 00:08: [io  0x0088]
[    1.499650] pnp 00:08: [io  0x008c-0x008e]
[    1.500109] pnp 00:08: [io  0x0090-0x009f]
[    1.500563] pnp 00:08: [io  0x00a2-0x00bf]
[    1.501018] pnp 00:08: [io  0x00e0-0x00ef]
[    1.501475] pnp 00:08: [io  0x04d0-0x04d1]
[    1.502014] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    1.502470] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.502939] pnp 00:09: [io  0x00f0-0x00ff]
[    1.503396] pnp 00:09: [irq 13]
[    1.503870] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.504439] pnp 00:0a: [io  0x0ca2]
[    1.504893] pnp 00:0a: [io  0x0ca3]
[    1.505367] pnp 00:0a: Plug and Play ACPI device, IDs IPI0001 (active)
[    1.506037] pnp 00:0b: [io  0x0400-0x0453]
[    1.506490] pnp 00:0b: [io  0x0458-0x047f]
[    1.506943] pnp 00:0b: [io  0x1180-0x119f]
[    1.507397] pnp 00:0b: [io  0x0500-0x057f]
[    1.507855] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    1.508315] pnp 00:0b: [mem 0xfec00000-0xfecfffff]
[    1.508771] pnp 00:0b: [mem 0xfed08000-0xfed08fff]
[    1.509223] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    1.509766] system 00:0b: [io  0x0400-0x0453] has been reserved
[    1.510226] system 00:0b: [io  0x0458-0x047f] has been reserved
[    1.510685] system 00:0b: [io  0x1180-0x119f] has been reserved
[    1.511142] system 00:0b: [io  0x0500-0x057f] has been reserved
[    1.511601] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.512067] system 00:0b: [mem 0xfec00000-0xfecfffff] could not be reserved
[    1.512529] system 00:0b: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.512990] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    1.513451] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.513961] pnp 00:0c: [io  0x0454-0x0457]
[    1.514499] system 00:0c: [io  0x0454-0x0457] has been reserved
[    1.514956] system 00:0c: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.515954] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    1.516454] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.516970] pnp 00:0e: [bus 7f]
[    1.517474] pnp 00:0e: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.518158] pnp 00:0f: [bus 80-fe]
[    1.518611] pnp 00:0f: [io  0x0000 window]
[    1.519063] pnp 00:0f: [io  0xa000-0xffff window]
[    1.519518] pnp 00:0f: [mem 0x00000000 window]
[    1.519975] pnp 00:0f: [mem 0xe8000000-0xfbffffff window]
[    1.520439] pnp 00:0f: [mem 0x381000000000-0x381fffffffff window]
[    1.520951] pnp 00:0f: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.521879] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.522393] pnp 00:11: [mem 0xfbffe000-0xfbffffff]
[    1.522945] system 00:11: [mem 0xfbffe000-0xfbffffff] has been reserved
[    1.523407] system 00:11: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.523936] pnp 00:12: [bus ff]
[    1.524449] pnp 00:12: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.525339] pnp: PnP ACPI: found 19 devices
[    1.525795] ACPI: ACPI bus type pnp unregistered
[    1.533705] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.534168] pci 0000:00:01.1: PCI bridge to [bus 02]
[    1.534630] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.535088] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    1.535552] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.536392] pci 0000:00:02.2: PCI bridge to [bus 04]
[    1.536854] pci 0000:00:03.0: PCI bridge to [bus 05]
[    1.537310] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    1.537771] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.538607] pci 0000:00:11.0: PCI bridge to [bus 06]
[    1.539064] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    1.539523] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    1.539988] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.540828] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    1.541284] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    1.541747] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    1.542209] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.543047] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    1.543504] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    1.543968] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.544436] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.545273] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    1.545729] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    1.546193] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.546655] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.547490] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    1.547955] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.548424] pci 0000:80:01.0: PCI bridge to [bus 82]
[    1.548889] pci 0000:80:01.1: PCI bridge to [bus 83]
[    1.549352] pci 0000:80:02.0: PCI bridge to [bus 84]
[    1.549817] pci 0000:80:02.2: PCI bridge to [bus 85]
[    1.550281] pci 0000:80:03.0: PCI bridge to [bus 86]
[    1.550738] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.551199] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.552112] pci 0000:00:1e.0: setting latency timer to 64
[    1.552629] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    1.553086] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    1.553546] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    1.554004] pci_bus 0000:00: resource 7 [io  0x0d00-0x9fff]
[    1.554461] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    1.554919] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    1.555378] pci_bus 0000:00: resource 10 [mem 0x90000000-0xe7ffffff]
[    1.555837] pci_bus 0000:00: resource 11 [mem 0x380000000000-0x380fffffffff]
[    1.556303] pci_bus 0000:03: resource 1 [mem 0xe7e00000-0xe7efffff]
[    1.556761] pci_bus 0000:03: resource 2 [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.557590] pci_bus 0000:05: resource 1 [mem 0xe7d00000-0xe7dfffff]
[    1.558051] pci_bus 0000:05: resource 2 [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.558881] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
[    1.559337] pci_bus 0000:06: resource 1 [mem 0xe7c00000-0xe7cfffff]
[    1.559797] pci_bus 0000:06: resource 2 [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.560631] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    1.561090] pci_bus 0000:07: resource 1 [mem 0xe7b00000-0xe7bfffff]
[    1.561548] pci_bus 0000:07: resource 2 [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.562377] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    1.562832] pci_bus 0000:09: resource 1 [mem 0xe7a00000-0xe7afffff]
[    1.563290] pci_bus 0000:09: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.564127] pci_bus 0000:0a: resource 0 [io  0x6000-0x6fff]
[    1.564584] pci_bus 0000:0a: resource 1 [mem 0xe7a00000-0xe7afffff]
[    1.575070] pci_bus 0000:0a: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.575900] pci_bus 0000:0b: resource 4 [io  0x0000-0x03af]
[    1.576362] pci_bus 0000:0b: resource 5 [io  0x03e0-0x0cf7]
[    1.576819] pci_bus 0000:0b: resource 6 [io  0x03b0-0x03df]
[    1.577278] pci_bus 0000:0b: resource 7 [io  0x0d00-0x9fff]
[    1.577735] pci_bus 0000:0b: resource 8 [mem 0x000a0000-0x000bffff]
[    1.578195] pci_bus 0000:0b: resource 9 [mem 0x000c0000-0x000dffff]
[    1.578656] pci_bus 0000:0b: resource 10 [mem 0x90000000-0xe7ffffff]
[    1.579114] pci_bus 0000:0b: resource 11 [mem 0x380000000000-0x380fffffffff]
[    1.579578] pci_bus 0000:80: resource 4 [io  0xa000-0xffff]
[    1.580038] pci_bus 0000:80: resource 5 [mem 0xe8000000-0xfbffffff]
[    1.580496] pci_bus 0000:80: resource 6 [mem 0x381000000000-0x381fffffffff]
[    1.580955] pci_bus 0000:86: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.581414] pci_bus 0000:86: resource 2 [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.582551] NET: Registered protocol family 2
[    1.584029] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.586323] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.586968] TCP: Hash tables configured (established 524288 bind 65536)
[    1.587471] TCP: reno registered
[    1.587992] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.588697] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.589608] NET: Registered protocol family 1
[    1.628089] pci 0000:0a:00.0: Boot video device
[    1.628695] PCI: CLS 64 bytes, default 64
[    1.629201] Unpacking initramfs...
[    2.001127] Freeing initrd memory: 20656k freed
[    2.006804] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.007267] software IO TLB [mem 0x89f5c000-0x8df5bfff] (64MB) mapped at [ffff880089f5c000-ffff88008df5bfff]
[    2.010896] audit: initializing netlink socket (disabled)
[    2.011370] type=2000 audit(1476805035.764:1): initialized
[    2.034256] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.040783] VFS: Disk quotas dquot_6.5.2
[    2.041322] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.042002] msgmni has been set to 32768
[    2.042785] alg: No test for stdrng (krng)
[    2.043357] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.044241] io scheduler noop registered
[    2.044695] io scheduler deadline registered
[    2.045236] io scheduler cfq registered (default)
[    2.046127] pcieport 0000:00:01.0: irq 88 for MSI/MSI-X
[    2.046712] pcieport 0000:00:01.1: irq 89 for MSI/MSI-X
[    2.047286] pcieport 0000:00:02.0: irq 90 for MSI/MSI-X
[    2.047875] pcieport 0000:00:02.2: irq 91 for MSI/MSI-X
[    2.048446] pcieport 0000:00:03.0: irq 92 for MSI/MSI-X
[    2.049048] pcieport 0000:00:11.0: irq 93 for MSI/MSI-X
[    2.049633] pcieport 0000:00:1c.0: irq 94 for MSI/MSI-X
[    2.050205] pcieport 0000:00:1c.4: irq 95 for MSI/MSI-X
[    2.050909] pcieport 0000:80:00.0: irq 96 for MSI/MSI-X
[    2.051541] pcieport 0000:80:01.0: irq 97 for MSI/MSI-X
[    2.052177] pcieport 0000:80:01.1: irq 98 for MSI/MSI-X
[    2.052781] pcieport 0000:80:02.0: irq 99 for MSI/MSI-X
[    2.053387] pcieport 0000:80:02.2: irq 100 for MSI/MSI-X
[    2.054004] pcieport 0000:80:03.0: irq 101 for MSI/MSI-X
[    2.054636] aer 0000:00:01.0:pcie02: service driver aer loaded
[    2.055129] aer 0000:00:01.1:pcie02: service driver aer loaded
[    2.055616] aer 0000:00:02.0:pcie02: service driver aer loaded
[    2.056115] aer 0000:00:02.2:pcie02: service driver aer loaded
[    2.056600] aer 0000:00:03.0:pcie02: service driver aer loaded
[    2.057090] aer 0000:00:11.0:pcie02: service driver aer loaded
[    2.057580] aer 0000:80:00.0:pcie02: service driver aer loaded
[    2.058071] aer 0000:80:01.0:pcie02: service driver aer loaded
[    2.058558] aer 0000:80:01.1:pcie02: service driver aer loaded
[    2.059048] aer 0000:80:02.0:pcie02: service driver aer loaded
[    2.059535] aer 0000:80:02.2:pcie02: service driver aer loaded
[    2.060039] aer 0000:80:03.0:pcie02: service driver aer loaded
[    2.060515] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    2.060978] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    2.061447] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    2.061912] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    2.062379] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    2.062839] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    2.063298] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    2.063767] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    2.064236] pcie_pme 0000:00:02.2:pcie01: service driver pcie_pme loaded
[    2.064706] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    2.065168] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    2.065630] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    2.066101] pcieport 0000:00:11.0: Signaling PME through PCIe PME interrupt
[    2.066563] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    2.067027] pcie_pme 0000:00:11.0:pcie01: service driver pcie_pme loaded
[    2.067507] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    2.067973] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    2.068437] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    2.068915] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    2.069379] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    2.069838] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    2.070301] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    2.070771] pcieport 0000:80:00.0: Signaling PME through PCIe PME interrupt
[    2.071235] pcie_pme 0000:80:00.0:pcie01: service driver pcie_pme loaded
[    2.071701] pcieport 0000:80:01.0: Signaling PME through PCIe PME interrupt
[    2.072169] pcie_pme 0000:80:01.0:pcie01: service driver pcie_pme loaded
[    2.072636] pcieport 0000:80:01.1: Signaling PME through PCIe PME interrupt
[    2.073099] pcie_pme 0000:80:01.1:pcie01: service driver pcie_pme loaded
[    2.073569] pcieport 0000:80:02.0: Signaling PME through PCIe PME interrupt
[    2.074032] pcie_pme 0000:80:02.0:pcie01: service driver pcie_pme loaded
[    2.074500] pcieport 0000:80:02.2: Signaling PME through PCIe PME interrupt
[    2.074961] pcie_pme 0000:80:02.2:pcie01: service driver pcie_pme loaded
[    2.075429] pcieport 0000:80:03.0: Signaling PME through PCIe PME interrupt
[    2.075895] pci 0000:86:00.0: Signaling PME through PCIe PME interrupt
[    2.076357] pcie_pme 0000:80:03.0:pcie01: service driver pcie_pme loaded
[    2.076843] ioapic: probe of 0000:00:05.4 failed with error -22
[    2.077331] ioapic: probe of 0000:80:05.4 failed with error -22
[    2.077889] intel_idle: does not run on family 6 model 62
[    2.078424] ERST: Error Record Serialization Table (ERST) support is initialized.
[    2.079437] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    2.079980] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.100887] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    2.101715] serial 00:04: unable to assign resources
[    2.102174] serial: probe of 00:04 failed with error -16
[    2.103036] Non-volatile memory driver v1.3
[    2.103493] Linux agpgart interface v0.103
[    2.104148] libphy: Fixed MDIO Bus: probed
[    2.104656] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.105972] i8042: No controller found
[    2.106505] mousedev: PS/2 mouse device common for all mice
[    2.107027] cpuidle: using governor ladder
[    2.107483] cpuidle: using governor menu
[    2.107944] EFI Variables Facility v0.08 2004-May-17
[    2.108638] TCP: cubic registered
[    2.109105] Key type dns_resolver registered
[    2.110480] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
[    2.111322] PM: Hibernation image not present or could not be loaded.
[    2.111800] registered taskstats version 1
[    2.115976]   Magic number: 4:549:639
[    2.118751] Freeing unused kernel memory: 1344k freed
[    2.119568] Write protecting the kernel read-only data: 10240k
[    2.124335] Freeing unused kernel memory: 1696k freed
[    2.130306] Freeing unused kernel memory: 1976k freed
[    2.175870] SCSI subsystem initialized
[    2.178669] ACPI: bus type scsi registered
[    2.179185] libata version 3.00 loaded.
[    2.180974] ahci 0000:00:1f.2: version 3.0
[    2.181490] ahci 0000:00:1f.2: irq 102 for MSI/MSI-X
[    2.181963] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0x3f
[    2.182471] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.183304] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    2.184171] ahci 0000:00:1f.2: setting latency timer to 64
[    2.185110] scsi0 : ahci
[    2.185728] scsi1 : ahci
[    2.186234] scsi2 : ahci
[    2.186740] scsi3 : ahci
[    2.187245] scsi4 : ahci
[    2.187800] scsi5 : ahci
[    2.188277] ata1: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00100 irq 102
[    2.189109] ata2: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00180 irq 102
[    2.189944] ata3: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00200 irq 102
[    2.190774] ata4: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00280 irq 102
[    2.191603] ata5: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00300 irq 102
[    2.192466] ata6: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00380 irq 102
[    3.007360] tsc: Refined TSC clocksource calibration: 2299.999 MHz
[    3.007821] Switching to clocksource tsc
[    3.219230] ata4: failed to resume link (SControl 0)
[    3.219725] ata4: SATA link down (SStatus 0 SControl 0)
[    3.220204] ata6: failed to resume link (SControl 0)
[    3.220682] ata6: SATA link down (SStatus 0 SControl 0)
[    3.221161] ata1: failed to resume link (SControl 0)
[    3.221643] ata1: SATA link down (SStatus 0 SControl 0)
[    3.222122] ata2: failed to resume link (SControl 0)
[    3.222620] ata2: SATA link down (SStatus 0 SControl 0)
[    3.223101] ata3: failed to resume link (SControl 0)
[    3.223619] ata3: SATA link down (SStatus 0 SControl 0)
[    3.224097] ata5: failed to resume link (SControl 0)
[    3.224596] ata5: SATA link down (SStatus 0 SControl 0)
[    3.230768] emc: device handler registered
[    3.246084] alua: device handler registered
[    3.251133] hp_sw: device handler registered
[    3.256164] rdac: device handler registered
[    3.260394] udev: starting version 147
[    3.280028] ACPI: Requesting acpi_cpufreq
[    3.282749] Monitor-Mwait will be used to enter C-1 state
[    3.283237] Monitor-Mwait will be used to enter C-2 state
[    3.283702] ACPI: acpi_idle registered with cpuidle
[    3.289196] ACPI: bus type usb registered
[    3.289702] usbcore: registered new interface driver usbfs
[    3.290183] usbcore: registered new interface driver hub
[    3.290714] usbcore: registered new device driver usb
[    3.292717] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.293243] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.293705] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.294167] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.295096] isci: Intel(R) C600 SAS Controller Driver - version 1.1.0
[    3.298910] ehci_hcd 0000:00:1a.0: debug port 2
[    3.299376] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.299857] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe7f02000
[    3.300393] isci 0000:06:00.0: driver configured for rev: 6 silicon
[    3.300859] isci 0000:06:00.0: OEM parameter table found in OROM
[    3.301319] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) loaded (platform)
[    3.302643] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    3.305906] scsi6 : isci
[    3.306711] isci 0000:06:00.0: irq 103 for MSI/MSI-X
[    3.307178] isci 0000:06:00.0: irq 104 for MSI/MSI-X
[    3.311198] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.311681] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.312142] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.312974] usb usb1: Product: EHCI Host Controller
[    3.313431] usb usb1: Manufacturer: Linux 3.6.0 ehci_hcd
[    3.313888] usb usb1: SerialNumber: 0000:00:1a.0
[    3.315066] hub 1-0:1.0: USB hub found
[    3.315547] hub 1-0:1.0: 2 ports detected
[    3.316262] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.316731] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.317192] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.321927] ehci_hcd 0000:00:1d.0: debug port 2
[    3.322388] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.322861] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xe7f01000
[    3.335195] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.335697] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.336159] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.336989] usb usb2: Product: EHCI Host Controller
[    3.337443] usb usb2: Manufacturer: Linux 3.6.0 ehci_hcd
[    3.337900] usb usb2: SerialNumber: 0000:00:1d.0
[    3.339176] hub 2-0:1.0: USB hub found
[    3.339634] hub 2-0:1.0: 2 ports detected
[    3.631100] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    3.763388] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    3.763850] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.764522] hub 1-1:1.0: USB hub found
[    3.765123] hub 1-1:1.0: 6 ports detected
[    3.874958] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    4.007264] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    4.007726] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    4.008403] hub 2-1:1.0: USB hub found
[    4.009004] hub 2-1:1.0: 8 ports detected
[    4.278886] usb 2-1.3: new high-speed USB device number 3 using ehci_hcd
[    4.314787] sas: phy-6:0 added to port-6:0, phy_mask:0x1 (ffffffffffffffff)
[    4.315268] sas: DOING DISCOVERY on port 0, pid:254
[    4.315750] sas: DONE DISCOVERY on port 0, pid:254, result:0
[    4.316265] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[    4.316819] sas: ata7: end_device-6:0: dev error handler
[    4.479249] ata7.00: ATA-8: WDC WD5000BHTZ-04JCPV1, 04.06A01, max UDMA/133
[    4.479710] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.480729] ata7.00: configured for UDMA/133
[    4.481244] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[    4.494944] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000BHTZ-0 04.0 PQ: 0 ANSI: 5
[    4.499003] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    4.499837] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    4.500503] sd 6:0:0:0: [sda] Write Protect is off
[    4.500963] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.501481] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.511121]  sda: sda1 sda2
[    4.512177] sd 6:0:0:0: [sda] Attached SCSI disk
[    4.584233] usb 2-1.3: New USB device found, idVendor=046b, idProduct=ff01
[    4.584721] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.585562] usb 2-1.3: Product: Virtual Hub
[    4.586031] usb 2-1.3: Manufacturer: American Megatrends Inc.
[    4.586501] usb 2-1.3: SerialNumber: serial
[    4.587489] hub 2-1.3:1.0: USB hub found
[    4.588096] hub 2-1.3:1.0: 5 ports detected
[    4.664155] [drm] Initialized drm 1.1.0 20060810
[    4.669007] [drm] AST 2300 detected
[    4.669484] [drm] dram 1632000000 1 32 04000000
[    4.670020] [TTM] Zone  kernel: Available graphics memory: 32972362 kiB
[    4.670480] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    4.670943] [TTM] Initializing pool allocator
[    4.671401] [TTM] Initializing DMA pool allocator
[    4.671867] mtrr: type mismatch for e7000000,800000 old: write-back new: write-combining
[   14.821540] [sched_delayed] sched: RT throttling activated
[   45.255159] fbcon: astdrmfb (fb0) is primary device
[   45.477001] Console: switching to colour frame buffer device 128x48
[   45.587978] fb0: astdrmfb frame buffer device
[   45.588793] drm: registered panic notifier
[   45.589569] [drm] Initialized ast 0.1.0 20120228 for 0000:0a:00.0 on minor 0
[   45.615963] PM: Marking nosave pages: [mem 0x0008f000-0x000fffff]
[   45.615967] PM: Marking nosave pages: [mem 0x8df5e000-0xffffffff]
[   45.617077] PM: Basic memory bitmaps created
[   45.814462] usb 2-1.3.1: new low-speed USB device number 4 using ehci_hcd
[   45.849007] PM: Basic memory bitmaps freed
[   45.856797] PM: Starting manual resume from disk
[   45.857641] PM: Hibernation image partition 8:1 present
[   45.857642] PM: Looking for hibernation image.
[   45.857814] PM: Image not found (code -22)
[   45.857815] PM: Hibernation image not present or could not be loaded.
[   45.975756] usb 2-1.3.1: New USB device found, idVendor=046b, idProduct=ff10
[   45.977056] usb 2-1.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   45.978467] usb 2-1.3.1: Product: Virtual Keyboard and Mouse
[   45.979526] usb 2-1.3.1: Manufacturer: American Megatrends Inc.
[   46.036016] usbcore: registered new interface driver usbhid
[   46.037029] usbhid: USB HID core driver
[   46.105687] kjournald starting.  Commit interval 5 seconds
[   46.106270] EXT3-fs (sda2): using internal journal
[   46.106271] EXT3-fs (sda2): mounted filesystem with ordered data mode
[   46.138650] usb 2-1.3.2: new high-speed USB device number 5 using ehci_hcd
[   46.313838] usb 2-1.3.2: New USB device found, idVendor=046b, idProduct=ff20
[   46.313839] usb 2-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   46.313841] usb 2-1.3.2: Product: Virtual Cdrom Device
[   46.313842] usb 2-1.3.2: Manufacturer: American Megatrends Inc.
[   46.313843] usb 2-1.3.2: SerialNumber: AAAABBBBCCCC1
[   46.446629] usb 2-1.3.3: new high-speed USB device number 6 using ehci_hcd
[   46.621528] usb 2-1.3.3: New USB device found, idVendor=046b, idProduct=ff40
[   46.621529] usb 2-1.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   46.621531] usb 2-1.3.3: Product: Virtual Floppy Device
[   46.621532] usb 2-1.3.3: Manufacturer: American Megatrends Inc.
[   46.621533] usb 2-1.3.3: SerialNumber: AAAABBBBCCCC2
[   46.754473] usb 2-1.3.4: new high-speed USB device number 7 using ehci_hcd
[   46.929627] usb 2-1.3.4: New USB device found, idVendor=046b, idProduct=ff31
[   46.929628] usb 2-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   46.929629] usb 2-1.3.4: Product: Virtual HardDisk Device
[   46.929630] usb 2-1.3.4: Manufacturer: American Megatrends Inc.
[   46.929631] usb 2-1.3.4: SerialNumber: AAAABBBBCCCC3
[   48.429505] udev: starting version 147
[   48.553280] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[   48.648467] ACPI: Power Button [PWRB]
[   48.695992] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   48.744436] ACPI: Power Button [PWRF]
[   48.793547] wmi: Mapper loaded
[   48.840062] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120711/utaddress-251)
[   48.935982] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   48.985894] ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \GINV 1 (20120711/utaddress-251)
[   49.086955] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   49.139454] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   49.205550] iTCO_vendor_support: vendor-support=0
[   49.268542] mei 0000:00:16.0: Device doesn't have valid ME Interface
[   49.321069] mei 0000:00:16.0: initialization failed.
[   49.440374] microcode: CPU0 sig=0x306e2, pf=0x1, revision=0x20d
[   49.538223] Initializing USB Mass Storage driver...
[   49.590708] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   49.590748] scsi7 : usb-storage 2-1.3.2:1.0
[   49.590756] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   49.590852] usb-storage 2-1.3.3:1.0: Quirks match for vid 046b pid ff40: 200
[   49.590885] scsi8 : usb-storage 2-1.3.3:1.0
[   49.590986] scsi9 : usb-storage 2-1.3.4:1.0
[   49.591044] usbcore: registered new interface driver usb-storage
[   49.591044] USB Mass Storage support registered.
[   50.010159] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   50.030535] microcode: CPU1 sig=0x306e2, pf=0x1, revision=0x20d
[   50.034479] microcode: CPU2 sig=0x306e2, pf=0x1, revision=0x20d
[   50.038369] microcode: CPU3 sig=0x306e2, pf=0x1, revision=0x20d
[   50.042031] microcode: CPU4 sig=0x306e2, pf=0x1, revision=0x20d
[   50.045836] microcode: CPU5 sig=0x306e2, pf=0x1, revision=0x20d
[   50.049624] microcode: CPU6 sig=0x306e2, pf=0x1, revision=0x20d
[   50.053250] microcode: CPU7 sig=0x306e2, pf=0x1, revision=0x20d
[   50.057031] microcode: CPU8 sig=0x306e2, pf=0x1, revision=0x20d
[   50.060666] microcode: CPU9 sig=0x306e2, pf=0x1, revision=0x20d
[   50.064382] microcode: CPU10 sig=0x306e2, pf=0x1, revision=0x20d
[   50.551600] microcode: CPU11 sig=0x306e2, pf=0x1, revision=0x20d
[   50.590775] scsi 8:0:0:0: Direct-Access     AMI      Virtual Floppy0  1.00 PQ: 0 ANSI: 0 CCS
[   50.592011] scsi 9:0:0:0: Direct-Access     AMI      Virtual HDISK0   1.00 PQ: 0 ANSI: 0 CCS
[   50.592636] scsi 7:0:0:0: CD-ROM            AMI      Virtual CDROM0   1.00 PQ: 0 ANSI: 0 CCS
[   50.599938] sd 9:0:0:0: [sdc] Attached SCSI removable disk
[   50.600631] sd 8:0:0:0: [sdb] Attached SCSI removable disk
[   50.819758] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   50.823199] microcode: CPU12 sig=0x306e2, pf=0x1, revision=0x20d
[   50.826780] microcode: CPU13 sig=0x306e2, pf=0x1, revision=0x20d
[   50.830446] microcode: CPU14 sig=0x306e2, pf=0x1, revision=0x20d
[   50.834110] microcode: CPU15 sig=0x306e2, pf=0x1, revision=0x20d
[   50.837669] microcode: CPU16 sig=0x306e2, pf=0x1, revision=0x20d
[   50.841278] microcode: CPU17 sig=0x306e2, pf=0x1, revision=0x20d
[   50.844847] microcode: CPU18 sig=0x306e2, pf=0x1, revision=0x20d
[   50.848429] microcode: CPU19 sig=0x306e2, pf=0x1, revision=0x20d
[   50.851949] microcode: CPU20 sig=0x306e2, pf=0x1, revision=0x20d
[   50.855509] microcode: CPU21 sig=0x306e2, pf=0x1, revision=0x20d
[   50.859015] microcode: CPU22 sig=0x306e2, pf=0x1, revision=0x20d
[   50.862586] microcode: CPU23 sig=0x306e2, pf=0x1, revision=0x20d
[   50.866179] microcode: CPU24 sig=0x306e2, pf=0x1, revision=0x20d
[   50.869736] microcode: CPU25 sig=0x306e2, pf=0x1, revision=0x20d
[   50.873267] microcode: CPU26 sig=0x306e2, pf=0x1, revision=0x20d
[   50.876789] microcode: CPU27 sig=0x306e2, pf=0x1, revision=0x20d
[   50.880337] microcode: CPU28 sig=0x306e2, pf=0x1, revision=0x20d
[   50.883895] microcode: CPU29 sig=0x306e2, pf=0x1, revision=0x20d
[   50.887425] microcode: CPU30 sig=0x306e2, pf=0x1, revision=0x20d
[   50.890864] microcode: CPU31 sig=0x306e2, pf=0x1, revision=0x20d
[   50.894436] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   51.524444] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.0/input/input3
[   51.570389] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input0
[   51.620427] NET: Registered protocol family 10
[   51.620476] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.1/input/input4
[   51.620559] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input1
[   51.861328] rtc_cmos 00:06: RTC can wake from S4
[   51.879717] sr0: scsi-1 drive
[   51.879718] cdrom: Uniform CD-ROM driver Revision: 3.20
[   51.879841] sr 7:0:0:0: Attached scsi CD-ROM sr0
[   51.982683] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   52.015035] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   52.048644] sd 6:0:0:0: Attached scsi generic sg0 type 0
[   52.082734] sd 8:0:0:0: Attached scsi generic sg1 type 0
[   52.116849] sd 9:0:0:0: Attached scsi generic sg2 type 0
[   52.150972] sr 7:0:0:0: Attached scsi generic sg3 type 5
[   52.151671] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   52.317503] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[   52.351919] mlx4_core: Initializing 0000:03:00.0
[   52.390761] dca service started, version 1.12.1
[   52.458333] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[   52.564544] igb: Intel(R) Gigabit Ethernet Network Driver - version 4.0.1-k
[   52.600793] igb: Copyright (c) 2007-2012 Intel Corporation.
[   52.636754] igb 0000:07:00.0: irq 105 for MSI/MSI-X
[   52.671904] igb 0000:07:00.0: irq 106 for MSI/MSI-X
[   52.707089] igb 0000:07:00.0: irq 107 for MSI/MSI-X
[   52.742288] igb 0000:07:00.0: irq 108 for MSI/MSI-X
[   52.777484] igb 0000:07:00.0: irq 109 for MSI/MSI-X
[   52.812679] igb 0000:07:00.0: irq 110 for MSI/MSI-X
[   52.847903] igb 0000:07:00.0: irq 111 for MSI/MSI-X
[   52.883152] igb 0000:07:00.0: irq 112 for MSI/MSI-X
[   52.918410] igb 0000:07:00.0: irq 113 for MSI/MSI-X
[   53.011815] igb 0000:07:00.0: Intel(R) Gigabit Ethernet Network Connection
[   53.048144] igb 0000:07:00.0: eth0: (PCIe:5.0Gb/s:Width x4) d4:3d:7e:72:26:b5
[   53.085373] igb 0000:07:00.0: eth0: PBA No: 106100-000
[   53.122740] igb 0000:07:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   53.269587] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.269617] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.269620] Pid: 1087, comm: modprobe Not tainted 3.6.0 #3
[   53.269621] Call Trace:
[   53.269626] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.269628] Pid: 1090, comm: modprobe Not tainted 3.6.0 #3
[   53.269636]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.269638] Call Trace:
[   53.269641] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.269649]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.269652] Pid: 1079, comm: modprobe Not tainted 3.6.0 #3
[   53.269657]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.269659] Call Trace:
[   53.269663]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.269666]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.269671]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.269679]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.269685]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.269688]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.269693]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.269700]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.269706]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.269709]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.269714]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.269717]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.269721]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.269726]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.269732]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.269738]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.269741]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.269745]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.269753]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.269757]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.269760]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.269765]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.269769]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.269771]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.269774] kvm: Could not allocate 304 bytes percpu data
[   53.269779]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.269782]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.269788]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.269790]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.269793]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.269795] kvm: Could not allocate 304 bytes percpu data
[   53.269798]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.269800] kvm: Could not allocate 304 bytes percpu data
[   53.270504] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.270506] Pid: 1083, comm: modprobe Not tainted 3.6.0 #3
[   53.270506] Call Trace:
[   53.270510]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.270513]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.270515]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.270518]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.270520]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.270522]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.270524]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.270527]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.270530]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.270532]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.270534]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.270536] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.270537] kvm: Could not allocate 304 bytes percpu data
[   53.270539] Pid: 1105, comm: modprobe Not tainted 3.6.0 #3
[   53.270539] Call Trace:
[   53.270544]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.270546] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.270549]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.270552] Pid: 1119, comm: modprobe Not tainted 3.6.0 #3
[   53.270554] Call Trace:
[   53.270556]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.270562]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.270564]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.270568]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.270571]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.270573] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.270577] Pid: 1111, comm: modprobe Not tainted 3.6.0 #3
[   53.270579]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.270582]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.270583] Call Trace:
[   53.270587]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.270589]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.270593]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.270597]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.270600]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.270603]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.270607]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.270609]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.270612]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.270616]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.270618]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.270621]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.270624]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.270627]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.270629]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.270631] kvm: Could not allocate 304 bytes percpu data
[   53.270634]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.270636]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   53.270638]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.270640]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.270642]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.270644]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.270645] kvm: Could not allocate 304 bytes percpu data
[   53.270648]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.270650]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.270652]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   53.270654] kvm: Could not allocate 304 bytes percpu data
[   57.074201] Pid: 1092, comm: modprobe Not tainted 3.6.0 #3
[   57.110346] Call Trace:
[   57.145443]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   57.180648]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   57.215728]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   57.251000]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   57.286180]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   57.320647]  [<ffffffff8144d2ac>] ? do_page_fault+0x23c/0x490
[   57.354580]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   57.388205]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   57.421773]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   57.454807]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   57.487840]  [<ffffffff81451779>] system_call_fastpath+0x16/0x1b
[   57.520900] kvm: Could not allocate 304 bytes percpu data
[   62.265920] mlx4_core 0000:03:00.0: irq 114 for MSI/MSI-X
[   62.299554] mlx4_core 0000:03:00.0: irq 115 for MSI/MSI-X
[   62.332089] mlx4_core 0000:03:00.0: irq 116 for MSI/MSI-X
[   62.363530] mlx4_core 0000:03:00.0: irq 117 for MSI/MSI-X
[   62.394190] mlx4_core 0000:03:00.0: irq 118 for MSI/MSI-X
[   62.424302] mlx4_core 0000:03:00.0: irq 119 for MSI/MSI-X
[   62.453734] mlx4_core 0000:03:00.0: irq 120 for MSI/MSI-X
[   62.482412] mlx4_core 0000:03:00.0: irq 121 for MSI/MSI-X
[   62.510630] mlx4_core 0000:03:00.0: irq 122 for MSI/MSI-X
[   62.538462] mlx4_core 0000:03:00.0: irq 123 for MSI/MSI-X
[   62.565940] mlx4_core 0000:03:00.0: irq 124 for MSI/MSI-X
[   62.592935] mlx4_core 0000:03:00.0: irq 125 for MSI/MSI-X
[   62.619495] mlx4_core 0000:03:00.0: irq 126 for MSI/MSI-X
[   62.645649] mlx4_core 0000:03:00.0: irq 127 for MSI/MSI-X
[   62.671373] mlx4_core 0000:03:00.0: irq 128 for MSI/MSI-X
[   62.696591] mlx4_core 0000:03:00.0: irq 129 for MSI/MSI-X
[   62.721323] mlx4_core 0000:03:00.0: irq 130 for MSI/MSI-X
[   62.745738] mlx4_core 0000:03:00.0: irq 131 for MSI/MSI-X
[   62.769711] mlx4_core 0000:03:00.0: irq 132 for MSI/MSI-X
[   62.793184] mlx4_core 0000:03:00.0: irq 133 for MSI/MSI-X
[   62.816139] mlx4_core 0000:03:00.0: irq 134 for MSI/MSI-X
[   62.838644] mlx4_core 0000:03:00.0: irq 135 for MSI/MSI-X
[   63.019390] Adding 2103292k swap on /dev/sda1.  Priority:-1 extents:1 across:2103292k 
[   63.517881] device-mapper: uevent: version 1.0.3
[   63.542104] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   63.866850] loop: module loaded
[   64.891921] fuse init (API version 7.20)
[   66.459944] netlink: 20 bytes leftover after parsing attributes.
[   66.459946] netlink: 20 bytes leftover after parsing attributes.
[   66.459999] netlink: 20 bytes leftover after parsing attributes.
[   66.466971] netlink: 20 bytes leftover after parsing attributes.
[   66.466972] netlink: 20 bytes leftover after parsing attributes.
[   66.467005] netlink: 20 bytes leftover after parsing attributes.
[   66.468213] netlink: 20 bytes leftover after parsing attributes.
[   66.468215] netlink: 20 bytes leftover after parsing attributes.
[   66.468247] netlink: 20 bytes leftover after parsing attributes.
[   66.474876] netlink: 20 bytes leftover after parsing attributes.
[   66.474878] netlink: 20 bytes leftover after parsing attributes.
[   66.474924] netlink: 20 bytes leftover after parsing attributes.
[   66.476193] netlink: 20 bytes leftover after parsing attributes.
[   66.476194] netlink: 20 bytes leftover after parsing attributes.
[   66.476226] netlink: 20 bytes leftover after parsing attributes.
[   66.490698] netlink: 20 bytes leftover after parsing attributes.
[   66.490699] netlink: 20 bytes leftover after parsing attributes.
[   66.490734] netlink: 20 bytes leftover after parsing attributes.
[   66.493534] netlink: 20 bytes leftover after parsing attributes.
[   66.493535] netlink: 20 bytes leftover after parsing attributes.
[   66.493567] netlink: 20 bytes leftover after parsing attributes.
[   66.537183] netlink: 20 bytes leftover after parsing attributes.
[   66.537185] netlink: 20 bytes leftover after parsing attributes.
[   66.537220] netlink: 20 bytes leftover after parsing attributes.
[   66.539661] netlink: 20 bytes leftover after parsing attributes.
[   70.275550] netlink: 20 bytes leftover after parsing attributes.
[   70.275562] netlink: 20 bytes leftover after parsing attributes.
[   70.275652] netlink: 20 bytes leftover after parsing attributes.
[   70.277949] netlink: 20 bytes leftover after parsing attributes.
[   70.277959] netlink: 20 bytes leftover after parsing attributes.
[   70.278048] netlink: 20 bytes leftover after parsing attributes.
[   70.308040] netlink: 20 bytes leftover after parsing attributes.
[   70.308050] netlink: 20 bytes leftover after parsing attributes.
[   70.308115] netlink: 20 bytes leftover after parsing attributes.
[   70.316310] netlink: 20 bytes leftover after parsing attributes.
[   70.316320] netlink: 20 bytes leftover after parsing attributes.
[   70.316387] netlink: 20 bytes leftover after parsing attributes.
[   70.321047] netlink: 20 bytes leftover after parsing attributes.
[   70.321056] netlink: 20 bytes leftover after parsing attributes.
[   70.321122] netlink: 20 bytes leftover after parsing attributes.
[   70.332268] netlink: 20 bytes leftover after parsing attributes.
[   70.332278] netlink: 20 bytes leftover after parsing attributes.
[   70.332343] netlink: 20 bytes leftover after parsing attributes.
[   70.336414] netlink: 20 bytes leftover after parsing attributes.
[   70.336424] netlink: 20 bytes leftover after parsing attributes.
[   70.336490] netlink: 20 bytes leftover after parsing attributes.
[   70.341121] netlink: 20 bytes leftover after parsing attributes.
[   70.393163] netlink: 20 bytes leftover after parsing attributes.
[   70.393176] netlink: 20 bytes leftover after parsing attributes.
[   70.393239] netlink: 20 bytes leftover after parsing attributes.
[   70.558492] netlink: 20 bytes leftover after parsing attributes.
[   70.558505] netlink: 20 bytes leftover after parsing attributes.
[   70.558568] netlink: 20 bytes leftover after parsing attributes.
[   70.569811] netlink: 20 bytes leftover after parsing attributes.
[   70.569814] netlink: 20 bytes leftover after parsing attributes.
[   70.569875] netlink: 20 bytes leftover after parsing attributes.
[   70.576020] netlink: 20 bytes leftover after parsing attributes.
[   70.576023] netlink: 20 bytes leftover after parsing attributes.
[   70.576086] netlink: 20 bytes leftover after parsing attributes.
[   70.587044] netlink: 20 bytes leftover after parsing attributes.
[   70.587047] netlink: 20 bytes leftover after parsing attributes.
[   70.587109] netlink: 20 bytes leftover after parsing attributes.
[   70.589207] netlink: 20 bytes leftover after parsing attributes.
[   70.589210] netlink: 20 bytes leftover after parsing attributes.
[   70.589274] netlink: 20 bytes leftover after parsing attributes.
[   70.607460] netlink: 20 bytes leftover after parsing attributes.
[   70.607463] netlink: 20 bytes leftover after parsing attributes.
[   70.607519] netlink: 20 bytes leftover after parsing attributes.
[   70.611904] netlink: 20 bytes leftover after parsing attributes.
[   70.611907] netlink: 20 bytes leftover after parsing attributes.
[   70.611971] netlink: 20 bytes leftover after parsing attributes.
[   70.622668] netlink: 20 bytes leftover after parsing attributes.
[   70.622671] netlink: 20 bytes leftover after parsing attributes.
[   70.622735] netlink: 20 bytes leftover after parsing attributes.
[   70.626441] netlink: 20 bytes leftover after parsing attributes.
[   71.404539] NET: Registered protocol family 17
[   71.406985] netlink: 20 bytes leftover after parsing attributes.
[   71.406996] netlink: 20 bytes leftover after parsing attributes.
[   71.407069] netlink: 20 bytes leftover after parsing attributes.
[   71.409229] netlink: 20 bytes leftover after parsing attributes.
[   71.409242] netlink: 20 bytes leftover after parsing attributes.
[   71.409319] netlink: 20 bytes leftover after parsing attributes.
[   71.495751] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   71.495792] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   71.495934] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   73.204541] netlink: 20 bytes leftover after parsing attributes.
[   73.204555] netlink: 20 bytes leftover after parsing attributes.
[   73.204757] netlink: 20 bytes leftover after parsing attributes.
[   73.209761] netlink: 20 bytes leftover after parsing attributes.
[   73.209775] netlink: 20 bytes leftover after parsing attributes.
[   73.209984] netlink: 20 bytes leftover after parsing attributes.
[   73.212579] netlink: 20 bytes leftover after parsing attributes.
[   73.212590] netlink: 20 bytes leftover after parsing attributes.
[   73.212774] netlink: 20 bytes leftover after parsing attributes.
[   73.223114] netlink: 20 bytes leftover after parsing attributes.
[   73.223124] netlink: 20 bytes leftover after parsing attributes.
[   73.223308] netlink: 20 bytes leftover after parsing attributes.
[   73.627453] netlink: 20 bytes leftover after parsing attributes.
[   73.627457] netlink: 20 bytes leftover after parsing attributes.
[   73.627609] netlink: 20 bytes leftover after parsing attributes.
[   73.632206] netlink: 20 bytes leftover after parsing attributes.
[   73.632212] netlink: 20 bytes leftover after parsing attributes.
[   73.632401] netlink: 20 bytes leftover after parsing attributes.
[   73.634982] netlink: 20 bytes leftover after parsing attributes.
[   73.634988] netlink: 20 bytes leftover after parsing attributes.
[   73.635164] netlink: 20 bytes leftover after parsing attributes.
[   73.645188] netlink: 20 bytes leftover after parsing attributes.
[   73.645194] netlink: 20 bytes leftover after parsing attributes.
[   73.645373] netlink: 20 bytes leftover after parsing attributes.
[   74.771687] netlink: 20 bytes leftover after parsing attributes.
[   74.771693] netlink: 20 bytes leftover after parsing attributes.
[   74.771881] netlink: 20 bytes leftover after parsing attributes.
[   74.791796] netlink: 20 bytes leftover after parsing attributes.
[   74.791799] netlink: 20 bytes leftover after parsing attributes.
[   74.791949] netlink: 20 bytes leftover after parsing attributes.
[   74.796609] netlink: 20 bytes leftover after parsing attributes.
[   74.796615] netlink: 20 bytes leftover after parsing attributes.
[   74.796798] netlink: 20 bytes leftover after parsing attributes.
[   74.799405] netlink: 20 bytes leftover after parsing attributes.
[   74.799411] netlink: 20 bytes leftover after parsing attributes.
[   74.799593] netlink: 20 bytes leftover after parsing attributes.
[   74.809080] netlink: 20 bytes leftover after parsing attributes.
[   74.809087] netlink: 20 bytes leftover after parsing attributes.
[   74.809267] netlink: 20 bytes leftover after parsing attributes.
[   74.813195] netlink: 20 bytes leftover after parsing attributes.
[   77.104893] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   78.050685] netlink: 20 bytes leftover after parsing attributes.
[   78.050692] netlink: 20 bytes leftover after parsing attributes.
[   78.050891] netlink: 20 bytes leftover after parsing attributes.
[   78.053225] netlink: 20 bytes leftover after parsing attributes.
[   78.053231] netlink: 20 bytes leftover after parsing attributes.
[   78.053430] netlink: 20 bytes leftover after parsing attributes.
[   78.074216] netlink: 20 bytes leftover after parsing attributes.
[   78.074222] netlink: 20 bytes leftover after parsing attributes.
[   78.074400] netlink: 20 bytes leftover after parsing attributes.
[   78.081843] netlink: 20 bytes leftover after parsing attributes.
[   78.081849] netlink: 20 bytes leftover after parsing attributes.
[   78.082031] netlink: 20 bytes leftover after parsing attributes.
[   78.086487] netlink: 20 bytes leftover after parsing attributes.
[   78.086493] netlink: 20 bytes leftover after parsing attributes.
[   78.086702] netlink: 20 bytes leftover after parsing attributes.
[   78.097323] netlink: 20 bytes leftover after parsing attributes.
[   78.097329] netlink: 20 bytes leftover after parsing attributes.
[   78.097519] netlink: 20 bytes leftover after parsing attributes.
[   78.100731] netlink: 20 bytes leftover after parsing attributes.
[   78.100737] netlink: 20 bytes leftover after parsing attributes.
[   78.100914] netlink: 20 bytes leftover after parsing attributes.
[   78.105839] netlink: 20 bytes leftover after parsing attributes.
[   78.149611] netlink: 20 bytes leftover after parsing attributes.
[   78.149615] netlink: 20 bytes leftover after parsing attributes.
[   78.149770] netlink: 20 bytes leftover after parsing attributes.

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmesg_3.7.0"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.7.0 (root@r1i2n0) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #4 SMP Mon Oct 17 20:58:17 EDT 2016
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8
[    0.000000] e820: BIOS-provided physical RAM map:
[    0.000000] BIOS-e820: [mem 0x0000000000000000-0x000000000008efff] usable
[    0.000000] BIOS-e820: [mem 0x000000000008f000-0x000000000009ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000000100000-0x000000008df5dfff] usable
[    0.000000] BIOS-e820: [mem 0x000000008df5e000-0x000000008df8dfff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008df8e000-0x000000008e0a3fff] ACPI data
[    0.000000] BIOS-e820: [mem 0x000000008e0a4000-0x000000008e2c9fff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x000000008e2ca000-0x000000008f336fff] reserved
[    0.000000] BIOS-e820: [mem 0x000000008f337000-0x000000008f7fffff] ACPI NVS
[    0.000000] BIOS-e820: [mem 0x0000000090000000-0x000000009fffffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000fed1c000-0x00000000fed3ffff] reserved
[    0.000000] BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
[    0.000000] BIOS-e820: [mem 0x0000000100000000-0x000000106fffffff] usable
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: SGI.COM ICE-XIP119/S0751-Medina, BIOS ma2e2054 02/05/2014
[    0.000000] e820: update [mem 0x00000000-0x0000ffff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
[    0.000000] No AGP bridge found
[    0.000000] e820: last_pfn = 0x1070000 max_arch_pfn = 0x400000000
[    0.000000] MTRR default type: uncachable
[    0.000000] MTRR fixed ranges enabled:
[    0.000000]   00000-9FFFF write-back
[    0.000000]   A0000-BFFFF uncachable
[    0.000000]   C0000-FFFFF write-protect
[    0.000000] MTRR variable ranges enabled:
[    0.000000]   0 base 000000000000 mask 3FF000000000 write-back
[    0.000000]   1 base 001000000000 mask 3FFF80000000 write-back
[    0.000000]   2 base 000090000000 mask 3FFFF0000000 uncachable
[    0.000000]   3 base 0000A0000000 mask 3FFFE0000000 uncachable
[    0.000000]   4 base 0000C0000000 mask 3FFFC0000000 uncachable
[    0.000000]   5 base 001070000000 mask 3FFFF0000000 uncachable
[    0.000000]   6 disabled
[    0.000000]   7 disabled
[    0.000000]   8 disabled
[    0.000000]   9 disabled
[    0.000000] x86 PAT enabled: cpu 0, old 0x7040600070406, new 0x7010600070106
[    0.000000] e820: update [mem 0x90000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x8df5e max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fdba0-0x000fdbaf] mapped at [ffff8800000fdba0]
[    0.000000] initial memory mapped: [mem 0x00000000-0x1fffffff]
[    0.000000] Base memory trampoline at [ffff880000088000] 88000 size 28672
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: [mem 0x00000000-0x8df5dfff]
[    0.000000]  [mem 0x00000000-0x7fffffff] page 1G
[    0.000000]  [mem 0x80000000-0x8ddfffff] page 2M
[    0.000000]  [mem 0x8de00000-0x8df5dfff] page 4k
[    0.000000] kernel direct mapping tables up to 0x8df5dfff @ [mem 0x1fffd000-0x1fffffff]
[    0.000000] init_memory_mapping: [mem 0x100000000-0x106fffffff]
[    0.000000]  [mem 0x100000000-0x103fffffff] page 1G
[    0.000000]  [mem 0x1040000000-0x106fffffff] page 2M
[    0.000000] kernel direct mapping tables up to 0x106fffffff @ [mem 0x8df5c000-0x8df5dfff]
[    0.000000] RAMDISK: [mem 0x36ba6000-0x37feffff]
[    0.000000] Reserving 128MB of memory at 736MB for crashkernel (System RAM: 65502MB)
[    0.000000] ACPI: RSDP 00000000000f04a0 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 000000008dfc5090 0009C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 000000008dfd1cd0 0010C (v05 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 000000008dfc51b8 0CB14 (v02 ALASKA    A M I 00000201 INTL 20051117)
[    0.000000] ACPI: FACS 000000008e2c1080 00040
[    0.000000] ACPI: APIC 000000008dfd1de0 00224 (v03 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 000000008dfd2008 00044 (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 000000008dfd2050 0003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
[    0.000000] ACPI: SRAT 000000008dfd2090 004B0 (v01 A M I  AMI SRAT 00000001 AMI. 00000000)
[    0.000000] ACPI: SLIT 000000008dfd2540 00030 (v01 A M I  AMI SLIT 00000000 AMI. 00000000)
[    0.000000] ACPI: HPET 000000008dfd2570 00038 (v01 ALASKA    A M I 01072009 AMI. 00000005)
[    0.000000] ACPI: PRAD 000000008dfd25a8 000BE (v02 PRADID  PRADTID 00000001 MSFT 03000001)
[    0.000000] ACPI: SPMI 000000008dfd2668 00040 (v05 A M I   OEMSPMI 00000000 AMI. 00000000)
[    0.000000] ACPI: SSDT 000000008dfd26a8 D0CB0 (v02  INTEL    CpuPm 00004000 INTL 20051117)
[    0.000000] ACPI: EINJ 000000008e0a3358 00130 (v01    AMI AMI EINJ 00000000      00000000)
[    0.000000] ACPI: ERST 000000008e0a3488 00230 (v01  AMIER AMI ERST 00000000      00000000)
[    0.000000] ACPI: HEST 000000008e0a36b8 00068 (v01    AMI AMI HEST 00000000      00000000)
[    0.000000] ACPI: BERT 000000008e0a3720 00030 (v01    AMI AMI BERT 00000000      00000000)
[    0.000000] ACPI: DMAR 000000008e0a3750 00150 (v01 A M I   OEMDMAR 00000001 INTL 00000001)
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] SRAT: PXM 0 -> APIC 0x02 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x03 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x04 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x05 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x06 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x07 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x08 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x09 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x10 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x11 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x12 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x13 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x14 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x15 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x16 -> Node 0
[    0.000000] SRAT: PXM 0 -> APIC 0x17 -> Node 0
[    0.000000] SRAT: PXM 1 -> APIC 0x20 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x21 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x22 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x23 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x24 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x25 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x26 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x27 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x32 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x33 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x34 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x35 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x36 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x37 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x38 -> Node 1
[    0.000000] SRAT: PXM 1 -> APIC 0x39 -> Node 1
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x00000000-0x8fffffff]
[    0.000000] SRAT: Node 0 PXM 0 [mem 0x100000000-0x86fffffff]
[    0.000000] SRAT: Node 1 PXM 1 [mem 0x870000000-0x106fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x8fffffff] + [mem 0x100000000-0x86fffffff] -> [mem 0x00000000-0x86fffffff]
[    0.000000] Initmem setup node 0 [mem 0x00000000-0x86fffffff]
[    0.000000]   NODE_DATA [mem 0x86ffd9000-0x86fffffff]
[    0.000000] Initmem setup node 1 [mem 0x870000000-0x106fffffff]
[    0.000000]   NODE_DATA [mem 0x106ffd8000-0x106fffefff]
[    0.000000] [ffffea001d880000-ffffea001d9fffff] potential offnode page_structs
[    0.000000]  [ffffea0000000000-ffffea001d9fffff] PMD -> [ffff88084fe00000-ffff88086bffffff] on node 0
[    0.000000]  [ffffea001da00000-ffffea00399fffff] PMD -> [ffff88104f600000-ffff88106b5fffff] on node 1
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x00010000-0x00ffffff]
[    0.000000]   DMA32    [mem 0x01000000-0xffffffff]
[    0.000000]   Normal   [mem 0x100000000-0x106fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x00010000-0x0008efff]
[    0.000000]   node   0: [mem 0x00100000-0x8df5dfff]
[    0.000000]   node   0: [mem 0x100000000-0x86fffffff]
[    0.000000]   node   1: [mem 0x870000000-0x106fffffff]
[    0.000000] On node 0 totalpages: 8380125
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 7 pages reserved
[    0.000000]   DMA zone: 3904 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 14280 pages used for memmap
[    0.000000]   DMA32 zone: 563094 pages, LIFO batch:31
[    0.000000]   Normal zone: 106624 pages used for memmap
[    0.000000]   Normal zone: 7692160 pages, LIFO batch:31
[    0.000000] On node 1 totalpages: 8388608
[    0.000000]   Normal zone: 114688 pages used for memmap
[    0.000000]   Normal zone: 8273920 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
[    0.000000] ACPI: LAPIC (acpi_id[0x00] lapic_id[0x02] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x02] lapic_id[0x04] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x04] lapic_id[0x06] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x06] lapic_id[0x08] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x08] lapic_id[0x10] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0a] lapic_id[0x12] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0c] lapic_id[0x14] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0e] lapic_id[0x16] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x10] lapic_id[0x20] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x12] lapic_id[0x22] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x14] lapic_id[0x24] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x16] lapic_id[0x26] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x18] lapic_id[0x32] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1a] lapic_id[0x34] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1c] lapic_id[0x36] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1e] lapic_id[0x38] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x01] lapic_id[0x03] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x03] lapic_id[0x05] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x05] lapic_id[0x07] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x07] lapic_id[0x09] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x09] lapic_id[0x11] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0b] lapic_id[0x13] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0d] lapic_id[0x15] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x0f] lapic_id[0x17] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x11] lapic_id[0x21] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x13] lapic_id[0x23] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x15] lapic_id[0x25] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x17] lapic_id[0x27] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x19] lapic_id[0x33] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1b] lapic_id[0x35] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1d] lapic_id[0x37] enabled)
[    0.000000] ACPI: LAPIC (acpi_id[0x1f] lapic_id[0x39] enabled)
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x00] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x06] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x08] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x10] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x12] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x14] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x16] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x18] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1a] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1c] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1e] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x05] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x07] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x09] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x0f] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x11] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x13] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x15] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x17] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x19] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1b] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1d] high edge lint[0x1])
[    0.000000] ACPI: LAPIC_NMI (acpi_id[0x1f] high edge lint[0x1])
[    0.000000] ACPI: IOAPIC (id[0x00] address[0xfec00000] gsi_base[0])
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] ACPI: IOAPIC (id[0x02] address[0xfec01000] gsi_base[24])
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.000000] ACPI: IOAPIC (id[0x03] address[0xfec40000] gsi_base[48])
[    0.000000] IOAPIC[2]: apic_id 3, version 32, address 0xfec40000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ2 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] nr_irqs_gsi: 88
[    0.000000] PM: Registered nosave memory: 000000000008f000 - 00000000000a0000
[    0.000000] PM: Registered nosave memory: 00000000000a0000 - 00000000000e0000
[    0.000000] PM: Registered nosave memory: 00000000000e0000 - 0000000000100000
[    0.000000] PM: Registered nosave memory: 000000008df5e000 - 000000008df8e000
[    0.000000] PM: Registered nosave memory: 000000008df8e000 - 000000008e0a4000
[    0.000000] PM: Registered nosave memory: 000000008e0a4000 - 000000008e2ca000
[    0.000000] PM: Registered nosave memory: 000000008e2ca000 - 000000008f337000
[    0.000000] PM: Registered nosave memory: 000000008f337000 - 000000008f800000
[    0.000000] PM: Registered nosave memory: 000000008f800000 - 0000000090000000
[    0.000000] PM: Registered nosave memory: 0000000090000000 - 00000000a0000000
[    0.000000] PM: Registered nosave memory: 00000000a0000000 - 00000000fed1c000
[    0.000000] PM: Registered nosave memory: 00000000fed1c000 - 00000000fed40000
[    0.000000] PM: Registered nosave memory: 00000000fed40000 - 00000000ff000000
[    0.000000] PM: Registered nosave memory: 00000000ff000000 - 0000000100000000
[    0.000000] e820: [mem 0xa0000000-0xfed1bfff] available for PCI devices
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:2
[    0.000000] PERCPU: Embedded 27 pages/cpu @ffff88086fc00000 s79232 r8192 d23168 u131072
[    0.000000] pcpu-alloc: s79232 r8192 d23168 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 16 17 18 19 20 21 22 23 
[    0.000000] pcpu-alloc: [1] 08 09 10 11 12 13 14 15 24 25 26 27 28 29 30 31 
[    0.000000] Built 2 zonelists in Zone order, mobility grouping on.  Total pages: 16533078
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 65918884k/68943872k available (4497k kernel code, 1868940k absent, 1156048k reserved, 6523k data, 1372k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=32.
[    0.000000] NR_IRQS:262400 nr_irqs:1752 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2299.843 MHz processor
[    0.000013] Calibrating delay loop (skipped), value calculated using timer frequency.. 4599.68 BogoMIPS (lpj=9199372)
[    0.000338] pid_max: default: 32768 minimum: 301
[    0.000548] Security Framework initialized
[    0.000716] AppArmor: AppArmor initialized
[    0.005023] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.019283] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.025428] Mount-cache hash table entries: 256
[    0.025857] Initializing cgroup subsys cpuacct
[    0.026016] Initializing cgroup subsys devices
[    0.026176] Initializing cgroup subsys freezer
[    0.026336] Initializing cgroup subsys net_cls
[    0.026494] Initializing cgroup subsys blkio
[    0.026653] Initializing cgroup subsys perf_event
[    0.026850] CPU: Physical Processor ID: 0
[    0.027006] CPU: Processor Core ID: 1
[    0.028038] mce: CPU supports 27 MCE banks
[    0.028245] CPU0: Thermal monitoring enabled (TM1)
[    0.028435] process: using mwait in idle threads
[    0.028597] Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
[    0.028597] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.028597] tlb_flushall_shift: 6
[    0.029046] Freeing SMP alternatives: 16k freed
[    0.030505] ACPI: Core revision 20120913
[    0.071116] Switched APIC routing to physical flat.
[    0.072187] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.112313] smpboot: CPU0: Genuine Intel(R) CPU  @ 2.80GHz (fam: 06, model: 3e, stepping: 02)
[    0.220007] Performance Events: PEBS fmt1+, generic architected perfmon, Intel PMU driver.
[    0.221073] ... version:                3
[    0.221527] ... bit width:              48
[    0.221981] ... generic registers:      4
[    0.222435] ... value mask:             0000ffffffffffff
[    0.222891] ... max period:             000000007fffffff
[    0.223347] ... fixed-purpose events:   3
[    0.223800] ... event mask:             000000070000000f
[    0.225078] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    0.328700] smpboot: Booting Node   1, Processors  #8 #9 #10 #11 #12 #13 #14 #15 OK
[    0.546099] smpboot: Booting Node   0, Processors  #16 #17 #18 #19 #20 #21 #22 #23 OK
[    0.661667] smpboot: Booting Node   1, Processors  #24 #25 #26 #27 #28 #29 #30 #31 OK
[    0.782378] Brought up 32 CPUs
[    0.782846] smpboot: Total of 32 processors activated (147193.62 BogoMIPS)
[    0.861516] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.863857] devtmpfs: initialized
[    0.872729] PM: Registering ACPI NVS region [mem 0x8e0a4000-0x8e2c9fff] (2252800 bytes)
[    0.873630] PM: Registering ACPI NVS region [mem 0x8f337000-0x8f7fffff] (5017600 bytes)
[    0.874755] regulator-dummy: no parameters
[    0.875243] RTC time: 15:57:41, date: 10/18/16
[    0.875864] NET: Registered protocol family 16
[    0.876548] ACPI: bus type pci registered
[    0.877079] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x90000000-0x9fffffff] (base 0x90000000)
[    0.877914] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved in E820
[    0.898864] PCI: Using configuration type 1 for base access
[    0.901567] bio: create slab <bio-0> at 0
[    0.902287] ACPI: Added _OSI(Module Device)
[    0.902741] ACPI: Added _OSI(Processor Device)
[    0.903195] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.903654] ACPI: Added _OSI(Processor Aggregator Device)
[    0.915249] ACPI: EC: Look up EC in DSDT
[    0.926793] ACPI: Executed 1 blocks of module-level executable AML code
[    1.194065] \_SB_:_OSC invalid UUID
[    1.194520] _OSC request data:1 1f 
[    1.201434] ACPI: Interpreter enabled
[    1.201889] ACPI: (supports S0 S4 S5)
[    1.202581] ACPI: Using IOAPIC for interrupt routing
[    1.215332] ACPI: No dock devices found.
[    1.225791] HEST: Table parsing has been initialized.
[    1.226249] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.227492] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    1.228418] PCI host bridge to bus 0000:00
[    1.228874] pci_bus 0000:00: root bus resource [bus 00-7e]
[    1.229332] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    1.229791] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    1.230249] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    1.230710] pci_bus 0000:00: root bus resource [io  0x0d00-0x9fff]
[    1.231168] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    1.231631] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    1.232093] pci_bus 0000:00: root bus resource [mem 0x90000000-0xe7ffffff]
[    1.232553] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x380fffffffff]
[    1.233394] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    1.233908] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.234390] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    1.234910] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.235392] pci 0000:00:01.1: [8086:0e03] type 01 class 0x060400
[    1.235914] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    1.236405] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    1.236924] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.237408] pci 0000:00:02.2: [8086:0e06] type 01 class 0x060400
[    1.237928] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    1.238416] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    1.238935] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.239419] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    1.239954] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    1.240486] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    1.240952] pci 0000:00:05.4: reg 10: [mem 0xe7f06000-0xe7f06fff]
[    1.241487] pci 0000:00:07.0: [8086:0e18] type 00 class 0x088000
[    1.242031] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    1.242581] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    1.243074] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    1.243557] pci 0000:00:16.0: reg 10: [mem 0xe7f05000-0xe7f0500f 64bit]
[    1.244087] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.244566] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000
[    1.245043] pci 0000:00:16.1: reg 10: [mem 0xe7f04000-0xe7f0400f 64bit]
[    1.245574] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    1.246064] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    1.246543] pci 0000:00:1a.0: reg 10: [mem 0xe7f02000-0xe7f023ff]
[    1.247091] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.247576] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    1.248112] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.248597] pci 0000:00:1c.4: [8086:1d18] type 01 class 0x060400
[    1.249133] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.249622] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    1.250100] pci 0000:00:1d.0: reg 10: [mem 0xe7f01000-0xe7f013ff]
[    1.250647] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.251125] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    1.251647] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    1.252229] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    1.252705] pci 0000:00:1f.2: reg 10: [io  0x9070-0x9077]
[    1.253168] pci 0000:00:1f.2: reg 14: [io  0x9060-0x9063]
[    1.253631] pci 0000:00:1f.2: reg 18: [io  0x9050-0x9057]
[    1.254094] pci 0000:00:1f.2: reg 1c: [io  0x9040-0x9043]
[    1.254557] pci 0000:00:1f.2: reg 20: [io  0x9020-0x903f]
[    1.255021] pci 0000:00:1f.2: reg 24: [mem 0xe7f00000-0xe7f007ff]
[    1.255525] pci 0000:00:1f.2: PME# supported from D3hot
[    1.255998] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    1.256469] pci 0000:00:1f.3: reg 10: [mem 0x380ffff01000-0x380ffff010ff 64bit]
[    1.257318] pci 0000:00:1f.3: reg 20: [io  0x9000-0x901f]
[    1.257808] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000
[    1.258286] pci 0000:00:1f.6: reg 10: [mem 0x380ffff00000-0x380ffff00fff 64bit]
[    1.259223] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.259727] pci 0000:00:01.1: PCI bridge to [bus 02]
[    1.260454] pci 0000:03:00.0: [15b3:1003] type 00 class 0x028000
[    1.261159] pci 0000:03:00.0: reg 10: [mem 0xe7e00000-0xe7efffff 64bit]
[    1.261824] pci 0000:03:00.0: reg 18: [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.264242] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.264702] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    1.265165] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.266035] pci 0000:00:02.2: PCI bridge to [bus 04]
[    1.266541] pci 0000:05:00.0: [8086:2250] type 00 class 0x0b4000
[    1.267008] pci 0000:05:00.0: reg 10: [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.267855] pci 0000:05:00.0: reg 20: [mem 0xe7d00000-0xe7d1ffff 64bit]
[    1.268344] pci 0000:05:00.0: PME# supported from D0
[    1.275467] pci 0000:00:03.0: PCI bridge to [bus 05]
[    1.275942] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    1.276405] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.277299] pci 0000:06:00.0: [8086:1d69] type 00 class 0x010700
[    1.277775] pci 0000:06:00.0: reg 10: [mem 0x380e00c7c000-0x380e00c7ffff 64bit pref]
[    1.278620] pci 0000:06:00.0: reg 18: [mem 0x380e00800000-0x380e00bfffff 64bit pref]
[    1.279462] pci 0000:06:00.0: reg 20: [io  0x8000-0x80ff]
[    1.280018] pci 0000:06:00.0: reg 164: [mem 0x380e00c00000-0x380e00c03fff 64bit pref]
[    1.280903] pci 0000:00:11.0: PCI bridge to [bus 06]
[    1.281361] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    1.281823] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    1.282289] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.283191] pci 0000:07:00.0: [8086:1523] type 00 class 0x020000
[    1.283670] pci 0000:07:00.0: reg 10: [mem 0xe7b00000-0xe7b1ffff]
[    1.284153] pci 0000:07:00.0: reg 18: [io  0x7000-0x701f]
[    1.284622] pci 0000:07:00.0: reg 1c: [mem 0xe7b20000-0xe7b23fff]
[    1.285187] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    1.285703] pci 0000:07:00.0: reg 184: [mem 0x380e00e20000-0x380e00e23fff 64bit pref]
[    1.286561] pci 0000:07:00.0: reg 190: [mem 0x380e00e00000-0x380e00e03fff 64bit pref]
[    1.291463] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    1.291936] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    1.292398] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    1.292861] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.293760] pci 0000:09:00.0: [1a03:1150] type 01 class 0x060400
[    1.294361] pci 0000:09:00.0: supports D1 D2
[    1.294816] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.299450] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    1.299926] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    1.300388] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.300855] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.301788] pci 0000:0a:00.0: [1a03:2000] type 00 class 0x030000
[    1.302279] pci 0000:0a:00.0: reg 10: [mem 0xe7000000-0xe77fffff pref]
[    1.302756] pci 0000:0a:00.0: reg 14: [mem 0xe7a00000-0xe7a1ffff]
[    1.303233] pci 0000:0a:00.0: reg 18: [io  0x6000-0x607f]
[    1.303815] pci 0000:0a:00.0: supports D1 D2
[    1.304272] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.304824] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    1.305289] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    1.305754] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.306223] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.307125] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    1.307596] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    1.308431] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    1.309264] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    1.310099] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff] (subtractive decode)
[    1.310934] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.311772] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    1.312609] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xe7ffffff] (subtractive decode)
[    1.313445] pci 0000:00:1e.0:   bridge window [mem 0x380000000000-0x380fffffffff] (subtractive decode)
[    1.314318] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    1.314778] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.315413] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    1.315952] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
[    1.316440] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
[    1.316941] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE2._PRT]
[    1.317433] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
[    1.317932] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE5._PRT]
[    1.318427] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
[    1.319045]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.319698]  pci0000:00: ACPI _OSC control (0x1d) granted
[    1.329506] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    1.330025] PCI host bridge to bus 0000:7f
[    1.330481] pci_bus 0000:7f: root bus resource [bus 7f]
[    1.330947] pci 0000:7f:08.0: [8086:0e80] type 00 class 0x088000
[    1.331445] pci 0000:7f:08.3: [8086:0e83] type 00 class 0x088000
[    1.331946] pci 0000:7f:08.4: [8086:0e84] type 00 class 0x088000
[    1.332452] pci 0000:7f:09.0: [8086:0e90] type 00 class 0x088000
[    1.332944] pci 0000:7f:09.3: [8086:0e93] type 00 class 0x088000
[    1.333446] pci 0000:7f:09.4: [8086:0e94] type 00 class 0x088000
[    1.333950] pci 0000:7f:0a.0: [8086:0ec0] type 00 class 0x088000
[    1.334436] pci 0000:7f:0a.1: [8086:0ec1] type 00 class 0x088000
[    1.334924] pci 0000:7f:0a.2: [8086:0ec2] type 00 class 0x088000
[    1.335411] pci 0000:7f:0a.3: [8086:0ec3] type 00 class 0x088000
[    1.335901] pci 0000:7f:0b.0: [8086:0e1e] type 00 class 0x088000
[    1.336392] pci 0000:7f:0b.3: [8086:0e1f] type 00 class 0x088000
[    1.336882] pci 0000:7f:0c.0: [8086:0ee0] type 00 class 0x088000
[    1.337369] pci 0000:7f:0c.1: [8086:0ee2] type 00 class 0x088000
[    1.337858] pci 0000:7f:0c.2: [8086:0ee4] type 00 class 0x088000
[    1.338348] pci 0000:7f:0c.3: [8086:0ee6] type 00 class 0x088000
[    1.348846] pci 0000:7f:0c.4: [8086:0ee8] type 00 class 0x088000
[    1.349335] pci 0000:7f:0d.0: [8086:0ee1] type 00 class 0x088000
[    1.349822] pci 0000:7f:0d.1: [8086:0ee3] type 00 class 0x088000
[    1.350311] pci 0000:7f:0d.2: [8086:0ee5] type 00 class 0x088000
[    1.350798] pci 0000:7f:0d.3: [8086:0ee7] type 00 class 0x088000
[    1.351285] pci 0000:7f:0d.4: [8086:0ee9] type 00 class 0x088000
[    1.351778] pci 0000:7f:0e.0: [8086:0ea0] type 00 class 0x088000
[    1.352272] pci 0000:7f:0e.1: [8086:0e30] type 00 class 0x110100
[    1.352769] pci 0000:7f:0f.0: [8086:0ea8] type 00 class 0x088000
[    1.353270] pci 0000:7f:0f.1: [8086:0e71] type 00 class 0x088000
[    1.353770] pci 0000:7f:0f.2: [8086:0eaa] type 00 class 0x088000
[    1.354270] pci 0000:7f:0f.3: [8086:0eab] type 00 class 0x088000
[    1.354770] pci 0000:7f:0f.4: [8086:0eac] type 00 class 0x088000
[    1.355269] pci 0000:7f:0f.5: [8086:0ead] type 00 class 0x088000
[    1.355774] pci 0000:7f:10.0: [8086:0eb0] type 00 class 0x088000
[    1.356275] pci 0000:7f:10.1: [8086:0eb1] type 00 class 0x088000
[    1.356777] pci 0000:7f:10.2: [8086:0eb2] type 00 class 0x088000
[    1.357278] pci 0000:7f:10.3: [8086:0eb3] type 00 class 0x088000
[    1.357781] pci 0000:7f:10.4: [8086:0eb4] type 00 class 0x088000
[    1.358281] pci 0000:7f:10.5: [8086:0eb5] type 00 class 0x088000
[    1.358782] pci 0000:7f:10.6: [8086:0eb6] type 00 class 0x088000
[    1.359283] pci 0000:7f:10.7: [8086:0eb7] type 00 class 0x088000
[    1.359787] pci 0000:7f:13.0: [8086:0e1d] type 00 class 0x088000
[    1.360277] pci 0000:7f:13.1: [8086:0e34] type 00 class 0x110100
[    1.360767] pci 0000:7f:13.4: [8086:0e81] type 00 class 0x088000
[    1.361257] pci 0000:7f:13.5: [8086:0e36] type 00 class 0x110100
[    1.361748] pci 0000:7f:16.0: [8086:0ec8] type 00 class 0x088000
[    1.362236] pci 0000:7f:16.1: [8086:0ec9] type 00 class 0x088000
[    1.362725] pci 0000:7f:16.2: [8086:0eca] type 00 class 0x088000
[    1.363220] pci_bus 0000:7f: on NUMA node 0 (pxm 0)
[    1.363696]  pci0000:7f: Requesting ACPI _OSC control (0x1d)
[    1.364177]  pci0000:7f: ACPI _OSC control (0x1d) granted
[    1.365691] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    1.366554] PCI host bridge to bus 0000:80
[    1.367010] pci_bus 0000:80: root bus resource [bus 80-fe]
[    1.367474] pci_bus 0000:80: root bus resource [io  0xa000-0xffff]
[    1.367935] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xfbffffff]
[    1.368398] pci_bus 0000:80: root bus resource [mem 0x381000000000-0x381fffffffff]
[    1.369247] pci 0000:80:00.0: [8086:0e01] type 01 class 0x060400
[    1.369777] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    1.370268] pci 0000:80:01.0: [8086:0e02] type 01 class 0x060400
[    1.370797] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    1.371284] pci 0000:80:01.1: [8086:0e03] type 01 class 0x060400
[    1.371815] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
[    1.372310] pci 0000:80:02.0: [8086:0e04] type 01 class 0x060400
[    1.372839] pci 0000:80:02.0: PME# supported from D0 D3hot D3cold
[    1.373326] pci 0000:80:02.2: [8086:0e06] type 01 class 0x060400
[    1.373855] pci 0000:80:02.2: PME# supported from D0 D3hot D3cold
[    1.374345] pci 0000:80:03.0: [8086:0e08] type 01 class 0x060400
[    1.374874] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    1.375363] pci 0000:80:05.0: [8086:0e28] type 00 class 0x088000
[    1.375907] pci 0000:80:05.2: [8086:0e2a] type 00 class 0x088000
[    1.376449] pci 0000:80:05.4: [8086:0e2c] type 00 class 0x080020
[    1.376918] pci 0000:80:05.4: reg 10: [mem 0xfbf00000-0xfbf00fff]
[    1.377465] pci 0000:80:07.0: [8086:0e18] type 00 class 0x088000
[    1.378056] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.378563] pci 0000:80:01.0: PCI bridge to [bus 82]
[    1.379070] pci 0000:80:01.1: PCI bridge to [bus 83]
[    1.379581] pci 0000:80:02.0: PCI bridge to [bus 84]
[    1.380090] pci 0000:80:02.2: PCI bridge to [bus 85]
[    1.380604] pci 0000:86:00.0: [8086:2250] type 00 class 0x0b4000
[    1.381075] pci 0000:86:00.0: reg 10: [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.381925] pci 0000:86:00.0: reg 20: [mem 0xfbe00000-0xfbe1ffff 64bit]
[    1.382420] pci 0000:86:00.0: PME# supported from D0
[    1.382995] pci 0000:80:03.0: PCI bridge to [bus 86]
[    1.383459] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.383925] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.384785] pci_bus 0000:80: on NUMA node 1 (pxm 1)
[    1.385244] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    1.385942]  pci0000:80: Requesting ACPI _OSC control (0x1d)
[    1.386590]  pci0000:80: ACPI _OSC control (0x1d) granted
[    1.388811] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    1.389336] PCI host bridge to bus 0000:ff
[    1.389793] pci_bus 0000:ff: root bus resource [bus ff]
[    1.390259] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    1.390760] pci 0000:ff:08.3: [8086:0e83] type 00 class 0x088000
[    1.391268] pci 0000:ff:08.4: [8086:0e84] type 00 class 0x088000
[    1.391788] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    1.392289] pci 0000:ff:09.3: [8086:0e93] type 00 class 0x088000
[    1.392800] pci 0000:ff:09.4: [8086:0e94] type 00 class 0x088000
[    1.393315] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    1.393810] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    1.394304] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    1.394798] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    1.395294] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    1.395788] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    1.396282] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    1.396775] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    1.397268] pci 0000:ff:0c.2: [8086:0ee4] type 00 class 0x088000
[    1.397762] pci 0000:ff:0c.3: [8086:0ee6] type 00 class 0x088000
[    1.398255] pci 0000:ff:0c.4: [8086:0ee8] type 00 class 0x088000
[    1.398749] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    1.399242] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    1.399738] pci 0000:ff:0d.2: [8086:0ee5] type 00 class 0x088000
[    1.400233] pci 0000:ff:0d.3: [8086:0ee7] type 00 class 0x088000
[    1.400726] pci 0000:ff:0d.4: [8086:0ee9] type 00 class 0x088000
[    1.401222] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    1.401726] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    1.402235] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    1.402747] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    1.403259] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    1.403773] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    1.404284] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    1.404797] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    1.405308] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    1.405821] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    1.406332] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    1.406845] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    1.407356] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    1.407871] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    1.408381] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    1.408893] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    1.409403] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    1.409896] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    1.410392] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    1.410888] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    1.411388] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    1.411883] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    1.412376] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    1.412879] pci_bus 0000:ff: on NUMA node 1 (pxm 1)
[    1.413351]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    1.413830]  pci0000:ff: ACPI _OSC control (0x1d) granted
[    1.415086] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    1.416509] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    1.417922] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    1.419259] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    1.420601] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.422460] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.424324] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    1.426180] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    1.427654] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
[    1.428500] vgaarb: loaded
[    1.428952] vgaarb: bridge control possible 0000:0a:00.0
[    1.429535] PCI: Using ACPI for IRQ routing
[    1.434545] PCI: pci_cache_line_size set to 64 bytes
[    1.435243] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    1.435708] e820: reserve RAM buffer [mem 0x8df5e000-0x8fffffff]
[    1.436263] NetLabel: Initializing
[    1.436716] NetLabel:  domain hash size = 128
[    1.437172] NetLabel:  protocols = UNLABELED CIPSOv4
[    1.437640] NetLabel:  unlabeled traffic allowed by default
[    1.438112] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    1.439252] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    1.441737] Switching to clocksource hpet
[    1.444151] AppArmor: AppArmor Filesystem Enabled
[    1.444702] pnp: PnP ACPI init
[    1.445226] ACPI: bus type pnp registered
[    1.446072] pnp 00:00: [bus 00-7e]
[    1.446578] pnp 00:00: [io  0x0cf8-0x0cff]
[    1.447067] pnp 00:00: [io  0x0000-0x03af window]
[    1.447541] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    1.448014] pnp 00:00: [io  0x03b0-0x03df window]
[    1.448487] pnp 00:00: [io  0x0d00-0x9fff window]
[    1.448962] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    1.449435] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    1.449910] pnp 00:00: [mem 0x90000000-0xe7ffffff window]
[    1.450391] pnp 00:00: [mem 0x380000000000-0x380fffffffff window]
[    1.450946] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.451815] pnp 00:01: [mem 0xfc000000-0xfcffffff]
[    1.452287] pnp 00:01: [mem 0xfd000000-0xfdffffff]
[    1.452758] pnp 00:01: [mem 0xfe000000-0xfeafffff]
[    1.453230] pnp 00:01: [mem 0xfeb00000-0xfebfffff]
[    1.453705] pnp 00:01: [mem 0xfed00400-0xfed3ffff]
[    1.454178] pnp 00:01: [mem 0xfed45000-0xfedfffff]
[    1.454769] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    1.455245] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    1.455723] system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
[    1.456200] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    1.456679] system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    1.457158] system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
[    1.457637] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.458179] pnp 00:02: [mem 0xe7ffc000-0xe7ffdfff]
[    1.468977] system 00:02: [mem 0xe7ffc000-0xe7ffdfff] has been reserved
[    1.469464] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.470027] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    1.470511] pnp 00:03: [io  0x0a00-0x0a1f]
[    1.471045] system 00:03: [io  0x0a00-0x0a1f] has been reserved
[    1.471520] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.472212] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    1.472701] pnp 00:05: [dma 4]
[    1.473170] pnp 00:05: [io  0x0000-0x000f]
[    1.473643] pnp 00:05: [io  0x0081-0x0083]
[    1.474117] pnp 00:05: [io  0x0087]
[    1.474594] pnp 00:05: [io  0x0089-0x008b]
[    1.475083] pnp 00:05: [io  0x008f]
[    1.475554] pnp 00:05: [io  0x00c0-0x00df]
[    1.476043] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    1.476530] pnp 00:06: [io  0x0070-0x0071]
[    1.477016] pnp 00:06: [irq 8]
[    1.477506] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    1.477990] pnp 00:07: [io  0x0061]
[    1.478482] pnp 00:07: Plug and Play ACPI device, IDs PNP0800 (active)
[    1.479009] pnp 00:08: [io  0x0010-0x001f]
[    1.479480] pnp 00:08: [io  0x0022-0x003f]
[    1.479951] pnp 00:08: [io  0x0044-0x005f]
[    1.480424] pnp 00:08: [io  0x0062-0x0063]
[    1.480896] pnp 00:08: [io  0x0065-0x006f]
[    1.481366] pnp 00:08: [io  0x0072-0x007f]
[    1.481837] pnp 00:08: [io  0x0080]
[    1.482312] pnp 00:08: [io  0x0084-0x0086]
[    1.482799] pnp 00:08: [io  0x0088]
[    1.483269] pnp 00:08: [io  0x008c-0x008e]
[    1.483741] pnp 00:08: [io  0x0090-0x009f]
[    1.484212] pnp 00:08: [io  0x00a2-0x00bf]
[    1.484684] pnp 00:08: [io  0x00e0-0x00ef]
[    1.485155] pnp 00:08: [io  0x04d0-0x04d1]
[    1.485672] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    1.486147] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.486641] pnp 00:09: [io  0x00f0-0x00ff]
[    1.487135] pnp 00:09: [irq 13]
[    1.487620] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    1.488209] pnp 00:0a: [io  0x0ca2]
[    1.488678] pnp 00:0a: [io  0x0ca3]
[    1.489165] pnp 00:0a: Plug and Play ACPI device, IDs IPI0001 (active)
[    1.489857] pnp 00:0b: [io  0x0400-0x0453]
[    1.490335] pnp 00:0b: [io  0x0458-0x047f]
[    1.490823] pnp 00:0b: [io  0x1180-0x119f]
[    1.491293] pnp 00:0b: [io  0x0500-0x057f]
[    1.491765] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    1.492240] pnp 00:0b: [mem 0xfec00000-0xfecfffff]
[    1.492713] pnp 00:0b: [mem 0xfed08000-0xfed08fff]
[    1.493186] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    1.493709] system 00:0b: [io  0x0400-0x0453] has been reserved
[    1.494184] system 00:0b: [io  0x0458-0x047f] has been reserved
[    1.494666] system 00:0b: [io  0x1180-0x119f] has been reserved
[    1.495156] system 00:0b: [io  0x0500-0x057f] has been reserved
[    1.495631] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    1.496109] system 00:0b: [mem 0xfec00000-0xfecfffff] could not be reserved
[    1.496587] system 00:0b: [mem 0xfed08000-0xfed08fff] has been reserved
[    1.497063] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    1.497539] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.498070] pnp 00:0c: [io  0x0454-0x0457]
[    1.498600] system 00:0c: [io  0x0454-0x0457] has been reserved
[    1.499084] system 00:0c: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    1.500139] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    1.500640] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    1.501170] pnp 00:0e: [bus 7f]
[    1.501664] pnp 00:0e: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.502398] pnp 00:0f: [bus 80-fe]
[    1.502869] pnp 00:0f: [io  0x0000 window]
[    1.503340] pnp 00:0f: [io  0xa000-0xffff window]
[    1.503812] pnp 00:0f: [mem 0x00000000 window]
[    1.504285] pnp 00:0f: [mem 0xe8000000-0xfbffffff window]
[    1.504761] pnp 00:0f: [mem 0x381000000000-0x381fffffffff window]
[    1.505259] pnp 00:0f: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    1.506173] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (active)
[    1.506725] pnp 00:11: [mem 0xfbffe000-0xfbffffff]
[    1.507254] system 00:11: [mem 0xfbffe000-0xfbffffff] has been reserved
[    1.507731] system 00:11: Plug and Play ACPI device, IDs PNP0c02 (active)
[    1.508282] pnp 00:12: [bus ff]
[    1.508774] pnp 00:12: Plug and Play ACPI device, IDs PNP0a03 (active)
[    1.509787] pnp: PnP ACPI: found 19 devices
[    1.510265] ACPI: ACPI bus type pnp unregistered
[    1.517324] pci 0000:00:01.0: PCI bridge to [bus 01]
[    1.517807] pci 0000:00:01.1: PCI bridge to [bus 02]
[    1.518294] pci 0000:00:02.0: PCI bridge to [bus 03]
[    1.518787] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    1.519265] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.520131] pci 0000:00:02.2: PCI bridge to [bus 04]
[    1.520612] pci 0000:00:03.0: PCI bridge to [bus 05]
[    1.521086] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    1.521564] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.522434] pci 0000:00:11.0: PCI bridge to [bus 06]
[    1.522927] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    1.523406] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    1.523885] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.524753] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    1.525226] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    1.525705] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    1.526184] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.527056] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    1.527548] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    1.528027] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.528507] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.529374] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    1.529847] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    1.530331] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.530824] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.531688] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    1.532173] pci 0000:80:00.0: PCI bridge to [bus 81]
[    1.532653] pci 0000:80:01.0: PCI bridge to [bus 82]
[    1.533132] pci 0000:80:01.1: PCI bridge to [bus 83]
[    1.533612] pci 0000:80:02.0: PCI bridge to [bus 84]
[    1.534091] pci 0000:80:02.2: PCI bridge to [bus 85]
[    1.534576] pci 0000:80:03.0: PCI bridge to [bus 86]
[    1.535067] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    1.535545] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.536502] pci 0000:00:1e.0: setting latency timer to 64
[    1.537032] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    1.537506] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    1.537979] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    1.538459] pci_bus 0000:00: resource 7 [io  0x0d00-0x9fff]
[    1.538949] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    1.539424] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    1.539899] pci_bus 0000:00: resource 10 [mem 0x90000000-0xe7ffffff]
[    1.540375] pci_bus 0000:00: resource 11 [mem 0x380000000000-0x380fffffffff]
[    1.540853] pci_bus 0000:03: resource 1 [mem 0xe7e00000-0xe7efffff]
[    1.541327] pci_bus 0000:03: resource 2 [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.542187] pci_bus 0000:05: resource 1 [mem 0xe7d00000-0xe7dfffff]
[    1.542669] pci_bus 0000:05: resource 2 [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.543547] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
[    1.544020] pci_bus 0000:06: resource 1 [mem 0xe7c00000-0xe7cfffff]
[    1.544494] pci_bus 0000:06: resource 2 [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.545354] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    1.545827] pci_bus 0000:07: resource 1 [mem 0xe7b00000-0xe7bfffff]
[    1.546309] pci_bus 0000:07: resource 2 [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.547186] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    1.547660] pci_bus 0000:09: resource 1 [mem 0xe7a00000-0xe7afffff]
[    1.548136] pci_bus 0000:09: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.548995] pci_bus 0000:0a: resource 0 [io  0x6000-0x6fff]
[    1.549468] pci_bus 0000:0a: resource 1 [mem 0xe7a00000-0xe7afffff]
[    1.549943] pci_bus 0000:0a: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.550808] pci_bus 0000:0b: resource 4 [io  0x0000-0x03af]
[    1.551299] pci_bus 0000:0b: resource 5 [io  0x03e0-0x0cf7]
[    1.551772] pci_bus 0000:0b: resource 6 [io  0x03b0-0x03df]
[    1.552244] pci_bus 0000:0b: resource 7 [io  0x0d00-0x9fff]
[    1.552717] pci_bus 0000:0b: resource 8 [mem 0x000a0000-0x000bffff]
[    1.553192] pci_bus 0000:0b: resource 9 [mem 0x000c0000-0x000dffff]
[    1.553667] pci_bus 0000:0b: resource 10 [mem 0x90000000-0xe7ffffff]
[    1.554141] pci_bus 0000:0b: resource 11 [mem 0x380000000000-0x380fffffffff]
[    1.554626] pci_bus 0000:80: resource 4 [io  0xa000-0xffff]
[    1.555116] pci_bus 0000:80: resource 5 [mem 0xe8000000-0xfbffffff]
[    1.555591] pci_bus 0000:80: resource 6 [mem 0x381000000000-0x381fffffffff]
[    1.556067] pci_bus 0000:86: resource 1 [mem 0xfbe00000-0xfbefffff]
[    1.556542] pci_bus 0000:86: resource 2 [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    1.557711] NET: Registered protocol family 2
[    1.559284] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    1.561604] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    1.562277] TCP: Hash tables configured (established 524288 bind 65536)
[    1.562815] TCP: reno registered
[    1.563365] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.564083] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    1.565029] NET: Registered protocol family 1
[    1.606253] pci 0000:0a:00.0: Boot video device
[    1.606856] PCI: CLS 64 bytes, default 64
[    1.617638] Unpacking initramfs...
[    1.980793] Freeing initrd memory: 20776k freed
[    1.989413] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.989895] software IO TLB [mem 0x89f5c000-0x8df5bfff] (64MB) mapped at [ffff880089f5c000-ffff88008df5bfff]
[    1.993034] audit: initializing netlink socket (disabled)
[    1.993540] type=2000 audit(1476806261.740:1): initialized
[    2.016914] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.021268] VFS: Disk quotas dquot_6.5.2
[    2.021822] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.022521] msgmni has been set to 32768
[    2.023414] alg: No test for stdrng (krng)
[    2.023968] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.024920] io scheduler noop registered
[    2.025413] io scheduler deadline registered
[    2.026001] io scheduler cfq registered (default)
[    2.026960] pcieport 0000:00:01.0: irq 88 for MSI/MSI-X
[    2.027555] pcieport 0000:00:01.1: irq 89 for MSI/MSI-X
[    2.028138] pcieport 0000:00:02.0: irq 90 for MSI/MSI-X
[    2.028722] pcieport 0000:00:02.2: irq 91 for MSI/MSI-X
[    2.029303] pcieport 0000:00:03.0: irq 92 for MSI/MSI-X
[    2.029919] pcieport 0000:00:11.0: irq 93 for MSI/MSI-X
[    2.030540] pcieport 0000:00:1c.0: irq 94 for MSI/MSI-X
[    2.031124] pcieport 0000:00:1c.4: irq 95 for MSI/MSI-X
[    2.031876] pcieport 0000:80:00.0: irq 96 for MSI/MSI-X
[    2.032485] pcieport 0000:80:01.0: irq 97 for MSI/MSI-X
[    2.033069] pcieport 0000:80:01.1: irq 98 for MSI/MSI-X
[    2.033654] pcieport 0000:80:02.0: irq 99 for MSI/MSI-X
[    2.034264] pcieport 0000:80:02.2: irq 100 for MSI/MSI-X
[    2.034852] pcieport 0000:80:03.0: irq 101 for MSI/MSI-X
[    2.035441] aer 0000:00:01.0:pcie02: service driver aer loaded
[    2.035951] aer 0000:00:01.1:pcie02: service driver aer loaded
[    2.036458] aer 0000:00:02.0:pcie02: service driver aer loaded
[    2.036965] aer 0000:00:02.2:pcie02: service driver aer loaded
[    2.037472] aer 0000:00:03.0:pcie02: service driver aer loaded
[    2.037990] aer 0000:00:11.0:pcie02: service driver aer loaded
[    2.038494] aer 0000:80:00.0:pcie02: service driver aer loaded
[    2.038996] aer 0000:80:01.0:pcie02: service driver aer loaded
[    2.039501] aer 0000:80:01.1:pcie02: service driver aer loaded
[    2.040002] aer 0000:80:02.0:pcie02: service driver aer loaded
[    2.040502] aer 0000:80:02.2:pcie02: service driver aer loaded
[    2.041003] aer 0000:80:03.0:pcie02: service driver aer loaded
[    2.041494] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    2.041979] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    2.042484] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    2.042962] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    2.043447] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    2.043924] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    2.044402] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    2.044887] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    2.045366] pcie_pme 0000:00:02.2:pcie01: service driver pcie_pme loaded
[    2.045851] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    2.046334] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    2.046830] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    2.047316] pcieport 0000:00:11.0: Signaling PME through PCIe PME interrupt
[    2.047792] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    2.048270] pcie_pme 0000:00:11.0:pcie01: service driver pcie_pme loaded
[    2.048763] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    2.049240] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    2.049719] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    2.050222] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    2.050714] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    2.051193] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    2.051672] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    2.052159] pcieport 0000:80:00.0: Signaling PME through PCIe PME interrupt
[    2.052637] pcie_pme 0000:80:00.0:pcie01: service driver pcie_pme loaded
[    2.053123] pcieport 0000:80:01.0: Signaling PME through PCIe PME interrupt
[    2.053603] pcie_pme 0000:80:01.0:pcie01: service driver pcie_pme loaded
[    2.054092] pcieport 0000:80:01.1: Signaling PME through PCIe PME interrupt
[    2.054587] pcie_pme 0000:80:01.1:pcie01: service driver pcie_pme loaded
[    2.055074] pcieport 0000:80:02.0: Signaling PME through PCIe PME interrupt
[    2.055551] pcie_pme 0000:80:02.0:pcie01: service driver pcie_pme loaded
[    2.056037] pcieport 0000:80:02.2: Signaling PME through PCIe PME interrupt
[    2.056515] pcie_pme 0000:80:02.2:pcie01: service driver pcie_pme loaded
[    2.057000] pcieport 0000:80:03.0: Signaling PME through PCIe PME interrupt
[    2.057476] pci 0000:86:00.0: Signaling PME through PCIe PME interrupt
[    2.057958] pcie_pme 0000:80:03.0:pcie01: service driver pcie_pme loaded
[    2.058483] ioapic: probe of 0000:00:05.4 failed with error -22
[    2.058998] ioapic: probe of 0000:80:05.4 failed with error -22
[    2.059567] intel_idle: MWAIT substates: 0x1120
[    2.060039] intel_idle: v0.4 model 0x3E
[    2.060508] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.061117] ERST: Error Record Serialization Table (ERST) support is initialized.
[    2.062174] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    2.062700] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.063250] serial 00:04: [io  0x02f8-0x02ff]
[    2.063875] serial 00:04: [irq 12]
[    2.064345] serial 00:04: [dma 18446744073709551615 disabled]
[    2.065540] serial 00:04: activated
[    2.086442] 00:04: ttyS1 at I/O 0x2f8 (irq = 12) is a 16550A
[    2.087594] Non-volatile memory driver v1.3
[    2.088066] Linux agpgart interface v0.103
[    2.088705] libphy: Fixed MDIO Bus: probed
[    2.089230] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    2.090574] i8042: No controller found
[    2.091121] mousedev: PS/2 mouse device common for all mice
[    2.092152] cpuidle: using governor ladder
[    2.093236] cpuidle: using governor menu
[    2.093707] EFI Variables Facility v0.08 2004-May-17
[    2.094413] TCP: cubic registered
[    2.094909] Key type dns_resolver registered
[    2.096259] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
[    2.097128] PM: Hibernation image not present or could not be loaded.
[    2.097613] registered taskstats version 1
[    2.101976]   Magic number: 4:411:993
[    2.102473] machinecheck machinecheck6: hash matches
[    2.103133] memory memory36: hash matches
[    2.105795] Freeing unused kernel memory: 1372k freed
[    2.106863] Write protecting the kernel read-only data: 10240k
[    2.111652] Freeing unused kernel memory: 1636k freed
[    2.117685] Freeing unused kernel memory: 1940k freed
[    2.166442] SCSI subsystem initialized
[    2.169541] ACPI: bus type scsi registered
[    2.170111] libata version 3.00 loaded.
[    2.172273] ahci 0000:00:1f.2: version 3.0
[    2.172792] ahci 0000:00:1f.2: irq 102 for MSI/MSI-X
[    2.173266] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0x3f
[    2.173774] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.174651] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    2.175492] ahci 0000:00:1f.2: setting latency timer to 64
[    2.176496] scsi0 : ahci
[    2.177192] scsi1 : ahci
[    2.177745] scsi2 : ahci
[    2.178373] scsi3 : ahci
[    2.178943] scsi4 : ahci
[    2.179512] scsi5 : ahci
[    2.179991] ata1: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00100 irq 102
[    2.180824] ata2: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00180 irq 102
[    2.181659] ata3: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00200 irq 102
[    2.182527] ata4: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00280 irq 102
[    2.183363] ata5: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00300 irq 102
[    2.184197] ata6: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00380 irq 102
[    2.989566] tsc: Refined TSC clocksource calibration: 2299.999 MHz
[    2.990046] Switching to clocksource tsc
[    3.209433] ata1: failed to resume link (SControl 0)
[    3.209944] ata1: SATA link down (SStatus 0 SControl 0)
[    3.210427] ata5: failed to resume link (SControl 0)
[    3.210923] ata5: SATA link down (SStatus 0 SControl 0)
[    3.211405] ata2: failed to resume link (SControl 0)
[    3.211902] ata2: SATA link down (SStatus 0 SControl 0)
[    3.212383] ata4: failed to resume link (SControl 0)
[    3.212885] ata4: SATA link down (SStatus 0 SControl 0)
[    3.213365] ata3: failed to resume link (SControl 0)
[    3.213861] ata3: SATA link down (SStatus 0 SControl 0)
[    3.214384] ata6: failed to resume link (SControl 0)
[    3.214880] ata6: SATA link down (SStatus 0 SControl 0)
[    3.221572] emc: device handler registered
[    3.227093] alua: device handler registered
[    3.232490] hp_sw: device handler registered
[    3.237773] rdac: device handler registered
[    3.242152] udev: starting version 147
[    3.261798] ACPI: Requesting acpi_cpufreq
[    3.273961] ACPI: bus type usb registered
[    3.274473] usbcore: registered new interface driver usbfs
[    3.274961] usbcore: registered new interface driver hub
[    3.275493] usbcore: registered new device driver usb
[    3.277046] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    3.277609] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    3.278079] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    3.278548] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    3.279400] isci: Intel(R) C600 SAS Controller Driver - version 1.1.0
[    3.283311] ehci_hcd 0000:00:1a.0: debug port 2
[    3.283776] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    3.284259] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe7f02000
[    3.284790] isci 0000:06:00.0: driver configured for rev: 6 silicon
[    3.285255] isci 0000:06:00.0: OEM parameter table found in OROM
[    3.295733] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) loaded (platform)
[    3.297029] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    3.297524] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    3.297987] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.298822] usb usb1: Product: EHCI Host Controller
[    3.299279] usb usb1: Manufacturer: Linux 3.7.0 ehci_hcd
[    3.299737] usb usb1: SerialNumber: 0000:00:1a.0
[    3.300217] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    3.303517] scsi6 : isci
[    3.304179] hub 1-0:1.0: USB hub found
[    3.304637] hub 1-0:1.0: 2 ports detected
[    3.305383] isci 0000:06:00.0: irq 103 for MSI/MSI-X
[    3.305847] isci 0000:06:00.0: irq 104 for MSI/MSI-X
[    3.306708] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    3.307169] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    3.307631] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    3.312378] ehci_hcd 0000:00:1d.0: debug port 2
[    3.312840] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    3.313313] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xe7f01000
[    3.325367] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    3.325870] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    3.326333] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    3.327166] usb usb2: Product: EHCI Host Controller
[    3.327624] usb usb2: Manufacturer: Linux 3.7.0 ehci_hcd
[    3.328082] usb usb2: SerialNumber: 0000:00:1d.0
[    3.329773] hub 2-0:1.0: USB hub found
[    3.330233] hub 2-0:1.0: 2 ports detected
[    3.617301] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    3.753527] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    3.753991] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.754684] hub 1-1:1.0: USB hub found
[    3.755273] hub 1-1:1.0: 6 ports detected
[    3.865148] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    3.997408] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    3.997872] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    3.998563] hub 2-1:1.0: USB hub found
[    3.999154] hub 2-1:1.0: 8 ports detected
[    4.273026] usb 2-1.3: new high-speed USB device number 3 using ehci_hcd
[    4.312970] sas: phy-6:0 added to port-6:0, phy_mask:0x1 (ffffffffffffffff)
[    4.313463] sas: DOING DISCOVERY on port 0, pid:255
[    4.314048] sas: DONE DISCOVERY on port 0, pid:255, result:0
[    4.314568] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[    4.315130] sas: ata7: end_device-6:0: dev error handler
[    4.477339] ata7.00: ATA-8: WDC WD5000BHTZ-04JCPV1, 04.06A01, max UDMA/133
[    4.477805] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    4.478387] sas: sas_ata_task_done: SAS error 2
[    4.478846] ata7.00: failed to get Identify Device Data, Emask 0x1
[    4.479929] sas: sas_ata_task_done: SAS error 2
[    4.480393] ata7.00: failed to get Identify Device Data, Emask 0x1
[    4.480862] ata7.00: configured for UDMA/133
[    4.481385] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[    4.497096] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000BHTZ-0 04.0 PQ: 0 ANSI: 5
[    4.501403] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    4.502240] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    4.502881] sd 6:0:0:0: [sda] Write Protect is off
[    4.503339] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    4.503880] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    4.516616]  sda: sda1 sda2
[    4.517693] sd 6:0:0:0: [sda] Attached SCSI disk
[    4.578498] usb 2-1.3: New USB device found, idVendor=046b, idProduct=ff01
[    4.578962] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    4.579804] usb 2-1.3: Product: Virtual Hub
[    4.580266] usb 2-1.3: Manufacturer: American Megatrends Inc.
[    4.580754] usb 2-1.3: SerialNumber: serial
[    4.581762] hub 2-1.3:1.0: USB hub found
[    4.582374] hub 2-1.3:1.0: 5 ports detected
[    4.646847] [drm] Initialized drm 1.1.0 20060810
[    4.651557] [drm] AST 2300 detected
[    4.652036] [drm] dram 1632000000 1 32 04000000
[    4.652540] [TTM] Zone  kernel: Available graphics memory: 32972312 kiB
[    4.653006] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    4.653468] [TTM] Initializing pool allocator
[    4.653928] [TTM] Initializing DMA pool allocator
[    4.654396] mtrr: type mismatch for e7000000,800000 old: write-back new: write-combining
[   14.835695] [sched_delayed] sched: RT throttling activated
[   45.366533] fbcon: astdrmfb (fb0) is primary device
[   45.588475] Console: switching to colour frame buffer device 128x48
[   45.699490] fb0: astdrmfb frame buffer device
[   45.700310] drm: registered panic notifier
[   45.701089] [drm] Initialized ast 0.1.0 20120228 for 0000:0a:00.0 on minor 0
[   45.727603] PM: Marking nosave pages: [mem 0x0008f000-0x000fffff]
[   45.727607] PM: Marking nosave pages: [mem 0x8df5e000-0xffffffff]
[   45.728722] PM: Basic memory bitmaps created
[   45.961344] PM: Basic memory bitmaps freed
[   45.968866] PM: Starting manual resume from disk
[   45.968868] PM: Hibernation image partition 8:1 present
[   45.968869] PM: Looking for hibernation image.
[   45.969212] PM: Image not found (code -22)
[   45.969212] PM: Hibernation image not present or could not be loaded.
[   46.084664] usb 2-1.3.1: new low-speed USB device number 4 using ehci_hcd
[   46.184381] kjournald starting.  Commit interval 5 seconds
[   46.184882] EXT3-fs (sda2): using internal journal
[   46.184883] EXT3-fs (sda2): mounted filesystem with ordered data mode
[   46.252731] usb 2-1.3.1: New USB device found, idVendor=046b, idProduct=ff10
[   46.252733] usb 2-1.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   46.252734] usb 2-1.3.1: Product: Virtual Keyboard and Mouse
[   46.252735] usb 2-1.3.1: Manufacturer: American Megatrends Inc.
[   46.384822] usb 2-1.3.2: new high-speed USB device number 5 using ehci_hcd
[   46.524283] usbcore: registered new interface driver usbhid
[   46.572831] usbhid: USB HID core driver
[   46.622208] usb 2-1.3.2: New USB device found, idVendor=046b, idProduct=ff20
[   46.672072] usb 2-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   46.722035] usb 2-1.3.2: Product: Virtual Cdrom Device
[   46.771641] usb 2-1.3.2: Manufacturer: American Megatrends Inc.
[   46.771643] usb 2-1.3.2: SerialNumber: AAAABBBBCCCC1
[   46.896202] usb 2-1.3.3: new high-speed USB device number 6 using ehci_hcd
[   47.103885] usb 2-1.3.3: New USB device found, idVendor=046b, idProduct=ff40
[   47.103886] usb 2-1.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   47.103887] usb 2-1.3.3: Product: Virtual Floppy Device
[   47.103889] usb 2-1.3.3: Manufacturer: American Megatrends Inc.
[   47.103890] usb 2-1.3.3: SerialNumber: AAAABBBBCCCC2
[   47.232435] usb 2-1.3.4: new high-speed USB device number 7 using ehci_hcd
[   47.399725] usb 2-1.3.4: New USB device found, idVendor=046b, idProduct=ff31
[   47.399726] usb 2-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   47.399727] usb 2-1.3.4: Product: Virtual HardDisk Device
[   47.399728] usb 2-1.3.4: Manufacturer: American Megatrends Inc.
[   47.399730] usb 2-1.3.4: SerialNumber: AAAABBBBCCCC3
[   48.363442] udev: starting version 147
[   48.460468] wmi: Mapper loaded
[   48.518337] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   48.599341] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[   48.646690] ACPI: Power Button [PWRB]
[   48.693023] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   48.740362] rtc_cmos 00:06: RTC can wake from S4
[   48.740438] ACPI: Power Button [PWRF]
[   48.833389] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   48.879778] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   48.926228] mei 0000:00:16.0: Device doesn't have valid ME Interface
[   48.926267] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   49.016681] mei 0000:00:16.0: initialization failed.
[   49.138265] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120913/utaddress-251)
[   49.231454] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   49.280155] ACPI Warning: 0x0000000000000500-0x000000000000052f SystemIO conflicts with Region \GINV 1 (20120913/utaddress-251)
[   49.378885] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   49.430398] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   49.509859] iTCO_vendor_support: vendor-support=0
[   49.563481] microcode: CPU0 sig=0x306e2, pf=0x1, revision=0x20d
[   49.687388] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   49.724531] microcode: CPU1 sig=0x306e2, pf=0x1, revision=0x20d
[   49.728870] microcode: CPU2 sig=0x306e2, pf=0x1, revision=0x20d
[   49.732847] microcode: CPU3 sig=0x306e2, pf=0x1, revision=0x20d
[   49.737031] microcode: CPU4 sig=0x306e2, pf=0x1, revision=0x20d
[   49.741044] microcode: CPU5 sig=0x306e2, pf=0x1, revision=0x20d
[   49.745210] microcode: CPU6 sig=0x306e2, pf=0x1, revision=0x20d
[   49.749114] microcode: CPU7 sig=0x306e2, pf=0x1, revision=0x20d
[   49.753091] microcode: CPU8 sig=0x306e2, pf=0x1, revision=0x20d
[   49.756934] microcode: CPU9 sig=0x306e2, pf=0x1, revision=0x20d
[   49.761040] microcode: CPU10 sig=0x306e2, pf=0x1, revision=0x20d
[   49.765080] microcode: CPU11 sig=0x306e2, pf=0x1, revision=0x20d
[   49.769039] microcode: CPU12 sig=0x306e2, pf=0x1, revision=0x20d
[   49.772948] microcode: CPU13 sig=0x306e2, pf=0x1, revision=0x20d
[   50.358119] microcode: CPU14 sig=0x306e2, pf=0x1, revision=0x20d
[   50.401634] Initializing USB Mass Storage driver...
[   50.401641] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   50.401759] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   50.401947] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.0/input/input3
[   50.402602] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input0
[   50.402748] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.1/input/input4
[   50.402913] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input1
[   50.407472] microcode: CPU15 sig=0x306e2, pf=0x1, revision=0x20d
[   50.411671] microcode: CPU16 sig=0x306e2, pf=0x1, revision=0x20d
[   50.415608] microcode: CPU17 sig=0x306e2, pf=0x1, revision=0x20d
[   50.419572] microcode: CPU18 sig=0x306e2, pf=0x1, revision=0x20d
[   50.423552] microcode: CPU19 sig=0x306e2, pf=0x1, revision=0x20d
[   50.427536] microcode: CPU20 sig=0x306e2, pf=0x1, revision=0x20d
[   50.431485] microcode: CPU21 sig=0x306e2, pf=0x1, revision=0x20d
[   50.435528] microcode: CPU22 sig=0x306e2, pf=0x1, revision=0x20d
[   50.439572] microcode: CPU23 sig=0x306e2, pf=0x1, revision=0x20d
[   50.443541] microcode: CPU24 sig=0x306e2, pf=0x1, revision=0x20d
[   50.447543] microcode: CPU25 sig=0x306e2, pf=0x1, revision=0x20d
[   50.451565] microcode: CPU26 sig=0x306e2, pf=0x1, revision=0x20d
[   50.455556] microcode: CPU27 sig=0x306e2, pf=0x1, revision=0x20d
[   50.459541] microcode: CPU28 sig=0x306e2, pf=0x1, revision=0x20d
[   50.463549] microcode: CPU29 sig=0x306e2, pf=0x1, revision=0x20d
[   50.467542] microcode: CPU30 sig=0x306e2, pf=0x1, revision=0x20d
[   50.471546] microcode: CPU31 sig=0x306e2, pf=0x1, revision=0x20d
[   50.475619] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   51.687267] scsi7 : usb-storage 2-1.3.2:1.0
[   51.718815] usb-storage 2-1.3.3:1.0: Quirks match for vid 046b pid ff40: 200
[   51.750952] scsi8 : usb-storage 2-1.3.3:1.0
[   51.782694] scsi9 : usb-storage 2-1.3.4:1.0
[   51.813459] usbcore: registered new interface driver usb-storage
[   51.844356] USB Mass Storage support registered.
[   51.875962] NET: Registered protocol family 10
[   51.907999] dca service started, version 1.12.1
[   52.029267] igb: Intel(R) Gigabit Ethernet Network Driver - version 4.0.1-k
[   52.063144] igb: Copyright (c) 2007-2012 Intel Corporation.
[   52.097938] igb 0000:07:00.0: irq 105 for MSI/MSI-X
[   52.133122] igb 0000:07:00.0: irq 106 for MSI/MSI-X
[   52.168241] igb 0000:07:00.0: irq 107 for MSI/MSI-X
[   52.203380] igb 0000:07:00.0: irq 108 for MSI/MSI-X
[   52.237939] igb 0000:07:00.0: irq 109 for MSI/MSI-X
[   52.272536] igb 0000:07:00.0: irq 110 for MSI/MSI-X
[   52.307187] igb 0000:07:00.0: irq 111 for MSI/MSI-X
[   52.341837] igb 0000:07:00.0: irq 112 for MSI/MSI-X
[   52.376439] igb 0000:07:00.0: irq 113 for MSI/MSI-X
[   52.452965] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[   52.487219] mlx4_core: Initializing 0000:03:00.0
[   52.530281] igb 0000:07:00.0: Intel(R) Gigabit Ethernet Network Connection
[   52.563659] igb 0000:07:00.0: eth0: (PCIe:5.0Gb/s:Width x4) d4:3d:7e:72:26:b5
[   52.596025] igb 0000:07:00.0: eth0: PBA No: 106100-000
[   52.626723] igb 0000:07:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   52.658613] sd 6:0:0:0: Attached scsi generic sg0 type 0
[   52.717947] scsi 7:0:0:0: CD-ROM            AMI      Virtual CDROM0   1.00 PQ: 0 ANSI: 0 CCS
[   52.746574] scsi 7:0:0:0: Attached scsi generic sg1 type 5
[   52.781796] scsi 8:0:0:0: Direct-Access     AMI      Virtual Floppy0  1.00 PQ: 0 ANSI: 0 CCS
[   52.808583] sd 8:0:0:0: Attached scsi generic sg2 type 0
[   52.811690] sd 8:0:0:0: [sdb] Attached SCSI removable disk
[   52.862052] scsi 9:0:0:0: Direct-Access     AMI      Virtual HDISK0   1.00 PQ: 0 ANSI: 0 CCS
[   52.890496] sd 9:0:0:0: Attached scsi generic sg3 type 0
[   52.894162] sd 9:0:0:0: [sdc] Attached SCSI removable disk
[   53.043122] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[   53.060182] sr0: scsi-1 drive
[   53.060184] cdrom: Uniform CD-ROM driver Revision: 3.20
[   53.060675] sr 7:0:0:0: Attached scsi CD-ROM sr0
[   53.286339] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286343] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286348] Pid: 1082, comm: modprobe Not tainted 3.7.0 #4
[   53.286349] Call Trace:
[   53.286362]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.286365] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286367] Pid: 1085, comm: modprobe Not tainted 3.7.0 #4
[   53.286374]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.286374] Call Trace:
[   53.286378]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.286382]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.286386]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.286389]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.286393] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286395]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.286397] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286399] Pid: 1099, comm: modprobe Not tainted 3.7.0 #4
[   53.286402]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.286404] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.286406] Pid: 1084, comm: modprobe Not tainted 3.7.0 #4
[   53.286407] Call Trace:
[   53.286408] Pid: 1078, comm: modprobe Not tainted 3.7.0 #4
[   53.286413]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.286414] Call Trace:
[   53.286417]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.286418] Call Trace:
[   53.286423]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.286425]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.286428]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.286431]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.286435]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.286438]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.286443]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.286445]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.286449]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.286452]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.286455]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.286459]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.286462]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.286465]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.286468]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.286471]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.286473]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.286476]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.286480]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.286483]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.286485]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.286489]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.286492]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.286495]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.286496] kvm: Could not allocate 304 bytes percpu data
[   53.286499]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.286502]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.286504]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.286507]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.286509]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.286512]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.286514]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.286518]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.286520]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.286523]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.286524] kvm: Could not allocate 304 bytes percpu data
[   53.286526]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.286529]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.286531]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.286533]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.286536]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.286539]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.286541]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.286545]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.286548]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.286550]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.286552] kvm: Could not allocate 304 bytes percpu data
[   53.286555]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.286556] kvm: Could not allocate 304 bytes percpu data
[   53.286557] kvm: Could not allocate 304 bytes percpu data
[   53.288069] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   53.288071] Pid: 1104, comm: modprobe Not tainted 3.7.0 #4
[   53.288071] Call Trace:
[   53.288076]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   53.288079]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   53.288082]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   53.288084]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   53.288087]  [<ffffffff810a5751>] load_module+0x111/0x860
[   53.288089]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   53.288091]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   53.288094]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   53.288096]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   53.288098]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   53.288101]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   53.288102] kvm: Could not allocate 304 bytes percpu data
[   56.504278] Pid: 1110, comm: modprobe Not tainted 3.7.0 #4
[   56.532229] Call Trace:
[   56.559780]  [<ffffffff8111d92d>] pcpu_alloc+0x3fd/0x460
[   56.588111]  [<ffffffff810a28f5>] ? get_modinfo+0x45/0xc0
[   56.616437]  [<ffffffff8111d99e>] __alloc_reserved_percpu+0xe/0x10
[   56.645052]  [<ffffffff810a4a54>] layout_and_allocate+0xb4/0x170
[   56.673741]  [<ffffffff810a5751>] load_module+0x111/0x860
[   56.702116]  [<ffffffff8145c464>] ? __do_page_fault+0x2e4/0x4c0
[   56.730463]  [<ffffffff81118195>] ? vm_mmap_pgoff+0x85/0xa0
[   56.758778]  [<ffffffff8120dd4b>] ? apparmor_capable+0x1b/0x80
[   56.787718]  [<ffffffff811e7c33>] ? security_capable+0x13/0x20
[   56.816375]  [<ffffffff810a5ef8>] sys_init_module+0x58/0x220
[   56.845066]  [<ffffffff814609a9>] system_call_fastpath+0x16/0x1b
[   56.873855] kvm: Could not allocate 304 bytes percpu data
[   61.721474] mlx4_core 0000:03:00.0: irq 114 for MSI/MSI-X
[   61.751295] mlx4_core 0000:03:00.0: irq 115 for MSI/MSI-X
[   61.780640] mlx4_core 0000:03:00.0: irq 116 for MSI/MSI-X
[   61.809560] mlx4_core 0000:03:00.0: irq 117 for MSI/MSI-X
[   61.837761] mlx4_core 0000:03:00.0: irq 118 for MSI/MSI-X
[   61.865224] mlx4_core 0000:03:00.0: irq 119 for MSI/MSI-X
[   61.892765] mlx4_core 0000:03:00.0: irq 120 for MSI/MSI-X
[   61.920148] mlx4_core 0000:03:00.0: irq 121 for MSI/MSI-X
[   61.947628] mlx4_core 0000:03:00.0: irq 122 for MSI/MSI-X
[   61.975177] mlx4_core 0000:03:00.0: irq 123 for MSI/MSI-X
[   62.002263] mlx4_core 0000:03:00.0: irq 124 for MSI/MSI-X
[   62.029442] mlx4_core 0000:03:00.0: irq 125 for MSI/MSI-X
[   62.056710] mlx4_core 0000:03:00.0: irq 126 for MSI/MSI-X
[   62.083557] mlx4_core 0000:03:00.0: irq 127 for MSI/MSI-X
[   62.110460] mlx4_core 0000:03:00.0: irq 128 for MSI/MSI-X
[   62.136642] mlx4_core 0000:03:00.0: irq 129 for MSI/MSI-X
[   62.162044] mlx4_core 0000:03:00.0: irq 130 for MSI/MSI-X
[   62.186715] mlx4_core 0000:03:00.0: irq 131 for MSI/MSI-X
[   62.211449] mlx4_core 0000:03:00.0: irq 132 for MSI/MSI-X
[   62.235068] mlx4_core 0000:03:00.0: irq 133 for MSI/MSI-X
[   62.257547] mlx4_core 0000:03:00.0: irq 134 for MSI/MSI-X
[   62.279478] mlx4_core 0000:03:00.0: irq 135 for MSI/MSI-X
[   62.484922] Adding 2103292k swap on /dev/sda1.  Priority:-1 extents:1 across:2103292k 
[   62.885518] device-mapper: uevent: version 1.0.3
[   62.909224] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   63.210915] loop: module loaded
[   64.159166] fuse init (API version 7.20)
[   65.403966] netlink: 20 bytes leftover after parsing attributes.
[   65.403968] netlink: 20 bytes leftover after parsing attributes.
[   65.404017] netlink: 20 bytes leftover after parsing attributes.
[   65.410889] netlink: 20 bytes leftover after parsing attributes.
[   65.410890] netlink: 20 bytes leftover after parsing attributes.
[   65.410924] netlink: 20 bytes leftover after parsing attributes.
[   65.412130] netlink: 20 bytes leftover after parsing attributes.
[   65.412131] netlink: 20 bytes leftover after parsing attributes.
[   65.412163] netlink: 20 bytes leftover after parsing attributes.
[   65.418659] netlink: 20 bytes leftover after parsing attributes.
[   65.418661] netlink: 20 bytes leftover after parsing attributes.
[   65.418709] netlink: 20 bytes leftover after parsing attributes.
[   65.419950] netlink: 20 bytes leftover after parsing attributes.
[   65.419952] netlink: 20 bytes leftover after parsing attributes.
[   65.419985] netlink: 20 bytes leftover after parsing attributes.
[   65.432479] netlink: 20 bytes leftover after parsing attributes.
[   65.432481] netlink: 20 bytes leftover after parsing attributes.
[   65.432512] netlink: 20 bytes leftover after parsing attributes.
[   65.435196] netlink: 20 bytes leftover after parsing attributes.
[   65.435198] netlink: 20 bytes leftover after parsing attributes.
[   65.435230] netlink: 20 bytes leftover after parsing attributes.
[   65.448152] netlink: 20 bytes leftover after parsing attributes.
[   65.448153] netlink: 20 bytes leftover after parsing attributes.
[   65.448188] netlink: 20 bytes leftover after parsing attributes.
[   65.450484] netlink: 20 bytes leftover after parsing attributes.
[   69.236978] netlink: 20 bytes leftover after parsing attributes.
[   69.236990] netlink: 20 bytes leftover after parsing attributes.
[   69.237076] netlink: 20 bytes leftover after parsing attributes.
[   69.239369] netlink: 20 bytes leftover after parsing attributes.
[   69.239381] netlink: 20 bytes leftover after parsing attributes.
[   69.239469] netlink: 20 bytes leftover after parsing attributes.
[   69.268274] netlink: 20 bytes leftover after parsing attributes.
[   69.268280] netlink: 20 bytes leftover after parsing attributes.
[   69.268313] netlink: 20 bytes leftover after parsing attributes.
[   69.276230] netlink: 20 bytes leftover after parsing attributes.
[   69.276239] netlink: 20 bytes leftover after parsing attributes.
[   69.276305] netlink: 20 bytes leftover after parsing attributes.
[   69.280934] netlink: 20 bytes leftover after parsing attributes.
[   69.280944] netlink: 20 bytes leftover after parsing attributes.
[   69.281011] netlink: 20 bytes leftover after parsing attributes.
[   69.292503] netlink: 20 bytes leftover after parsing attributes.
[   69.292513] netlink: 20 bytes leftover after parsing attributes.
[   69.292578] netlink: 20 bytes leftover after parsing attributes.
[   69.296892] netlink: 20 bytes leftover after parsing attributes.
[   69.296902] netlink: 20 bytes leftover after parsing attributes.
[   69.296968] netlink: 20 bytes leftover after parsing attributes.
[   69.301130] netlink: 20 bytes leftover after parsing attributes.
[   69.335476] netlink: 20 bytes leftover after parsing attributes.
[   69.335483] netlink: 20 bytes leftover after parsing attributes.
[   69.335516] netlink: 20 bytes leftover after parsing attributes.
[   69.495016] netlink: 20 bytes leftover after parsing attributes.
[   69.495027] netlink: 20 bytes leftover after parsing attributes.
[   69.495088] netlink: 20 bytes leftover after parsing attributes.
[   69.506876] netlink: 20 bytes leftover after parsing attributes.
[   69.506879] netlink: 20 bytes leftover after parsing attributes.
[   69.506944] netlink: 20 bytes leftover after parsing attributes.
[   69.509139] netlink: 20 bytes leftover after parsing attributes.
[   69.509140] netlink: 20 bytes leftover after parsing attributes.
[   69.509174] netlink: 20 bytes leftover after parsing attributes.
[   69.518774] netlink: 20 bytes leftover after parsing attributes.
[   69.518777] netlink: 20 bytes leftover after parsing attributes.
[   69.518844] netlink: 20 bytes leftover after parsing attributes.
[   69.520862] netlink: 20 bytes leftover after parsing attributes.
[   69.520865] netlink: 20 bytes leftover after parsing attributes.
[   69.520925] netlink: 20 bytes leftover after parsing attributes.
[   69.551713] netlink: 20 bytes leftover after parsing attributes.
[   69.551716] netlink: 20 bytes leftover after parsing attributes.
[   69.551772] netlink: 20 bytes leftover after parsing attributes.
[   69.556125] netlink: 20 bytes leftover after parsing attributes.
[   69.556130] netlink: 20 bytes leftover after parsing attributes.
[   69.556192] netlink: 20 bytes leftover after parsing attributes.
[   69.566510] netlink: 20 bytes leftover after parsing attributes.
[   69.566523] netlink: 20 bytes leftover after parsing attributes.
[   69.566591] netlink: 20 bytes leftover after parsing attributes.
[   69.570561] netlink: 20 bytes leftover after parsing attributes.
[   70.328536] NET: Registered protocol family 17
[   70.330678] netlink: 20 bytes leftover after parsing attributes.
[   70.330688] netlink: 20 bytes leftover after parsing attributes.
[   70.330760] netlink: 20 bytes leftover after parsing attributes.
[   70.332320] netlink: 20 bytes leftover after parsing attributes.
[   70.332327] netlink: 20 bytes leftover after parsing attributes.
[   70.332364] netlink: 20 bytes leftover after parsing attributes.
[   70.418271] IPv6: ADDRCONF(NETDEV_UP): eth0: link is not ready
[   70.418312] igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   70.418460] IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   72.097551] netlink: 20 bytes leftover after parsing attributes.
[   72.097564] netlink: 20 bytes leftover after parsing attributes.
[   72.097760] netlink: 20 bytes leftover after parsing attributes.
[   72.102007] netlink: 20 bytes leftover after parsing attributes.
[   72.102018] netlink: 20 bytes leftover after parsing attributes.
[   72.102202] netlink: 20 bytes leftover after parsing attributes.
[   72.104688] netlink: 20 bytes leftover after parsing attributes.
[   72.104699] netlink: 20 bytes leftover after parsing attributes.
[   72.104882] netlink: 20 bytes leftover after parsing attributes.
[   72.115179] netlink: 20 bytes leftover after parsing attributes.
[   72.115190] netlink: 20 bytes leftover after parsing attributes.
[   72.115372] netlink: 20 bytes leftover after parsing attributes.
[   72.519131] netlink: 20 bytes leftover after parsing attributes.
[   72.519137] netlink: 20 bytes leftover after parsing attributes.
[   72.519317] netlink: 20 bytes leftover after parsing attributes.
[   72.523222] netlink: 20 bytes leftover after parsing attributes.
[   72.523225] netlink: 20 bytes leftover after parsing attributes.
[   72.523382] netlink: 20 bytes leftover after parsing attributes.
[   72.525425] netlink: 20 bytes leftover after parsing attributes.
[   72.525428] netlink: 20 bytes leftover after parsing attributes.
[   72.525570] netlink: 20 bytes leftover after parsing attributes.
[   72.534403] netlink: 20 bytes leftover after parsing attributes.
[   72.534409] netlink: 20 bytes leftover after parsing attributes.
[   72.534590] netlink: 20 bytes leftover after parsing attributes.
[   73.667040] netlink: 20 bytes leftover after parsing attributes.
[   73.667046] netlink: 20 bytes leftover after parsing attributes.
[   73.667235] netlink: 20 bytes leftover after parsing attributes.
[   73.684971] netlink: 20 bytes leftover after parsing attributes.
[   73.684974] netlink: 20 bytes leftover after parsing attributes.
[   73.685122] netlink: 20 bytes leftover after parsing attributes.
[   73.689745] netlink: 20 bytes leftover after parsing attributes.
[   73.689751] netlink: 20 bytes leftover after parsing attributes.
[   73.689932] netlink: 20 bytes leftover after parsing attributes.
[   73.692581] netlink: 20 bytes leftover after parsing attributes.
[   73.692587] netlink: 20 bytes leftover after parsing attributes.
[   73.692769] netlink: 20 bytes leftover after parsing attributes.
[   73.702680] netlink: 20 bytes leftover after parsing attributes.
[   73.702686] netlink: 20 bytes leftover after parsing attributes.
[   73.702868] netlink: 20 bytes leftover after parsing attributes.
[   73.706785] netlink: 20 bytes leftover after parsing attributes.
[   76.213113] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   77.168754] netlink: 20 bytes leftover after parsing attributes.
[   77.168761] netlink: 20 bytes leftover after parsing attributes.
[   77.168958] netlink: 20 bytes leftover after parsing attributes.
[   77.171147] netlink: 20 bytes leftover after parsing attributes.
[   77.171153] netlink: 20 bytes leftover after parsing attributes.
[   77.171331] netlink: 20 bytes leftover after parsing attributes.
[   77.193715] netlink: 20 bytes leftover after parsing attributes.
[   77.193721] netlink: 20 bytes leftover after parsing attributes.
[   77.193911] netlink: 20 bytes leftover after parsing attributes.
[   77.201951] netlink: 20 bytes leftover after parsing attributes.
[   77.201958] netlink: 20 bytes leftover after parsing attributes.
[   77.202136] netlink: 20 bytes leftover after parsing attributes.
[   77.206726] netlink: 20 bytes leftover after parsing attributes.
[   77.206732] netlink: 20 bytes leftover after parsing attributes.
[   77.206908] netlink: 20 bytes leftover after parsing attributes.
[   77.217619] netlink: 20 bytes leftover after parsing attributes.
[   77.217622] netlink: 20 bytes leftover after parsing attributes.
[   77.217769] netlink: 20 bytes leftover after parsing attributes.
[   77.222245] netlink: 20 bytes leftover after parsing attributes.
[   77.222250] netlink: 20 bytes leftover after parsing attributes.
[   77.222427] netlink: 20 bytes leftover after parsing attributes.
[   77.226529] netlink: 20 bytes leftover after parsing attributes.
[   77.265797] netlink: 20 bytes leftover after parsing attributes.
[   77.265800] netlink: 20 bytes leftover after parsing attributes.
[   77.265943] netlink: 20 bytes leftover after parsing attributes.

--4Ckj6UjgE2iN1+kY--
