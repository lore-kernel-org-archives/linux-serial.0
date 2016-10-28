From: Nathan Zimmer <nzimmer@sgi.com>
Subject: Re: console issue since 3.6, console=ttyS1 hangs
Date: Fri, 28 Oct 2016 14:42:25 -0500
Message-ID: <20161028194225.GA233549@stormcage.americas.sgi.com>
References: <20161018192930.GA207959@stormcage.americas.sgi.com>
 <20161019090719.GA1764@gofer.mess.org>
 <29b311e3-a26e-81de-82cf-e0a202db6d96@sgi.com>
 <20161020201051.GA29324@gofer.mess.org>
 <49f038af-5cb7-e76f-e4e9-57fad876710d@sgi.com>
 <20161024135235.GA29984@gofer.mess.org>
 <20161024214925.GA143272@stormcage.americas.sgi.com>
 <20161025204139.GA22268@gofer.mess.org>
 <fb8f3b77-6095-c14b-02e8-deb595777f23@sgi.com>
 <20161027201916.GA7718@gofer.mess.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161027201916.GA7718@gofer.mess.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sean Young <sean@mess.org>
Cc: Nathan Zimmer <nzimmer@sgi.com>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org, alan@linux.intel.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
List-Id: linux-serial@vger.kernel.org


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 27, 2016 at 09:19:16PM +0100, Sean Young wrote:
> On Wed, Oct 26, 2016 at 01:16:16PM -0500, Nathan Zimmer wrote:
> > On 10/25/2016 03:41 PM, Sean Young wrote:
> > >On Mon, Oct 24, 2016 at 04:49:25PM -0500, Nathan Zimmer wrote:
> > >>[    1.565062] serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
> > >The isa probe driver find the serial port.
> > >
> > >>[    1.566453] serial 00:04: pnp_assign_resources, try dependent set 0
> > >>[    1.567383] serial 00:04:   couldn't assign io 0 (min 0x2f8 max 0x2f8)
> > >But then decides that the port is already in use (the existing serial driver).
> > >>[    1.568366] serial 00:04: pnp_assign_resources failed (-16)
> > >>[    1.569188] serial 00:04: unable to assign resources
> > >>[    1.569924] serial: probe of 00:04 failed with error -16
> > >Please try and boot 3.7.0 with "8250.share_irqs=1", maybe it will pick
> > >irq 3 and it will be happy again, but that is just a guess.
> > >
> > >I think I have not fully understood what the failure is. Does the serial
> > >port not work or does the boot hang? What are the symptoms?
> > With console=ttyS1 the boot will "hang", sometimes it makes it all the way
> > through but may take 30 minutes, instead of the 2-4 minutes this box
> 
> Where does it hang? Any error messages?
> 

Shortly after mounting the root.
After that I get no more output...

Here is a failure log from 4.8.

