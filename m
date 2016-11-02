From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Wed, 2 Nov 2016 10:29:51 -0500
Message-ID: <20161102152951.GA107664@stormcage.americas.sgi.com>
References: <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
 <c73bc50a-51fb-78db-b872-277af3fb06bc@sgi.com>
 <20161031202706.GA10263@gofer.mess.org>
 <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKU3ayXn4y+_Amu0FzL5ZhF2W8vFuEb0RR8b2hTBZ6rd+YZMqg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Hurley <peter@hurleysoftware.com>
Cc: Sean Young <sean@mess.org>, Nathan <nzimmer@sgi.com>, Linux kernel mailing list <linux-kernel@vger.kernel.org>, "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 31, 2016 at 08:55:49PM -0600, Peter Hurley wrote:
> On Mon, Oct 31, 2016 at 2:27 PM, Sean Young <sean@mess.org> wrote:
> > On Sun, Oct 30, 2016 at 10:33:02AM -0500, Nathan wrote:
> >> I think this should be PNP0501 instead of PNP0c02.
> >> Once I alter that then when I boot the serial comes up on irq 3. However it
> >> still hangs.
> >> I'll keep digging.
> >
> > Well that's that theory out of the window. I'm not sure where to look now,
> > I would start by enabling as many as possible of the "kernel hacking" config
> > options and see if anything gets caught.
> >
> > Looking at your earlier messages, you have a collection of percpu allocation
> > failures. That might be worth resolving before anything else.
> 
> Hi Nathan,
> 
> Couple of questions:
> 1. Was login over serial console setup and working on SLES 11?  or was
> the 'console=ttyS1' only for debug output?
> I ask because console output doesn't use IRQs; iow, maybe the serial
> port w/ driver never actually worked.
> 2. Can you post dmesg for the SLES 11 setup?  That would show if there
> were probe errors even on that.
> 
> An alternative that should be equivalent to your previous setup is to
> build w/ CONFIG_SERIAL_8250_PNP=n
> Seems like your ACPI BIOS is buggy, but also that something else is using IRQ 3?
> 
> Regards,
> Peter Hurley



1) Yes I can confirm I used it to login sometimes.

I built with CONFIG_SERIAL_8250_PNP=n and that seemed to work better, in that the system did not hang.
However I couldn't login on the serial and got these error messages, I suspect I broke something while trying different permutations.

gdm[5206]: WARNING: GdmDisplay: display lasted 0.136636 seconds
gdm[5206]: WARNING: GdmDisplay: display lasted 0.180955 seconds
gdm[5206]: WARNING: GdmDisplay: display lasted 0.161415 seconds
gdm[5206]: WARNING: GdmLocalDisplayFactory: maximum number of X display failures reached: check X server log for errors

It did boot all the way though.

2) attached log



--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=dmesg_sles11

