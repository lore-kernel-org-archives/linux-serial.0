From: Stephen Warren <swarren@nvidia.com>
Subject: RE: ce4100 does no longer boots with CONFIG_EARLY_PRINTK enabled
Date: Thu, 16 Jun 2011 12:23:58 -0700
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04992C07EB@HQMAIL01.nvidia.com>
References: <20110616191128.GA32006@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:5651 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751901Ab1FPTYL convert rfc822-to-8bit (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 15:24:11 -0400
In-Reply-To: <20110616191128.GA32006@linutronix.de>
Content-Language: en-US
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Alan Cox <alan@linux.intel.com>
Cc: "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>, Greg Kroah-Hartman <gregkh@suse.de>, Dirk Brandewie <dirk.brandewie@gmail.com>, "x86@kernel.org" <x86@kernel.org>

Sebastian Andrzej Siewior wrote at Thursday, June 16, 2011 1:11 PM:
> The ce4100 discovers the uart via PCI (PCI_DEVICE_ID_INTEL_CE4100_UART).
> There is a fixup routine in has an uart defined in
> arch/x86/platform/ce4100/ce4100.c.
> 
> Booting commit 1ff42c32c76 ("x86: ce4100: Configure IOAPIC pins for USB
> and SATA to level type") results in:
> 
> | Refined TSC clocksource calibration: 1200.000 MHz.
> | Switching to clocksource tsc
> | Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> | 0000:01:0b.0: ttyS0 at MMIO 0xdffe0200 (irq = 38) is a XScale
> | console [ttyS0] enabled
> 
> i.e. it works. Booting v3.0-rc1 gives me:
> | Refined TSC clocksource calibration: 1199.999 MHz.
> | Switching to clocksource tsc
> | Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 
> and the box hangs. Current HEAD of Linus and the TIP tree gives the same
> result. Removing the legacy ports via
> 
> diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
> index 628c801..e6004c1 100644
> --- a/arch/x86/include/asm/serial.h
> +++ b/arch/x86/include/asm/serial.h
> @@ -19,11 +19,13 @@
>  #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
>  #endif
> 
> +#if 0
>  #define SERIAL_PORT_DFNS			\
>  	/* UART CLK   PORT IRQ     FLAGS        */			\
>  	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
>  	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
>  	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
>  	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
> +#endif
> 
>  #endif /* _ASM_X86_SERIAL_H */
> 
> helps. The problem with the legacy uart is that funny things happen once
> we are in APIC mode and we still use ioport 0x3f8. git bisect recommends
> to revert commit
> 
> |commit 4539c24fe4f92c09ee668ef959d3e8180df619b9
> |Author: Stephen Warren <swarren@nvidia.com>
> |Date:   Tue May 17 16:12:36 2011 -0600
> |
> |    tty/serial: Add explicit PORT_TEGRA type
> 
> This also does the job. With it removed I see:
> | Refined TSC clocksource calibration: 1200.000 MHz.
> | Switching to clocksource tsc
> | Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> | serial8250: ttyS0 at MMIO 0xdffe0200 (irq = 4) is a XScale
> | 0000:01:0b.0: ttyS0 at MMIO 0xdffe0200 (irq = 38) is a XScale

Just guessing here, but is the solution to add this patch to ToT?:

diff --git a/drivers/tty/serial/8250.c b/drivers/tty/serial/8250.c
index b40f7b9..bca2232 100644
--- a/drivers/tty/serial/8250.c
+++ b/drivers/tty/serial/8250.c
@@ -1107,7 +1107,7 @@ static void autoconfig_16550a(struct uart_8250_port *up)
                         */
                        DEBUG_AUTOCONF("Xscale ");
                        up->port.type = PORT_XSCALE;
-                       up->capabilities |= UART_CAP_UUE;
+                       up->capabilities |= UART_CAP_UUE | UART_CAP_RTOIE;
                        return;
                }
        } else {

I added a new flag used for both XSCALE and TEGRA port types, and
modified the XSCALE port type to define the new flag, thinking that all
code would take the capabilities from that port type table entry, but
perhaps the auto-detection logic needs an equivalent change for XSCALE.

> I'm little worried that it seems somehow that I have two uarts at
> 0xdffe0200 and IRQ4 which is evil.

That does sound odd. It's very unclear to me how my change would cause
that...

> Any recomendations on that? Should we declare SERIAL_PORT_DFNS via
> x86_ops or is the PORT_TEGRA regression obvious?
> 
> Sebastian

-- 
nvpublic

