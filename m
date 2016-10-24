From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Mon, 24 Oct 2016 16:49:25 -0500
Message-ID: <20161024214925.GA143272@stormcage.americas.sgi.com>
References: <20161017151906.GA19082@gofer.mess.org>
 <20161017164140.GA35950@stormcage.americas.sgi.com>
 <20161018164004.GA159046@stormcage.americas.sgi.com>
 <20161018180518.GA28700@gofer.mess.org>
 <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="bg08WKrSYDhXBjb5"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161024135235.GA29984@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com
List-Id: linux-serial@vger.kernel.org


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 24, 2016 at 02:52:35PM +0100, Sean Young wrote:
> On Fri, Oct 21, 2016 at 10:55:40AM -0500, Nathan Zimmer wrote:
> > It didn't seem to make a difference as far as output.
> > Did I miss a config option? or something else?
> > 
> > [    0.000000] Linux version 3.6.0 (root@r1i2n0) (gcc version 4.3.4
> > [gcc-4_3-branch revision 152973] (SUSE Linux) ) #3 SMP Mon Oct 17 20:43:34
> > EDT 2016
> > [    0.000000] Command line:
> > root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2
> > resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
> > crashkernel=256M-:128M loglevel=8 pnp.debug=1
> > ...
> > [    2.076084] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
> > [    2.097001] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > [    2.097844] serial 00:04: unable to assign resources
> > [    2.098303] serial: probe of 00:04 failed with error -16
> 
> Ehm is this kernel compiled with CONFIG_PNP_DEBUG_MESSAGES? Are you 
> getting any debug messages? You could try ignore_loglevel. 
> 
> 
> Sean

In going back and forth for builds I had become confused about the status of
CONFIG_PNP_DEBUG_MESSAGES.

Here is a better dmesg.