[    0.000000] Initializing cgroup subsys cpuset
[    0.000000] Initializing cgroup subsys cpu
[    0.000000] Linux version 3.0.101-63-default (geeko@buildhost) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #1 SMP Tue Jun 23 16:02:31 UTC 2015 (4b89d0c)
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M showopts loglevel=8 pnp.debug=1 console=ttyS1,115200n8 
[    0.000000] BIOS-provided physical RAM map:
[    0.000000]  BIOS-e820: 0000000000000000 - 000000000008f000 (usable)
[    0.000000]  BIOS-e820: 000000000008f000 - 00000000000a0000 (reserved)
[    0.000000]  BIOS-e820: 00000000000e0000 - 0000000000100000 (reserved)
[    0.000000]  BIOS-e820: 0000000000100000 - 000000008df5e000 (usable)
[    0.000000]  BIOS-e820: 000000008df5e000 - 000000008df8e000 (reserved)
[    0.000000]  BIOS-e820: 000000008df8e000 - 000000008e0a4000 (ACPI data)
[    0.000000]  BIOS-e820: 000000008e0a4000 - 000000008e2ca000 (ACPI NVS)
[    0.000000]  BIOS-e820: 000000008e2ca000 - 000000008f337000 (reserved)
[    0.000000]  BIOS-e820: 000000008f337000 - 000000008f800000 (ACPI NVS)
[    0.000000]  BIOS-e820: 0000000090000000 - 00000000a0000000 (reserved)
[    0.000000]  BIOS-e820: 00000000fed1c000 - 00000000fed40000 (reserved)
[    0.000000]  BIOS-e820: 00000000ff000000 - 0000000100000000 (reserved)
[    0.000000]  BIOS-e820: 0000000100000000 - 0000001070000000 (usable)
[    0.000000] NX (Execute Disable) protection: active
[    0.000000] DMI 2.7 present.
[    0.000000] DMI: SGI.COM ICE-XIP119/S0751-Medina, BIOS ma2e2054 02/05/2014
[    0.000000] e820 update range: 0000000000000000 - 0000000000010000 (usable) ==> (reserved)
[    0.000000] e820 remove range: 00000000000a0000 - 0000000000100000 (usable)
[    0.000000] No AGP bridge found
[    0.000000] last_pfn = 0x1070000 max_arch_pfn = 0x400000000
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
[    0.000000] e820 update range: 0000000090000000 - 0000000100000000 (usable) ==> (reserved)
[    0.000000] last_pfn = 0x8df5e max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [ffff8800000fdba0] fdba0
[    0.000000] initial memory mapped : 0 - 20000000
[    0.000000] Base memory trampoline at [ffff88000008a000] 8a000 size 20480
[    0.000000] Using GB pages for direct mapping
[    0.000000] init_memory_mapping: 0000000000000000-000000008df5e000
[    0.000000]  0000000000 - 0080000000 page 1G
[    0.000000]  0080000000 - 008de00000 page 2M
[    0.000000]  008de00000 - 008df5e000 page 4k
[    0.000000] kernel direct mapping tables up to 0x8df5dfff @ [mem 0x1fffd000-0x1fffffff]
[    0.000000] init_memory_mapping: 0000000100000000-0000001070000000
[    0.000000]  0100000000 - 1040000000 page 1G
[    0.000000]  1040000000 - 1070000000 page 2M
[    0.000000] kernel direct mapping tables up to 0x106fffffff @ [mem 0x8df5c000-0x8df5dfff]
[    0.000000] nmi ring buffer: 262144
[    0.000000] RAMDISK: 377da000 - 37ff0000
[    0.000000] Reserving 128MB of memory at 752MB for crashkernel (System RAM: 67328MB)
[    0.000000] ACPI: RSDP 00000000000f04a0 00024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 000000008dfc5090 0009C (v01 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI: FACP 000000008dfd1cd0 0010C (v05 ALASKA    A M I 01072009 AMI  00010013)
[    0.000000] ACPI Warning: FADT (revision 5) is longer than ACPI 2.0 version, truncating length 268 to 244 (20110413/tbfadt-288)
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
[    0.000000] SRAT: Node 0 PXM 0 0-90000000
[    0.000000] SRAT: Node 0 PXM 0 100000000-870000000
[    0.000000] SRAT: Node 1 PXM 1 870000000-1070000000
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [0,90000000) + [100000000,870000000) -> [0,870000000)
[    0.000000] Initmem setup node 0 0000000000000000-0000000870000000
[    0.000000]   NODE_DATA [000000086ffd9000 - 000000086fffffff]
[    0.000000] Initmem setup node 1 0000000870000000-0000001070000000
[    0.000000]   NODE_DATA [000000106ff98080 - 000000106ffbf07f]
[    0.000000] [ffffea001d880000-ffffea001d9fffff] potential offnode page_structs
[    0.000000]  [ffffea0000000000-ffffea001d9fffff] PMD -> [ffff88084fe00000-ffff88086bffffff] on node 0
[    0.000000]  [ffffea001da00000-ffffea00399fffff] PMD -> [ffff88104f600000-ffff88106b5fffff] on node 1
[    0.000000] Zone PFN ranges:
[    0.000000]   DMA      0x00000010 -> 0x00001000
[    0.000000]   DMA32    0x00001000 -> 0x00100000
[    0.000000]   Normal   0x00100000 -> 0x01070000
[    0.000000] Movable zone start PFN for each node
[    0.000000] early_node_map[4] active PFN ranges
[    0.000000]     0: 0x00000010 -> 0x0000008f
[    0.000000]     0: 0x00000100 -> 0x0008df5e
[    0.000000]     0: 0x00100000 -> 0x00870000
[    0.000000]     1: 0x00870000 -> 0x01070000
[    0.000000] On node 0 totalpages: 8380125
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 5 pages reserved
[    0.000000]   DMA zone: 3906 pages, LIFO batch:0
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
[    0.000000] SMP: Allowing 32 CPUs, 0 hotplug CPUs
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
[    0.000000] Allocating PCI resources starting at a0000000 (gap: a0000000:5ed1c000)
[    0.000000] Booting paravirtualized kernel on bare hardware
[    0.000000] setup_percpu: NR_CPUS:4096 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:2
[    0.000000] PERCPU: Embedded 25 pages/cpu @ffff88086fc00000 s71680 r8192 d22528 u131072
[    0.000000] pcpu-alloc: s71680 r8192 d22528 u131072 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 16 17 18 19 20 21 22 23 
[    0.000000] pcpu-alloc: [1] 08 09 10 11 12 13 14 15 24 25 26 27 28 29 30 31 
[    0.000000] Built 2 zonelists in Zone order, mobility grouping on.  Total pages: 16533080
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M showopts loglevel=8 pnp.debug=1 console=ttyS1,115200n8 
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] xsave/xrstor: enabled xstate_bv 0x7, cntxt size 0x340
[    0.000000] Checking aperture...
[    0.000000] No AGP bridge found
[    0.000000] Queued invalidation will be enabled to support x2apic and Intr-remapping.
[    0.000000] Memory: 65929500k/68943872k available (4556k kernel code, 1868940k absent, 1145432k reserved, 7590k data, 1360k init)
[    0.000000] Hierarchical RCU implementation.
[    0.000000] NR_IRQS:262400 nr_irqs:1752 16
[    0.000000] Extended CMOS year: 2000
[    0.000000] Console: colour VGA+ 80x25
[    0.000000] console [ttyS1] enabled
[    0.000000] allocated 536870912 bytes of page_cgroup
[    0.000000] please try 'cgroup_disable=memory' option if you don't want memory cgroups
[    0.000000] hpet clockevent registered
[    0.000000] Fast TSC calibration using PIT
[    0.004000] Detected 2300.102 MHz processor.
[    0.000014] Calibrating delay loop (skipped), value calculated using timer frequency.. 4600.20 BogoMIPS (lpj=9200408)
[    0.003919] pid_max: default: 32768 minimum: 301
[    0.004591] kdb version 4.4 by Keith Owens, Scott Lurndal. Copyright SGI, All Rights Reserved
[    0.007746] Security Framework initialized
[    0.008138] AppArmor: AppArmor initialized
[    0.012752] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.027402] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.034036] Mount-cache hash table entries: 256
[    0.034690] Initializing cgroup subsys cpuacct
[    0.035110] Initializing cgroup subsys memory
[    0.035539] Initializing cgroup subsys devices
[    0.035884] Initializing cgroup subsys freezer
[    0.036335] Initializing cgroup subsys net_cls
[    0.036806] Initializing cgroup subsys blkio
[    0.037206] Initializing cgroup subsys perf_event
[    0.037680] CPU: Physical Processor ID: 0
[    0.038045] CPU: Processor Core ID: 1
[    0.039282] mce: CPU supports 27 MCE banks
[    0.039696] CPU0: Thermal monitoring enabled (TM1)
[    0.040184] using mwait in idle threads.
[    0.044094] ACPI: Core revision 20110413
[    0.082207] DMAR: Host address width 46
[    0.082598] DMAR: DRHD base: 0x000000fbffe000 flags: 0x0
[    0.083628] IOMMU 0: reg_base_addr fbffe000 ver 1:0 cap d2078c106f0466 ecap f020de
[    0.084286] DMAR: DRHD base: 0x000000e7ffc000 flags: 0x1
[    0.084751] IOMMU 1: reg_base_addr e7ffc000 ver 1:0 cap d2078c106f0466 ecap f020de
[    0.085446] DMAR: RMRR base: 0x0000008f212000 end: 0x0000008f220fff
[    0.086066] DMAR: ATSR flags: 0x0
[    0.086382] DMAR: RHSA base: 0x000000fbffe000 proximity domain: 0x1
[    0.086975] DMAR: RHSA base: 0x000000e7ffc000 proximity domain: 0x0
[    0.087769] IOAPIC id 3 under DRHD base  0xfbffe000 IOMMU 0
[    0.088312] IOAPIC id 0 under DRHD base  0xe7ffc000 IOMMU 1
[    0.088819] IOAPIC id 2 under DRHD base  0xe7ffc000 IOMMU 1
[    0.089360] HPET id 0 under DRHD base 0xe7ffc000
[    0.090515] Enabled IRQ remapping in x2apic mode
[    0.093582] Enabling x2apic
[    0.093850] Enabled x2apic
[    0.094195] Switched APIC routing to cluster x2apic.
[    0.095353] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.135601] CPU0: Genuine Intel(R) CPU  @ 2.80GHz stepping 02
[    0.243045] Performance Events: PEBS fmt1+, 16-deep LBR, IvyBridge events, Intel PMU driver.
[    0.243911] ... version:                3
[    0.244212] ... bit width:              48
[    0.244638] ... generic registers:      4
[    0.245092] ... value mask:             0000ffffffffffff
[    0.245590] ... max period:             000000007fffffff
[    0.246017] ... fixed-purpose events:   3
[    0.246389] ... event mask:             000000070000000f
[    0.247691] NMI watchdog enabled, takes one hw-pmu counter.
[    0.248394] Booting Node   0, Processors  #1
[    0.283932] NMI watchdog enabled, takes one hw-pmu counter.
[    0.284696]  #2
[    0.316824] NMI watchdog enabled, takes one hw-pmu counter.
[    0.317582]  #3
[    0.349802] NMI watchdog enabled, takes one hw-pmu counter.
[    0.353379]  #4
[    0.385504] NMI watchdog enabled, takes one hw-pmu counter.
[    0.386264]  #5
[    0.418390] NMI watchdog enabled, takes one hw-pmu counter.
[    0.419150]  #6
[    0.451267] NMI watchdog enabled, takes one hw-pmu counter.
[    0.453542]  #7
[    0.485660] NMI watchdog enabled, takes one hw-pmu counter.
[    0.486791]  Ok.
[    0.487006] Booting Node   1, Processors  #8
[    0.598944] NMI watchdog enabled, takes one hw-pmu counter.
[    0.599716]  #9
[    0.632598] NMI watchdog enabled, takes one hw-pmu counter.
[    0.633460]  #10
[    0.666359] NMI watchdog enabled, takes one hw-pmu counter.
[    0.667129]  #11
[    0.700020] NMI watchdog enabled, takes one hw-pmu counter.
[    0.700771]  #12
[    0.733567] NMI watchdog enabled, takes one hw-pmu counter.
[    0.734335]  #13
[    0.767155] NMI watchdog enabled, takes one hw-pmu counter.
[    0.767905]  #14
[    0.800808] NMI watchdog enabled, takes one hw-pmu counter.
[    0.801560]  #15
[    0.834457] NMI watchdog enabled, takes one hw-pmu counter.
[    0.835176]  Ok.
[    0.835376] Booting Node   0, Processors  #16
[    0.867883] NMI watchdog enabled, takes one hw-pmu counter.
[    0.868633]  #17
[    0.900755] NMI watchdog enabled, takes one hw-pmu counter.
[    0.901505]  #18
[    0.933640] NMI watchdog enabled, takes one hw-pmu counter.
[    0.934398]  #19
[    0.966636] NMI watchdog enabled, takes one hw-pmu counter.
[    0.967521]  #20
[    0.999650] NMI watchdog enabled, takes one hw-pmu counter.
[    1.000401]  #21
[    1.032534] NMI watchdog enabled, takes one hw-pmu counter.
[    1.033280]  #22
[    1.065405] NMI watchdog enabled, takes one hw-pmu counter.
[    1.066151]  #23
[    1.098270] NMI watchdog enabled, takes one hw-pmu counter.
[    1.099082]  Ok.
[    1.099282] Booting Node   1, Processors  #24
[    1.134983] NMI watchdog enabled, takes one hw-pmu counter.
[    1.135712]  #25
[    1.168511] NMI watchdog enabled, takes one hw-pmu counter.
[    1.169243]  #26
[    1.202186] NMI watchdog enabled, takes one hw-pmu counter.
[    1.202929]  #27
[    1.235820] NMI watchdog enabled, takes one hw-pmu counter.
[    1.236559]  #28
[    1.269452] NMI watchdog enabled, takes one hw-pmu counter.
[    1.270194]  #29
[    1.302986] NMI watchdog enabled, takes one hw-pmu counter.
[    1.303723]  #30
[    1.336519] NMI watchdog enabled, takes one hw-pmu counter.
[    1.337257]  #31 Ok.
[    1.370225] NMI watchdog enabled, takes one hw-pmu counter.
[    1.370816] Brought up 32 CPUs
[    1.371111] Total of 32 processors activated (147203.36 BogoMIPS).
[    1.417965] devtmpfs: initialized
[    1.424876] PM: Registering ACPI NVS region at 8e0a4000 (2252800 bytes)
[    1.425589] PM: Registering ACPI NVS region at 8f337000 (5017600 bytes)
[    1.426871] print_constraints: dummy: 
[    1.427278] Time: 14:38:54  Date: 11/02/16
[    1.427836] NET: Registered protocol family 16
[    1.428430] ACPI: bus type pci registered
[    1.428902] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x90000000-0x9fffffff] (base 0x90000000)
[    1.432362] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved in E820
[    1.450148] PCI: Using configuration type 1 for base access
[    1.453494] bio: create slab <bio-0> at 0
[    1.464099] ACPI: EC: Look up EC in DSDT
[    1.473917] ACPI: Executed 1 blocks of module-level executable AML code
[    1.732720] \_SB_:_OSC invalid UUID
[    1.733080] _OSC request data:1 17 
[    1.739477] ACPI: Interpreter enabled
[    1.739889] ACPI: (supports S0 S4 S5)
[    1.740359] ACPI: Using IOAPIC for interrupt routing
[    1.753083] ACPI: No dock devices found.
[    1.753524] HEST: Table parsing has been initialized.
[    1.753963] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    1.755409] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    1.756576] pci_root PNP0A08:00: host bridge window [io  0x0000-0x03af]
[    1.757317] pci_root PNP0A08:00: host bridge window [io  0x03e0-0x0cf7]
[    1.757991] pci_root PNP0A08:00: host bridge window [io  0x03b0-0x03df]
[    1.758628] pci_root PNP0A08:00: host bridge window [io  0x0d00-0x9fff]
[    1.759281] pci_root PNP0A08:00: host bridge window [mem 0x000a0000-0x000bffff]
[    1.763330] pci_root PNP0A08:00: host bridge window [mem 0x000c0000-0x000dffff]
[    1.764019] pci_root PNP0A08:00: host bridge window [mem 0x90000000-0xe7ffffff]
[    1.764699] pci_root PNP0A08:00: host bridge window [mem 0x380000000000-0x380fffffffff]
[    1.765400] pci 0000:00:00.0: [8086:0e00] type 0 class 0x000600
[    1.766024] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    1.766608] pci 0000:00:00.0: PME# disabled
[    1.766966] pci 0000:00:01.0: [8086:0e02] type 1 class 0x000604
[    1.767562] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    1.768136] pci 0000:00:01.0: PME# disabled
[    1.768518] pci 0000:00:01.1: [8086:0e03] type 1 class 0x000604
[    1.769144] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    1.773905] pci 0000:00:01.1: PME# disabled
[    1.774363] pci 0000:00:02.0: [8086:0e04] type 1 class 0x000604
[    1.774957] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    1.775540] pci 0000:00:02.0: PME# disabled
[    1.775933] pci 0000:00:02.2: [8086:0e06] type 1 class 0x000604
[    1.776524] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    1.777099] pci 0000:00:02.2: PME# disabled
[    1.777504] pci 0000:00:03.0: [8086:0e08] type 1 class 0x000604
[    1.778092] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    1.778671] pci 0000:00:03.0: PME# disabled
[    1.779128] pci 0000:00:05.0: [8086:0e28] type 0 class 0x000880
[    1.783377] pci 0000:00:05.2: [8086:0e2a] type 0 class 0x000880
[    1.784012] pci 0000:00:05.4: [8086:0e2c] type 0 class 0x000800
[    1.784619] pci 0000:00:05.4: reg 10: [mem 0xe7f06000-0xe7f06fff]
[    1.785319] pci 0000:00:07.0: [8086:0e18] type 0 class 0x000880
[    1.785967] pci 0000:00:11.0: [8086:1d3e] type 1 class 0x000604
[    1.786643] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    1.787231] pci 0000:00:11.0: PME# disabled
[    1.787602] pci 0000:00:16.0: [8086:1d3a] type 0 class 0x000780
[    1.788144] pci 0000:00:16.0: reg 10: [mem 0xe7f05000-0xe7f0500f 64bit]
[    1.788789] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    1.789429] pci 0000:00:16.0: PME# disabled
[    1.792692] pci 0000:00:16.1: [8086:1d3b] type 0 class 0x000780
[    1.793239] pci 0000:00:16.1: reg 10: [mem 0xe7f04000-0xe7f0400f 64bit]
[    1.793866] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    1.794322] pci 0000:00:16.1: PME# disabled
[    1.794728] pci 0000:00:1a.0: [8086:1d2d] type 0 class 0x000c03
[    1.795249] pci 0000:00:1a.0: reg 10: [mem 0xe7f02000-0xe7f023ff]
[    1.795851] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    1.796478] pci 0000:00:1a.0: PME# disabled
[    1.796893] pci 0000:00:1c.0: [8086:1d10] type 1 class 0x000604
[    1.797434] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    1.798113] pci 0000:00:1c.0: PME# disabled
[    1.798547] pci 0000:00:1c.4: [8086:1d18] type 1 class 0x000604
[    1.799070] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    1.806339] pci 0000:00:1c.4: PME# disabled
[    1.806765] pci 0000:00:1d.0: [8086:1d26] type 0 class 0x000c03
[    1.807291] pci 0000:00:1d.0: reg 10: [mem 0xe7f01000-0xe7f013ff]
[    1.807904] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    1.808543] pci 0000:00:1d.0: PME# disabled
[    1.808965] pci 0000:00:1e.0: [8086:244e] type 1 class 0x000604
[    1.813439] pci 0000:00:1f.0: [8086:1d41] type 0 class 0x000601
[    1.814013] pci 0000:00:1f.2: [8086:1d02] type 0 class 0x000106
[    1.814627] pci 0000:00:1f.2: reg 10: [io  0x9070-0x9077]
[    1.815152] pci 0000:00:1f.2: reg 14: [io  0x9060-0x9063]
[    1.815561] pci 0000:00:1f.2: reg 18: [io  0x9050-0x9057]
[    1.816018] pci 0000:00:1f.2: reg 1c: [io  0x9040-0x9043]
[    1.816478] pci 0000:00:1f.2: reg 20: [io  0x9020-0x903f]
[    1.816947] pci 0000:00:1f.2: reg 24: [mem 0xe7f00000-0xe7f007ff]
[    1.817508] pci 0000:00:1f.2: PME# supported from D3hot
[    1.817919] pci 0000:00:1f.2: PME# disabled
[    1.818338] pci 0000:00:1f.3: [8086:1d22] type 0 class 0x000c05
[    1.818878] pci 0000:00:1f.3: reg 10: [mem 0x380ffff01000-0x380ffff010ff 64bit]
[    1.822661] pci 0000:00:1f.3: reg 20: [io  0x9000-0x901f]
[    1.823158] pci 0000:00:1f.6: [8086:1d24] type 0 class 0x001180
[    1.823664] pci 0000:00:1f.6: reg 10: [mem 0x380ffff00000-0x380ffff00fff 64bit]
[    1.824434] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    1.824939] pci 0000:00:01.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.825609] pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.826293] pci 0000:00:01.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.827048] pci 0000:00:01.1: PCI bridge to [bus 02-02]
[    1.827482] pci 0000:00:01.1:   bridge window [io  0xf000-0x0000] (disabled)
[    1.828082] pci 0000:00:01.1:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.828783] pci 0000:00:01.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.832767] pci 0000:03:00.0: [15b3:1003] type 0 class 0x000280
[    1.833601] pci 0000:03:00.0: reg 10: [mem 0xe7e00000-0xe7efffff 64bit]
[    1.834457] pci 0000:03:00.0: reg 18: [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.836786] pci 0000:00:02.0: PCI bridge to [bus 03-03]
[    1.837308] pci 0000:00:02.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.837858] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    1.838437] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    1.839242] pci 0000:00:02.2: PCI bridge to [bus 04-04]
[    1.842916] pci 0000:00:02.2:   bridge window [io  0xf000-0x0000] (disabled)
[    1.843575] pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.844324] pci 0000:00:02.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.845142] pci 0000:05:00.0: [8086:2250] type 0 class 0x000b40
[    1.845660] pci 0000:05:00.0: reg 10: [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.846348] pci 0000:05:00.0: reg 20: [mem 0xe7d00000-0xe7d1ffff 64bit]
[    1.846997] pci 0000:05:00.0: PME# supported from D0
[    1.847472] pci 0000:05:00.0: PME# disabled
[    1.854211] pci 0000:00:03.0: PCI bridge to [bus 05-05]
[    1.854744] pci 0000:00:03.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.855397] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    1.856020] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    1.856866] pci 0000:06:00.0: [8086:1d69] type 0 class 0x000107
[    1.857443] pci 0000:06:00.0: reg 10: [mem 0x380e00c7c000-0x380e00c7ffff 64bit pref]
[    1.858104] pci 0000:06:00.0: reg 18: [mem 0x380e00800000-0x380e00bfffff 64bit pref]
[    1.858822] pci 0000:06:00.0: reg 20: [io  0x8000-0x80ff]
[    1.862711] pci 0000:06:00.0: reg 164: [mem 0x380e00c00000-0x380e00c03fff 64bit pref]
[    1.863510] pci 0000:00:11.0: PCI bridge to [bus 06-06]
[    1.863893] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    1.864418] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    1.865068] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    1.865908] pci 0000:07:00.0: [8086:1523] type 0 class 0x000200
[    1.866488] pci 0000:07:00.0: reg 10: [mem 0xe7b00000-0xe7b1ffff]
[    1.866978] pci 0000:07:00.0: reg 18: [io  0x7000-0x701f]
[    1.867428] pci 0000:07:00.0: reg 1c: [mem 0xe7b20000-0xe7b23fff]
[    1.868035] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    1.868649] pci 0000:07:00.0: PME# disabled
[    1.869165] pci 0000:07:00.0: reg 184: [mem 0x380e00e20000-0x380e00e23fff 64bit pref]
[    1.872934] pci 0000:07:00.0: reg 190: [mem 0x380e00e00000-0x380e00e03fff 64bit pref]
[    1.878201] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    1.878738] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    1.882537] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    1.883158] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    1.884006] pci 0000:09:00.0: [1a03:1150] type 1 class 0x000604
[    1.884707] pci 0000:09:00.0: supports D1 D2
[    1.885134] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.885739] pci 0000:09:00.0: PME# disabled
[    1.894192] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    1.894743] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    1.895338] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.895985] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.896756] pci 0000:0a:00.0: [1a03:2000] type 0 class 0x000300
[    1.897390] pci 0000:0a:00.0: reg 10: [mem 0xe7000000-0xe77fffff pref]
[    1.898033] pci 0000:0a:00.0: reg 14: [mem 0xe7a00000-0xe7a1ffff]
[    1.898643] pci 0000:0a:00.0: reg 18: [io  0x6000-0x607f]
[    1.902759] pci 0000:0a:00.0: supports D1 D2
[    1.903169] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    1.903709] pci 0000:0a:00.0: PME# disabled
[    1.904213] pci 0000:09:00.0: PCI bridge to [bus 0a-0a]
[    1.904713] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    1.905159] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    1.905786] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    1.906564] pci 0000:00:1e.0: PCI bridge to [bus 0b-0b] (subtractive decode)
[    1.907275] pci 0000:00:1e.0:   bridge window [io  0xf000-0x0000] (disabled)
[    1.907959] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    1.908655] pci 0000:00:1e.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    1.912395] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af] (subtractive decode)
[    1.913142] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7] (subtractive decode)
[    1.913826] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df] (subtractive decode)
[    1.914543] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff] (subtractive decode)
[    1.915242] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff] (subtractive decode)
[    1.916024] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff] (subtractive decode)
[    1.916780] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xe7ffffff] (subtractive decode)
[    1.917556] pci 0000:00:1e.0:   bridge window [mem 0x380000000000-0x380fffffffff] (subtractive decode)
[    1.918391] pci_bus 0000:00: on NUMA node 0 (pxm 0)
[    1.918778] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
[    1.922777] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0P9._PRT]
[    1.923448] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.P0PA._PRT]
[    1.924061] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE1._PRT]
[    1.924708] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE2._PRT]
[    1.925322] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE3._PRT]
[    1.925966] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE5._PRT]
[    1.926559] ACPI: PCI Interrupt Routing Table [\_SB_.PCI0.NPE7._PRT]
[    1.927235]  pci0000:00: Requesting ACPI _OSC control (0x1d)
[    1.927964]  pci0000:00: ACPI _OSC control (0x1d) granted
[    1.937299] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    1.937972] pci 0000:7f:08.0: [8086:0e80] type 0 class 0x000880
[    1.938612] pci 0000:7f:08.3: [8086:0e83] type 0 class 0x000880
[    1.942486] pci 0000:7f:08.4: [8086:0e84] type 0 class 0x000880
[    1.943119] pci 0000:7f:09.0: [8086:0e90] type 0 class 0x000880
[    1.943711] pci 0000:7f:09.3: [8086:0e93] type 0 class 0x000880
[    1.944319] pci 0000:7f:09.4: [8086:0e94] type 0 class 0x000880
[    1.944916] pci 0000:7f:0a.0: [8086:0ec0] type 0 class 0x000880
[    1.945477] pci 0000:7f:0a.1: [8086:0ec1] type 0 class 0x000880
[    1.946058] pci 0000:7f:0a.2: [8086:0ec2] type 0 class 0x000880
[    1.946635] pci 0000:7f:0a.3: [8086:0ec3] type 0 class 0x000880
[    1.947196] pci 0000:7f:0b.0: [8086:0e1e] type 0 class 0x000880
[    1.947753] pci 0000:7f:0b.3: [8086:0e1f] type 0 class 0x000880
[    1.948305] pci 0000:7f:0c.0: [8086:0ee0] type 0 class 0x000880
[    1.948852] pci 0000:7f:0c.1: [8086:0ee2] type 0 class 0x000880
[    1.952383] pci 0000:7f:0c.2: [8086:0ee4] type 0 class 0x000880
[    1.952933] pci 0000:7f:0c.3: [8086:0ee6] type 0 class 0x000880
[    1.953464] pci 0000:7f:0c.4: [8086:0ee8] type 0 class 0x000880
[    1.953987] pci 0000:7f:0d.0: [8086:0ee1] type 0 class 0x000880
[    1.954504] pci 0000:7f:0d.1: [8086:0ee3] type 0 class 0x000880
[    1.955013] pci 0000:7f:0d.2: [8086:0ee5] type 0 class 0x000880
[    1.955518] pci 0000:7f:0d.3: [8086:0ee7] type 0 class 0x000880
[    1.956010] pci 0000:7f:0d.4: [8086:0ee9] type 0 class 0x000880
[    1.956588] pci 0000:7f:0e.0: [8086:0ea0] type 0 class 0x000880
[    1.957216] pci 0000:7f:0e.1: [8086:0e30] type 0 class 0x001101
[    1.957833] pci 0000:7f:0f.0: [8086:0ea8] type 0 class 0x000880
[    1.958444] pci 0000:7f:0f.1: [8086:0e71] type 0 class 0x000880
[    1.959091] pci 0000:7f:0f.2: [8086:0eaa] type 0 class 0x000880
[    1.963067] pci 0000:7f:0f.3: [8086:0eab] type 0 class 0x000880
[    1.963676] pci 0000:7f:0f.4: [8086:0eac] type 0 class 0x000880
[    1.964266] pci 0000:7f:0f.5: [8086:0ead] type 0 class 0x000880
[    1.964847] pci 0000:7f:10.0: [8086:0eb0] type 0 class 0x000880
[    1.965417] pci 0000:7f:10.1: [8086:0eb1] type 0 class 0x000880
[    1.965985] pci 0000:7f:10.2: [8086:0eb2] type 0 class 0x000880
[    1.966545] pci 0000:7f:10.3: [8086:0eb3] type 0 class 0x000880
[    1.967093] pci 0000:7f:10.4: [8086:0eb4] type 0 class 0x000880
[    1.967684] pci 0000:7f:10.5: [8086:0eb5] type 0 class 0x000880
[    1.968391] pci 0000:7f:10.6: [8086:0eb6] type 0 class 0x000880
[    1.969018] pci 0000:7f:10.7: [8086:0eb7] type 0 class 0x000880
[    1.973686] pci 0000:7f:13.0: [8086:0e1d] type 0 class 0x000880
[    1.974206] pci 0000:7f:13.1: [8086:0e34] type 0 class 0x001101
[    1.974724] pci 0000:7f:13.4: [8086:0e81] type 0 class 0x000880
[    1.975232] pci 0000:7f:13.5: [8086:0e36] type 0 class 0x001101
[    1.975743] pci 0000:7f:16.0: [8086:0ec8] type 0 class 0x000880
[    1.976234] pci 0000:7f:16.1: [8086:0ec9] type 0 class 0x000880
[    1.976812] pci 0000:7f:16.2: [8086:0eca] type 0 class 0x000880
[    1.977440] pci_bus 0000:7f: on NUMA node 0 (pxm 0)
[    1.977912]  pci0000:7f: Requesting ACPI _OSC control (0x1d)
[    1.978346]  pci0000:7f: ACPI _OSC control (0x1d) granted
[    1.979936] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    1.985805] pci_root PNP0A08:01: host bridge window [io  0xa000-0xffff]
[    1.987422] pci_root PNP0A08:01: host bridge window [mem 0xe8000000-0xfbffffff]
[    1.992408] pci_root PNP0A08:01: host bridge window [mem 0x381000000000-0x381fffffffff]
[    1.993566] pci 0000:80:00.0: [8086:0e01] type 1 class 0x000604
[    1.994230] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    1.995448] pci 0000:80:00.0: PME# disabled
[    1.995879] pci 0000:80:01.0: [8086:0e02] type 1 class 0x000604
[    1.996657] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    1.997125] pci 0000:80:01.0: PME# disabled
[    1.997550] pci 0000:80:01.1: [8086:0e03] type 1 class 0x000604
[    1.998131] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
[    1.998641] pci 0000:80:01.1: PME# disabled
[    1.999126] pci 0000:80:02.0: [8086:0e04] type 1 class 0x000604
[    2.002633] pci 0000:80:02.0: PME# supported from D0 D3hot D3cold
[    2.003213] pci 0000:80:02.0: PME# disabled
[    2.003625] pci 0000:80:02.2: [8086:0e06] type 1 class 0x000604
[    2.004224] pci 0000:80:02.2: PME# supported from D0 D3hot D3cold
[    2.004802] pci 0000:80:02.2: PME# disabled
[    2.005188] pci 0000:80:03.0: [8086:0e08] type 1 class 0x000604
[    2.005770] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    2.006350] pci 0000:80:03.0: PME# disabled
[    2.006739] pci 0000:80:05.0: [8086:0e28] type 0 class 0x000880
[    2.007330] pci 0000:80:05.2: [8086:0e2a] type 0 class 0x000880
[    2.008020] pci 0000:80:05.4: [8086:0e2c] type 0 class 0x000800
[    2.008585] pci 0000:80:05.4: reg 10: [mem 0xfbf00000-0xfbf00fff]
[    2.009239] pci 0000:80:07.0: [8086:0e18] type 0 class 0x000880
[    2.012789] pci 0000:80:00.0: PCI bridge to [bus 81-81]
[    2.013289] pci 0000:80:00.0:   bridge window [io  0xf000-0x0000] (disabled)
[    2.013892] pci 0000:80:00.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    2.014637] pci 0000:80:00.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    2.015439] pci 0000:80:01.0: PCI bridge to [bus 82-82]
[    2.015912] pci 0000:80:01.0:   bridge window [io  0xf000-0x0000] (disabled)
[    2.016550] pci 0000:80:01.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    2.017292] pci 0000:80:01.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    2.018096] pci 0000:80:01.1: PCI bridge to [bus 83-83]
[    2.018575] pci 0000:80:01.1:   bridge window [io  0xf000-0x0000] (disabled)
[    2.022602] pci 0000:80:01.1:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    2.023276] pci 0000:80:01.1:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    2.024032] pci 0000:80:02.0: PCI bridge to [bus 84-84]
[    2.024516] pci 0000:80:02.0:   bridge window [io  0xf000-0x0000] (disabled)
[    2.025162] pci 0000:80:02.0:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    2.025821] pci 0000:80:02.0:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    2.026582] pci 0000:80:02.2: PCI bridge to [bus 85-85]
[    2.027056] pci 0000:80:02.2:   bridge window [io  0xf000-0x0000] (disabled)
[    2.027705] pci 0000:80:02.2:   bridge window [mem 0xfff00000-0x000fffff] (disabled)
[    2.028366] pci 0000:80:02.2:   bridge window [mem 0xfff00000-0x000fffff pref] (disabled)
[    2.032101] pci 0000:86:00.0: [8086:2250] type 0 class 0x000b40
[    2.032632] pci 0000:86:00.0: reg 10: [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    2.033324] pci 0000:86:00.0: reg 20: [mem 0xfbe00000-0xfbe1ffff 64bit]
[    2.033899] pci 0000:86:00.0: PME# supported from D0
[    2.034285] pci 0000:86:00.0: PME# disabled
[    2.034791] pci 0000:80:03.0: PCI bridge to [bus 86-86]
[    2.035288] pci 0000:80:03.0:   bridge window [io  0xf000-0x0000] (disabled)
[    2.035868] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    2.036446] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    2.037215] pci_bus 0000:80: on NUMA node 1 (pxm 1)
[    2.037689] ACPI: PCI Interrupt Routing Table [\_SB_.PCI1._PRT]
[    2.038492]  pci0000:80: Requesting ACPI _OSC control (0x1d)
[    2.039289]  pci0000:80: ACPI _OSC control (0x1d) granted
[    2.044213] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    2.044869] pci 0000:ff:08.0: [8086:0e80] type 0 class 0x000880
[    2.045468] pci 0000:ff:08.3: [8086:0e83] type 0 class 0x000880
[    2.046072] pci 0000:ff:08.4: [8086:0e84] type 0 class 0x000880
[    2.046746] pci 0000:ff:09.0: [8086:0e90] type 0 class 0x000880
[    2.047343] pci 0000:ff:09.3: [8086:0e93] type 0 class 0x000880
[    2.047998] pci 0000:ff:09.4: [8086:0e94] type 0 class 0x000880
[    2.048610] pci 0000:ff:0a.0: [8086:0ec0] type 0 class 0x000880
[    2.049279] pci 0000:ff:0a.1: [8086:0ec1] type 0 class 0x000880
[    2.052865] pci 0000:ff:0a.2: [8086:0ec2] type 0 class 0x000880
[    2.053488] pci 0000:ff:0a.3: [8086:0ec3] type 0 class 0x000880
[    2.054105] pci 0000:ff:0b.0: [8086:0e1e] type 0 class 0x000880
[    2.054703] pci 0000:ff:0b.3: [8086:0e1f] type 0 class 0x000880
[    2.055304] pci 0000:ff:0c.0: [8086:0ee0] type 0 class 0x000880
[    2.055895] pci 0000:ff:0c.1: [8086:0ee2] type 0 class 0x000880
[    2.056482] pci 0000:ff:0c.2: [8086:0ee4] type 0 class 0x000880
[    2.057059] pci 0000:ff:0c.3: [8086:0ee6] type 0 class 0x000880
[    2.057632] pci 0000:ff:0c.4: [8086:0ee8] type 0 class 0x000880
[    2.058204] pci 0000:ff:0d.0: [8086:0ee1] type 0 class 0x000880
[    2.058754] pci 0000:ff:0d.1: [8086:0ee3] type 0 class 0x000880
[    2.062251] pci 0000:ff:0d.2: [8086:0ee5] type 0 class 0x000880
[    2.062816] pci 0000:ff:0d.3: [8086:0ee7] type 0 class 0x000880
[    2.063365] pci 0000:ff:0d.4: [8086:0ee9] type 0 class 0x000880
[    2.063906] pci 0000:ff:0e.0: [8086:0ea0] type 0 class 0x000880
[    2.064446] pci 0000:ff:0e.1: [8086:0e30] type 0 class 0x001101
[    2.064975] pci 0000:ff:0f.0: [8086:0ea8] type 0 class 0x000880
[    2.065494] pci 0000:ff:0f.1: [8086:0e71] type 0 class 0x000880
[    2.066003] pci 0000:ff:0f.2: [8086:0eaa] type 0 class 0x000880
[    2.066508] pci 0000:ff:0f.3: [8086:0eab] type 0 class 0x000880
[    2.067002] pci 0000:ff:0f.4: [8086:0eac] type 0 class 0x000880
[    2.067493] pci 0000:ff:0f.5: [8086:0ead] type 0 class 0x000880
[    2.068056] pci 0000:ff:10.0: [8086:0eb0] type 0 class 0x000880
[    2.068661] pci 0000:ff:10.1: [8086:0eb1] type 0 class 0x000880
[    2.072294] pci 0000:ff:10.2: [8086:0eb2] type 0 class 0x000880
[    2.072904] pci 0000:ff:10.3: [8086:0eb3] type 0 class 0x000880
[    2.073512] pci 0000:ff:10.4: [8086:0eb4] type 0 class 0x000880
[    2.074175] pci 0000:ff:10.5: [8086:0eb5] type 0 class 0x000880
[    2.074781] pci 0000:ff:10.6: [8086:0eb6] type 0 class 0x000880
[    2.075426] pci 0000:ff:10.7: [8086:0eb7] type 0 class 0x000880
[    2.076029] pci 0000:ff:13.0: [8086:0e1d] type 0 class 0x000880
[    2.076616] pci 0000:ff:13.1: [8086:0e34] type 0 class 0x001101
[    2.077266] pci 0000:ff:13.4: [8086:0e81] type 0 class 0x000880
[    2.077882] pci 0000:ff:13.5: [8086:0e36] type 0 class 0x001101
[    2.078501] pci 0000:ff:16.0: [8086:0ec8] type 0 class 0x000880
[    2.082244] pci 0000:ff:16.1: [8086:0ec9] type 0 class 0x000880
[    2.082859] pci 0000:ff:16.2: [8086:0eca] type 0 class 0x000880
[    2.083466] pci_bus 0000:ff: on NUMA node 1 (pxm 1)
[    2.083955]  pci0000:ff: Requesting ACPI _OSC control (0x1d)
[    2.084548]  pci0000:ff: ACPI _OSC control (0x1d) granted
[    2.086004] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    2.086828] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    2.087636] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    2.088411] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    2.089231] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    2.092793] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    2.093601] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    2.094420] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    2.095253] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
[    2.096067] vgaarb: loaded
[    2.096382] PCI: Using ACPI for IRQ routing
[    2.101311] PCI: pci_cache_line_size set to 64 bytes
[    2.102125] reserve RAM buffer: 000000000008f000 - 000000000008ffff 
[    2.102768] reserve RAM buffer: 000000008df5e000 - 000000008fffffff 
[    2.103509] NetLabel: Initializing
[    2.103855] NetLabel:  domain hash size = 128
[    2.104254] NetLabel:  protocols = UNLABELED CIPSOv4
[    2.104804] NetLabel:  unlabeled traffic allowed by default
[    2.105399] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    2.106067] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    2.109692] Switching to clocksource hpet
[    2.111885] AppArmor: AppArmor Filesystem Enabled
[    2.112936] pnp: PnP ACPI init
[    2.113272] ACPI: bus type pnp registered
[    2.114027] pnp 00:00: [bus 00-7e]
[    2.114409] pnp 00:00: [io  0x0cf8-0x0cff]
[    2.114811] pnp 00:00: [io  0x0000-0x03af window]
[    2.115218] pnp 00:00: [io  0x03e0-0x0cf7 window]
[    2.115717] pnp 00:00: [io  0x03b0-0x03df window]
[    2.116219] pnp 00:00: [io  0x0d00-0x9fff window]
[    2.116679] pnp 00:00: [mem 0x000a0000-0x000bffff window]
[    2.117105] pnp 00:00: [mem 0x000c0000-0x000dffff window]
[    2.117574] pnp 00:00: [mem 0x90000000-0xe7ffffff window]
[    2.118047] pnp 00:00: [mem 0x380000000000-0x380fffffffff window]
[    2.118694] pnp 00:00: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    2.122295] pnp 00:01: [mem 0xfc000000-0xfcffffff]
[    2.122825] pnp 00:01: [mem 0xfd000000-0xfdffffff]
[    2.123296] pnp 00:01: [mem 0xfe000000-0xfeafffff]
[    2.123688] pnp 00:01: [mem 0xfeb00000-0xfebfffff]
[    2.124125] pnp 00:01: [mem 0xfed00400-0xfed3ffff]
[    2.124585] pnp 00:01: [mem 0xfed45000-0xfedfffff]
[    2.125203] system 00:01: [mem 0xfc000000-0xfcffffff] has been reserved
[    2.125865] system 00:01: [mem 0xfd000000-0xfdffffff] has been reserved
[    2.126369] system 00:01: [mem 0xfe000000-0xfeafffff] has been reserved
[    2.127007] system 00:01: [mem 0xfeb00000-0xfebfffff] has been reserved
[    2.127671] system 00:01: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    2.128323] system 00:01: [mem 0xfed45000-0xfedfffff] has been reserved
[    2.128970] system 00:01: Plug and Play ACPI device, IDs PNP0c01 (active)
[    2.132558] pnp 00:02: [mem 0xe7ffc000-0xe7ffdfff]
[    2.133019] system 00:02: [mem 0xe7ffc000-0xe7ffdfff] has been reserved
[    2.133689] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.134427] pnp 00:03: [io  0x0000-0xffffffffffffffff disabled]
[    2.135014] pnp 00:03: [io  0x0a00-0x0a1f]
[    2.135497] system 00:03: [io  0x0a00-0x0a1f] has been reserved
[    2.136085] system 00:03: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.136899] pnp 00:04: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    2.137581] pnp 00:05: [dma 4]
[    2.137882] pnp 00:05: [io  0x0000-0x000f]
[    2.138323] pnp 00:05: [io  0x0081-0x0083]
[    2.138725] pnp 00:05: [io  0x0087]
[    2.142190] pnp 00:05: [io  0x0089-0x008b]
[    2.142651] pnp 00:05: [io  0x008f]
[    2.142996] pnp 00:05: [io  0x00c0-0x00df]
[    2.143397] pnp 00:05: Plug and Play ACPI device, IDs PNP0200 (active)
[    2.143990] pnp 00:06: [io  0x0070-0x0071]
[    2.144415] pnp 00:06: [irq 8]
[    2.144734] pnp 00:06: Plug and Play ACPI device, IDs PNP0b00 (active)
[    2.145310] pnp 00:07: [io  0x0061]
[    2.145677] pnp 00:07: Plug and Play ACPI device, IDs PNP0800 (active)
[    2.146340] pnp 00:08: [io  0x0010-0x001f]
[    2.146645] pnp 00:08: [io  0x0022-0x003f]
[    2.147062] pnp 00:08: [io  0x0044-0x005f]
[    2.147522] pnp 00:08: [io  0x0062-0x0063]
[    2.147931] pnp 00:08: [io  0x0065-0x006f]
[    2.148283] pnp 00:08: [io  0x0072-0x007f]
[    2.148715] pnp 00:08: [io  0x0080]
[    2.149129] pnp 00:08: [io  0x0084-0x0086]
[    2.152577] pnp 00:08: [io  0x0088]
[    2.152969] pnp 00:08: [io  0x008c-0x008e]
[    2.153373] pnp 00:08: [io  0x0090-0x009f]
[    2.153719] pnp 00:08: [io  0x00a2-0x00bf]
[    2.154139] pnp 00:08: [io  0x00e0-0x00ef]
[    2.154592] pnp 00:08: [io  0x04d0-0x04d1]
[    2.155083] system 00:08: [io  0x04d0-0x04d1] has been reserved
[    2.155668] system 00:08: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.156337] pnp 00:09: [io  0x00f0-0x00ff]
[    2.156705] pnp 00:09: [irq 13]
[    2.157099] pnp 00:09: Plug and Play ACPI device, IDs PNP0c04 (active)
[    2.157847] pnp 00:0a: [io  0x0ca2]
[    2.158209] pnp 00:0a: [io  0x0ca3]
[    2.158576] pnp 00:0a: Plug and Play ACPI device, IDs IPI0001 (active)
[    2.159490] pnp 00:0b: [io  0x0400-0x0453]
[    2.162520] pnp 00:0b: [io  0x0458-0x047f]
[    2.162960] pnp 00:0b: [io  0x1180-0x119f]
[    2.163432] pnp 00:0b: [io  0x0500-0x057f]
[    2.163836] pnp 00:0b: [mem 0xfed1c000-0xfed1ffff]
[    2.164250] pnp 00:0b: [mem 0xfec00000-0xfecfffff]
[    2.164718] pnp 00:0b: [mem 0xfed08000-0xfed08fff]
[    2.165210] pnp 00:0b: [mem 0xff000000-0xffffffff]
[    2.165808] system 00:0b: [io  0x0400-0x0453] has been reserved
[    2.166387] system 00:0b: [io  0x0458-0x047f] has been reserved
[    2.166967] system 00:0b: [io  0x1180-0x119f] has been reserved
[    2.167452] system 00:0b: [io  0x0500-0x057f] has been reserved
[    2.167975] system 00:0b: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    2.168523] system 00:0b: [mem 0xfec00000-0xfecfffff] could not be reserved
[    2.172316] system 00:0b: [mem 0xfed08000-0xfed08fff] has been reserved
[    2.172975] system 00:0b: [mem 0xff000000-0xffffffff] has been reserved
[    2.173598] system 00:0b: Plug and Play ACPI device, IDs PNP0c01 (active)
[    2.174256] pnp 00:0c: [io  0x0454-0x0457]
[    2.174685] system 00:0c: [io  0x0454-0x0457] has been reserved
[    2.175282] system 00:0c: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    2.176182] pnp 00:0d: [mem 0xfed00000-0xfed003ff]
[    2.176704] pnp 00:0d: Plug and Play ACPI device, IDs PNP0103 (active)
[    2.177404] pnp 00:0e: [bus 7f]
[    2.177760] pnp 00:0e: Plug and Play ACPI device, IDs PNP0a03 (active)
[    2.178620] pnp 00:0f: [bus 80-fe]
[    2.179024] pnp 00:0f: [io  0x0000 window]
[    2.179429] pnp 00:0f: [io  0xa000-0xffff window]
[    2.182621] pnp 00:0f: [mem 0x00000000 window]
[    2.183064] pnp 00:0f: [mem 0xe8000000-0xfbffffff window]
[    2.183602] pnp 00:0f: [mem 0x381000000000-0x381fffffffff window]
[    2.184235] pnp 00:0f: Plug and Play ACPI device, IDs PNP0a08 PNP0a03 (active)
[    2.185039] system 00:10: Plug and Play ACPI device, IDs PNP0c01 (active)
[    2.185757] pnp 00:11: [mem 0xfbffe000-0xfbffffff]
[    2.186320] system 00:11: [mem 0xfbffe000-0xfbffffff] has been reserved
[    2.186985] system 00:11: Plug and Play ACPI device, IDs PNP0c02 (active)
[    2.187548] pnp 00:12: [bus ff]
[    2.187835] pnp 00:12: Plug and Play ACPI device, IDs PNP0a03 (active)
[    2.188979] pnp: PnP ACPI: found 19 devices
[    2.189422] ACPI: ACPI bus type pnp unregistered
[    2.198375] PCI: max bus depth: 2 pci_try_num: 3
[    2.199017] pci 0000:00:01.0: PCI bridge to [bus 01-01]
[    2.202451] pci 0000:00:01.0:   bridge window [io  disabled]
[    2.203022] pci 0000:00:01.0:   bridge window [mem disabled]
[    2.203592] pci 0000:00:01.0:   bridge window [mem pref disabled]
[    2.204176] pci 0000:00:01.1: PCI bridge to [bus 02-02]
[    2.204693] pci 0000:00:01.1:   bridge window [io  disabled]
[    2.205254] pci 0000:00:01.1:   bridge window [mem disabled]
[    2.205811] pci 0000:00:01.1:   bridge window [mem pref disabled]
[    2.206400] pci 0000:00:02.0: PCI bridge to [bus 03-03]
[    2.206913] pci 0000:00:02.0:   bridge window [io  disabled]
[    2.207474] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    2.208112] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    2.211875] pci 0000:00:02.2: PCI bridge to [bus 04-04]
[    2.212398] pci 0000:00:02.2:   bridge window [io  disabled]
[    2.212818] pci 0000:00:02.2:   bridge window [mem disabled]
[    2.213293] pci 0000:00:02.2:   bridge window [mem pref disabled]
[    2.213885] pci 0000:00:03.0: PCI bridge to [bus 05-05]
[    2.214394] pci 0000:00:03.0:   bridge window [io  disabled]
[    2.214826] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    2.215460] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    2.216231] pci 0000:00:11.0: PCI bridge to [bus 06-06]
[    2.216703] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    2.217259] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    2.217843] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    2.218598] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    2.222123] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    2.222732] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    2.223368] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    2.224179] pci 0000:09:00.0: PCI bridge to [bus 0a-0a]
[    2.224690] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    2.225231] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    2.225905] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    2.226618] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    2.227100] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    2.227667] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    2.228247] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    2.232124] pci 0000:00:1e.0: PCI bridge to [bus 0b-0b]
[    2.232683] pci 0000:00:1e.0:   bridge window [io  disabled]
[    2.233281] pci 0000:00:1e.0:   bridge window [mem disabled]
[    2.233879] pci 0000:00:1e.0:   bridge window [mem pref disabled]
[    2.234509] pci 0000:80:00.0: PCI bridge to [bus 81-81]
[    2.235057] pci 0000:80:00.0:   bridge window [io  disabled]
[    2.235659] pci 0000:80:00.0:   bridge window [mem disabled]
[    2.236243] pci 0000:80:00.0:   bridge window [mem pref disabled]
[    2.236866] pci 0000:80:01.0: PCI bridge to [bus 82-82]
[    2.237413] pci 0000:80:01.0:   bridge window [io  disabled]
[    2.238008] pci 0000:80:01.0:   bridge window [mem disabled]
[    2.238598] pci 0000:80:01.0:   bridge window [mem pref disabled]
[    2.242141] pci 0000:80:01.1: PCI bridge to [bus 83-83]
[    2.242699] pci 0000:80:01.1:   bridge window [io  disabled]
[    2.243300] pci 0000:80:01.1:   bridge window [mem disabled]
[    2.243903] pci 0000:80:01.1:   bridge window [mem pref disabled]
[    2.244520] pci 0000:80:02.0: PCI bridge to [bus 84-84]
[    2.245071] pci 0000:80:02.0:   bridge window [io  disabled]
[    2.245665] pci 0000:80:02.0:   bridge window [mem disabled]
[    2.246257] pci 0000:80:02.0:   bridge window [mem pref disabled]
[    2.246879] pci 0000:80:02.2: PCI bridge to [bus 85-85]
[    2.247429] pci 0000:80:02.2:   bridge window [io  disabled]
[    2.248034] pci 0000:80:02.2:   bridge window [mem disabled]
[    2.248618] pci 0000:80:02.2:   bridge window [mem pref disabled]
[    2.252217] pci 0000:80:03.0: PCI bridge to [bus 86-86]
[    2.252774] pci 0000:80:03.0:   bridge window [io  disabled]
[    2.253374] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    2.254041] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    2.254814] pci 0000:00:01.0: PCI INT A -> GSI 26 (level, low) -> IRQ 26
[    2.255355] pci 0000:00:01.0: setting latency timer to 64
[    2.255803] pci 0000:00:01.1: PCI INT A -> GSI 26 (level, low) -> IRQ 26
[    2.256422] pci 0000:00:01.1: setting latency timer to 64
[    2.257010] pci 0000:00:02.0: PCI INT A -> GSI 32 (level, low) -> IRQ 32
[    2.257655] pci 0000:00:02.0: setting latency timer to 64
[    2.258211] pci 0000:00:02.2: PCI INT A -> GSI 32 (level, low) -> IRQ 32
[    2.258900] pci 0000:00:02.2: setting latency timer to 64
[    2.262526] pci 0000:00:03.0: PCI INT A -> GSI 47 (level, low) -> IRQ 47
[    2.263150] pci 0000:00:03.0: setting latency timer to 64
[    2.263693] pci 0000:00:11.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.264287] pci 0000:00:11.0: setting latency timer to 64
[    2.264793] pci 0000:00:1c.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.265371] pci 0000:00:1c.0: setting latency timer to 64
[    2.265848] pci 0000:00:1c.4: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.266413] pci 0000:00:1c.4: setting latency timer to 64
[    2.266872] pci 0000:09:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    2.267499] pci 0000:09:00.0: setting latency timer to 64
[    2.268083] pci 0000:00:1e.0: setting latency timer to 64
[    2.268665] pci 0000:80:00.0: PCI INT A -> GSI 48 (level, low) -> IRQ 48
[    2.272244] pci 0000:80:00.0: setting latency timer to 64
[    2.272830] pci 0000:80:01.0: PCI INT A -> GSI 50 (level, low) -> IRQ 50
[    2.273476] pci 0000:80:01.0: setting latency timer to 64
[    2.274021] pci 0000:80:01.1: PCI INT A -> GSI 50 (level, low) -> IRQ 50
[    2.274658] pci 0000:80:01.1: setting latency timer to 64
[    2.275199] pci 0000:80:02.0: PCI INT A -> GSI 56 (level, low) -> IRQ 56
[    2.275814] pci 0000:80:02.0: setting latency timer to 64
[    2.276311] pci 0000:80:02.2: PCI INT A -> GSI 56 (level, low) -> IRQ 56
[    2.276909] pci 0000:80:02.2: setting latency timer to 64
[    2.277403] pci 0000:80:03.0: PCI INT A -> GSI 64 (level, low) -> IRQ 64
[    2.277971] pci 0000:80:03.0: setting latency timer to 64
[    2.278437] pci_bus 0000:00: resource 4 [io  0x0000-0x03af]
[    2.278960] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7]
[    2.282605] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df]
[    2.283107] pci_bus 0000:00: resource 7 [io  0x0d00-0x9fff]
[    2.283603] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff]
[    2.284138] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff]
[    2.284662] pci_bus 0000:00: resource 10 [mem 0x90000000-0xe7ffffff]
[    2.285252] pci_bus 0000:00: resource 11 [mem 0x380000000000-0x380fffffffff]
[    2.285934] pci_bus 0000:03: resource 1 [mem 0xe7e00000-0xe7efffff]
[    2.286529] pci_bus 0000:03: resource 2 [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    2.287217] pci_bus 0000:05: resource 1 [mem 0xe7d00000-0xe7dfffff]
[    2.287749] pci_bus 0000:05: resource 2 [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    2.288593] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
[    2.292302] pci_bus 0000:06: resource 1 [mem 0xe7c00000-0xe7cfffff]
[    2.292911] pci_bus 0000:06: resource 2 [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    2.293604] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    2.294087] pci_bus 0000:07: resource 1 [mem 0xe7b00000-0xe7bfffff]
[    2.294613] pci_bus 0000:07: resource 2 [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    2.295322] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    2.295879] pci_bus 0000:09: resource 1 [mem 0xe7a00000-0xe7afffff]
[    2.296467] pci_bus 0000:09: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    2.297111] pci_bus 0000:0a: resource 0 [io  0x6000-0x6fff]
[    2.297610] pci_bus 0000:0a: resource 1 [mem 0xe7a00000-0xe7afffff]
[    2.298155] pci_bus 0000:0a: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    2.301766] pci_bus 0000:0b: resource 4 [io  0x0000-0x03af]
[    2.302369] pci_bus 0000:0b: resource 5 [io  0x03e0-0x0cf7]
[    2.302964] pci_bus 0000:0b: resource 6 [io  0x03b0-0x03df]
[    2.303571] pci_bus 0000:0b: resource 7 [io  0x0d00-0x9fff]
[    2.304158] pci_bus 0000:0b: resource 8 [mem 0x000a0000-0x000bffff]
[    2.304805] pci_bus 0000:0b: resource 9 [mem 0x000c0000-0x000dffff]
[    2.305433] pci_bus 0000:0b: resource 10 [mem 0x90000000-0xe7ffffff]
[    2.306054] pci_bus 0000:0b: resource 11 [mem 0x380000000000-0x380fffffffff]
[    2.306699] pci_bus 0000:80: resource 4 [io  0xa000-0xffff]
[    2.307214] pci_bus 0000:80: resource 5 [mem 0xe8000000-0xfbffffff]
[    2.307783] pci_bus 0000:80: resource 6 [mem 0x381000000000-0x381fffffffff]
[    2.308364] pci_bus 0000:86: resource 1 [mem 0xfbe00000-0xfbefffff]
[    2.311980] pci_bus 0000:86: resource 2 [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    2.313131] NET: Registered protocol family 2
[    2.314114] IP route cache hash table entries: 524288 (order: 10, 4194304 bytes)
[    2.316930] TCP established hash table entries: 524288 (order: 11, 8388608 bytes)
[    2.319110] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    2.322732] TCP: Hash tables configured (established 524288 bind 65536)
[    2.323398] TCP reno registered
[    2.323770] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    2.324620] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    2.326012] NET: Registered protocol family 1
[    2.326502] pci 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    2.345994] pci 0000:00:1a.0: PCI INT A disabled
[    2.346504] pci 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    2.367543] pci 0000:00:1d.0: PCI INT A disabled
[    2.393463] pci 0000:0a:00.0: Boot video device
[    2.394713] PCI: CLS 64 bytes, default 64
[    2.395157] Unpacking initramfs...
[    2.528157] Freeing initrd memory: 8280k freed
[    2.529962] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    2.532134] Placing 64MB software IO TLB between ffff880089f5c000 - ffff88008df5c000
[    2.532847] software IO TLB at phys 0x89f5c000 - 0x8df5c000
[    2.536552] futex hash table entries: 8192 (order: 8, 1048576 bytes)
[    2.537349] Initialise module verification
[    2.538030] audit: initializing netlink socket (disabled)
[    2.538581] type=2000 audit(1478097533.852:1): initialized
[    2.564603] bounce pool size: 64 pages
[    2.565023] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    2.572271] VFS: Disk quotas dquot_6.5.2
[    2.572804] Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    2.573696] msgmni has been set to 32196
[    2.574506] alg: No test for stdrng (krng)
[    2.574928] Asymmetric key parser 'x509' registered
[    2.575478] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 252)
[    2.576292] io scheduler noop registered
[    2.576703] io scheduler deadline registered
[    2.577244] io scheduler cfq registered (default)
[    2.578154] pcieport 0000:00:01.0: setting latency timer to 64
[    2.578838] pcieport 0000:00:01.0: irq 90 for MSI/MSI-X
[    2.582245] pcieport 0000:00:01.1: setting latency timer to 64
[    2.582878] pcieport 0000:00:01.1: irq 91 for MSI/MSI-X
[    2.583475] pcieport 0000:00:02.0: setting latency timer to 64
[    2.584084] pcieport 0000:00:02.0: irq 92 for MSI/MSI-X
[    2.584679] pcieport 0000:00:02.2: setting latency timer to 64
[    2.585271] pcieport 0000:00:02.2: irq 93 for MSI/MSI-X
[    2.585863] pcieport 0000:00:03.0: setting latency timer to 64
[    2.586451] pcieport 0000:00:03.0: irq 94 for MSI/MSI-X
[    2.587042] pcieport 0000:00:11.0: setting latency timer to 64
[    2.587659] pcieport 0000:00:11.0: irq 95 for MSI/MSI-X
[    2.588265] pcieport 0000:00:1c.0: setting latency timer to 64
[    2.588928] pcieport 0000:00:1c.0: irq 96 for MSI/MSI-X
[    2.592327] pcieport 0000:00:1c.4: setting latency timer to 64
[    2.592945] pcieport 0000:00:1c.4: irq 97 for MSI/MSI-X
[    2.593583] pcieport 0000:80:00.0: setting latency timer to 64
[    2.594225] pcieport 0000:80:00.0: irq 98 for MSI/MSI-X
[    2.594837] pcieport 0000:80:01.0: setting latency timer to 64
[    2.595453] pcieport 0000:80:01.0: irq 99 for MSI/MSI-X
[    2.596050] pcieport 0000:80:01.1: setting latency timer to 64
[    2.596661] pcieport 0000:80:01.1: irq 100 for MSI/MSI-X
[    2.597262] pcieport 0000:80:02.0: setting latency timer to 64
[    2.597871] pcieport 0000:80:02.0: irq 101 for MSI/MSI-X
[    2.598478] pcieport 0000:80:02.2: setting latency timer to 64
[    2.599152] pcieport 0000:80:02.2: irq 102 for MSI/MSI-X
[    2.602659] pcieport 0000:80:03.0: setting latency timer to 64
[    2.603329] pcieport 0000:80:03.0: irq 103 for MSI/MSI-X
[    2.603971] aer 0000:00:01.0:pcie02: service driver aer loaded
[    2.604592] aer 0000:00:01.1:pcie02: service driver aer loaded
[    2.605195] aer 0000:00:02.0:pcie02: service driver aer loaded
[    2.605661] aer 0000:00:02.2:pcie02: service driver aer loaded
[    2.606148] aer 0000:00:03.0:pcie02: service driver aer loaded
[    2.606728] aer 0000:00:11.0:pcie02: service driver aer loaded
[    2.607332] aer 0000:80:00.0:pcie02: service driver aer loaded
[    2.607965] aer 0000:80:01.0:pcie02: service driver aer loaded
[    2.608577] aer 0000:80:01.1:pcie02: service driver aer loaded
[    2.612144] aer 0000:80:02.0:pcie02: service driver aer loaded
[    2.612762] aer 0000:80:02.2:pcie02: service driver aer loaded
[    2.613367] aer 0000:80:03.0:pcie02: service driver aer loaded
[    2.613956] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    2.614603] pcie_pme 0000:00:01.0:pcie01: service driver pcie_pme loaded
[    2.615222] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    2.615819] pcie_pme 0000:00:01.1:pcie01: service driver pcie_pme loaded
[    2.616462] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    2.617143] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    2.617767] pcie_pme 0000:00:02.0:pcie01: service driver pcie_pme loaded
[    2.618388] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    2.622807] pcie_pme 0000:00:02.2:pcie01: service driver pcie_pme loaded
[    2.623514] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    2.624273] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    2.625048] pcie_pme 0000:00:03.0:pcie01: service driver pcie_pme loaded
[    2.625687] pcieport 0000:00:11.0: Signaling PME through PCIe PME interrupt
[    2.626292] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    2.626846] pcie_pme 0000:00:11.0:pcie01: service driver pcie_pme loaded
[    2.627471] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    2.628120] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    2.628775] pcie_pme 0000:00:1c.0:pcie01: service driver pcie_pme loaded
[    2.632761] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    2.633348] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    2.633971] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    2.634628] pcie_pme 0000:00:1c.4:pcie01: service driver pcie_pme loaded
[    2.635269] pcieport 0000:80:00.0: Signaling PME through PCIe PME interrupt
[    2.635893] pcie_pme 0000:80:00.0:pcie01: service driver pcie_pme loaded
[    2.636477] pcieport 0000:80:01.0: Signaling PME through PCIe PME interrupt
[    2.637124] pcie_pme 0000:80:01.0:pcie01: service driver pcie_pme loaded
[    2.637791] pcieport 0000:80:01.1: Signaling PME through PCIe PME interrupt
[    2.638436] pcie_pme 0000:80:01.1:pcie01: service driver pcie_pme loaded
[    2.644404] pcieport 0000:80:02.0: Signaling PME through PCIe PME interrupt
[    2.645001] pcie_pme 0000:80:02.0:pcie01: service driver pcie_pme loaded
[    2.645649] pcieport 0000:80:02.2: Signaling PME through PCIe PME interrupt
[    2.646319] pcie_pme 0000:80:02.2:pcie01: service driver pcie_pme loaded
[    2.646958] pcieport 0000:80:03.0: Signaling PME through PCIe PME interrupt
[    2.647583] pci 0000:86:00.0: Signaling PME through PCIe PME interrupt
[    2.648139] pcie_pme 0000:80:03.0:pcie01: service driver pcie_pme loaded
[    2.651894] intel_idle: MWAIT substates: 0x1120
[    2.652363] intel_idle: v0.4 model 0x3E
[    2.652738] intel_idle: lapic_timer_reliable_states 0xffffffff
[    2.653521] ERST pstore disabled, enforce via pstore.backend=erst
[    2.654116] ERST: Could not register with persistent store
[    2.654681] ERST: Error Record Serialization Table (ERST) support is initialized.
[    2.655538] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    2.656224] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    2.690577] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
[    2.998416] serial 00:04: unable to assign resources
[    2.999020] serial: probe of 00:04 failed with error -16
[    3.003072] Non-volatile memory driver v1.3
[    3.003505] Linux agpgart interface v0.103
[    3.004090] Fixed MDIO Bus: probed
[    3.004507] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    3.557369] Refined TSC clocksource calibration: 2299.999 MHz.
[    3.557994] Switching to clocksource tsc
[    4.033466] i8042: No controller found
[    4.033942] mousedev: PS/2 mouse device common for all mice
[    4.035302] cpuidle: using governor ladder
[    4.036745] cpuidle: using governor menu
[    4.037147] EFI Variables Facility v0.08 2004-May-17
[    4.037915] TCP cubic registered
[    4.038295] Registering the dns_resolver key type
[    4.041321] Loading module verification certificates
[    4.041848] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    4.042796] MODSIGN: Loaded cert 'SUSE Linux Enterprise Secure Boot Signkey: 3fb077b6cebc6ff2522e1c148c57c777c788e3e7'
[    4.043684] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
[    4.044595] PM: Hibernation image not present or could not be loaded.
[    4.045170] registered taskstats version 1
[    4.049447]   Magic number: 8:246:636
[    4.052400] Freeing unused kernel memory: 1360k freed
[    4.053515] Write protecting the kernel read-only data: 10240k
[    4.058096] Freeing unused kernel memory: 1568k freed
[    4.061622] Freeing unused kernel memory: 916k freed
[    4.110560] SCSI subsystem initialized
[    4.112493] libata version 3.00 loaded.
[    4.113645] ahci 0000:00:1f.2: version 3.0
[    4.114066] ahci 0000:00:1f.2: PCI INT B -> GSI 19 (level, low) -> IRQ 19
[    4.114990] ahci 0000:00:1f.2: irq 104 for MSI/MSI-X
[    4.115468] ahci 0000:00:1f.2: forcing PORTS_IMPL to 0x3f
[    4.116059] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x3f impl SATA mode
[    4.116870] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst 
[    4.117615] ahci 0000:00:1f.2: setting latency timer to 64
[    4.121441] scsi0 : ahci
[    4.121863] scsi1 : ahci
[    4.122177] scsi2 : ahci
[    4.122506] scsi3 : ahci
[    4.122835] scsi4 : ahci
[    4.123181] scsi5 : ahci
[    4.123564] ata2: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00100 irq 104
[    4.124279] ata3: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00180 irq 104
[    4.124918] ata4: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00200 irq 104
[    4.125612] ata5: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00280 irq 104
[    4.126248] ata6: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00300 irq 104
[    4.126929] ata7: SATA max UDMA/133 abar m2048@0xe7f00000 port 0xe7f00380 irq 104
[    5.152640] ata4: failed to resume link (SControl 0)
[    5.153177] ata4: SATA link down (SStatus 0 SControl 0)
[    5.153710] ata2: failed to resume link (SControl 0)
[    5.154117] ata2: SATA link down (SStatus 0 SControl 0)
[    5.154946] ata7: failed to resume link (SControl 0)
[    5.155464] ata7: SATA link down (SStatus 0 SControl 0)
[    5.156000] ata5: failed to resume link (SControl 0)
[    5.156528] ata5: SATA link down (SStatus 0 SControl 0)
[    5.157091] ata6: failed to resume link (SControl 0)
[    5.157678] ata6: SATA link down (SStatus 0 SControl 0)
[    5.160844] ata3: failed to resume link (SControl 0)
[    5.161437] ata3: SATA link down (SStatus 0 SControl 0)
[    5.167686] emc: device handler registered
[    5.176120] alua: device handler registered
[    5.181133] hp_sw: device handler registered
[    5.186060] rdac: device handler registered
[    5.189754] udev: starting version 147
[    5.204927] ACPI: acpi_idle yielding to intel_idle
[    5.215271] usbcore: registered new interface driver usbfs
[    5.215868] usbcore: registered new interface driver hub
[    5.216403] isci: Intel(R) C600 SAS Controller Driver - version 1.1.0
[    5.216438] usbcore: registered new device driver usb
[    5.220684] isci 0000:06:00.0: driver configured for rev: 6 silicon
[    5.221502] isci 0000:06:00.0: OEM parameter table found in OROM
[    5.222042] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) loaded (platform)
[    5.222768] isci 0000:06:00.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.223471] ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
[    5.223843] isci 0000:06:00.0: setting latency timer to 64
[    5.223923] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    5.226430] scsi6 : isci
[    5.227058] isci 0000:06:00.0: irq 105 for MSI/MSI-X
[    5.227608] isci 0000:06:00.0: irq 106 for MSI/MSI-X
[    5.230737] ehci_hcd 0000:00:1a.0: PCI INT A -> GSI 16 (level, low) -> IRQ 16
[    5.231499] ehci_hcd 0000:00:1a.0: setting latency timer to 64
[    5.232098] ehci_hcd 0000:00:1a.0: EHCI Host Controller
[    5.232621] ehci_hcd 0000:00:1a.0: new USB bus registered, assigned bus number 1
[    5.233268] ehci_hcd 0000:00:1a.0: debug port 2
[    5.237608] ehci_hcd 0000:00:1a.0: cache line size of 64 is not supported
[    5.240872] ehci_hcd 0000:00:1a.0: irq 16, io mem 0xe7f02000
[    5.256579] ehci_hcd 0000:00:1a.0: USB 2.0 started, EHCI 1.00
[    5.257191] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002
[    5.260699] usb usb1: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.261360] usb usb1: Product: EHCI Host Controller
[    5.261811] usb usb1: Manufacturer: Linux 3.0.101-63-default ehci_hcd
[    5.262378] usb usb1: SerialNumber: 0000:00:1a.0
[    5.262898] hub 1-0:1.0: USB hub found
[    5.263258] hub 1-0:1.0: 2 ports detected
[    5.263774] ehci_hcd 0000:00:1d.0: PCI INT A -> GSI 23 (level, low) -> IRQ 23
[    5.264526] ehci_hcd 0000:00:1d.0: setting latency timer to 64
[    5.265130] ehci_hcd 0000:00:1d.0: EHCI Host Controller
[    5.265628] ehci_hcd 0000:00:1d.0: new USB bus registered, assigned bus number 2
[    5.266295] ehci_hcd 0000:00:1d.0: debug port 2
[    5.270641] ehci_hcd 0000:00:1d.0: cache line size of 64 is not supported
[    5.271331] ehci_hcd 0000:00:1d.0: irq 23, io mem 0xe7f01000
[    5.284610] ehci_hcd 0000:00:1d.0: USB 2.0 started, EHCI 1.00
[    5.285211] usb usb2: New USB device found, idVendor=1d6b, idProduct=0002
[    5.285790] usb usb2: New USB device strings: Mfr=3, Product=2, SerialNumber=1
[    5.286433] usb usb2: Product: EHCI Host Controller
[    5.286876] usb usb2: Manufacturer: Linux 3.0.101-63-default ehci_hcd
[    5.287494] usb usb2: SerialNumber: 0000:00:1d.0
[    5.290927] hub 2-0:1.0: USB hub found
[    5.291290] hub 2-0:1.0: 2 ports detected
[    5.572434] usb 1-1: new high-speed USB device number 2 using ehci_hcd
[    5.704757] usb 1-1: New USB device found, idVendor=8087, idProduct=0024
[    5.705417] usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.706546] hub 1-1:1.0: USB hub found
[    5.707030] hub 1-1:1.0: 6 ports detected
[    5.820350] usb 2-1: new high-speed USB device number 2 using ehci_hcd
[    5.956635] usb 2-1: New USB device found, idVendor=8087, idProduct=0024
[    5.957340] usb 2-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
[    5.958182] hub 2-1:1.0: USB hub found
[    5.958784] hub 2-1:1.0: 8 ports detected
[    6.232315] usb 2-1.3: new high-speed USB device number 3 using ehci_hcd
[    6.335600] sas: phy-6:0 added to port-6:0, phy_mask:0x1 (ffffffffffffffff)
[    6.336315] sas: DOING DISCOVERY on port 0, pid:242
[    6.336962] sas: DONE DISCOVERY on port 0, pid:242, result:0
[    6.337865] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[    6.338364] sas: ata8: end_device-6:0: dev error handler
[    6.500517] ata8.00: ATA-8: WDC WD5000BHTZ-04JCPV1, 04.06A01, max UDMA/133
[    6.537399] ata8.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    6.538529] ata8.00: configured for UDMA/133
[    6.538999] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[    6.539102] usb 2-1.3: New USB device found, idVendor=046b, idProduct=ff01
[    6.539104] usb 2-1.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    6.539105] usb 2-1.3: Product: Virtual Hub
[    6.539107] usb 2-1.3: Manufacturer: American Megatrends Inc.
[    6.539108] usb 2-1.3: SerialNumber: serial
[    6.539494] hub 2-1.3:1.0: USB hub found
[    6.539601] hub 2-1.3:1.0: 5 ports detected
[    6.552214] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000BHTZ-0 04.0 PQ: 0 ANSI: 5
[    6.555806] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/465 GiB)
[    6.556549] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    6.560060] sd 6:0:0:0: [sda] Write Protect is off
[    6.560523] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    6.561026] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    6.573015]  sda: sda1 sda2
[    6.573564] sd 6:0:0:0: [sda] Attached SCSI disk
[    6.731729] [drm] Initialized drm 1.1.0 20060810
[    6.734054] This driver is only used in secure boot mode as default
[    6.797294] PM: Marking nosave pages: 000000000008f000 - 0000000000100000
[    6.797299] PM: Marking nosave pages: 000000008df5e000 - 0000000100000000
[    6.799032] PM: Basic memory bitmaps created
[    6.799991] PM: Basic memory bitmaps freed
[    6.809425] PM: Starting manual resume from disk
[    6.809906] PM: Hibernation image partition 8:1 present
[    6.810454] PM: Looking for hibernation image.
[    6.810997] PM: Image not found (code -22)
[    6.811480] PM: Hibernation image not present or could not be loaded.
[    6.871946] usb 2-1.3.1: new low-speed USB device number 4 using ehci_hcd
[    7.005505] kjournald starting.  Commit interval 15 seconds
[    7.005744] EXT3-fs (sda2): using internal journal
[    7.005749] EXT3-fs (sda2): mounted filesystem with ordered data mode
[    7.036869] usb 2-1.3.1: New USB device found, idVendor=046b, idProduct=ff10
[    7.040049] usb 2-1.3.1: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[    7.040761] usb 2-1.3.1: Product: Virtual Keyboard and Mouse
[    7.041589] usb 2-1.3.1: Manufacturer: American Megatrends Inc.
[    7.097168] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.0/input/input0
[    7.100970] generic-usb 0003:046B:FF10.0001: input,hidraw0: USB HID v1.10 Keyboard [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input0
[    7.102942] input: American Megatrends Inc. Virtual Keyboard and Mouse as /devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.3/2-1.3.1/2-1.3.1:1.1/input/input1
[    7.104238] generic-usb 0003:046B:FF10.0002: input,hidraw1: USB HID v1.10 Mouse [American Megatrends Inc. Virtual Keyboard and Mouse] on usb-0000:00:1d.0-1.3.1/input1
[    7.105445] usbcore: registered new interface driver usbhid
[    7.105965] usbhid: USB HID core driver
[    7.171828] usb 2-1.3.2: new high-speed USB device number 5 using ehci_hcd
[    7.336470] usb 2-1.3.2: New USB device found, idVendor=046b, idProduct=ff20
[    7.337436] usb 2-1.3.2: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.338153] usb 2-1.3.2: Product: Virtual Cdrom Device
[    7.338991] usb 2-1.3.2: Manufacturer: American Megatrends Inc.
[    7.339570] usb 2-1.3.2: SerialNumber: AAAABBBBCCCC1
[    7.463683] usb 2-1.3.3: new high-speed USB device number 6 using ehci_hcd
[    7.628318] usb 2-1.3.3: New USB device found, idVendor=046b, idProduct=ff40
[    7.629014] usb 2-1.3.3: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.629680] usb 2-1.3.3: Product: Virtual Floppy Device
[    7.630493] usb 2-1.3.3: Manufacturer: American Megatrends Inc.
[    7.631035] usb 2-1.3.3: SerialNumber: AAAABBBBCCCC2
[    7.759537] usb 2-1.3.4: new high-speed USB device number 7 using ehci_hcd
[    7.916428] usb 2-1.3.4: New USB device found, idVendor=046b, idProduct=ff31
[    7.917128] usb 2-1.3.4: New USB device strings: Mfr=1, Product=2, SerialNumber=3
[    7.917772] usb 2-1.3.4: Product: Virtual HardDisk Device
[    7.918573] usb 2-1.3.4: Manufacturer: American Megatrends Inc.
[    7.919094] usb 2-1.3.4: SerialNumber: AAAABBBBCCCC3
[    8.326335] udev: starting version 147
[    8.351488] pci_hotplug: PCI Hot Plug PCI Core version: 0.5
[    8.353093] shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
[    8.381809] iTCO_vendor_support: vendor-support=0
[    8.387380] wmi: Mapper loaded
[    8.388194] iTCO_wdt: Intel TCO WatchDog Timer Driver v1.06
[    8.388814] iTCO_wdt: unable to reset NO_REBOOT flag, device disabled by hardware/BIOS
[    8.390393] input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/input2
[    8.391287] ACPI: Power Button [PWRB]
[    8.391683] input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input3
[    8.392419] ACPI: Power Button [PWRF]
[    8.393485] pps_core: LinuxPPS API ver. 1 registered
[    8.393965] pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <giometti@linux.it>
[    8.395508] PTP clock support registered
[    8.400644] i801_smbus 0000:00:1f.3: PCI INT C -> GSI 18 (level, low) -> IRQ 18
[    8.414053] rtc_cmos 00:06: RTC can wake from S4
[    8.414669] rtc_cmos 00:06: rtc core: registered rtc_cmos as rtc0
[    8.415317] rtc0: alarms up to one month, y3k, 114 bytes nvram, hpet irqs
[    8.433765] mei 0000:00:16.0: Device doesn't have valid ME Interface
[    8.434404] mei 0000:00:16.0: initialization failed.
[    8.436375] input: PC Speaker as /devices/platform/pcspkr/input/input4
[    8.444020] dca service started, version 1.12.1
[    8.463197] sd 6:0:0:0: Attached scsi generic sg0 type 0
[    8.463824] Initializing USB Mass Storage driver...
[    8.464505] scsi7 : usb-storage 2-1.3.2:1.0
[    8.465001] usb-storage 2-1.3.3:1.0: Quirks match for vid 046b pid ff40: 200
[    8.465656] scsi8 : usb-storage 2-1.3.3:1.0
[    8.466179] scsi9 : usb-storage 2-1.3.4:1.0
[    8.469412] usbcore: registered new interface driver usb-storage
[    8.469997] USB Mass Storage support registered.
[    8.475917] ipmi message handler version 39.2
[    8.484874] IPMI System Interface driver.
[    8.485318] ipmi_si: probing via ACPI
[    8.485704] ipmi_si 00:0a: [io  0x0ca2] regsize 1 spacing 1 irq 0
[    8.491942] ipmi_si: Adding ACPI-specified kcs state machine
[    8.493003] ipmi_si: probing via SMBIOS
[    8.493863] ipmi_si: SMBIOS: mem 0x0 regsize 1 spacing 1 irq 0
[    8.495251] ipmi_si: Adding SMBIOS-specified kcs state machine
[    8.498946] ipmi_si: probing via SPMI
[    8.499292] ipmi_si: SPMI: io 0xca2 regsize 1 spacing 1 irq 0
[    8.499774] ipmi_si: Adding SPMI-specified kcs state machine duplicate interface
[    8.500529] ipmi_si: Trying ACPI-specified kcs state machine at i/o address 0xca2, slave address 0x0, irq 0
[    8.501410] mlx4_core: Mellanox ConnectX core driver v2.2-1 (Feb, 2014)
[    8.501986] mlx4_core: Initializing 0000:03:00.0
[    8.502405] mlx4_core 0000:03:00.0: PCI INT A -> GSI 32 (level, low) -> IRQ 32
[    8.503141] mlx4_core 0000:03:00.0: setting latency timer to 64
[    8.503963] igb: Intel(R) Gigabit Ethernet Network Driver - version 5.2.15-k
[    8.504655] igb: Copyright (c) 2007-2014 Intel Corporation.
[    8.505150] igb 0000:07:00.0: PCI INT A -> GSI 17 (level, low) -> IRQ 17
[    8.505653] igb 0000:07:00.0: setting latency timer to 64
[    8.528455] NET: Registered protocol family 10
[    8.699094] ipmi_si 00:0a: Found new BMC (man_id: 0x002383, prod_id: 0x0751, dev_id: 0x20)
[    8.701314] ipmi_si 00:0a: IPMI kcs interface initialized
[    8.814935] igb 0000:07:00.0: irq 107 for MSI/MSI-X
[    8.815448] igb 0000:07:00.0: irq 108 for MSI/MSI-X
[    8.816294] igb 0000:07:00.0: irq 109 for MSI/MSI-X
[    8.816784] igb 0000:07:00.0: irq 110 for MSI/MSI-X
[    8.817462] igb 0000:07:00.0: irq 111 for MSI/MSI-X
[    8.817969] igb 0000:07:00.0: irq 112 for MSI/MSI-X
[    8.818487] igb 0000:07:00.0: irq 113 for MSI/MSI-X
[    8.819027] igb 0000:07:00.0: irq 114 for MSI/MSI-X
[    8.819491] igb 0000:07:00.0: irq 115 for MSI/MSI-X
[    8.856015] igb 0000:07:00.0: added PHC on eth0
[    8.856470] igb 0000:07:00.0: Intel(R) Gigabit Ethernet Network Connection
[    8.857156] igb 0000:07:00.0: eth0: (PCIe:5.0Gb/s:Width x4) d4:3d:7e:72:26:b5
[    8.857937] igb 0000:07:00.0: eth0: PBA No: 106100-000
[    8.858419] igb 0000:07:00.0: Using MSI-X interrupts. 8 rx queue(s), 8 tx queue(s)
[    9.494587] scsi 7:0:0:0: CD-ROM            AMI      Virtual CDROM0   1.00 PQ: 0 ANSI: 0 CCS
[    9.496254] scsi 7:0:0:0: Attached scsi generic sg1 type 5
[    9.497172] scsi 8:0:0:0: Direct-Access     AMI      Virtual Floppy0  1.00 PQ: 0 ANSI: 0 CCS
[    9.498145] sd 8:0:0:0: Attached scsi generic sg2 type 0
[    9.498780] scsi 9:0:0:0: Direct-Access     AMI      Virtual HDISK0   1.00 PQ: 0 ANSI: 0 CCS
[    9.499669] sd 9:0:0:0: Attached scsi generic sg3 type 0
[    9.502285] sd 8:0:0:0: [sdb] Attached SCSI removable disk
[    9.503414] sd 9:0:0:0: [sdc] Attached SCSI removable disk
[    9.645767] sr0: scsi-1 drive
[    9.646147] cdrom: Uniform CD-ROM driver Revision: 3.20
[    9.646745] sr 7:0:0:0: Attached scsi CD-ROM sr0
[   13.867461] mlx4_core 0000:03:00.0: 64B EQEs/CQEs supported by the device but not enabled
[   13.868263] mlx4_core 0000:03:00.0: Disabling EQE/CQE stride per user request
[   14.445570] mlx4_core 0000:03:00.0: PCIe link speed is 8.0GT/s, device supports 8.0GT/s
[   14.446349] mlx4_core 0000:03:00.0: PCIe link width is x8, device supports x8
[   14.447468] mlx4_core 0000:03:00.0: irq 116 for MSI/MSI-X
[   14.448016] mlx4_core 0000:03:00.0: irq 117 for MSI/MSI-X
[   14.448531] mlx4_core 0000:03:00.0: irq 118 for MSI/MSI-X
[   14.449074] mlx4_core 0000:03:00.0: irq 119 for MSI/MSI-X
[   14.449620] mlx4_core 0000:03:00.0: irq 120 for MSI/MSI-X
[   14.450173] mlx4_core 0000:03:00.0: irq 121 for MSI/MSI-X
[   14.450731] mlx4_core 0000:03:00.0: irq 122 for MSI/MSI-X
[   14.451298] mlx4_core 0000:03:00.0: irq 123 for MSI/MSI-X
[   14.451867] mlx4_core 0000:03:00.0: irq 124 for MSI/MSI-X
[   14.452446] mlx4_core 0000:03:00.0: irq 125 for MSI/MSI-X
[   14.453017] mlx4_core 0000:03:00.0: irq 126 for MSI/MSI-X
[   14.456243] mlx4_core 0000:03:00.0: irq 127 for MSI/MSI-X
[   14.456710] mlx4_core 0000:03:00.0: irq 128 for MSI/MSI-X
[   14.457180] mlx4_core 0000:03:00.0: irq 129 for MSI/MSI-X
[   14.457652] mlx4_core 0000:03:00.0: irq 130 for MSI/MSI-X
[   14.458132] mlx4_core 0000:03:00.0: irq 131 for MSI/MSI-X
[   14.458616] mlx4_core 0000:03:00.0: irq 132 for MSI/MSI-X
[   14.459107] mlx4_core 0000:03:00.0: irq 133 for MSI/MSI-X
[   14.459608] mlx4_core 0000:03:00.0: irq 134 for MSI/MSI-X
[   14.460115] mlx4_core 0000:03:00.0: irq 135 for MSI/MSI-X
[   14.460618] mlx4_core 0000:03:00.0: irq 136 for MSI/MSI-X
[   14.461133] mlx4_core 0000:03:00.0: irq 137 for MSI/MSI-X
[   14.461653] mlx4_core 0000:03:00.0: irq 138 for MSI/MSI-X
[   14.462178] mlx4_core 0000:03:00.0: irq 139 for MSI/MSI-X
[   14.462714] mlx4_core 0000:03:00.0: irq 140 for MSI/MSI-X
[   14.466253] mlx4_core 0000:03:00.0: irq 141 for MSI/MSI-X
[   14.466820] mlx4_core 0000:03:00.0: irq 142 for MSI/MSI-X
[   14.467385] mlx4_core 0000:03:00.0: irq 143 for MSI/MSI-X
[   14.467954] mlx4_core 0000:03:00.0: irq 144 for MSI/MSI-X
[   14.468530] mlx4_core 0000:03:00.0: irq 145 for MSI/MSI-X
[   14.469107] mlx4_core 0000:03:00.0: irq 146 for MSI/MSI-X
[   14.469693] mlx4_core 0000:03:00.0: irq 147 for MSI/MSI-X
[   14.470218] mlx4_core 0000:03:00.0: irq 148 for MSI/MSI-X
[   14.470640] mlx4_core 0000:03:00.0: irq 149 for MSI/MSI-X
[   14.471104] mlx4_core 0000:03:00.0: irq 150 for MSI/MSI-X
[   14.471572] mlx4_core 0000:03:00.0: irq 151 for MSI/MSI-X
[   14.472063] mlx4_core 0000:03:00.0: irq 152 for MSI/MSI-X
[   14.472537] mlx4_core 0000:03:00.0: irq 153 for MSI/MSI-X
[   14.642750] <mlx4_ib> mlx4_ib_add: mlx4_ib: Mellanox ConnectX InfiniBand driver v2.2-1 (Feb 2014)
[   14.670069] Adding 2103292k swap on /dev/sda1.  Priority:-1 extents:1 across:2103292k 
[   15.370954] device-mapper: uevent: version 1.0.3
[   15.371530] device-mapper: ioctl: 4.25.0-ioctl (2012-07-25) initialised: dm-devel@redhat.com
[   15.629070] loop: module loaded
[   16.550221] fuse init (API version 7.16)
[   17.829787] type=1400 audit(1478097549.149:2): apparmor="STATUS" operation="profile_load" name="/bin/ping" pid=1601 comm="apparmor_parser"
[   17.853283] type=1400 audit(1478097549.173:3): apparmor="STATUS" operation="profile_load" name="/sbin/klogd" pid=1606 comm="apparmor_parser"
[   17.905494] type=1400 audit(1478097549.225:4): apparmor="STATUS" operation="profile_load" name="/sbin/syslog-ng" pid=1610 comm="apparmor_parser"
[   17.954340] type=1400 audit(1478097549.277:5): apparmor="STATUS" operation="profile_load" name="/sbin/syslogd" pid=1614 comm="apparmor_parser"
[   17.974542] type=1400 audit(1478097549.297:6): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-explicit-grant-helper" pid=1619 comm="apparmor_parser"
[   18.024742] type=1400 audit(1478097549.345:7): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-grant-helper" pid=1623 comm="apparmor_parser"
[   18.073219] type=1400 audit(1478097549.393:8): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-grant-helper-pam" pid=1627 comm="apparmor_parser"
[   18.122351] type=1400 audit(1478097549.445:9): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-read-auth-helper" pid=1631 comm="apparmor_parser"
[   18.141772] type=1400 audit(1478097549.461:10): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-resolve-exe-helper" pid=1635 comm="apparmor_parser"
[   18.167329] type=1400 audit(1478097549.489:11): apparmor="STATUS" operation="profile_load" name="/usr/lib/PolicyKit/polkit-revoke-helper" pid=1639 comm="apparmor_parser"
[   22.823498] NET: Registered protocol family 17
[   22.911086] igb 0000:07:00.0: eth0: igb: eth0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
[   22.912391] ADDRCONF(NETDEV_UP): eth0: link is not ready
[   22.913921] ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
[   26.711382] BIOS EDD facility v0.16 2004-Jun-25, 1 devices found
[   33.430767] eth0: no IPv6 routers present

--PNTmBPCT7hxwcZjr--