> > >We might be able to fix the problem with a pnp quirk but 3.7 is has not had
> > >any releases for a long time. We will need a reproduction on a concurrent
> > >kernel so a patch can be written for that.
> > Yes it still happens with 4.8+
> > I had only started dwelling on 3.6/3.7 since that is where it first appears
> > and don't have any attachment to those.
> 
> Ok. Please try to following patch. I'm not sure it is good enough to be
> merged as-is, but should provide a start for testing. Output with
> CONFIG_PNP_DEBUG_MESSAGES should show only irq 3 is available for the 
> serial port now.
> 
> Sean
> 
> From 3a1705a2e28f4385b778ad96d7c517b82ea860e2 Mon Sep 17 00:00:00 2001
> From: Sean Young <sean@mess.org>
> Date: Thu, 27 Oct 2016 20:13:50 +0100
> Subject: [PATCH] PNP: Add quirk for BIOS advertising wrong irqs for serial
>  port
> 
> Signed-off-by: Sean Young <sean@mess.org>
> ---
>  drivers/pnp/quirks.c | 43 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
> 
> diff --git a/drivers/pnp/quirks.c b/drivers/pnp/quirks.c
> index d28e3ab..8712161 100644
> --- a/drivers/pnp/quirks.c
> +++ b/drivers/pnp/quirks.c
> @@ -66,6 +66,48 @@ static void quirk_awe32_resources(struct pnp_dev *dev)
>  	}
>  }
>  
> +static void quirk_serial_port(struct pnp_dev *dev)
> +{
> +	struct pnp_option *option;
> +	struct pnp_irq *irq;
> +	struct pnp_port *port;
> +
> +	list_for_each_entry(option, &dev->options, list) {
> +		if (!pnp_option_is_dependent(option))
> +			continue;
> +
> +		if (option->type == IORESOURCE_IO) {
> +			port = &option->u.port;
> +
> +			if (port->min != 0x2f8 || port->max != 0x2f8 ||
> +				port->size != 8 || port->align != 1)
> +				return;
> +		} else if (option->type == IORESOURCE_IRQ) {
> +			pnp_irq_mask_t map;
> +
> +			irq = &option->u.irq;
> +
> +			bitmap_zero(map.bits, PNP_IRQ_NR);
> +			__set_bit(3, map.bits);
> +			__set_bit(4, map.bits);
> +			__set_bit(5, map.bits);
> +			__set_bit(6, map.bits);
> +			__set_bit(7, map.bits);
> +			__set_bit(10, map.bits);
> +			__set_bit(11, map.bits);
> +			__set_bit(12, map.bits);
> +
> +			if (!bitmap_equal(map.bits, irq->map.bits, PNP_IRQ_NR))
> +				return;
> +		}
> +	}
> +
> +	if (irq && port) {
> +		bitmap_zero(irq->map.bits, PNP_IRQ_NR);
> +		__set_bit(3, irq->map.bits);
> +	}
> +}
> +
>  static void quirk_cmi8330_resources(struct pnp_dev *dev)
>  {
>  	struct pnp_option *option;
> @@ -448,6 +490,7 @@ static struct pnp_fixup pnp_fixups[] = {
>  #ifdef CONFIG_PCI
>  	{"PNP0c02", quirk_intel_mch},
>  #endif
> +	{"PNP0c02", quirk_serial_port},
>  	{""}
>  };
>  
> -- 
> 2.7.4
> 

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="con_log_4.8"


root (hd0,1)
 Filesystem type is ext2fs, partition type 0x83
kernel /boot/vmlinuz-4.8.0 root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-W
XA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54K
KR60-part1 crashkernel=256M-:128M showopts loglevel=8 pnp.debug=1 vga=0x314 con
sole=ttyS1                                                                      [    0.000000] Linux version 4.8.0 (root@r1i2n0) (gcc version 4.3.4 [gcc-4_3-branch revision 152973] (SUSE Linux) ) #36 SMP Fri Oct 28 13:08:10 EDT 2016   *
[    0.000000] Command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M showopts loglevel=8 pnp.debug=1 vga=0x314 console=ttyS1                                                                  *
[    0.000000] x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'                                                                     *
[    0.000000] x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'*****
[    0.000000] x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
[    0.000000] x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
[    0.000000] x86/fpu: Enabled xstate features 0x7, context size is 832 bytes, using 'standard' format.ore) the selected line, 'd' to remove the
[    0.000000] x86/fpu: Using 'eager' FPU context switches.
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
[    0.000000] SMBIOS 2.7 present.
[    0.000000] DMI: SGI.COM ICE-XIP119/S0751-Medina, BIOS ma2e2054 02/05/2014
[    0.000000] e820: update [mem 0x00000000-0x00000fff] usable ==> reserved
[    0.000000] e820: remove [mem 0x000a0000-0x000fffff] usable
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
[    0.000000] x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WC  UC- WT
[    0.000000] e820: update [mem 0x90000000-0xffffffff] usable ==> reserved
[    0.000000] e820: last_pfn = 0x8df5e max_arch_pfn = 0x400000000
[    0.000000] found SMP MP-table at [mem 0x000fdba0-0x000fdbaf] mapped at [ffff8800000fdba0]
[    0.000000] Scanning 1 areas for low memory corruption
[    0.000000] Base memory trampoline at [ffff880000088000] 88000 size 28672
[    0.000000] Using GB pages for direct mapping
[    0.000000] BRK [0x01e70000, 0x01e70fff] PGTABLE
[    0.000000] BRK [0x01e71000, 0x01e71fff] PGTABLE
[    0.000000] BRK [0x01e72000, 0x01e72fff] PGTABLE
[    0.000000] BRK [0x01e73000, 0x01e73fff] PGTABLE
[    0.000000] RAMDISK: [mem 0x36740000-0x37feffff]
[    0.000000] ACPI: Early table checksum verification disabled
[    0.000000] ACPI: RSDP 0x00000000000F04A0 000024 (v02 ALASKA)
[    0.000000] ACPI: XSDT 0x000000008DFC5090 00009C (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FACP 0x000000008DFD1CD0 00010C (v05 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: DSDT 0x000000008DFC51B8 00CB14 (v02 ALASKA A M I    00000201 INTL 20051117)
[    0.000000] ACPI: FACS 0x000000008E2C1080 000040
[    0.000000] ACPI: APIC 0x000000008DFD1DE0 000224 (v03 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: FPDT 0x000000008DFD2008 000044 (v01 ALASKA A M I    01072009 AMI  00010013)
[    0.000000] ACPI: MCFG 0x000000008DFD2050 00003C (v01 ALASKA OEMMCFG. 01072009 MSFT 00000097)
[    0.000000] ACPI: SRAT 0x000000008DFD2090 0004B0 (v01 A M I  AMI SRAT 00000001 AMI. 00000000)
[    0.000000] ACPI: SLIT 0x000000008DFD2540 000030 (v01 A M I  AMI SLIT 00000000 AMI. 00000000)
[    0.000000] ACPI: HPET 0x000000008DFD2570 000038 (v01 ALASKA A M I    01072009 AMI. 00000005)
[    0.000000] ACPI: PRAD 0x000000008DFD25A8 0000BE (v02 PRADID PRADTID  00000001 MSFT 03000001)
[    0.000000] ACPI: SPMI 0x000000008DFD2668 000040 (v05 A M I  OEMSPMI  00000000 AMI. 00000000)
[    0.000000] ACPI: SSDT 0x000000008DFD26A8 0D0CB0 (v02 INTEL  CpuPm    00004000 INTL 20051117)
[    0.000000] ACPI: EINJ 0x000000008E0A3358 000130 (v01 AMI    AMI EINJ 00000000      00000000)
[    0.000000] ACPI: ERST 0x000000008E0A3488 000230 (v01 AMIER  AMI ERST 00000000      00000000)
[    0.000000] ACPI: HEST 0x000000008E0A36B8 000068 (v01 AMI    AMI HEST 00000000      00000000)
[    0.000000] ACPI: BERT 0x000000008E0A3720 000030 (v01 AMI    AMI BERT 00000000      00000000)
[    0.000000] ACPI: DMAR 0x000000008E0A3750 000150 (v01 A M I  OEMDMAR  00000001 INTL 00000001)
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
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x00000000-0x8fffffff]
[    0.000000] ACPI: SRAT: Node 0 PXM 0 [mem 0x100000000-0x86fffffff]
[    0.000000] ACPI: SRAT: Node 1 PXM 1 [mem 0x870000000-0x106fffffff]
[    0.000000] NUMA: Initialized distance table, cnt=2
[    0.000000] NUMA: Node 0 [mem 0x00000000-0x8fffffff] + [mem 0x100000000-0x86fffffff] -> [mem 0x00000000-0x86fffffff]
[    0.000000] NODE_DATA(0) allocated [mem 0x86ffde000-0x86fffffff]
[    0.000000] NODE_DATA(1) allocated [mem 0x106ffdb000-0x106fffcfff]
[    0.000000] Reserving 128MB of memory at 736MB for crashkernel (System RAM: 65502MB)
[    0.000000] [ffffea001d880000-ffffea001d9fffff] potential offnode page_structs
[    0.000000] Zone ranges:
[    0.000000]   DMA      [mem 0x0000000000001000-0x0000000000ffffff]
[    0.000000]   DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
[    0.000000]   Normal   [mem 0x0000000100000000-0x000000106fffffff]
[    0.000000] Movable zone start for each node
[    0.000000] Early memory node ranges
[    0.000000]   node   0: [mem 0x0000000000001000-0x000000000008efff]
[    0.000000]   node   0: [mem 0x0000000000100000-0x000000008df5dfff]
[    0.000000]   node   0: [mem 0x0000000100000000-0x000000086fffffff]
[    0.000000]   node   1: [mem 0x0000000870000000-0x000000106fffffff]
[    0.000000] Initmem setup node 0 [mem 0x0000000000001000-0x000000086fffffff]
[    0.000000] On node 0 totalpages: 8380140
[    0.000000]   DMA zone: 56 pages used for memmap
[    0.000000]   DMA zone: 22 pages reserved
[    0.000000]   DMA zone: 3982 pages, LIFO batch:0
[    0.000000]   DMA32 zone: 7894 pages used for memmap
[    0.000000]   DMA32 zone: 577374 pages, LIFO batch:31
[    0.000000]   Normal zone: 106624 pages used for memmap
[    0.000000]   Normal zone: 7798784 pages, LIFO batch:31
[    0.000000] Initmem setup node 1 [mem 0x0000000870000000-0x000000106fffffff]
[    0.000000] On node 1 totalpages: 8388608
[    0.000000]   Normal zone: 114688 pages used for memmap
[    0.000000]   Normal zone: 8388608 pages, LIFO batch:31
[    0.000000] ACPI: PM-Timer IO Port: 0x408
[    0.000000] ACPI: Local APIC address 0xfee00000
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
[    0.000000] IOAPIC[0]: apic_id 0, version 32, address 0xfec00000, GSI 0-23
[    0.000000] IOAPIC[1]: apic_id 2, version 32, address 0xfec01000, GSI 24-47
[    0.000000] IOAPIC[2]: apic_id 3, version 32, address 0xfec40000, GSI 48-71
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
[    0.000000] ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
[    0.000000] ACPI: IRQ0 used by override.
[    0.000000] ACPI: IRQ9 used by override.
[    0.000000] Using ACPI (MADT) for SMP configuration information
[    0.000000] ACPI: HPET id: 0x8086a701 base: 0xfed00000
[    0.000000] smpboot: Allowing 32 CPUs, 0 hotplug CPUs
[    0.000000] PM: Registered nosave memory: [mem 0x00000000-0x00000fff]
[    0.000000] PM: Registered nosave memory: [mem 0x0008f000-0x0009ffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000a0000-0x000dffff]
[    0.000000] PM: Registered nosave memory: [mem 0x000e0000-0x000fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8df5e000-0x8df8dfff]
[    0.000000] PM: Registered nosave memory: [mem 0x8df8e000-0x8e0a3fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8e0a4000-0x8e2c9fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8e2ca000-0x8f336fff]
[    0.000000] PM: Registered nosave memory: [mem 0x8f337000-0x8f7fffff]
[    0.000000] PM: Registered nosave memory: [mem 0x8f800000-0x8fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0x90000000-0x9fffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xa0000000-0xfed1bfff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed1c000-0xfed3ffff]
[    0.000000] PM: Registered nosave memory: [mem 0xfed40000-0xfeffffff]
[    0.000000] PM: Registered nosave memory: [mem 0xff000000-0xffffffff]
[    0.000000] e820: [mem 0xa0000000-0xfed1bfff] available for PCI devices
[    0.000000] clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645519600211568 ns
[    0.000000] setup_percpu: NR_CPUS:8192 nr_cpumask_bits:32 nr_cpu_ids:32 nr_node_ids:2
[    0.000000] percpu: Embedded 33 pages/cpu @ffff88086fa00000 s96984 r8192 d29992 u262144
[    0.000000] pcpu-alloc: s96984 r8192 d29992 u262144 alloc=1*2097152
[    0.000000] pcpu-alloc: [0] 00 01 02 03 04 05 06 07 [0] 16 17 18 19 20 21 22 23
[    0.000000] pcpu-alloc: [1] 08 09 10 11 12 13 14 15 [1] 24 25 26 27 28 29 30 31
[    0.000000] Built 2 zonelists in Node order, mobility grouping on.  Total pages: 16539464
[    0.000000] Policy zone: Normal
[    0.000000] Kernel command line: root=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part2 resume=/dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1 crashkernel=256M-:128M showopts loglevel=8 pnp.debug=1 vga=0x314 console=ttyS1
[    0.000000] PID hash table entries: 4096 (order: 3, 32768 bytes)
[    0.000000] Memory: 65913268K/67074992K available (5676K kernel code, 1070K rwdata, 2624K rodata, 1716K init, 1720K bss, 1161724K reserved, 0K cma-reserved)
[    0.000000] Hierarchical RCU implementation.
[    0.000000]  Build-time adjustment of leaf fanout to 64.
[    0.000000]  RCU restricting CPUs from NR_CPUS=8192 to nr_cpu_ids=32.
[    0.000000] RCU: Adjusting geometry for rcu_fanout_leaf=64, nr_cpu_ids=32
[    0.000000] NR_IRQS:524544 nr_irqs:1496 16
[    0.000000] Console: colour dummy device 80x25
[    0.000000] console [ttyS1] enabled
[    0.000000] clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 133484882848 ns
[    0.000000] hpet clockevent registered
[    0.000000] tsc: Fast TSC calibration using PIT
[    0.000000] tsc: Detected 2299.884 MHz processor
[    0.000014] Calibrating delay loop (skipped), value calculated using timer frequency.. 4599.76 BogoMIPS (lpj=9199536)
[    0.001020] pid_max: default: 32768 minimum: 301
[    0.001466] ACPI: Core revision 20160422
[    0.102740] ACPI: 2 ACPI AML tables successfully acquired and loaded
[    0.103363]
[    0.103631] Security Framework initialized
[    0.104009] AppArmor: AppArmor initialized
[    0.108116] Dentry cache hash table entries: 8388608 (order: 14, 67108864 bytes)
[    0.123995] Inode-cache hash table entries: 4194304 (order: 13, 33554432 bytes)
[    0.130596] Mount-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.131313] Mountpoint-cache hash table entries: 131072 (order: 8, 1048576 bytes)
[    0.132650] CPU: Physical Processor ID: 0
[    0.133026] CPU: Processor Core ID: 1
[    0.133363] mce: CPU supports 27 MCE banks
[    0.133767] CPU0: Thermal monitoring enabled (TM1)
[    0.134288] process: using mwait in idle threads
[    0.134714] Last level iTLB entries: 4KB 512, 2MB 8, 4MB 8
[    0.135219] Last level dTLB entries: 4KB 512, 2MB 32, 4MB 32, 1GB 0
[    0.136236] Freeing SMP alternatives memory: 24K (ffffffff81cba000 - ffffffff81cc0000)
[    0.140263] smpboot: APIC(2) Converting physical 0 to logical package 0
[    0.140903] smpboot: APIC(20) Converting physical 1 to logical package 1
[    0.141454] smpboot: Max logical packages: 4
[    0.141862] Switched APIC routing to physical flat.
[    0.142945] ..TIMER: vector=0x30 apic1=0 pin1=2 apic2=-1 pin2=-1
[    0.183213] TSC deadline timer enabled
[    0.183599] smpboot: CPU0: Genuine Intel(R) CPU  @ 2.80GHz (family: 0x6, model: 0x3e, stepping: 0x2)
[    0.184487] Performance Events: PEBS fmt1+, IvyBridge events, 16-deep LBR, full-width counters, Intel PMU driver.
[    0.185585] ... version:                3
[    0.186011] ... bit width:              48
[    0.186465] ... generic registers:      4
[    0.189777] ... value mask:             0000ffffffffffff
[    0.190298] ... max period:             0000ffffffffffff
[    0.190817] ... fixed-purpose events:   3
[    0.191258] ... event mask:             000000070000000f
[    0.194015] NMI watchdog: enabled on all CPUs, permanently consumes one hw-PMU counter.
[    0.194958] x86: Booting SMP configuration:
[    0.195371] .... node  #0, CPUs:        #1  #2  #3  #4  #5  #6  #7
[    0.760369] .... node  #1, CPUs:    #8  #9 #10 #11 #12 #13 #14 #15
[    1.448756] .... node  #0, CPUs:   #16 #17 #18 #19 #20 #21 #22 #23
[    2.093415] .... node  #1, CPUs:   #24 #25 #26 #27 #28 #29 #30 #31
[    2.765605] x86: Booted up 2 nodes, 32 CPUs
[    2.766049] smpboot: Total of 32 processors activated (147277.48 BogoMIPS)
[    2.872236] devtmpfs: initialized
[    2.872722] x86/mm: Memory block size: 2048MB
[    2.932231] PM: Registering ACPI NVS region [mem 0x8e0a4000-0x8e2c9fff] (2252800 bytes)
[    2.933072] PM: Registering ACPI NVS region [mem 0x8f337000-0x8f7fffff] (5017600 bytes)
[    2.934467] clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: 7645041785100000 ns
[    2.980395] RTC time: 19:19:33, date: 10/28/16
[    3.013411] NET: Registered protocol family 16
[    3.028228] cpuidle: using governor ladder
[    3.044241] cpuidle: using governor menu
[    3.044692] ACPI: bus type PCI registered
[    3.076380] PCI: MMCONFIG for domain 0000 [bus 00-ff] at [mem 0x90000000-0x9fffffff] (base 0x90000000)
[    3.077245] PCI: MMCONFIG at [mem 0x90000000-0x9fffffff] reserved in E820
[    3.078179] pmd_set_huge: Cannot satisfy [mem 0x90000000-0x90200000] with a huge-page mapping due to MTRR override.
[    3.079401] PCI: Using configuration type 1 for base access
[    3.080303] core: PMU erratum BJ122, BV98, HSD29 worked around, HT is on
[    3.116693] HugeTLB registered 1 GB page size, pre-allocated 0 pages
[    3.117345] HugeTLB registered 2 MB page size, pre-allocated 0 pages
[    3.180515] ACPI: Added _OSI(Module Device)
[    3.180950] ACPI: Added _OSI(Processor Device)
[    3.181383] ACPI: Added _OSI(3.0 _SCP Extensions)
[    3.181782] ACPI: Added _OSI(Processor Aggregator Device)
[    3.182853] ACPI: Executed 1 blocks of module-level executable AML code
[    3.536651] ACPI: Interpreter enabled
[    3.537068] ACPI: (supports S0 S4 S5)
[    3.537428] ACPI: Using IOAPIC for interrupt routing
[    3.537915] HEST: Table parsing has been initialized.
[    3.538673] PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
[    3.566911] ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-7e])
[    3.567554] acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.568641] acpi PNP0A08:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.569708] PCI host bridge to bus 0000:00
[    3.570127] pci_bus 0000:00: root bus resource [io  0x0000-0x03af window]
[    3.570798] pci_bus 0000:00: root bus resource [io  0x03e0-0x0cf7 window]
[    3.571348] pci_bus 0000:00: root bus resource [io  0x03b0-0x03df window]
[    3.571999] pci_bus 0000:00: root bus resource [io  0x0d00-0x9fff window]
[    3.572670] pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
[    3.573357] pci_bus 0000:00: root bus resource [mem 0x000c0000-0x000dffff window]
[    3.573995] pci_bus 0000:00: root bus resource [mem 0x90000000-0xe7ffffff window]
[    3.574680] pci_bus 0000:00: root bus resource [mem 0x380000000000-0x380fffffffff window]
[    3.575420] pci_bus 0000:00: root bus resource [bus 00-7e]
[    3.575922] pci 0000:00:00.0: [8086:0e00] type 00 class 0x060000
[    3.576572] pci 0000:00:00.0: PME# supported from D0 D3hot D3cold
[    3.580182] pci 0000:00:01.0: [8086:0e02] type 01 class 0x060400
[    3.580855] pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
[    3.581538] pci 0000:00:01.0: System wakeup disabled by ACPI
[    3.582155] pci 0000:00:01.1: [8086:0e03] type 01 class 0x060400
[    3.582827] pci 0000:00:01.1: PME# supported from D0 D3hot D3cold
[    3.583508] pci 0000:00:01.1: System wakeup disabled by ACPI
[    3.584134] pci 0000:00:02.0: [8086:0e04] type 01 class 0x060400
[    3.584803] pci 0000:00:02.0: PME# supported from D0 D3hot D3cold
[    3.585482] pci 0000:00:02.0: System wakeup disabled by ACPI
[    3.586095] pci 0000:00:02.2: [8086:0e06] type 01 class 0x060400
[    3.589973] pci 0000:00:02.2: PME# supported from D0 D3hot D3cold
[    3.590659] pci 0000:00:02.2: System wakeup disabled by ACPI
[    3.591268] pci 0000:00:03.0: [8086:0e08] type 01 class 0x060400
[    3.591933] pci 0000:00:03.0: PME# supported from D0 D3hot D3cold
[    3.592631] pci 0000:00:03.0: System wakeup disabled by ACPI
[    3.593235] pci 0000:00:05.0: [8086:0e28] type 00 class 0x088000
[    3.593980] pci 0000:00:05.2: [8086:0e2a] type 00 class 0x088000
[    3.594733] pci 0000:00:05.4: [8086:0e2c] type 00 class 0x080020
[    3.595341] pci 0000:00:05.4: reg 0x10: [mem 0xe7f06000-0xe7f06fff]
[    3.596120] pci 0000:00:07.0: [8086:0e18] type 00 class 0x088000
[    3.600147] pci 0000:00:11.0: [8086:1d3e] type 01 class 0x060400
[    3.600853] pci 0000:00:11.0: PME# supported from D0 D3hot D3cold
[    3.601593] pci 0000:00:16.0: [8086:1d3a] type 00 class 0x078000
[    3.602209] pci 0000:00:16.0: reg 0x10: [mem 0xe7f05000-0xe7f0500f 64bit]
[    3.602998] pci 0000:00:16.0: PME# supported from D0 D3hot D3cold
[    3.603708] pci 0000:00:16.1: [8086:1d3b] type 00 class 0x078000
[    3.604329] pci 0000:00:16.1: reg 0x10: [mem 0xe7f04000-0xe7f0400f 64bit]
[    3.605091] pci 0000:00:16.1: PME# supported from D0 D3hot D3cold
[    3.605818] pci 0000:00:1a.0: [8086:1d2d] type 00 class 0x0c0320
[    3.606493] pci 0000:00:1a.0: reg 0x10: [mem 0xe7f02000-0xe7f023ff]
[    3.610022] pci 0000:00:1a.0: PME# supported from D0 D3hot D3cold
[    3.610746] pci 0000:00:1a.0: System wakeup disabled by ACPI
[    3.611351] pci 0000:00:1c.0: [8086:1d10] type 01 class 0x060400
[    3.612014] pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
[    3.612700] pci 0000:00:1c.0: System wakeup disabled by ACPI
[    3.613310] pci 0000:00:1c.4: [8086:1d18] type 01 class 0x060400
[    3.613989] pci 0000:00:1c.4: PME# supported from D0 D3hot D3cold
[    3.614661] pci 0000:00:1c.4: System wakeup disabled by ACPI
[    3.615264] pci 0000:00:1d.0: [8086:1d26] type 00 class 0x0c0320
[    3.615869] pci 0000:00:1d.0: reg 0x10: [mem 0xe7f01000-0xe7f013ff]
[    3.621174] pci 0000:00:1d.0: PME# supported from D0 D3hot D3cold
[    3.622551] pci 0000:00:1d.0: System wakeup disabled by ACPI
[    3.623870] pci 0000:00:1e.0: [8086:244e] type 01 class 0x060401
[    3.625299] pci 0000:00:1e.0: System wakeup disabled by ACPI
[    3.625921] pci 0000:00:1f.0: [8086:1d41] type 00 class 0x060100
[    3.629933] pci 0000:00:1f.2: [8086:1d02] type 00 class 0x010601
[    3.630552] pci 0000:00:1f.2: reg 0x10: [io  0x9070-0x9077]
[    3.631101] pci 0000:00:1f.2: reg 0x14: [io  0x9060-0x9063]
[    3.631587] pci 0000:00:1f.2: reg 0x18: [io  0x9050-0x9057]
[    3.632100] pci 0000:00:1f.2: reg 0x1c: [io  0x9040-0x9043]
[    3.632617] pci 0000:00:1f.2: reg 0x20: [io  0x9020-0x903f]
[    3.633133] pci 0000:00:1f.2: reg 0x24: [mem 0xe7f00000-0xe7f007ff]
[    3.633736] pci 0000:00:1f.2: PME# supported from D3hot
[    3.634278] pci 0000:00:1f.3: [8086:1d22] type 00 class 0x0c0500
[    3.634879] pci 0000:00:1f.3: reg 0x10: [mem 0x380ffff01000-0x380ffff010ff 64bit]
[    3.635621] pci 0000:00:1f.3: reg 0x20: [io  0x9000-0x901f]
[    3.636149] pci 0000:00:1f.6: [8086:1d24] type 00 class 0x118000
[    3.639771] pci 0000:00:1f.6: reg 0x10: [mem 0x380ffff00000-0x380ffff00fff 64bit]
[    3.640701] pci 0000:00:01.0: PCI bridge to [bus 01]
[    3.641262] pci 0000:00:01.1: PCI bridge to [bus 02]
[    3.641976] pci 0000:03:00.0: [15b3:1003] type 00 class 0x028000
[    3.642853] pci 0000:03:00.0: reg 0x10: [mem 0xe7e00000-0xe7efffff 64bit]
[    3.643729] pci 0000:03:00.0: reg 0x18: [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    3.646418] pci 0000:00:02.0: PCI bridge to [bus 03]
[    3.646940] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    3.650496] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    3.651332] pci 0000:00:02.2: PCI bridge to [bus 04]
[    3.651831] pci 0000:05:00.0: [8086:2250] type 00 class 0x0b4000
[    3.652431] pci 0000:05:00.0: reg 0x10: [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    3.653354] pci 0000:05:00.0: reg 0x20: [mem 0xe7d00000-0xe7d1ffff 64bit]
[    3.654073] pci 0000:05:00.0: PME# supported from D0
[    3.666575] pci 0000:00:03.0: PCI bridge to [bus 05]
[    3.667115] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    3.671366] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    3.672650] pci 0000:06:00.0: [8086:1d69] type 00 class 0x010700
[    3.673652] pci 0000:06:00.0: reg 0x10: [mem 0x380e00c7c000-0x380e00c7ffff 64bit pref]
[    3.675817] pci 0000:06:00.0: reg 0x18: [mem 0x380e00800000-0x380e00bfffff 64bit pref]
[    3.680079] pci 0000:06:00.0: reg 0x20: [io  0x8000-0x80ff]
[    3.680753] pci 0000:06:00.0: reg 0x164: [mem 0x380e00c00000-0x380e00c03fff 64bit pref]
[    3.681533] pci 0000:06:00.0: VF(n) BAR0 space: [mem 0x380e00c00000-0x380e00c7bfff 64bit pref] (contains BAR0 for 31 VFs)
[    3.682750] pci 0000:00:11.0: PCI bridge to [bus 06]
[    3.683267] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    3.683782] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    3.684398] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    3.685236] pci 0000:07:00.0: [8086:1523] type 00 class 0x020000
[    3.685842] pci 0000:07:00.0: reg 0x10: [mem 0xe7b00000-0xe7b1ffff]
[    3.689491] pci 0000:07:00.0: reg 0x18: [io  0x7000-0x701f]
[    3.690090] pci 0000:07:00.0: reg 0x1c: [mem 0xe7b20000-0xe7b23fff]
[    3.690870] pci 0000:07:00.0: PME# supported from D0 D3hot D3cold
[    3.691538] pci 0000:07:00.0: reg 0x184: [mem 0x380e00e20000-0x380e00e23fff 64bit pref]
[    3.692292] pci 0000:07:00.0: VF(n) BAR0 space: [mem 0x380e00e20000-0x380e00e3ffff 64bit pref] (contains BAR0 for 8 VFs)
[    3.693315] pci 0000:07:00.0: reg 0x190: [mem 0x380e00e00000-0x380e00e03fff 64bit pref]
[    3.694008] pci 0000:07:00.0: VF(n) BAR3 space: [mem 0x380e00e00000-0x380e00e1ffff 64bit pref] (contains BAR3 for 8 VFs)
[    3.710055] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    3.710604] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    3.711190] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    3.711833] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    3.712706] pci 0000:09:00.0: [1a03:1150] type 01 class 0x060400
[    3.713450] pci 0000:09:00.0: supports D1 D2
[    3.713882] pci 0000:09:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.726472] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    3.727027] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    3.730201] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    3.730862] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    3.731673] pci 0000:0a:00.0: [1a03:2000] type 00 class 0x030000
[    3.732318] pci 0000:0a:00.0: reg 0x10: [mem 0xe7000000-0xe77fffff pref]
[    3.732973] pci 0000:0a:00.0: reg 0x14: [mem 0xe7a00000-0xe7a1ffff]
[    3.733593] pci 0000:0a:00.0: reg 0x18: [io  0x6000-0x607f]
[    3.734259] pci 0000:0a:00.0: supports D1 D2
[    3.734703] pci 0000:0a:00.0: PME# supported from D0 D1 D2 D3hot D3cold
[    3.735431] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    3.735936] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    3.736602] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    3.740253] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    3.741054] pci 0000:00:1e.0: PCI bridge to [bus 0b] (subtractive decode)
[    3.741703] pci 0000:00:1e.0:   bridge window [io  0x0000-0x03af window] (subtractive decode)
[    3.742474] pci 0000:00:1e.0:   bridge window [io  0x03e0-0x0cf7 window] (subtractive decode)
[    3.743268] pci 0000:00:1e.0:   bridge window [io  0x03b0-0x03df window] (subtractive decode)
[    3.744035] pci 0000:00:1e.0:   bridge window [io  0x0d00-0x9fff window] (subtractive decode)
[    3.744818] pci 0000:00:1e.0:   bridge window [mem 0x000a0000-0x000bffff window] (subtractive decode)
[    3.745619] pci 0000:00:1e.0:   bridge window [mem 0x000c0000-0x000dffff window] (subtractive decode)
[    3.746473] pci 0000:00:1e.0:   bridge window [mem 0x90000000-0xe7ffffff window] (subtractive decode)
[    3.750286] pci 0000:00:1e.0:   bridge window [mem 0x380000000000-0x380fffffffff window] (subtractive decode)
[    3.751225] pci_bus 0000:00: on NUMA node 0
[    3.752470] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
[    3.753066] acpi PNP0A03:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.753823] acpi PNP0A03:00: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.754632] PCI host bridge to bus 0000:7f
[    3.755036] pci_bus 0000:7f: root bus resource [bus 7f]
[    3.755551] pci 0000:7f:08.0: [8086:0e80] type 00 class 0x088000
[    3.756143] pci 0000:7f:08.3: [8086:0e83] type 00 class 0x088000
[    3.756886] pci 0000:7f:08.4: [8086:0e84] type 00 class 0x088000
[    3.760569] pci 0000:7f:09.0: [8086:0e90] type 00 class 0x088000
[    3.761222] pci 0000:7f:09.3: [8086:0e93] type 00 class 0x088000
[    3.761889] pci 0000:7f:09.4: [8086:0e94] type 00 class 0x088000
[    3.762567] pci 0000:7f:0a.0: [8086:0ec0] type 00 class 0x088000
[    3.763219] pci 0000:7f:0a.1: [8086:0ec1] type 00 class 0x088000
[    3.763866] pci 0000:7f:0a.2: [8086:0ec2] type 00 class 0x088000
[    3.764519] pci 0000:7f:0a.3: [8086:0ec3] type 00 class 0x088000
[    3.765170] pci 0000:7f:0b.0: [8086:0e1e] type 00 class 0x088000
[    3.765818] pci 0000:7f:0b.3: [8086:0e1f] type 00 class 0x088000
[    3.766538] pci 0000:7f:0c.0: [8086:0ee0] type 00 class 0x088000
[    3.770106] pci 0000:7f:0c.1: [8086:0ee2] type 00 class 0x088000
[    3.770630] pci 0000:7f:0c.2: [8086:0ee4] type 00 class 0x088000
[    3.771135] pci 0000:7f:0c.3: [8086:0ee6] type 00 class 0x088000
[    3.771709] pci 0000:7f:0c.4: [8086:0ee8] type 00 class 0x088000
[    3.772374] pci 0000:7f:0d.0: [8086:0ee1] type 00 class 0x088000
[    3.773020] pci 0000:7f:0d.1: [8086:0ee3] type 00 class 0x088000
[    3.773662] pci 0000:7f:0d.2: [8086:0ee5] type 00 class 0x088000
[    3.774312] pci 0000:7f:0d.3: [8086:0ee7] type 00 class 0x088000
[    3.774961] pci 0000:7f:0d.4: [8086:0ee9] type 00 class 0x088000
[    3.775611] pci 0000:7f:0e.0: [8086:0ea0] type 00 class 0x088000
[    3.776268] pci 0000:7f:0e.1: [8086:0e30] type 00 class 0x110100
[    3.779890] pci 0000:7f:0f.0: [8086:0ea8] type 00 class 0x088000
[    3.780555] pci 0000:7f:0f.1: [8086:0e71] type 00 class 0x088000
[    3.781234] pci 0000:7f:0f.2: [8086:0eaa] type 00 class 0x088000
[    3.781900] pci 0000:7f:0f.3: [8086:0eab] type 00 class 0x088000
[    3.782579] pci 0000:7f:0f.4: [8086:0eac] type 00 class 0x088000
[    3.783247] pci 0000:7f:0f.5: [8086:0ead] type 00 class 0x088000
[    3.783930] pci 0000:7f:10.0: [8086:0eb0] type 00 class 0x088000
[    3.784611] pci 0000:7f:10.1: [8086:0eb1] type 00 class 0x088000
[    3.785290] pci 0000:7f:10.2: [8086:0eb2] type 00 class 0x088000
[    3.785960] pci 0000:7f:10.3: [8086:0eb3] type 00 class 0x088000
[    3.786698] pci 0000:7f:10.4: [8086:0eb4] type 00 class 0x088000
[    3.790137] pci 0000:7f:10.5: [8086:0eb5] type 00 class 0x088000
[    3.790803] pci 0000:7f:10.6: [8086:0eb6] type 00 class 0x088000
[    3.791494] pci 0000:7f:10.7: [8086:0eb7] type 00 class 0x088000
[    3.792157] pci 0000:7f:13.0: [8086:0e1d] type 00 class 0x088000
[    3.792806] pci 0000:7f:13.1: [8086:0e34] type 00 class 0x110100
[    3.793457] pci 0000:7f:13.4: [8086:0e81] type 00 class 0x088000
[    3.794105] pci 0000:7f:13.5: [8086:0e36] type 00 class 0x110100
[    3.794763] pci 0000:7f:16.0: [8086:0ec8] type 00 class 0x088000
[    3.795409] pci 0000:7f:16.1: [8086:0ec9] type 00 class 0x088000
[    3.796075] pci 0000:7f:16.2: [8086:0eca] type 00 class 0x088000
[    3.799871] pci_bus 0000:7f: on NUMA node 0
[    3.800613] ACPI: PCI Root Bridge [PCI1] (domain 0000 [bus 80-fe])
[    3.801237] acpi PNP0A08:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.802311] acpi PNP0A08:01: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.803458] PCI host bridge to bus 0000:80
[    3.803880] pci_bus 0000:80: root bus resource [io  0xa000-0xffff window]
[    3.804535] pci_bus 0000:80: root bus resource [mem 0xe8000000-0xfbffffff window]
[    3.805216] pci_bus 0000:80: root bus resource [mem 0x381000000000-0x381fffffffff window]
[    3.805987] pci_bus 0000:80: root bus resource [bus 80-fe]
[    3.809527] pci 0000:80:00.0: [8086:0e01] type 01 class 0x060400
[    3.810167] pci 0000:80:00.0: PME# supported from D0 D3hot D3cold
[    3.810871] pci 0000:80:01.0: [8086:0e02] type 01 class 0x060400
[    3.811536] pci 0000:80:01.0: PME# supported from D0 D3hot D3cold
[    3.812227] pci 0000:80:01.1: [8086:0e03] type 01 class 0x060400
[    3.812897] pci 0000:80:01.1: PME# supported from D0 D3hot D3cold
[    3.813602] pci 0000:80:02.0: [8086:0e04] type 01 class 0x060400
[    3.814269] pci 0000:80:02.0: PME# supported from D0 D3hot D3cold
[    3.814959] pci 0000:80:02.2: [8086:0e06] type 01 class 0x060400
[    3.815624] pci 0000:80:02.2: PME# supported from D0 D3hot D3cold
[    3.816314] pci 0000:80:03.0: [8086:0e08] type 01 class 0x060400
[    3.819951] pci 0000:80:03.0: PME# supported from D0 D3hot D3cold
[    3.820649] pci 0000:80:05.0: [8086:0e28] type 00 class 0x088000
[    3.821372] pci 0000:80:05.2: [8086:0e2a] type 00 class 0x088000
[    3.822091] pci 0000:80:05.4: [8086:0e2c] type 00 class 0x080020
[    3.822695] pci 0000:80:05.4: reg 0x10: [mem 0xfbf00000-0xfbf00fff]
[    3.823436] pci 0000:80:07.0: [8086:0e18] type 00 class 0x088000
[    3.824207] pci 0000:80:00.0: PCI bridge to [bus 81]
[    3.824754] pci 0000:80:01.0: PCI bridge to [bus 82]
[    3.825287] pci 0000:80:01.1: PCI bridge to [bus 83]
[    3.825821] pci 0000:80:02.0: PCI bridge to [bus 84]
[    3.826410] pci 0000:80:02.2: PCI bridge to [bus 85]
[    3.829956] pci 0000:86:00.0: [8086:2250] type 00 class 0x0b4000
[    3.830553] pci 0000:86:00.0: reg 0x10: [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    3.831218] pci 0000:86:00.0: reg 0x20: [mem 0xfbe00000-0xfbe1ffff 64bit]
[    3.831886] pci 0000:86:00.0: PME# supported from D0
[    3.832552] pci 0000:80:03.0: PCI bridge to [bus 86]
[    3.833058] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    3.833626] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    3.834460] pci_bus 0000:80: on NUMA node 1
[    3.834991] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
[    3.835579] acpi PNP0A03:01: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI]
[    3.836368] acpi PNP0A03:01: _OSC: OS now controls [PCIeHotplug PME AER PCIeCapability]
[    3.840127] PCI host bridge to bus 0000:ff
[    3.840532] pci_bus 0000:ff: root bus resource [bus ff]
[    3.840967] pci 0000:ff:08.0: [8086:0e80] type 00 class 0x088000
[    3.841577] pci 0000:ff:08.3: [8086:0e83] type 00 class 0x088000
[    3.842231] pci 0000:ff:08.4: [8086:0e84] type 00 class 0x088000
[    3.842922] pci 0000:ff:09.0: [8086:0e90] type 00 class 0x088000
[    3.843568] pci 0000:ff:09.3: [8086:0e93] type 00 class 0x088000
[    3.844228] pci 0000:ff:09.4: [8086:0e94] type 00 class 0x088000
[    3.844887] pci 0000:ff:0a.0: [8086:0ec0] type 00 class 0x088000
[    3.845528] pci 0000:ff:0a.1: [8086:0ec1] type 00 class 0x088000
[    3.846171] pci 0000:ff:0a.2: [8086:0ec2] type 00 class 0x088000
[    3.849831] pci 0000:ff:0a.3: [8086:0ec3] type 00 class 0x088000
[    3.850480] pci 0000:ff:0b.0: [8086:0e1e] type 00 class 0x088000
[    3.851129] pci 0000:ff:0b.3: [8086:0e1f] type 00 class 0x088000
[    3.851770] pci 0000:ff:0c.0: [8086:0ee0] type 00 class 0x088000
[    3.852412] pci 0000:ff:0c.1: [8086:0ee2] type 00 class 0x088000
[    3.853053] pci 0000:ff:0c.2: [8086:0ee4] type 00 class 0x088000
[    3.853694] pci 0000:ff:0c.3: [8086:0ee6] type 00 class 0x088000
[    3.854340] pci 0000:ff:0c.4: [8086:0ee8] type 00 class 0x088000
[    3.854989] pci 0000:ff:0d.0: [8086:0ee1] type 00 class 0x088000
[    3.855629] pci 0000:ff:0d.1: [8086:0ee3] type 00 class 0x088000
[    3.856270] pci 0000:ff:0d.2: [8086:0ee5] type 00 class 0x088000
[    3.860077] pci 0000:ff:0d.3: [8086:0ee7] type 00 class 0x088000
[    3.860721] pci 0000:ff:0d.4: [8086:0ee9] type 00 class 0x088000
[    3.861370] pci 0000:ff:0e.0: [8086:0ea0] type 00 class 0x088000
[    3.862015] pci 0000:ff:0e.1: [8086:0e30] type 00 class 0x110100
[    3.862670] pci 0000:ff:0f.0: [8086:0ea8] type 00 class 0x088000
[    3.863322] pci 0000:ff:0f.1: [8086:0e71] type 00 class 0x088000
[    3.863973] pci 0000:ff:0f.2: [8086:0eaa] type 00 class 0x088000
[    3.864630] pci 0000:ff:0f.3: [8086:0eab] type 00 class 0x088000
[    3.865300] pci 0000:ff:0f.4: [8086:0eac] type 00 class 0x088000
[    3.865952] pci 0000:ff:0f.5: [8086:0ead] type 00 class 0x088000
[    3.866670] pci 0000:ff:10.0: [8086:0eb0] type 00 class 0x088000
[    3.870041] pci 0000:ff:10.1: [8086:0eb1] type 00 class 0x088000
[    3.870560] pci 0000:ff:10.2: [8086:0eb2] type 00 class 0x088000
[    3.871067] pci 0000:ff:10.3: [8086:0eb3] type 00 class 0x088000
[    3.871656] pci 0000:ff:10.4: [8086:0eb4] type 00 class 0x088000
[    3.872316] pci 0000:ff:10.5: [8086:0eb5] type 00 class 0x088000
[    3.872968] pci 0000:ff:10.6: [8086:0eb6] type 00 class 0x088000
[    3.873622] pci 0000:ff:10.7: [8086:0eb7] type 00 class 0x088000
[    3.874280] pci 0000:ff:13.0: [8086:0e1d] type 00 class 0x088000
[    3.874929] pci 0000:ff:13.1: [8086:0e34] type 00 class 0x110100
[    3.875578] pci 0000:ff:13.4: [8086:0e81] type 00 class 0x088000
[    3.876224] pci 0000:ff:13.5: [8086:0e36] type 00 class 0x110100
[    3.879865] pci 0000:ff:16.0: [8086:0ec8] type 00 class 0x088000
[    3.880513] pci 0000:ff:16.1: [8086:0ec9] type 00 class 0x088000
[    3.881157] pci 0000:ff:16.2: [8086:0eca] type 00 class 0x088000
[    3.881809] pci_bus 0000:ff: on NUMA node 1
[    3.882353] ACPI: PCI Interrupt Link [LNKA] (IRQs 3 4 5 6 7 10 *11 12 14 15)
[    3.883245] ACPI: PCI Interrupt Link [LNKB] (IRQs 3 4 *5 6 7 10 11 12 14 15)
[    3.884120] ACPI: PCI Interrupt Link [LNKC] (IRQs 3 4 5 6 *10 11 12 14 15)
[    3.884946] ACPI: PCI Interrupt Link [LNKD] (IRQs 3 *4 5 6 10 11 12 14 15)
[    3.885779] ACPI: PCI Interrupt Link [LNKE] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    3.886729] ACPI: PCI Interrupt Link [LNKF] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    3.890745] ACPI: PCI Interrupt Link [LNKG] (IRQs 3 4 5 6 7 10 11 12 14 15) *0
[    3.891631] ACPI: PCI Interrupt Link [LNKH] (IRQs 3 4 5 6 *7 10 11 12 14 15)
[    3.897137] ACPI: Enabled 4 GPEs in block 00 to 3F
[    3.897898] vgaarb: setting as boot device: PCI:0000:0a:00.0
[    3.900150] vgaarb: device added: PCI:0000:0a:00.0,decodes=io+mem,owns=io+mem,locks=none
[    3.900974] vgaarb: loaded
[    3.901233] vgaarb: bridge control possible 0000:0a:00.0
[    3.902032] PCI: Using ACPI for IRQ routing
[    3.907034] PCI: pci_cache_line_size set to 64 bytes
[    3.907798] e820: reserve RAM buffer [mem 0x0008f000-0x0008ffff]
[    3.910259] e820: reserve RAM buffer [mem 0x8df5e000-0x8fffffff]
[    3.910960] NetLabel: Initializing
[    3.911316] NetLabel:  domain hash size = 128
[    3.911724] NetLabel:  protocols = UNLABELED CIPSOv4
[    3.912141] NetLabel:  unlabeled traffic allowed by default
[    3.912774] hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
[    3.913430] hpet0: 8 comparators, 64-bit 14.318180 MHz counter
[    3.916114] clocksource: Switched to clocksource hpet
[    3.920724] VFS: Disk quotas dquot_6.6.0
[    3.960129] VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
[    3.992187] AppArmor: AppArmor Filesystem Enabled
[    3.992759] pnp: PnP ACPI init
[    3.993118] pnp 00:00: parse allocated resources
[    3.993591] pnp 00:00: PNP0c01: calling quirk_system_pci_resources+0x0/0x180
[    3.994362] pnp 00:00: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xc0
[    3.995054] system 00:00: [mem 0xfc000000-0xfcffffff] has been reserved
[    3.995733] system 00:00: [mem 0xfd000000-0xfdffffff] has been reserved
[    3.999472] system 00:00: [mem 0xfe000000-0xfeafffff] has been reserved
[    4.000127] system 00:00: [mem 0xfeb00000-0xfebfffff] has been reserved
[    4.000753] system 00:00: [mem 0xfed00400-0xfed3ffff] could not be reserved
[    4.001370] system 00:00: [mem 0xfed45000-0xfedfffff] has been reserved
[    4.001940] system 00:00: Plug and Play ACPI device, IDs PNP0c01 (active)
[    4.002610] pnp 00:01: parse allocated resources
[    4.003110] pnp 00:01: PNP0c02: calling quirk_system_pci_resources+0x0/0x180
[    4.003821] pnp 00:01: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    4.004480] system 00:01: [mem 0xe7ffc000-0xe7ffdfff] has been reserved
[    4.005125] system 00:01: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.005792] pnp 00:02: parse allocated resources
[    4.006407] pnp 00:02: PNP0c02: calling quirk_system_pci_resources+0x0/0x180
[    4.010170] pnp 00:02: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    4.010778] system 00:02: [io  0x0a00-0x0a1f] has been reserved
[    4.011277] system 00:02: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.012071] pnp 00:03: parse resource options
[    4.012535] pnp 00:03:   dependent set 0 (acceptable) io  min 0x2f8 max 0x2f8 align 1 size 8 flags 0x1
[    4.013429] pnp 00:03:   dependent set 0 (acceptable) irq 3 4 5 6 7 10 11 12 flags 0x1
[    4.014139] pnp 00:03:   dependent set 0 (acceptable) dma <none> (bitmask 0x0) flags 0x0
[    4.014913] pnp 00:03: Plug and Play ACPI device, IDs PNP0501 (disabled)
[    4.015548] pnp 00:04: parse allocated resources
[    4.016058] pnp 00:04: Plug and Play ACPI device, IDs PNP0b00 (active)
[    4.019886] pnp 00:05: parse allocated resources
[    4.020436] pnp 00:05: PNP0c02: calling quirk_system_pci_resources+0x0/0x180
[    4.021146] pnp 00:05: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    4.021781] system 00:05: [io  0x04d0-0x04d1] has been reserved
[    4.022361] system 00:05: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.022994] pnp 00:06: parse allocated resources
[    4.023716] pnp 00:06: PNP0c01: calling quirk_system_pci_resources+0x0/0x180
[    4.024453] pnp 00:06: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xc0
[    4.025154] system 00:06: [io  0x0400-0x0453] has been reserved
[    4.025734] system 00:06: [io  0x0458-0x047f] has been reserved
[    4.026383] system 00:06: [io  0x1180-0x119f] has been reserved
[    4.029936] system 00:06: [io  0x0500-0x057f] has been reserved
[    4.030530] system 00:06: [mem 0xfed1c000-0xfed1ffff] has been reserved
[    4.031161] system 00:06: [mem 0xfec00000-0xfecfffff] could not be reserved
[    4.031783] system 00:06: [mem 0xfed08000-0xfed08fff] has been reserved
[    4.032351] system 00:06: [mem 0xff000000-0xffffffff] has been reserved
[    4.032981] system 00:06: Plug and Play ACPI device, IDs PNP0c01 (active)
[    4.033671] pnp 00:07: parse allocated resources
[    4.034203] pnp 00:07: PNP0c02: calling quirk_system_pci_resources+0x0/0x180
[    4.034909] pnp 00:07: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    4.035550] system 00:07: [io  0x0454-0x0457] has been reserved
[    4.036186] system 00:07: Plug and Play ACPI device, IDs INT3f0d PNP0c02 (active)
[    4.040227] pnp 00:08: parse allocated resources
[    4.040705] pnp 00:08: PNP0c01: calling quirk_system_pci_resources+0x0/0x180
[    4.041411] pnp 00:08: PNP0c01: calling quirk_amd_mmconfig_area+0x0/0xc0
[    4.041973] system 00:08: Plug and Play ACPI device, IDs PNP0c01 (active)
[    4.042630] pnp 00:09: parse allocated resources
[    4.043125] pnp 00:09: PNP0c02: calling quirk_system_pci_resources+0x0/0x180
[    4.043833] pnp 00:09: PNP0c02: calling quirk_intel_mch+0x0/0x1a0
[    4.044468] system 00:09: [mem 0xfbffe000-0xfbffffff] has been reserved
[    4.045108] system 00:09: Plug and Play ACPI device, IDs PNP0c02 (active)
[    4.046263] pnp: PnP ACPI: found 10 devices
[    4.053666] clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2085701024 ns
[    4.054683] pci 0000:00:01.0: PCI bridge to [bus 01]
[    4.055165] pci 0000:00:01.1: PCI bridge to [bus 02]
[    4.055644] pci 0000:00:02.0: PCI bridge to [bus 03]
[    4.056132] pci 0000:00:02.0:   bridge window [mem 0xe7e00000-0xe7efffff]
[    4.059841] pci 0000:00:02.0:   bridge window [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    4.060582] pci 0000:00:02.2: PCI bridge to [bus 04]
[    4.061002] pci 0000:00:03.0: PCI bridge to [bus 05]
[    4.061441] pci 0000:00:03.0:   bridge window [mem 0xe7d00000-0xe7dfffff]
[    4.062021] pci 0000:00:03.0:   bridge window [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    4.062769] pci 0000:00:11.0: PCI bridge to [bus 06]
[    4.063265] pci 0000:00:11.0:   bridge window [io  0x8000-0x8fff]
[    4.063859] pci 0000:00:11.0:   bridge window [mem 0xe7c00000-0xe7cfffff]
[    4.064487] pci 0000:00:11.0:   bridge window [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    4.065280] pci 0000:00:1c.0: PCI bridge to [bus 07-08]
[    4.065842] pci 0000:00:1c.0:   bridge window [io  0x7000-0x7fff]
[    4.069672] pci 0000:00:1c.0:   bridge window [mem 0xe7b00000-0xe7bfffff]
[    4.070351] pci 0000:00:1c.0:   bridge window [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    4.071112] pci 0000:09:00.0: PCI bridge to [bus 0a]
[    4.071564] pci 0000:09:00.0:   bridge window [io  0x6000-0x6fff]
[    4.072118] pci 0000:09:00.0:   bridge window [mem 0xe7a00000-0xe7afffff]
[    4.072693] pci 0000:09:00.0:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    4.073400] pci 0000:00:1c.4: PCI bridge to [bus 09-0a]
[    4.073925] pci 0000:00:1c.4:   bridge window [io  0x6000-0x6fff]
[    4.074534] pci 0000:00:1c.4:   bridge window [mem 0xe7a00000-0xe7afffff]
[    4.075170] pci 0000:00:1c.4:   bridge window [mem 0xe7000000-0xe77fffff 64bit pref]
[    4.075848] pci 0000:00:1e.0: PCI bridge to [bus 0b]
[    4.076340] pci_bus 0000:00: resource 4 [io  0x0000-0x03af window]
[    4.079806] pci_bus 0000:00: resource 5 [io  0x03e0-0x0cf7 window]
[    4.080349] pci_bus 0000:00: resource 6 [io  0x03b0-0x03df window]
[    4.080957] pci_bus 0000:00: resource 7 [io  0x0d00-0x9fff window]
[    4.081603] pci_bus 0000:00: resource 8 [mem 0x000a0000-0x000bffff window]
[    4.082278] pci_bus 0000:00: resource 9 [mem 0x000c0000-0x000dffff window]
[    4.082922] pci_bus 0000:00: resource 10 [mem 0x90000000-0xe7ffffff window]
[    4.083539] pci_bus 0000:00: resource 11 [mem 0x380000000000-0x380fffffffff window]
[    4.084263] pci_bus 0000:03: resource 1 [mem 0xe7e00000-0xe7efffff]
[    4.084895] pci_bus 0000:03: resource 2 [mem 0x380e00000000-0x380e007fffff 64bit pref]
[    4.085618] pci_bus 0000:05: resource 1 [mem 0xe7d00000-0xe7dfffff]
[    4.086179] pci_bus 0000:05: resource 2 [mem 0x380c00000000-0x380dffffffff 64bit pref]
[    4.089989] pci_bus 0000:06: resource 0 [io  0x8000-0x8fff]
[    4.090581] pci_bus 0000:06: resource 1 [mem 0xe7c00000-0xe7cfffff]
[    4.091215] pci_bus 0000:06: resource 2 [mem 0x380e00800000-0x380e00cfffff 64bit pref]
[    4.091947] pci_bus 0000:07: resource 0 [io  0x7000-0x7fff]
[    4.092470] pci_bus 0000:07: resource 1 [mem 0xe7b00000-0xe7bfffff]
[    4.093032] pci_bus 0000:07: resource 2 [mem 0x380e00e00000-0x380e00efffff 64bit pref]
[    4.093770] pci_bus 0000:09: resource 0 [io  0x6000-0x6fff]
[    4.094355] pci_bus 0000:09: resource 1 [mem 0xe7a00000-0xe7afffff]
[    4.094993] pci_bus 0000:09: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    4.095680] pci_bus 0000:0a: resource 0 [io  0x6000-0x6fff]
[    4.096218] pci_bus 0000:0a: resource 1 [mem 0xe7a00000-0xe7afffff]
[    4.099982] pci_bus 0000:0a: resource 2 [mem 0xe7000000-0xe77fffff 64bit pref]
[    4.100633] pci_bus 0000:0b: resource 4 [io  0x0000-0x03af window]
[    4.101160] pci_bus 0000:0b: resource 5 [io  0x03e0-0x0cf7 window]
[    4.101762] pci_bus 0000:0b: resource 6 [io  0x03b0-0x03df window]
[    4.102406] pci_bus 0000:0b: resource 7 [io  0x0d00-0x9fff window]
[    4.103032] pci_bus 0000:0b: resource 8 [mem 0x000a0000-0x000bffff window]
[    4.103692] pci_bus 0000:0b: resource 9 [mem 0x000c0000-0x000dffff window]
[    4.104320] pci_bus 0000:0b: resource 10 [mem 0x90000000-0xe7ffffff window]
[    4.104925] pci_bus 0000:0b: resource 11 [mem 0x380000000000-0x380fffffffff window]
[    4.105672] pci 0000:80:00.0: PCI bridge to [bus 81]
[    4.106159] pci 0000:80:01.0: PCI bridge to [bus 82]
[    4.109665] pci 0000:80:01.1: PCI bridge to [bus 83]
[    4.110141] pci 0000:80:02.0: PCI bridge to [bus 84]
[    4.110566] pci 0000:80:02.2: PCI bridge to [bus 85]
[    4.111035] pci 0000:80:03.0: PCI bridge to [bus 86]
[    4.111508] pci 0000:80:03.0:   bridge window [mem 0xfbe00000-0xfbefffff]
[    4.112128] pci 0000:80:03.0:   bridge window [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    4.112908] pci_bus 0000:80: resource 4 [io  0xa000-0xffff window]
[    4.113520] pci_bus 0000:80: resource 5 [mem 0xe8000000-0xfbffffff window]
[    4.114170] pci_bus 0000:80: resource 6 [mem 0x381000000000-0x381fffffffff window]
[    4.114833] pci_bus 0000:86: resource 1 [mem 0xfbe00000-0xfbefffff]
[    4.115361] pci_bus 0000:86: resource 2 [mem 0x381e00000000-0x381fffffffff 64bit pref]
[    4.276110] NET: Registered protocol family 2
[    4.308504] TCP established hash table entries: 524288 (order: 10, 4194304 bytes)
[    4.310929] TCP bind hash table entries: 65536 (order: 8, 1048576 bytes)
[    4.311766] TCP: Hash tables configured (established 524288 bind 65536)
[    4.312515] UDP hash table entries: 32768 (order: 8, 1048576 bytes)
[    4.313338] UDP-Lite hash table entries: 32768 (order: 8, 1048576 bytes)
[    4.314307] NET: Registered protocol family 1
[    4.360289] pci 0000:0a:00.0: Video device with shadowed ROM at [mem 0x000c0000-0x000dffff]
[    4.390531] PCI: CLS 64 bytes, default 64
[    4.391376] Unpacking initramfs...
[    4.846346] Freeing initrd memory: 25280K (ffff880036740000 - ffff880037ff0000)
[    4.850129] PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
[    4.850783] software IO TLB [mem 0x89f5e000-0x8df5e000] (64MB) mapped at [ffff880089f5e000-ffff88008df5dfff]
[    4.852246] RAPL PMU: API unit is 2^-32 Joules, 3 fixed counters, 163840 ms ovfl timer
[    4.853075] RAPL PMU: hw unit of domain pp0-core 2^-16 Joules
[    4.853690] RAPL PMU: hw unit of domain package 2^-16 Joules
[    4.854300] RAPL PMU: hw unit of domain dram 2^-16 Joules
[    4.858628] Scanning for low memory corruption every 60 seconds
[    4.904827] futex hash table entries: 8192 (order: 7, 524288 bytes)
[    4.936151] audit: initializing netlink subsys (disabled)
[    4.936810] audit: type=2000 audit(1477682374.796:1): initialized
[    4.940922] Initialise system trusted keyrings
[    4.941744] workingset: timestamp_bits=52 max_order=24 bucket_order=0
[    5.079836] Key type asymmetric registered
[    5.080288] Asymmetric key parser 'x509' registered
[    5.120184] Block layer SCSI generic (bsg) driver version 0.4 loaded (major 251)
[    5.121057] io scheduler noop registered
[    5.121458] io scheduler deadline registered
[    5.122209] io scheduler cfq registered (default)
[    5.126113] aer 0000:00:01.0:pcie002: service driver aer loaded
[    5.129416] aer 0000:00:01.1:pcie002: service driver aer loaded
[    5.130046] aer 0000:00:02.0:pcie002: service driver aer loaded
[    5.130660] aer 0000:00:02.2:pcie002: service driver aer loaded
[    5.131330] aer 0000:00:03.0:pcie002: service driver aer loaded
[    5.131944] aer 0000:00:11.0:pcie002: service driver aer loaded
[    5.132561] aer 0000:80:00.0:pcie002: service driver aer loaded
[    5.133180] aer 0000:80:01.0:pcie002: service driver aer loaded
[    5.133830] aer 0000:80:01.1:pcie002: service driver aer loaded
[    5.134436] aer 0000:80:02.0:pcie002: service driver aer loaded
[    5.135043] aer 0000:80:02.2:pcie002: service driver aer loaded
[    5.135649] aer 0000:80:03.0:pcie002: service driver aer loaded
[    5.136237] pcieport 0000:00:01.0: Signaling PME through PCIe PME interrupt
[    5.139693] pcie_pme 0000:00:01.0:pcie001: service driver pcie_pme loaded
[    5.140345] pcieport 0000:00:01.1: Signaling PME through PCIe PME interrupt
[    5.140939] pcie_pme 0000:00:01.1:pcie001: service driver pcie_pme loaded
[    5.141598] pcieport 0000:00:02.0: Signaling PME through PCIe PME interrupt
[    5.142279] pci 0000:03:00.0: Signaling PME through PCIe PME interrupt
[    5.142906] pcie_pme 0000:00:02.0:pcie001: service driver pcie_pme loaded
[    5.143531] pcieport 0000:00:02.2: Signaling PME through PCIe PME interrupt
[    5.144120] pcie_pme 0000:00:02.2:pcie001: service driver pcie_pme loaded
[    5.144782] pcieport 0000:00:03.0: Signaling PME through PCIe PME interrupt
[    5.145440] pci 0000:05:00.0: Signaling PME through PCIe PME interrupt
[    5.146064] pcie_pme 0000:00:03.0:pcie001: service driver pcie_pme loaded
[    5.149907] pcieport 0000:00:11.0: Signaling PME through PCIe PME interrupt
[    5.150505] pci 0000:06:00.0: Signaling PME through PCIe PME interrupt
[    5.151141] pcie_pme 0000:00:11.0:pcie001: service driver pcie_pme loaded
[    5.151845] pcieport 0000:00:1c.0: Signaling PME through PCIe PME interrupt
[    5.152485] pci 0000:07:00.0: Signaling PME through PCIe PME interrupt
[    5.153080] pcie_pme 0000:00:1c.0:pcie001: service driver pcie_pme loaded
[    5.153696] pcieport 0000:00:1c.4: Signaling PME through PCIe PME interrupt
[    5.154327] pci 0000:09:00.0: Signaling PME through PCIe PME interrupt
[    5.155161] pci 0000:0a:00.0: Signaling PME through PCIe PME interrupt
[    5.155876] pcie_pme 0000:00:1c.4:pcie001: service driver pcie_pme loaded
[    5.156574] pcieport 0000:80:00.0: Signaling PME through PCIe PME interrupt
[    5.161404] pcie_pme 0000:80:00.0:pcie001: service driver pcie_pme loaded
[    5.162088] pcieport 0000:80:01.0: Signaling PME through PCIe PME interrupt
[    5.162773] pcie_pme 0000:80:01.0:pcie001: service driver pcie_pme loaded
[    5.163432] pcieport 0000:80:01.1: Signaling PME through PCIe PME interrupt
[    5.164060] pcie_pme 0000:80:01.1:pcie001: service driver pcie_pme loaded
[    5.164662] pcieport 0000:80:02.0: Signaling PME through PCIe PME interrupt
[    5.165307] pcie_pme 0000:80:02.0:pcie001: service driver pcie_pme loaded
[    5.165985] pcieport 0000:80:02.2: Signaling PME through PCIe PME interrupt
[    5.170636] pcie_pme 0000:80:02.2:pcie001: service driver pcie_pme loaded
[    5.171750] pcieport 0000:80:03.0: Signaling PME through PCIe PME interrupt
[    5.172439] pci 0000:86:00.0: Signaling PME through PCIe PME interrupt
[    5.173562] pcie_pme 0000:80:03.0:pcie001: service driver pcie_pme loaded
[    5.174708] vesafb: mode is 800x600x16, linelength=1600, pages=7
[    5.176029] vesafb: scrolling: redraw
[    5.179960] vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
[    5.180592] vesafb: framebuffer at 0xe7000000, mapped to 0xffffc90006c00000, using 1875k, total 8192k
[    5.229694] Console: switching to colour frame buffer device 100x37
[    5.279951] fb0: VESA VGA frame buffer device
[    5.280398] intel_idle: MWAIT substates: 0x1120
[    5.280777] intel_idle: v0.4.1 model 0x3E
[    5.282481] intel_idle: lapic_timer_reliable_states 0xffffffff
[    5.283134] ERST: Error Record Serialization Table (ERST) support is initialized.
[    5.283840] pstore: using zlib compression
[    5.284196] pstore: Registered erst as persistent store backend
[    5.284919] GHES: APEI firmware first mode is enabled by WHEA _OSC.
[    5.285578] Serial: 8250/16550 driver, 8 ports, IRQ sharing disabled
[    5.286266] serial 00:03: pnp_assign_resources, try dependent set 0
[    5.289851] serial 00:03: [io  0x02f8-0x02ff]
[    5.290278] serial 00:03:   device 0000:00:16.1 using irq 5
[    5.290743] serial 00:03:   device 0000:00:1f.3 using irq 10
[    5.291212] serial 00:03:   device 0000:00:16.0 using irq 11
[    5.291822] serial 00:03: [irq 12]
[    5.292159] serial 00:03:   dma 0 disabled
[    5.292546] serial 00:03: [dma 18446744073709551615 disabled]
[    5.292972] serial 00:03: pnp_assign_resources succeeded: current resources:
[    5.293635] serial 00:03: [io  0x02f8-0x02ff flags 0x40000101]
[    5.294229] serial 00:03: [irq 12 flags 0x40000401]
[    5.294757] serial 00:03: [dma 18446744073709551615 flags 0x50000800]
[    5.295408] serial 00:03: pnp_start_dev: current resources:
[    5.295980] serial 00:03: [io  0x02f8-0x02ff flags 0x40000101]
[    5.299790] serial 00:03: [irq 12 flags 0x40000401]
[    5.300332] serial 00:03: [dma 18446744073709551615 flags 0x50000800]
[    5.300986] serial 00:03: set resources
[    5.301703] serial 00:03: encode 3 resources
[    5.302128] serial 00:03:   encode io 0x2f8-0x2ff decode 0x1
[    5.302669] serial 00:03:   encode irq 12 edge high exclusive (2-byte descriptor)
[    5.303360] serial 00:03:   encode dma (disabled)
[    5.304268] serial 00:03: activated
[    5.325005] 00:03: ttyS1 at I/O 0x2f8 (irq = 12, base_baud = 115200) is a 16550A
[    5.326526] Non-volatile memory driver v1.3
[    5.326983] Linux agpgart interface v0.103
[    5.333260] libphy: Fixed MDIO Bus: probed
[    5.333718] i8042: PNP: No PS/2 controller found. Probing ports directly.
[    5.860194] tsc: Refined TSC clocksource calibration: 2299.999 MHz
[    5.860865] clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2127345424d, max_idle_ns: 440795318347 ns
[    6.361962] i8042: No controller found
[    6.362470] mousedev: PS/2 mouse device common for all mice
[    6.363237] Key type dns_resolver registered
[    6.365159] microcode: sig=0x306e2, pf=0x1, revision=0x20d
[    6.366581] microcode: Microcode Update Driver: v2.01 <tigran@aivazian.fsnet.co.uk>, Peter Oruba
[    6.370062] registered taskstats version 1
[    6.370475] Loading compiled-in X.509 certificates
[    6.373289] alg: No test for pkcs1pad(rsa,sha256) (pkcs1pad(rsa-generic,sha256))
[    6.374869] Loaded X.509 cert 'Build time autogenerated kernel key: f8cff5ba05d4eb45c1db76af1201728efd559897'
[    6.375827] AppArmor: AppArmor sha1 policy hashing enabled
[    6.377290] BERT: Can't request iomem region <000000008e2c9c98-000000008e2c9cab>.
[    6.380377]   Magic number: 4:417:345
[    6.380793] tty tty62: hash matches
[    6.381300] PM: Checking hibernation image partition /dev/disk/by-id/ata-WDC_WD5000BHTZ-04JCPV1_WD-WXA1E54KKR60-part1
[    6.382283] PM: Hibernation image not present or could not be loaded.
[    6.384534] Freeing unused kernel memory: 1716K (ffffffff81b0d000 - ffffffff81cba000)
[    6.385278] Write protecting the kernel read-only data: 10240k
[    6.386173] Freeing unused kernel memory: 448K (ffff880001590000 - ffff880001600000)
[    6.391182] Freeing unused kernel memory: 1472K (ffff880001890000 - ffff880001a00000)
[    6.439852] scsi_mod: module verification failed: signature and/or required key missing - tainting kernel
[    6.496278] SCSI subsystem initialized
[    6.499142] libata version 3.00 loaded.
[    6.501050] ahci 0000:00:1f.2: version 3.0
[    6.501703] ahci 0000:00:1f.2: AHCI 0001.0300 32 slots 6 ports 6 Gbps 0x0 impl SATA mode
[    6.502544] ahci 0000:00:1f.2: flags: 64bit ncq sntf pm led clo pio slum part ems apst
[    6.503841] scsi host0: ahci
[    6.504273] scsi host1: ahci
[    6.504663] scsi host2: ahci
[    6.505068] scsi host3: ahci
[    6.505452] scsi host4: ahci
[    6.505831] scsi host5: ahci
[    6.506204] ata1: DUMMY
[    6.506535] ata2: DUMMY
[    6.506786] ata3: DUMMY
[    6.510635] ata4: DUMMY
[    6.510869] ata5: DUMMY
[    6.511100] ata6: DUMMY
[    6.514698] udev: starting version 147
[    6.562443] isci: Intel(R) C600 SAS Controller Driver - version 1.2.0
[    6.563200] isci 0000:06:00.0: driver configured for rev: 6 silicon
[    6.563851] isci 0000:06:00.0: OEM parameter table found in OROM
[    6.564679] isci 0000:06:00.0: OEM SAS parameters (version: 1.0) loaded (platform)
[    6.566851] isci 0000:06:00.0: SCU controller 0: phy 3-0 cables: {short, short, short, short}
[    6.569969] scsi host6: isci
[    6.884432] clocksource: Switched to clocksource tsc
[    7.588399] sas: phy-6:0 added to port-6:0, phy_mask:0x1 (ffffffffffffffff)
[    7.589112] sas: DOING DISCOVERY on port 0, pid:270
[    7.589631] sas: DONE DISCOVERY on port 0, pid:270, result:0
[    7.590346] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[    7.590938] sas: ata7: end_device-6:0: dev error handler
[    7.756885] ata7.00: ATA-8: WDC WD5000BHTZ-04JCPV1, 04.06A01, max UDMA/133
[    7.757557] ata7.00: 976773168 sectors, multi 0: LBA48 NCQ (depth 31/32)
[    7.758838] ata7.00: configured for UDMA/133
[    7.759309] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[    7.769975] scsi 6:0:0:0: Direct-Access     ATA      WDC WD5000BHTZ-0 6A01 PQ: 0 ANSI: 5
[    7.803329] sd 6:0:0:0: [sda] 976773168 512-byte logical blocks: (500 GB/466 GiB)
[    7.804087] sd 6:0:0:0: [sda] 4096-byte physical blocks
[    7.804835] sd 6:0:0:0: [sda] Write Protect is off
[    7.805325] sd 6:0:0:0: [sda] Mode Sense: 00 3a 00 00
[    7.805835] sd 6:0:0:0: [sda] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
[    7.821720]  sda: sda1 sda2
[    7.822370] sd 6:0:0:0: [sda] Attached SCSI disk
[    7.897827] random: fast init done
[    7.930745] [drm] Initialized drm 1.1.0 20060810
[    7.936136] [drm] AST 2300 detected
[    7.936545] [drm] Analog VGA only
[    7.936881] [drm] dram 1632000000 1 16 00800000
[    7.937576] [TTM] Zone  kernel: Available graphics memory: 32971104 kiB
[    7.938142] [TTM] Zone   dma32: Available graphics memory: 2097152 kiB
[    7.938718] [TTM] Initializing pool allocator
[    7.939133] [TTM] Initializing DMA pool allocator
[    7.947410] checking generic (e7000000 800000) vs hw (e7000000 800000)
[    7.950234] fb: switching to astdrmfb from VESA VGA
[    7.950818] Console: switching to colour dummy device 80x25
[    7.951442] fbcon: astdrmfb (fb0) is primary device
[    7.968848] Console: switching to colour frame buffer device 128x48
[    7.998082] ast 0000:0a:00.0: fb0: astdrmfb frame buffer device
[    8.012293] [drm] Initialized ast 0.1.0 20120228 for 0000:0a:00.0 on minor 0
[    8.041703] PM: Starting manual resume from disk
[    8.042177] PM: Hibernation image partition 8:1 present
[    8.042666] PM: Looking for hibernation image.
[    8.043452] PM: Image not found (code -22)
[    8.043849] PM: Hibernation image not present or could not be loaded.
[    8.573073] EXT4-fs (sda2): mounting ext3 file system using the ext4 subsystem
[    8.664935] EXT4-fs (sda2): mounted filesystem with ordered data mode. Opts: acl,user_xattr
[    8.722520] EXT4-fs (sda2): re-mounted. Opts: acl,user_xattr



--/9DWx/yDrRhgMJTb--