Nate


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="dmegs_pnp_3.6.0"

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.6.0-ntz (root@r1i2n0) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #23 SMP Mon Oct 24 15:53:30 EDT 2016
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8 vga=0x314 pnp.debug=1
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
[    0.000000] RAMDISK: [mem 0x36bb4000-0x37feffff]
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
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M loglevel=8 vga=0x314 pnp.debug=1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] __ex_table already sorted, skipping sort
[    0.000000] xsave: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Memory: 65918988k/68943872k available (4439k kernel code, 1868940k absent, 1155944k reserved, 6575k data, 1344k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] 	RCU restricting CPUs from NR_CPUS=4096 to nr_cpu_ids=32.
[    0.000000] NR_IRQS:262400 nr_irqs:1752 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [tty0] enabled
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.004000] tsc: Detected 2300.189 MHz processor
[    0.000013] Calibrating delay loop (skipped), value calculated using timer frequency.. 4600.37 BogoMIPS (lpj=9200756)
[    0.000018] pid_max: default: 32768 minimum: 301
[    0.000069] Security Framework initialized
[    0.000086] AppArmor: AppArmor initialized
[    0.004266] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.018341] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.024241] Mount-cache hash table entries: 256
[    0.024510] Initializing cgroup subsys cpuacct
[    0.024514] Initializing cgroup subsys devices
[    0.024516] Initializing cgroup subsys freezer
[    0.024519] Initializing cgroup subsys net_cls
[    0.024521] Initializing cgroup subsys blkio
[    0.024524] Initializing cgroup subsys perf_event
[    0.024576] CPU: Physical Processor ID: 0
[    0.024579] CPU: Processor Core ID: 1
[    0.025459] mce: CPU supports 27 MCE banks
[    0.025501] CPU0: Thermal monitoring enabled (TM1)
[    0.025535] process: using mwait in idle threads
[    0.025540] Last level iTLB entries: 4KB 512, 2MB 0, 4MB 0
[    0.025540] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32
[    0.025540] tlb_flushall_shift is 0x6
[    0.026584] ACPI: Core revision 20120711
[    0.066448] Switched APIC routing to physical flat.
[    0.067070] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.106739] smpboot: CPU0: Genuine Intel(R) CPU  @ 2.80GHz stepping 02
[    0.212471] Performance Events: PEBS fmt1+, generic architected perfmon, Intel PMU driver.
[    0.212478] ... version:                3
[    0.212480] ... bit width:              48
[    0.212481] ... generic registers:      4
[    0.212483] ... value mask:             0000ffffffffffff
[    0.212485] ... max period:             000000007fffffff
[    0.212487] ... fixed-purpose events:   3
[    0.212489] ... event mask:             000000070000000f
[    0.213483] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.213905] smpboot: Booting Node   0, Processors  #1 #2 #3 #4 #5 #6 #7 OK
[    0.316609] smpboot: Booting Node   1, Processors  #8
[    0.428405] TSC synchronization [CPU#0 -> CPU#8]:
[    0.428408] Measured 912261 cycles TSC warp between CPUs, turning off TSC clock.
[    0.008000] tsc: Marking TSC unstable due to check_tsc_sync_source failed
[    0.312245]  #9 #10 #11 #12 #13 #14 #15 OK
[    0.403267] smpboot: Booting Node   0, Processors  #16 #17 #18 #19 #20 #21 #22 #23 OK
[    0.501392] smpboot: Booting Node   1, Processors  #24 #25 #26 #27 #28 #29 #30 #31 OK
[    0.605442] Brought up 32 CPUs
[    0.605442] smpboot: Total of 32 processors activated (147204.84 BogoMIPS)
[    0.612173] devtmpfs: initialized
[    0.620360] PM: Registering ACPI NVS region [mem 0x8e0a4000-0x8e2c9fff] (2252800 bytes)
[    0.620360] PM: Registering ACPI NVS region [mem 0x8f337000-0x8f7fffff] (5017600 bytes)
[    0.620441] dummy: 
[    0.620481] RTC time: 20:07:00, date: 10/24/16
[    0.620645] NET: Registered protocol family 16
[    0.620885] ACPI: bus type pci registered
[    0.620972] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x90000000-0x9fffffff] (base 0x90000000)
[    0.620977] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved in E820
[    0.642409] PCI: Using configuration type 1 for base access
[    0.644377] bio: create slab <bio-0> at 0
[    0.644465] ACPI: Added _OSI(Module Device)
[    0.644465] ACPI: Added _OSI(Processor Device)
[    0.644465] ACPI: Added _OSI(3.0 _SCP Extensions)
[    0.644465] ACPI: Added _OSI(Processor Aggregator Device)
[    0.657415] ACPI: EC: Look up EC in DSDT
[    0.657895] \_SB_:_OSC invalid UUID
[    0.657898] _OSC request data:1 1f 
[    0.668665] ACPI: Executed 1 blocks of module-level executable AML code
[    0.898797] ACPI: Dynamic OEM Table Load:
[    0.898802] ACPI: PRAD           (null) 000BE (v02 PRADID  PRADTID 00000001 MSFT 03000001)
[    0.905455] ACPI: Interpreter enabled
[    0.905460] ACPI: (supports S0 S4 S5)
[    0.905481] ACPI: Using IOAPIC for interrupt routing
[    0.918123] ACPI: No dock devices found.
[    0.918144] HEST: Table parsing has been initialized.
[    0.918148] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    0.918552] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    0.919015] PCI host bridge to bus 0000:00
[    0.919020] pci_bus 0000:00: busn_res: [bus 00-7e] is inserted under domain [bus 00-ff]
[    0.919023] pci_bus 0000:00: root bus resource [bus 00-7e]
[    0.919026] pci_bus 0000:00: root bus resource [io  0x0000-0x03af]
[    0.919029] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7]
[    0.919032] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df]
[    0.919035] pci_bus 0000:00: root bus resource [io  0x0d00-0x9fff]
[    0.919039] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff]
[    0.919043] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff]
[    0.919046] pci_bus 0000:00: root bus resource [mem 0x90000000-0xe7ffffff]
[    0.919049] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x380fffffffff]
[    0.919063] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    0.919127] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    0.919153] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    0.919221] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    0.919248] pci 0000:00:01.1: [8086:0e03] type 01 class 0x060400
[    0.919313] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    0.919346] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    0.919412] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    0.919440] pci 0000:00:02.2: [8086:0e06] type 01 class 0x060400
[    0.919505] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    0.919536] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    0.919602] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    0.919630] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    0.919707] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    0.919783] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    0.919794] pci 0000:00:05.4: reg 10: [mem 0xe7f06000-0xe7f06fff]
[    0.919875] pci 0000:00:07.0: [8086:0e18] type 00 class 0x088000
[    0.919963] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    0.920066] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    0.920103] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    0.920126] pci 0000:00:16.0: reg 10: [mem 0xe7f05000-0xe7f0500f 64bit]
[    0.920198] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    0.920222] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000
[    0.920245] pci 0000:00:16.1: reg 10: [mem 0xe7f04000-0xe7f0400f 64bit]
[    0.920317] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    0.920354] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    0.920376] pci 0000:00:1a.0: reg 10: [mem 0xe7f02000-0xe7f023ff]
[    0.920467] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    0.920494] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    0.920576] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    0.920605] pci 0000:00:1c.4: [8086:1d18] type 01 class 0x060400
[    0.920687] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    0.920723] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    0.920744] pci 0000:00:1d.0: reg 10: [mem 0xe7f01000-0xe7f013ff]
[    0.920836] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    0.920859] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    0.920925] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    0.921053] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    0.921072] pci 0000:00:1f.2: reg 10: [io  0x9070-0x9077]
[    0.921081] pci 0000:00:1f.2: reg 14: [io  0x9060-0x9063]
[    0.921090] pci 0000:00:1f.2: reg 18: [io  0x9050-0x9057]
[    0.921098] pci 0000:00:1f.2: reg 1c: [io  0x9040-0x9043]
[    0.921107] pci 0000:00:1f.2: reg 20: [io  0x9020-0x903f]
[    0.921116] pci 0000:00:1f.2: reg 24: [mem 0xe7f00000-0xe7f007ff]
[    0.921162] pci 0000:00:1f.2: PME# supported from D3hot
[    0.921181] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    0.921197] pci 0000:00:1f.3: reg 10: [mem 0x380ffff01000-0x380ffff010ff 64bit]
[    0.921219] pci 0000:00:1f.3: reg 20: [io  0x9000-0x901f]
[    0.921255] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000
[    0.921277] pci 0000:00:1f.6: reg 10: [mem 0x380ffff00000-0x380ffff00fff 64bit]
[    0.921387] pci_bus 0000:01: busn_res: [bus 01] is inserted under [bus 00-7e]
[    0.921390] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.921437] pci_bus 0000:02: busn_res: [bus 02] is inserted under [bus 00-7e]
[    0.921441] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.921487] pci_bus 0000:03: busn_res: [bus 03] is inserted under [bus 00-7e]
[    0.921716] pci 0000:03:00.0: [15b3:1003] type 00 class 0x028000
[    0.921968] pci 0000:03:00.0: reg 10: [mem 0xe7e00000-0xe7efffff 64bit]
[    0.922172] pci 0000:03:00.0: reg 18: [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    0.923765] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.923771] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    0.923778] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    0.923818] pci_bus 0000:04: busn_res: [bus 04] is inserted under [bus 00-7e]
[    0.923822] pci 0000:00:02.2: PCI bridge to [bus 04]
[    0.923869] pci_bus 0000:05: busn_res: [bus 05] is inserted under [bus 00-7e]
[    0.923880] pci 0000:05:00.0: [8086:2250] type 00 class 0x0b4000
[    0.923891] pci 0000:05:00.0: reg 10: [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    0.923909] pci 0000:05:00.0: reg 20: [mem 0xe7d00000-0xe7d1ffff 64bit]
[    0.923941] pci 0000:05:00.0: PME# supported from D0
[    0.928075] pci 0000:00:03.0: PCI bridge to [bus 05]
[    0.928098] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    0.928105] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    0.928157] pci_bus 0000:06: busn_res: [bus 06] is inserted under [bus 00-7e]
[    0.928178] pci 0000:06:00.0: [8086:1d69] type 00 class 0x010700
[    0.928198] pci 0000:06:00.0: reg 10: [mem 0x380e00c7c000-0x380e00c7ffff 64bit pref]
[    0.928214] pci 0000:06:00.0: reg 18: [mem 0x380e00800000-0x380e00bfffff 64bit pref]
[    0.928226] pci 0000:06:00.0: reg 20: [io  0x8000-0x80ff]
[    0.928330] pci 0000:06:00.0: reg 164: [mem 0x380e00c00000-0x380e00c03fff 64bit pref]
[    0.928390] pci 0000:00:11.0: PCI bridge to [bus 06]
[    0.928395] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    0.928401] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    0.928409] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    0.928455] pci_bus 0000:07: busn_res: [bus 07-08] is inserted under [bus 00-7e]
[    0.928484] pci 0000:07:00.0: [8086:1523] type 00 class 0x020000
[    0.928504] pci 0000:07:00.0: reg 10: [mem 0xe7b00000-0xe7b1ffff]
[    0.928530] pci 0000:07:00.0: reg 18: [io  0x7000-0x701f]
[    0.928544] pci 0000:07:00.0: reg 1c: [mem 0xe7b20000-0xe7b23fff]
[    0.928653] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    0.928715] pci 0000:07:00.0: reg 184: [mem 0x380e00e20000-0x380e00e23fff 64bit pref]
[    0.928746] pci 0000:07:00.0: reg 190: [mem 0x380e00e00000-0x380e00e03fff 64bit pref]
[    0.936078] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    0.936098] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    0.936103] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    0.936110] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    0.936157] pci_bus 0000:09: busn_res: [bus 09-0a] is inserted under [bus 00-7e]
[    0.936188] pci 0000:09:00.0: [1a03:1150] type 01 class 0x060400
[    0.936335] pci 0000:09:00.0: supports D1 D2
[    0.936337] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.944076] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    0.944098] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    0.944103] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    0.944110] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.944197] pci_bus 0000:0a: busn_res: [bus 0a] is inserted under [bus 09-0a]
[    0.944222] pci 0000:0a:00.0: [1a03:2000] type 00 class 0x030000
[    0.944256] pci 0000:0a:00.0: reg 10: [mem 0xe7000000-0xe77fffff pref]
[    0.944277] pci 0000:0a:00.0: reg 14: [mem 0xe7a00000-0xe7a1ffff]
[    0.944296] pci 0000:0a:00.0: reg 18: [io  0x6000-0x607f]
[    0.944421] pci 0000:0a:00.0: supports D1 D2
[    0.944423] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    0.944516] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.944526] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    0.944533] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    0.944543] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.944577] pci_bus 0000:0b: busn_res: [bus 0b] is inserted under [bus 00-7e]
[    0.944619] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    0.944629] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    0.944632] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    0.944636] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    0.944639] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff] (subtractive decode)
[    0.944642] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    0.944645] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    0.944649] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xe7ffffff] (subtractive decode)
[    0.944652] pci 0000:00:1e.0:   bridge window [mem 0x380000000000-0x380fffffffff] (subtractive decode)
[    0.944691] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    0.944696] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    0.944869] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    0.944944] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
[    0.944971] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
[    0.945012] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE2._PRT]
[    0.945046] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
[    0.945084] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE5._PRT]
[    0.945123] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
[    0.945281]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    0.945472]  pci0000:00: ACPI _OSC control (0x1d) granted
[    0.954750] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    0.954812] PCI host bridge to bus 0000:7f
[    0.954816] pci_bus 0000:7f: busn_res: [bus 7f] is inserted under domain [bus 00-ff]
[    0.954819] pci_bus 0000:7f: root bus resource [bus 7f]
[    0.954829] pci 0000:7f:08.0: [8086:0e80] type 00 class 0x088000
[    0.954866] pci 0000:7f:08.3: [8086:0e83] type 00 class 0x088000
[    0.954909] pci 0000:7f:08.4: [8086:0e84] type 00 class 0x088000
[    0.954957] pci 0000:7f:09.0: [8086:0e90] type 00 class 0x088000
[    0.954992] pci 0000:7f:09.3: [8086:0e93] type 00 class 0x088000
[    0.955036] pci 0000:7f:09.4: [8086:0e94] type 00 class 0x088000
[    0.955084] pci 0000:7f:0a.0: [8086:0ec0] type 00 class 0x088000
[    0.955113] pci 0000:7f:0a.1: [8086:0ec1] type 00 class 0x088000
[    0.955146] pci 0000:7f:0a.2: [8086:0ec2] type 00 class 0x088000
[    0.955179] pci 0000:7f:0a.3: [8086:0ec3] type 00 class 0x088000
[    0.955214] pci 0000:7f:0b.0: [8086:0e1e] type 00 class 0x088000
[    0.955243] pci 0000:7f:0b.3: [8086:0e1f] type 00 class 0x088000
[    0.955275] pci 0000:7f:0c.0: [8086:0ee0] type 00 class 0x088000
[    0.955305] pci 0000:7f:0c.1: [8086:0ee2] type 00 class 0x088000
[    0.955335] pci 0000:7f:0c.2: [8086:0ee4] type 00 class 0x088000
[    0.955367] pci 0000:7f:0c.3: [8086:0ee6] type 00 class 0x088000
[    0.955396] pci 0000:7f:0c.4: [8086:0ee8] type 00 class 0x088000
[    0.955428] pci 0000:7f:0d.0: [8086:0ee1] type 00 class 0x088000
[    0.955458] pci 0000:7f:0d.1: [8086:0ee3] type 00 class 0x088000
[    0.955487] pci 0000:7f:0d.2: [8086:0ee5] type 00 class 0x088000
[    0.955517] pci 0000:7f:0d.3: [8086:0ee7] type 00 class 0x088000
[    0.955547] pci 0000:7f:0d.4: [8086:0ee9] type 00 class 0x088000
[    0.955579] pci 0000:7f:0e.0: [8086:0ea0] type 00 class 0x088000
[    0.955614] pci 0000:7f:0e.1: [8086:0e30] type 00 class 0x110100
[    0.955654] pci 0000:7f:0f.0: [8086:0ea8] type 00 class 0x088000
[    0.955698] pci 0000:7f:0f.1: [8086:0e71] type 00 class 0x088000
[    0.955744] pci 0000:7f:0f.2: [8086:0eaa] type 00 class 0x088000
[    0.955787] pci 0000:7f:0f.3: [8086:0eab] type 00 class 0x088000
[    0.955832] pci 0000:7f:0f.4: [8086:0eac] type 00 class 0x088000
[    0.955875] pci 0000:7f:0f.5: [8086:0ead] type 00 class 0x088000
[    0.955921] pci 0000:7f:10.0: [8086:0eb0] type 00 class 0x088000
[    0.955964] pci 0000:7f:10.1: [8086:0eb1] type 00 class 0x088000
[    0.956009] pci 0000:7f:10.2: [8086:0eb2] type 00 class 0x088000
[    0.956052] pci 0000:7f:10.3: [8086:0eb3] type 00 class 0x088000
[    0.956103] pci 0000:7f:10.4: [8086:0eb4] type 00 class 0x088000
[    0.956147] pci 0000:7f:10.5: [8086:0eb5] type 00 class 0x088000
[    0.956192] pci 0000:7f:10.6: [8086:0eb6] type 00 class 0x088000
[    0.956236] pci 0000:7f:10.7: [8086:0eb7] type 00 class 0x088000
[    0.956280] pci 0000:7f:13.0: [8086:0e1d] type 00 class 0x088000
[    0.956314] pci 0000:7f:13.1: [8086:0e34] type 00 class 0x110100
[    0.956346] pci 0000:7f:13.4: [8086:0e81] type 00 class 0x088000
[    0.956377] pci 0000:7f:13.5: [8086:0e36] type 00 class 0x110100
[    0.956412] pci 0000:7f:16.0: [8086:0ec8] type 00 class 0x088000
[    0.956442] pci 0000:7f:16.1: [8086:0ec9] type 00 class 0x088000
[    0.956472] pci 0000:7f:16.2: [8086:0eca] type 00 class 0x088000
[    0.956510] pci_bus 0000:7f: on NUMA node 0 (pxm 0)
[    0.956528]  pci0000:7f: Requesting ACPI _OSC control (0x1d)
[    0.956552]  pci0000:7f: ACPI _OSC control (0x1d) granted
[    0.957609] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    0.958016] PCI host bridge to bus 0000:80
[    0.958020] pci_bus 0000:80: busn_res: [bus 80-fe] is inserted under domain [bus 00-ff]
[    0.958024] pci_bus 0000:80: root bus resource [bus 80-fe]
[    0.958027] pci_bus 0000:80: root bus resource [io  0xa000-0xffff]
[    0.958030] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xfbffffff]
[    0.958033] pci_bus 0000:80: root bus resource [mem 0x381000000000-0x381fffffffff]
[    0.958049] pci 0000:80:00.0: [8086:0e01] type 01 class 0x060400
[    0.958122] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    0.958155] pci 0000:80:01.0: [8086:0e02] type 01 class 0x060400
[    0.958227] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    0.958257] pci 0000:80:01.1: [8086:0e03] type 01 class 0x060400
[    0.958328] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
[    0.958365] pci 0000:80:02.0: [8086:0e04] type 01 class 0x060400
[    0.958437] pci 0000:80:02.0: PME# supported from D0 D3hot D3cold
[    0.958467] pci 0000:80:02.2: [8086:0e06] type 01 class 0x060400
[    0.958538] pci 0000:80:02.2: PME# supported from D0 D3hot D3cold
[    0.958572] pci 0000:80:03.0: [8086:0e08] type 01 class 0x060400
[    0.958644] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    0.958676] pci 0000:80:05.0: [8086:0e28] type 00 class 0x088000
[    0.958759] pci 0000:80:05.2: [8086:0e2a] type 00 class 0x088000
[    0.958842] pci 0000:80:05.4: [8086:0e2c] type 00 class 0x080020
[    0.958854] pci 0000:80:05.4: reg 10: [mem 0xfbf00000-0xfbf00fff]
[    0.958943] pci 0000:80:07.0: [8086:0e18] type 00 class 0x088000
[    0.959076] pci_bus 0000:81: busn_res: [bus 81] is inserted under [bus 80-fe]
[    0.959080] pci 0000:80:00.0: PCI bridge to [bus 81]
[    0.959131] pci_bus 0000:82: busn_res: [bus 82] is inserted under [bus 80-fe]
[    0.959134] pci 0000:80:01.0: PCI bridge to [bus 82]
[    0.959185] pci_bus 0000:83: busn_res: [bus 83] is inserted under [bus 80-fe]
[    0.959188] pci 0000:80:01.1: PCI bridge to [bus 83]
[    0.959239] pci_bus 0000:84: busn_res: [bus 84] is inserted under [bus 80-fe]
[    0.959242] pci 0000:80:02.0: PCI bridge to [bus 84]
[    0.959292] pci_bus 0000:85: busn_res: [bus 85] is inserted under [bus 80-fe]
[    0.959296] pci 0000:80:02.2: PCI bridge to [bus 85]
[    0.959346] pci_bus 0000:86: busn_res: [bus 86] is inserted under [bus 80-fe]
[    0.959357] pci 0000:86:00.0: [8086:2250] type 00 class 0x0b4000
[    0.959369] pci 0000:86:00.0: reg 10: [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    0.959389] pci 0000:86:00.0: reg 20: [mem 0xfbe00000-0xfbe1ffff 64bit]
[    0.959424] pci 0000:86:00.0: PME# supported from D0
[    0.959549] pci 0000:80:03.0: PCI bridge to [bus 86]
[    0.959556] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.959562] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    0.959599] pci_bus 0000:80: on NUMA node 1 (pxm 1)
[    0.959603] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    0.959839]  pci0000:80: Requesting ACPI _OSC control (0x1d)
[    0.960028]  pci0000:80: ACPI _OSC control (0x1d) granted
[    0.961785] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    0.961850] PCI host bridge to bus 0000:ff
[    0.961854] pci_bus 0000:ff: busn_res: [bus ff] is inserted under domain [bus 00-ff]
[    0.961857] pci_bus 0000:ff: root bus resource [bus ff]
[    0.961868] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    0.961913] pci 0000:ff:08.3: [8086:0e83] type 00 class 0x088000
[    0.961967] pci 0000:ff:08.4: [8086:0e84] type 00 class 0x088000
[    0.962025] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    0.962067] pci 0000:ff:09.3: [8086:0e93] type 00 class 0x088000
[    0.962121] pci 0000:ff:09.4: [8086:0e94] type 00 class 0x088000
[    0.962178] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    0.962215] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    0.962252] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    0.962289] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    0.962328] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    0.962363] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    0.962400] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    0.962435] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    0.962471] pci 0000:ff:0c.2: [8086:0ee4] type 00 class 0x088000
[    0.962507] pci 0000:ff:0c.3: [8086:0ee6] type 00 class 0x088000
[    0.962545] pci 0000:ff:0c.4: [8086:0ee8] type 00 class 0x088000
[    0.962583] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    0.962619] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    0.962655] pci 0000:ff:0d.2: [8086:0ee5] type 00 class 0x088000
[    0.962691] pci 0000:ff:0d.3: [8086:0ee7] type 00 class 0x088000
[    0.962727] pci 0000:ff:0d.4: [8086:0ee9] type 00 class 0x088000
[    0.962764] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    0.962810] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    0.962861] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    0.962916] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    0.962968] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    0.963022] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    0.963075] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    0.963128] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    0.963182] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    0.963237] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    0.963290] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    0.963343] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    0.963396] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    0.963453] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    0.963506] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    0.963560] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    0.963612] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    0.963648] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    0.963685] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    0.963724] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    0.963765] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    0.963802] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    0.963838] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    0.963884] pci_bus 0000:ff: on NUMA node 1 (pxm 1)
[    0.963901]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    0.963924]  pci0000:ff: ACPI _OSC control (0x1d) granted
[    0.964738] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    0.964797] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    0.964850] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    0.964903] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    0.964953] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    0.965006] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    0.965058] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    0.965109] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    0.965170] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
[    0.965170] vgaarb: loaded
[    0.965170] vgaarb: bridge control possible 0000:0a:00.0
[    0.965170] PCI: Using ACPI for IRQ routing
[    0.969951] PCI: pci_cache_line_size set to 64 bytes
[    0.970259] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    0.970262] e820: reserve RAM buffer [mem 0x8df5e000-0x8fffffff]
[    0.970366] NetLabel: Initializing
[    0.970368] NetLabel:  domain hash size = 128
[    0.970370] NetLabel:  protocols = UNLABELED CIPSOv4
[    0.970382] NetLabel:  unlabeled traffic allowed by default
[    0.970400] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    0.970407] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    0.972114] Switching to clocksource hpet
[    0.974013] AppArmor: AppArmor Filesystem Enabled
[    0.974036] pnp: PnP ACPI init
[    0.974049] ACPI: bus type pnp registered
[    0.974081] pnp 00:00: parse allocated resources
[    0.974324] pnp 00:00: [bus 00-7e]
[    0.974327] pnp 00:00: [io  0x0cf8-0x0cff]
[    0.974330] pnp 00:00: [io  0x0000-0x03af window]
[    0.974333] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    0.974335] pnp 00:00: [io  0x03b0-0x03df window]
[    0.974338] pnp 00:00: [io  0x0d00-0x9fff window]
[    0.974341] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    0.974343] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    0.974346] pnp 00:00: [mem 0x90000000-0xe7ffffff window]
[    0.974349] pnp 00:00: [mem 0x380000000000-0x380fffffffff window]
[    0.974411] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.974420] pnp 00:01: parse allocated resources
[    0.974427] pnp 00:01: [mem 0xfc000000-0xfcffffff]
[    0.974430] pnp 00:01: [mem 0xfd000000-0xfdffffff]
[    0.974433] pnp 00:01: [mem 0xfe000000-0xfeafffff]
[    0.974435] pnp 00:01: [mem 0xfeb00000-0xfebfffff]
[    0.974438] pnp 00:01: [mem 0xfed00400-0xfed3ffff]
[    0.974440] pnp 00:01: [mem 0xfed45000-0xfedfffff]
[    0.974448] pnp 00:01: PNP0c01: calling quirk_system_pci_resources+0x0/0x1a0
[    0.974512] pnp 00:01: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xd0
[    0.974536] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    0.974540] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    0.974543] system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
[    0.974546] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    0.974549] system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    0.974552] system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
[    0.974556] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.974582] pnp 00:02: parse allocated resources
[    0.974618] pnp 00:02: [mem 0xe7ffc000-0xe7ffdfff]
[    0.974623] pnp 00:02: PNP0c02: calling quirk_system_pci_resources+0x0/0x1a0
[    0.974701] system 00:02: [mem 0xe7ffc000-0xe7ffdfff] has been reserved
[    0.974706] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.974716] pnp 00:03: parse allocated resources
[    0.974785] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    0.974789] pnp 00:03: [io  0x0a00-0x0a1f]
[    0.974793] pnp 00:03: PNP0c02: calling quirk_system_pci_resources+0x0/0x1a0
[    0.974869] system 00:03: [io  0x0a00-0x0a1f] has been reserved
[    0.974874] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.975038] pnp 00:04: parse resource options
[    0.975048] pnp 00:04:   dependent set 0 (acceptable) io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    0.975056] pnp 00:04:   dependent set 0 (acceptable) irq 3 4 5 6 7 10 11 12 flags 0x1
[    0.975060] pnp 00:04:   dependent set 0 (acceptable) dma <none> (bitmask 0x0) flags 0x0
[    0.975081] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    0.975091] pnp 00:05: parse allocated resources
[    0.975098] pnp 00:05: [dma 4]
[    0.975101] pnp 00:05: [io  0x0000-0x000f]
[    0.975103] pnp 00:05: [io  0x0081-0x0083]
[    0.975106] pnp 00:05: [io  0x0087]
[    0.975109] pnp 00:05: [io  0x0089-0x008b]
[    0.975111] pnp 00:05: [io  0x008f]
[    0.975113] pnp 00:05: [io  0x00c0-0x00df]
[    0.975132] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    0.975141] pnp 00:06: parse allocated resources
[    0.975147] pnp 00:06: [io  0x0070-0x0071]
[    0.975156] pnp 00:06: [irq 8]
[    0.975178] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    0.975185] pnp 00:07: parse allocated resources
[    0.975190] pnp 00:07: [io  0x0061]
[    0.975209] pnp 00:07: Plug and Play ACPI device, IDs PNP0800 (active)
[    0.975215] pnp 00:08: parse allocated resources
[    0.975243] pnp 00:08: [io  0x0010-0x001f]
[    0.975246] pnp 00:08: [io  0x0022-0x003f]
[    0.975248] pnp 00:08: [io  0x0044-0x005f]
[    0.975251] pnp 00:08: [io  0x0062-0x0063]
[    0.975253] pnp 00:08: [io  0x0065-0x006f]
[    0.975256] pnp 00:08: [io  0x0072-0x007f]
[    0.975259] pnp 00:08: [io  0x0080]
[    0.975261] pnp 00:08: [io  0x0084-0x0086]
[    0.975264] pnp 00:08: [io  0x0088]
[    0.975266] pnp 00:08: [io  0x008c-0x008e]
[    0.975268] pnp 00:08: [io  0x0090-0x009f]
[    0.975270] pnp 00:08: [io  0x00a2-0x00bf]
[    0.975273] pnp 00:08: [io  0x00e0-0x00ef]
[    0.975273] pnp 00:08: [io  0x04d0-0x04d1]
[    0.975273] pnp 00:08: PNP0c02: calling quirk_system_pci_resources+0x0/0x1a0
[    0.975346] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    0.975350] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.975358] pnp 00:09: parse allocated resources
[    0.975364] pnp 00:09: [io  0x00f0-0x00ff]
[    0.975373] pnp 00:09: [irq 13]
[    0.975394] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    0.975423] pnp 00:0a: parse allocated resources
[    0.975502] pnp 00:0a: [io  0x0ca2]
[    0.975505] pnp 00:0a: [io  0x0ca3]
[    0.975527] pnp 00:0a: Plug and Play ACPI device, IDs IPI0001 (active)
[    0.975537] pnp 00:0b: parse allocated resources
[    0.975752] pnp 00:0b: [io  0x0400-0x0453]
[    0.975755] pnp 00:0b: [io  0x0458-0x047f]
[    0.975765] pnp 00:0b: [io  0x1180-0x119f]
[    0.975769] pnp 00:0b: [io  0x0500-0x057f]
[    0.975772] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    0.975775] pnp 00:0b: [mem 0xfec00000-0xfecfffff]
[    0.975777] pnp 00:0b: [mem 0xfed08000-0xfed08fff]
[    0.975780] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    0.975785] pnp 00:0b: PNP0c01: calling quirk_system_pci_resources+0x0/0x1a0
[    0.975848] pnp 00:0b: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xd0
[    0.975881] system 00:0b: [io  0x0400-0x0453] has been reserved
[    0.975884] system 00:0b: [io  0x0458-0x047f] has been reserved
[    0.975887] system 00:0b: [io  0x1180-0x119f] has been reserved
[    0.975890] system 00:0b: [io  0x0500-0x057f] has been reserved
[    0.975894] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    0.975897] system 00:0b: [mem 0xfec00000-0xfecfffff] could not be reserved
[    0.975900] system 00:0b: [mem 0xfed08000-0xfed08fff] has been reserved
[    0.975903] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    0.975907] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.975923] pnp 00:0c: parse allocated resources
[    0.975960] pnp 00:0c: [io  0x0454-0x0457]
[    0.975966] pnp 00:0c: PNP0c02: calling quirk_system_pci_resources+0x0/0x1a0
[    0.976075] system 00:0c: [io  0x0454-0x0457] has been reserved
[    0.976082] system 00:0c: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    0.976237] pnp 00:0d: parse allocated resources
[    0.976266] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    0.976309] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    0.976326] pnp 00:0e: parse allocated resources
[    0.976365] pnp 00:0e: [bus 7f]
[    0.976418] pnp 00:0e: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.976452] pnp 00:0f: parse allocated resources
[    0.976644] pnp 00:0f: [bus 80-fe]
[    0.976647] pnp 00:0f: [io  0x0000 window]
[    0.976650] pnp 00:0f: [io  0xa000-0xffff window]
[    0.976653] pnp 00:0f: [mem 0x00000000 window]
[    0.976656] pnp 00:0f: [mem 0xe8000000-0xfbffffff window]
[    0.976659] pnp 00:0f: [mem 0x381000000000-0x381fffffffff window]
[    0.976714] pnp 00:0f: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    0.976722] pnp 00:10: parse allocated resources
[    0.976730] pnp 00:10: PNP0c01: calling quirk_system_pci_resources+0x0/0x1a0
[    0.976787] pnp 00:10: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xd0
[    0.976832] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (active)
[    0.976857] pnp 00:11: parse allocated resources
[    0.976892] pnp 00:11: [mem 0xfbffe000-0xfbffffff]
[    0.976897] pnp 00:11: PNP0c02: calling quirk_system_pci_resources+0x0/0x1a0
[    0.976995] system 00:11: [mem 0xfbffe000-0xfbffffff] has been reserved
[    0.976999] system 00:11: Plug and Play ACPI device, IDs PNP0c02 (active)
[    0.977035] pnp 00:12: parse allocated resources
[    0.977072] pnp 00:12: [bus ff]
[    0.977126] pnp 00:12: Plug and Play ACPI device, IDs PNP0a03 (active)
[    0.977545] pnp: PnP ACPI: found 19 devices
[    0.977548] ACPI: ACPI bus type pnp unregistered
[    0.985567] pci 0000:00:01.0: PCI bridge to [bus 01]
[    0.985579] pci 0000:00:01.1: PCI bridge to [bus 02]
[    0.985589] pci 0000:00:02.0: PCI bridge to [bus 03]
[    0.985595] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    0.985599] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    0.985606] pci 0000:00:02.2: PCI bridge to [bus 04]
[    0.985616] pci 0000:00:03.0: PCI bridge to [bus 05]
[    0.985621] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    0.985626] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    0.985633] pci 0000:00:11.0: PCI bridge to [bus 06]
[    0.985637] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    0.985643] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    0.985648] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    0.985657] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    0.985660] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    0.985666] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    0.985671] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    0.985678] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    0.985683] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    0.985691] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    0.985698] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.985709] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    0.985712] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    0.985718] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    0.985723] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.985730] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    0.985746] pci 0000:80:00.0: PCI bridge to [bus 81]
[    0.985757] pci 0000:80:01.0: PCI bridge to [bus 82]
[    0.985767] pci 0000:80:01.1: PCI bridge to [bus 83]
[    0.985778] pci 0000:80:02.0: PCI bridge to [bus 84]
[    0.985789] pci 0000:80:02.2: PCI bridge to [bus 85]
[    0.985800] pci 0000:80:03.0: PCI bridge to [bus 86]
[    0.985805] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    0.985809] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    0.985891] pci 0000:00:1e.0: setting latency timer to 64
[    0.985952] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    0.985955] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    0.985957] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    0.985960] pci_bus 0000:00: resource 7 [io  0x0d00-0x9fff]
[    0.985963] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    0.985965] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    0.985968] pci_bus 0000:00: resource 10 [mem 0x90000000-0xe7ffffff]
[    0.985971] pci_bus 0000:00: resource 11 [mem 0x380000000000-0x380fffffffff]
[    0.985974] pci_bus 0000:03: resource 1 [mem 0xe7e00000-0xe7efffff]
[    0.985977] pci_bus 0000:03: resource 2 [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    0.985981] pci_bus 0000:05: resource 1 [mem 0xe7d00000-0xe7dfffff]
[    0.985983] pci_bus 0000:05: resource 2 [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    0.985987] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
[    0.985989] pci_bus 0000:06: resource 1 [mem 0xe7c00000-0xe7cfffff]
[    0.985992] pci_bus 0000:06: resource 2 [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    0.985995] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    0.985998] pci_bus 0000:07: resource 1 [mem 0xe7b00000-0xe7bfffff]
[    0.986001] pci_bus 0000:07: resource 2 [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    0.986004] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    0.986007] pci_bus 0000:09: resource 1 [mem 0xe7a00000-0xe7afffff]
[    0.986009] pci_bus 0000:09: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.986012] pci_bus 0000:0a: resource 0 [io  0x6000-0x6fff]
[    0.986015] pci_bus 0000:0a: resource 1 [mem 0xe7a00000-0xe7afffff]
[    0.986018] pci_bus 0000:0a: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    0.986021] pci_bus 0000:0b: resource 4 [io  0x0000-0x03af]
[    0.986024] pci_bus 0000:0b: resource 5 [io  0x03e0-0x0cf7]
[    0.986026] pci_bus 0000:0b: resource 6 [io  0x03b0-0x03df]
[    0.986029] pci_bus 0000:0b: resource 7 [io  0x0d00-0x9fff]
[    0.986031] pci_bus 0000:0b: resource 8 [mem 0x000a0000-0x000bffff]
[    0.986034] pci_bus 0000:0b: resource 9 [mem 0x000c0000-0x000dffff]
[    0.986037] pci_bus 0000:0b: resource 10 [mem 0x90000000-0xe7ffffff]
[    0.986040] pci_bus 0000:0b: resource 11 [mem 0x380000000000-0x380fffffffff]
[    0.986044] pci_bus 0000:80: resource 4 [io  0xa000-0xffff]
[    0.986046] pci_bus 0000:80: resource 5 [mem 0xe8000000-0xfbffffff]
[    0.986049] pci_bus 0000:80: resource 6 [mem 0x381000000000-0x381fffffffff]
[    0.986052] pci_bus 0000:86: resource 1 [mem 0xfbe00000-0xfbefffff]
[    0.986055] pci_bus 0000:86: resource 2 [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    0.986464] NET: Registered protocol family 2
[    0.987645] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    0.989120] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    0.989302] TCP: Hash tables configured (established 524288 bind 65536)
[    0.989349] TCP: reno registered
[    0.989423] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.989666] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    0.990199] NET: Registered protocol family 1
[    1.028110] pci 0000:0a:00.0: Boot video device
[    1.028263] PCI: CLS 64 bytes, default 64
[    1.028317] Unpacking initramfs...
[    1.400513] Freeing initrd memory: 20720k freed
[    1.405774] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    1.405779] software IO TLB [mem 0x89f5c000-0x8df5bfff] (64MB) mapped at [ffff880089f5c000-ffff88008df5bfff]
[    1.408869] audit: initializing netlink socket (disabled)
[    1.408891] type=2000 audit(1477339620.404:1): initialized
[    1.431231] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    1.437463] VFS: Disk quotas dquot_6.5.2
[    1.437575] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    1.437831] msgmni has been set to 32768
[    1.438293] alg: No test for stdrng (krng)
[    1.438441] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    1.438487] io scheduler noop registered
[    1.438489] io scheduler deadline registered
[    1.438609] io scheduler cfq registered (default)
[    1.439017] pcieport 0000:00:01.0: irq 88 for MSI/MSI-X
[    1.439145] pcieport 0000:00:01.1: irq 89 for MSI/MSI-X
[    1.439264] pcieport 0000:00:02.0: irq 90 for MSI/MSI-X
[    1.439383] pcieport 0000:00:02.2: irq 91 for MSI/MSI-X
[    1.439500] pcieport 0000:00:03.0: irq 92 for MSI/MSI-X
[    1.439644] pcieport 0000:00:11.0: irq 93 for MSI/MSI-X
[    1.439775] pcieport 0000:00:1c.0: irq 94 for MSI/MSI-X
[    1.439895] pcieport 0000:00:1c.4: irq 95 for MSI/MSI-X
[    1.440165] pcieport 0000:80:00.0: irq 96 for MSI/MSI-X
[    1.440334] pcieport 0000:80:01.0: irq 97 for MSI/MSI-X
[    1.440477] pcieport 0000:80:01.1: irq 98 for MSI/MSI-X
[    1.440618] pcieport 0000:80:02.0: irq 99 for MSI/MSI-X
[    1.440759] pcieport 0000:80:02.2: irq 100 for MSI/MSI-X
[    1.440903] pcieport 0000:80:03.0: irq 101 for MSI/MSI-X
[    1.441078] aer 0000:00:01.0:pcie02: service driver aer loaded
[    1.441111] aer 0000:00:01.1:pcie02: service driver aer loaded
[    1.441142] aer 0000:00:02.0:pcie02: service driver aer loaded
[    1.441172] aer 0000:00:02.2:pcie02: service driver aer loaded
[    1.441203] aer 0000:00:03.0:pcie02: service driver aer loaded
[    1.441237] aer 0000:00:11.0:pcie02: service driver aer loaded
[    1.441271] aer 0000:80:00.0:pcie02: service driver aer loaded
[    1.441303] aer 0000:80:01.0:pcie02: service driver aer loaded
[    1.441336] aer 0000:80:01.1:pcie02: service driver aer loaded
[    1.441368] aer 0000:80:02.0:pcie02: service driver aer loaded
[    1.441400] aer 0000:80:02.2:pcie02: service driver aer loaded
[    1.441433] aer 0000:80:03.0:pcie02: service driver aer loaded
[    1.441453] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    1.441458] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    1.441469] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    1.441474] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    1.441484] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    1.441487] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    1.441491] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    1.441501] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    1.441506] pcie_pme 0000:00:02.2:pcie01: service driver pcie_pme loaded
[    1.441515] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    1.441518] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    1.441522] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    1.441533] pcieport 0000:00:11.0: Signaling PME through PCIe PME interrupt
[    1.441536] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    1.441541] pcie_pme 0000:00:11.0:pcie01: service driver pcie_pme loaded
[    1.441559] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    1.441562] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    1.441567] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    1.441586] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    1.441589] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    1.441592] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    1.441596] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    1.441607] pcieport 0000:80:00.0: Signaling PME through PCIe PME interrupt
[    1.441612] pcie_pme 0000:80:00.0:pcie01: service driver pcie_pme loaded
[    1.441623] pcieport 0000:80:01.0: Signaling PME through PCIe PME interrupt
[    1.441628] pcie_pme 0000:80:01.0:pcie01: service driver pcie_pme loaded
[    1.441637] pcieport 0000:80:01.1: Signaling PME through PCIe PME interrupt
[    1.441642] pcie_pme 0000:80:01.1:pcie01: service driver pcie_pme loaded
[    1.441653] pcieport 0000:80:02.0: Signaling PME through PCIe PME interrupt
[    1.441658] pcie_pme 0000:80:02.0:pcie01: service driver pcie_pme loaded
[    1.441667] pcieport 0000:80:02.2: Signaling PME through PCIe PME interrupt
[    1.441672] pcie_pme 0000:80:02.2:pcie01: service driver pcie_pme loaded
[    1.441682] pcieport 0000:80:03.0: Signaling PME through PCIe PME interrupt
[    1.441685] pci 0000:86:00.0: Signaling PME through PCIe PME interrupt
[    1.441689] pcie_pme 0000:80:03.0:pcie01: service driver pcie_pme loaded
[    1.441713] ioapic: probe of 0000:00:05.4 failed with error -22
[    1.441746] ioapic: probe of 0000:80:05.4 failed with error -22
[    1.441834] vesafb: mode is 800x600x16, linelength=1600, pages=7
[    1.441836] vesafb: scrolling: redraw
[    1.441839] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    1.442050] vesafb: framebuffer at 0xe7000000, mapped to 0xffffc90016d00000, using 1875k, total 8192k
[    1.490669] Console: switching to colour frame buffer device 100x37
[    1.539814] fb0: VESA VGA frame buffer device
[    1.540489] intel_idle: does not run on family 6 model 62
[    1.541356] ERST: Error Record Serialization Table (ERST) support is initialized.
[    1.542644] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    1.543636] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
[    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
[    1.568366] serial 00:04: pnp_assign_resources failed (-16)
[    1.569188] serial 00:04: unable to assign resources
[    1.569924] serial: probe of 00:04 failed with error -16
[    1.571134] Non-volatile memory driver v1.3
[    1.594109] Linux agpgart interface v0.103
[    1.617003] libphy: Fixed MDIO Bus: probed
[    1.640157] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    1.664637] i8042: No controller found
[    1.688019] mousedev: PS/2 mouse device common for all mice
[    1.711699] cpuidle: using governor ladder
[    1.735096] cpuidle: using governor menu
[    1.758064] EFI Variables Facility v0.08 2004-May-17
[    1.781468] TCP: cubic registered
[    1.804360] Key type dns_resolver registered
[    1.828230] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
[    1.876145] PM: Hibernation image not present or could not be loaded.
[    1.900903] registered taskstats version 1
[    1.929641]   Magic number: 4:17:145
[    1.953950] pcie_pme 0000:00:02.2:pcie01: hash matches
[    1.978488] acpi device:16: hash matches
[    2.002670] memory memory282: hash matches
[    2.029504] Freeing unused kernel memory: 1344k freed
[    2.054728] Write protecting the kernel read-only data: 10240k
[    2.084088] Freeing unused kernel memory: 1696k freed
[    2.114760] Freeing unused kernel memory: 1976k freed
[    2.206167] SCSI subsystem initialized
[    2.232146] ACPI: bus type scsi registered
[    2.255360] libata version 3.00 loaded.
[    2.279860] ahci 0000:00:1f.2: version 3.0
[    2.302357] ahci 0000:00:1f.2: irq 102 for MSI/MSI-X
[    2.324337] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0x3f
[    2.346023] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    2.368081] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    2.390242] ahci 0000:00:1f.2: setting latency timer to 64
[    2.412740] scsi0 : ahci
[    2.434418] scsi1 : ahci
[    2.455603] scsi2 : ahci
[    2.476375] scsi3 : ahci
[    2.496637] scsi4 : ahci
[    2.516532] scsi5 : ahci
[    2.536079] ata1: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00100 irq 102
[    2.556344] ata2: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00180 irq 102
[    2.575986] ata3: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00200 irq 102
[    2.595139] ata4: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00280 irq 102
[    2.613790] ata5: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00300 irq 102
[    2.632426] ata6: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00380 irq 102
[    3.676051] ata2: failed to resume link (SControl 0)
[    3.694188] ata2: SATA link down (SStatus 0 SControl 0)
[    3.712448] ata6: failed to resume link (SControl 0)
[    3.730125] ata6: SATA link down (SStatus 0 SControl 0)
[    3.747126] ata5: failed to resume link (SControl 0)
[    3.763750] ata5: SATA link down (SStatus 0 SControl 0)
[    3.780199] ata4: failed to resume link (SControl 0)
[    3.796696] ata4: SATA link down (SStatus 0 SControl 0)
[    3.813157] ata3: failed to resume link (SControl 0)
[    3.829552] ata3: SATA link down (SStatus 0 SControl 0)
[    3.846027] ata1: failed to resume link (SControl 0)
[    3.862396] ata1: SATA link down (SStatus 0 SControl 0)
[    3.885033] emc: device handler registered
[    3.909052] alua: device handler registered
[    3.930283] hp_sw: device handler registered
[    3.951484] rdac: device handler registered
[    3.987273] udev: starting version 147
[    4.011934] ACPI: Requesting acpi_cpufreq
[    4.031497] Monitor-Mwait will be used to enter C-1 state
[    4.048685] Monitor-Mwait will be used to enter C-2 state
[    4.065504] ACPI: acpi_idle registered with cpuidle
[    4.082432] isci: Intel(R) C600 SAS Controller Driver - version 1.1.0
[    4.082436] ACPI: bus type usb registered
[    4.082465] usbcore: registered new interface driver usbfs
[    4.082472] usbcore: registered new interface driver hub
[    4.082553] usbcore: registered new device driver usb
[    4.165537] isci 0000:06:00.0: driver configured for rev: 6 silicon
[    4.183200] isci 0000:06:00.0: OEM parameter table found in OROM
[    4.201363] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) loaded (platform)
[    4.220448] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    4.220934] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    4.223467] scsi6 : isci
[    4.224462] isci 0000:06:00.0: irq 103 for MSI/MSI-X
[    4.224480] isci 0000:06:00.0: irq 104 for MSI/MSI-X
[    4.320486] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    4.341800] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    4.362498] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    4.387503] ehci_hcd 0000:00:1a.0: debug port 2
[    4.408250] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    4.429252] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe7f02000
[    4.460199] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    4.480852] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    4.501944] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.523208] usb usb1: Product: EHCI Host Controller
[    4.544371] usb usb1: Manufacturer: Linux 3.6.0-ntz ehci_hcd
[    4.565652] usb usb1: SerialNumber: 0000:00:1a.0
[    4.586915] hub 1-0:1.0: USB hub found
[    4.607833] hub 1-0:1.0: 2 ports detected
[    4.628696] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    4.649721] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    4.670489] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    4.695593] ehci_hcd 0000:00:1d.0: debug port 2
[    4.716395] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    4.737483] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xe7f01000
[    4.772124] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    4.792848] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    4.814395] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    4.836025] usb usb2: Product: EHCI Host Controller
[    4.857322] usb usb2: Manufacturer: Linux 3.6.0-ntz ehci_hcd
[    4.878589] usb usb2: SerialNumber: 0000:00:1d.0
[    4.899789] hub 2-0:1.0: USB hub found
[    4.921090] hub 2-0:1.0: 2 ports detected
[    5.008101] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    5.160466] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    5.182262] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.204358] hub 1-1:1.0: USB hub found
[    5.225706] hub 1-1:1.0: 6 ports detected
[    5.232217] sas: phy-6:0 added to port-6:0, phy_mask:0x1 (ffffffffffffffff)
[    5.232231] sas: DOING DISCOVERY on port 0, pid:258
[    5.287766] sas: DONE DISCOVERY on port 0, pid:258, result:0
[    5.309334] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[    5.330843] sas: ata7: end_device-6:0: dev error handler
[    5.400091] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    5.516654] ata7.00: ATA-8: WDC WD5000BHTZ-04JCPV1, 04.06A01, max UDMA/133
[    5.538948] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    5.562045] ata7.00: configured for UDMA/133
[    5.584379] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[    5.584756] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    5.584762] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.585316] hub 2-1:1.0: USB hub found
[    5.585519] hub 2-1:1.0: 8 ports detected
[    5.712424] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000BHTZ-0 04.0 PQ: 0 ANSI: 5
[    5.740148] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    5.763734] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    5.787604] sd 6:0:0:0: [sda] Write Protect is off
[    5.810998] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    5.834473] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    5.882213] usb 2-1.3: new high-speed USB device number 3 using ehci_hcd
[    5.907056]  sda: sda1 sda2
[    5.931947] sd 6:0:0:0: [sda] Attached SCSI disk
[    6.156592] [drm] Initialized drm 1.1.0 20060810
[    6.162864] usb 2-1.3: New USB device found, idVendor=046b, idProduct=ff01
[    6.162866] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.162867] usb 2-1.3: Product: Virtual Hub
[    6.162868] usb 2-1.3: Manufacturer: American Megatrends Inc.
[    6.162869] usb 2-1.3: SerialNumber: serial
[    6.163504] hub 2-1.3:1.0: USB hub found
[    6.163623] hub 2-1.3:1.0: 5 ports detected
[    6.291013] [drm] AST 2300 detected
[    6.291091] [drm] dram 1632000000 1 32 04000000
[    6.291273] [TTM] Zone  kernel: Available graphics memory: 32972362 kiB
[    6.291273] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    6.291274] [TTM] Initializing pool allocator
[    6.291277] [TTM] Initializing DMA pool allocator
[    6.291292] mtrr: type mismatch for e7000000,800000 old: write-back new: write-combining
[   16.968031] [sched_delayed] sched: RT throttling activated
[   48.494674] checking generic (e7000000 800000) vs hw (e7000000 800000)
[   48.519141] fb: conflicting fb hw usage astdrmfb vs VESA VGA - removing generic driver
[   48.544243] Console: switching to colour dummy device 80x25
[   48.544392] fbcon: astdrmfb (fb0) is primary device
[   48.564213] Console: switching to colour frame buffer device 128x48
[   48.592207] fb0: astdrmfb frame buffer device
[   48.592354] drm: registered panic notifier
[   48.592496] [drm] Initialized ast 0.1.0 20120228 for 0000:0a:00.0 on minor 0
[   48.616516] PM: Marking nosave pages: [mem 0x0008f000-0x000fffff]
[   48.616520] PM: Marking nosave pages: [mem 0x8df5e000-0xffffffff]
[   48.617630] PM: Basic memory bitmaps created
[   48.672103] usb 2-1.3.1: new low-speed USB device number 4 using ehci_hcd
[   48.837229] usb 2-1.3.1: New USB device found, idVendor=046b, idProduct=ff10
[   48.837232] usb 2-1.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[   48.837233] usb 2-1.3.1: Product: Virtual Keyboard and Mouse
[   48.837235] usb 2-1.3.1: Manufacturer: American Megatrends Inc.
[   48.850003] PM: Basic memory bitmaps freed
[   48.892577] usbcore: registered new interface driver usbhid
[   48.892770] usbhid: USB HID core driver
[   48.960283] usb 2-1.3.2: new high-speed USB device number 5 using ehci_hcd
[   49.007197] PM: Starting manual resume from disk
[   49.007199] PM: Hibernation image partition 8:1 present
[   49.007200] PM: Looking for hibernation image.
[   49.007448] PM: Image not found (code -22)
[   49.007449] PM: Hibernation image not present or could not be loaded.
[   49.117100] usb 2-1.3.2: New USB device found, idVendor=046b, idProduct=ff20
[   49.117347] usb 2-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   49.117605] usb 2-1.3.2: Product: Virtual Cdrom Device
[   49.117782] usb 2-1.3.2: Manufacturer: American Megatrends Inc.
[   49.126117] usb 2-1.3.2: SerialNumber: AAAABBBBCCCC1
[   49.237635] kjournald starting.  Commit interval 5 seconds
[   49.238019] EXT3-fs (sda2): using internal journal
[   49.238020] EXT3-fs (sda2): mounted filesystem with ordered data mode
[   49.264396] usb 2-1.3.3: new high-speed USB device number 6 using ehci_hcd
[   49.424976] usb 2-1.3.3: New USB device found, idVendor=046b, idProduct=ff40
[   49.433790] usb 2-1.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   49.442701] usb 2-1.3.3: Product: Virtual Floppy Device
[   49.451593] usb 2-1.3.3: Manufacturer: American Megatrends Inc.
[   49.460529] usb 2-1.3.3: SerialNumber: AAAABBBBCCCC2
[   49.592105] usb 2-1.3.4: new high-speed USB device number 7 using ehci_hcd
[   49.756974] usb 2-1.3.4: New USB device found, idVendor=046b, idProduct=ff31
[   49.766059] usb 2-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[   49.775194] usb 2-1.3.4: Product: Virtual HardDisk Device
[   49.784241] usb 2-1.3.4: Manufacturer: American Megatrends Inc.
[   49.793227] usb 2-1.3.4: SerialNumber: AAAABBBBCCCC3
[   50.430211] udev: starting version 147
[   50.467341] input: Power Button as /devices/LNXSYSTM:00/device:00/PNP0C0C:00/input/input0
[   50.485351] ACPI: Power Button [PWRB]
[   50.494371] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input1
[   50.503493] ACPI: Power Button [PWRF]
[   50.503501] wmi: Mapper loaded
[   50.766295] rtc_cmos 00:06: RTC can wake from S4
[   50.775524] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[   50.784691] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[   50.803550] ACPI Warning: 0x0000000000000428-0x000000000000042f SystemIO conflicts with Region \PMIO 1 (20120711/utaddress-251)
[   50.822315] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   50.831688] ACPI Warning: 0x0000000000000500-0x000000000000053f SystemIO conflicts with Region \GINV 1 (20120711/utaddress-251)
[   50.850267] ACPI: If an ACPI driver is available for this device, you should use it instead of the native driver
[   50.859820] lpc_ich: Resource conflict(s) found affecting gpio_ich
[   50.876860] input: PC Speaker as /devices/platform/pcspkr/input/input2
[   50.962954] mei 0000:00:16.0: Device doesn't have valid ME Interface
[   50.972748] mei 0000:00:16.0: initialization failed.
[   50.985440] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[   51.000163] iTCO_vendor_support: vendor-support=0
[   51.066016] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.10
[   51.075455] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[   51.088286] microcode: CPU0 sig=0x306e2, pf=0x1, revision=0x20d
[   51.101935] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[   51.227424] mlx4_core: Mellanox ConnectX core driver v1.1 (Dec, 2011)
[   51.236788] mlx4_core: Initializing 0000:03:00.0
[   51.288266] microcode: CPU1 sig=0x306e2, pf=0x1, revision=0x20d
[   51.298042] dca service started, version 1.12.1
[   51.302280] microcode: CPU2 sig=0x306e2, pf=0x1, revision=0x20d
[   51.307233] microcode: CPU3 sig=0x306e2, pf=0x1, revision=0x20d
[   51.313054] microcode: CPU4 sig=0x306e2, pf=0x1, revision=0x20d
[   51.318021] microcode: CPU5 sig=0x306e2, pf=0x1, revision=0x20d
[   51.323058] microcode: CPU6 sig=0x306e2, pf=0x1, revision=0x20d
[   51.327950] microcode: CPU7 sig=0x306e2, pf=0x1, revision=0x20d
[   51.333310] microcode: CPU8 sig=0x306e2, pf=0x1, revision=0x20d
[   51.338240] microcode: CPU9 sig=0x306e2, pf=0x1, revision=0x20d
[   51.343239] microcode: CPU10 sig=0x306e2, pf=0x1, revision=0x20d
[   51.348777] microcode: CPU11 sig=0x306e2, pf=0x1, revision=0x20d
[   51.353680] microcode: CPU12 sig=0x306e2, pf=0x1, revision=0x20d
[   51.358577] microcode: CPU13 sig=0x306e2, pf=0x1, revision=0x20d
[   51.363515] microcode: CPU14 sig=0x306e2, pf=0x1, revision=0x20d
[   51.368877] microcode: CPU15 sig=0x306e2, pf=0x1, revision=0x20d
[   51.373904] microcode: CPU16 sig=0x306e2, pf=0x1, revision=0x20d
[   51.378805] microcode: CPU17 sig=0x306e2, pf=0x1, revision=0x20d
[   51.383717] microcode: CPU18 sig=0x306e2, pf=0x1, revision=0x20d
[   51.389096] microcode: CPU19 sig=0x306e2, pf=0x1, revision=0x20d
[   51.393902] microcode: CPU20 sig=0x306e2, pf=0x1, revision=0x20d
[   51.398915] microcode: CPU21 sig=0x306e2, pf=0x1, revision=0x20d
[   51.403913] microcode: CPU22 sig=0x306e2, pf=0x1, revision=0x20d
[   51.409211] microcode: CPU23 sig=0x306e2, pf=0x1, revision=0x20d
[   51.414079] microcode: CPU24 sig=0x306e2, pf=0x1, revision=0x20d
[   51.419020] microcode: CPU25 sig=0x306e2, pf=0x1, revision=0x20d
[   51.300197] microcode: CPU26 sig=0x306e2, pf=0x1, revision=0x20d
[   51.505668] microcode: CPU27 sig=0x306e2, pf=0x1, revision=0x20d
[   51.515634] microcode: CPU28 sig=0x306e2, pf=0x1, revision=0x20d
[   51.525423] microcode: CPU29 sig=0x306e2, pf=0x1, revision=0x20d
[   51.534799] microcode: CPU30 sig=0x306e2, pf=0x1, revision=0x20d
[   51.543956] igb: Intel(R) Gigabit Ethernet Network Driver - version 4.0.1-k
[   51.544285] microcode: CPU31 sig=0x306e2, pf=0x1, revision=0x20d
[   51.549487] microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[   51.558446] igb: Copyright (c) 2007-2012 Intel Corporation.
[   51.563411] igb 0000:07:00.0: irq 105 for MSI/MSI-X
[   51.567883] igb 0000:07:00.0: irq 106 for MSI/MSI-X
[   51.572245] igb 0000:07:00.0: irq 107 for MSI/MSI-X
[   51.576386] igb 0000:07:00.0: irq 108 for MSI/MSI-X
[   51.580405] igb 0000:07:00.0: irq 109 for MSI/MSI-X
[   51.584315] igb 0000:07:00.0: irq 110 for MSI/MSI-X
[   51.588102] igb 0000:07:00.0: irq 111 for MSI/MSI-X
[   51.591731] igb 0000:07:00.0: irq 112 for MSI/MSI-X
[   51.595219] igb 0000:07:00.0: irq 113 for MSI/MSI-X
[   51.599095] Initializing USB Mass Storage driver...
[   51.602761] scsi7 : usb-storage 2-1.3.2:1.0
[   51.606107] usb-storage 2-1.3.3:1.0: Quirks match for vid 046b pid ff40: 200
[   51.606131] sd 6:0:0:0: Attached scsi generic sg0 type 0
[   51.612769] scsi8 : usb-storage 2-1.3.3:1.0
[   51.616133] scsi9 : usb-storage 2-1.3.4:1.0
[   51.619226] usbcore: registered new interface driver usb-storage
[   51.622492] USB Mass Storage support registered.
[   51.646522] NET: Registered protocol family 10
[   51.657021] igb 0000:07:00.0: Intel(R) Gigabit Ethernet Network Connection
[   51.660745] igb 0000:07:00.0: eth0: (PCIe:5.0Gb/s:Width x4) d4:3d:7e:72:26:b5
[   51.664772] igb 0000:07:00.0: eth0: PBA No: 106100-000
[   51.668797] igb 0000:07:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[   51.741571] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.0/input/input3
[   51.750805] hid-generic 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input0
[   51.761358] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.1/input/input4
[   51.773161] hid-generic 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input1
[   52.070081] alg: No test for __gcm-aes-aesni (__driver-gcm-aes-aesni)
[   52.269362] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.269371] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.269375] Pid: 1174, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.269376] Call Trace:
[   52.269380] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.269382] Pid: 1220, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.269384] Call Trace:
[   52.269395]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.269400]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.269407]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.269411]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.269414]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.269417]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.269422]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.269425]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.269429]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.269433]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.269439]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.269450]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.269455]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.269475]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.269484]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.269513]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.269529]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.269539]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.269555]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.269585]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.269593] kvm: Could not allocate 304 bytes percpu data
[   52.269613]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.269630]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.269632] kvm: Could not allocate 304 bytes percpu data
[   52.269849] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.269851] Pid: 1226, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.269851] Call Trace:
[   52.269856]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.269858]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.269861]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.269863]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.269866]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.269868]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.269871]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.269873]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.269876]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.269878]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.269880]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.269882] kvm: Could not allocate 304 bytes percpu data
[   52.284230] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.284232] Pid: 1202, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.284233] Call Trace:
[   52.284269]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.284278]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.284291] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.284295] Pid: 1178, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.284296]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.284301] Call Trace:
[   52.284300]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.284315]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.284313] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.284316] Pid: 1182, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.284318]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.284327]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.284325] Call Trace:
[   52.284327] PERCPU: allocation failed, size=304 align=32, alloc from reserved chunk failed
[   52.284331] Pid: 1218, comm: modprobe Not tainted 3.6.0-ntz #23
[   52.284337]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.284337]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.284339]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.284341] Call Trace:
[   52.284350]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.284349]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.284350]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.284356]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   52.284363]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.284363]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.284365]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.284369]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   52.284379]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.284378]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.284380]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.284384]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   52.284392]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.284392]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.284393]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.284397]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   52.284407]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.284406]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.284407]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.284411]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   52.284413] kvm: Could not allocate 304 bytes percpu data
[   52.284422]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.284420]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.284422]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   52.284429]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.284429]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.284431]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   52.284438]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.284437]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.284439]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   52.284444] kvm: Could not allocate 304 bytes percpu data
[   52.284444]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.284446]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   52.284448]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.284451]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   52.284452] kvm: Could not allocate 304 bytes percpu data
[   52.284454]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   52.284455] kvm: Could not allocate 304 bytes percpu data
[   52.605342] scsi 7:0:0:0: CD-ROM            AMI      Virtual CDROM0   1.00 PQ: 0 ANSI: 0 CCS
[   52.605606] scsi 7:0:0:0: Attached scsi generic sg1 type 5
[   52.613431] scsi 8:0:0:0: Direct-Access     AMI      Virtual Floppy0  1.00 PQ: 0 ANSI: 0 CCS
[   52.613770] sd 8:0:0:0: Attached scsi generic sg2 type 0
[   52.615890] sd 8:0:0:0: [sdb] Attached SCSI removable disk
[   52.617516] scsi 9:0:0:0: Direct-Access     AMI      Virtual HDISK0   1.00 PQ: 0 ANSI: 0 CCS
[   52.617812] sd 9:0:0:0: Attached scsi generic sg3 type 0
[   52.619823] sd 9:0:0:0: [sdc] Attached SCSI removable disk
[   53.056874] Pid: 1194, comm: modprobe Not tainted 3.6.0-ntz #23
[   53.063151] Call Trace:
[   53.069385]  [<ffffffff8111ac3d>] pcpu_alloc+0x40d/0x470
[   53.075719]  [<ffffffff810a0e35>] ? get_modinfo+0x45/0xc0
[   53.082090]  [<ffffffff8111acae>] __alloc_reserved_percpu+0xe/0x10
[   53.088556]  [<ffffffff810a2fa4>] layout_and_allocate+0xb4/0x170
[   53.094969]  [<ffffffff810a3b31>] load_module+0x111/0x830
[   53.101463]  [<ffffffff8144dbec>] ? do_page_fault+0x23c/0x490
[   53.107861]  [<ffffffff81115495>] ? vm_mmap_pgoff+0x85/0xa0
[   53.114360]  [<ffffffff8120742b>] ? apparmor_capable+0x1b/0x80
[   53.120841]  [<ffffffff811e1283>] ? security_capable+0x13/0x20
[   53.127224]  [<ffffffff810a42aa>] sys_init_module+0x5a/0x220
[   53.133659]  [<ffffffff814520b9>] system_call_fastpath+0x16/0x1b
[   53.140118] kvm: Could not allocate 304 bytes percpu data
[   53.204181] sr0: scsi-1 drive
[   53.210540] cdrom: Uniform CD-ROM driver Revision: 3.20
[   53.217199] sr 7:0:0:0: Attached scsi CD-ROM sr0
[   57.425406] mlx4_core 0000:03:00.0: irq 114 for MSI/MSI-X
[   57.431907] mlx4_core 0000:03:00.0: irq 115 for MSI/MSI-X
[   57.438311] mlx4_core 0000:03:00.0: irq 116 for MSI/MSI-X
[   57.444638] mlx4_core 0000:03:00.0: irq 117 for MSI/MSI-X
[   57.450876] mlx4_core 0000:03:00.0: irq 118 for MSI/MSI-X
[   57.456986] mlx4_core 0000:03:00.0: irq 119 for MSI/MSI-X
[   57.462957] mlx4_core 0000:03:00.0: irq 120 for MSI/MSI-X
[   57.468853] mlx4_core 0000:03:00.0: irq 121 for MSI/MSI-X
[   57.474686] mlx4_core 0000:03:00.0: irq 122 for MSI/MSI-X
[   57.480457] mlx4_core 0000:03:00.0: irq 123 for MSI/MSI-X
[   57.486139] mlx4_core 0000:03:00.0: irq 124 for MSI/MSI-X
[   57.491741] mlx4_core 0000:03:00.0: irq 125 for MSI/MSI-X
[   57.497266] mlx4_core 0000:03:00.0: irq 126 for MSI/MSI-X
[   57.502699] mlx4_core 0000:03:00.0: irq 127 for MSI/MSI-X
[   57.508099] mlx4_core 0000:03:00.0: irq 128 for MSI/MSI-X
[   57.513374] mlx4_core 0000:03:00.0: irq 129 for MSI/MSI-X
[   57.518519] mlx4_core 0000:03:00.0: irq 130 for MSI/MSI-X
[   57.523586] mlx4_core 0000:03:00.0: irq 131 for MSI/MSI-X
[   57.528571] mlx4_core 0000:03:00.0: irq 132 for MSI/MSI-X
[   57.533469] mlx4_core 0000:03:00.0: irq 133 for MSI/MSI-X
[   57.538239] mlx4_core 0000:03:00.0: irq 134 for MSI/MSI-X
[   57.542874] mlx4_core 0000:03:00.0: irq 135 for MSI/MSI-X
[   57.707426] Adding 2103292k swap on /dev/sda1.  Priority:-1 extents:1 across:2103292k 
[   58.131148] device-mapper: uevent: version 1.0.3
[   58.135848] device-mapper: ioctl: 4.23.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   58.422605] loop: module loaded
[   59.407900] fuse init (API version 7.20)

--bg08WKrSYDhXBjb5--
