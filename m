From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: ce4100 does no longer boots with CONFIG_EARLY_PRINTK enabled
Date: Thu, 16 Jun 2011 21:11:28 +0200
Message-ID: <20110616191128.GA32006@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:57786 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756792Ab1FPTLc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 16 Jun 2011 15:11:32 -0400
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Stephen Warren <swarren@nvidia.com>
Cc: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>, Dirk Brandewie <dirk.brandewie@gmail.com>, x86@kernel.org

The ce4100 discovers the uart via PCI (PCI_DEVICE_ID_INTEL_CE4100_UART).
There is a fixup routine in has an uart defined in
arch/x86/platform/ce4100/ce4100.c.

Booting commit 1ff42c32c76 ("x86: ce4100: Configure IOAPIC pins for USB
and SATA to level type") results in:

| Refined TSC clocksource calibration: 1200.000 MHz.
| Switching to clocksource tsc
| Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
| 0000:01:0b.0: ttyS0 at MMIO 0xdffe0200 (irq = 38) is a XScale
| console [ttyS0] enabled

i.e. it works. Booting v3.0-rc1 gives me:
| Refined TSC clocksource calibration: 1199.999 MHz.
| Switching to clocksource tsc
| Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled

and the box hangs. Current HEAD of Linus and the TIP tree gives the same
result. Removing the legacy ports via

diff --git a/arch/x86/include/asm/serial.h b/arch/x86/include/asm/serial.h
index 628c801..e6004c1 100644
--- a/arch/x86/include/asm/serial.h
+++ b/arch/x86/include/asm/serial.h
@@ -19,11 +19,13 @@
 #define STD_COM4_FLAGS ASYNC_BOOT_AUTOCONF
 #endif
 
+#if 0
 #define SERIAL_PORT_DFNS			\
 	/* UART CLK   PORT IRQ     FLAGS        */			\
 	{ 0, BASE_BAUD, 0x3F8, 4, STD_COM_FLAGS },	/* ttyS0 */	\
 	{ 0, BASE_BAUD, 0x2F8, 3, STD_COM_FLAGS },	/* ttyS1 */	\
 	{ 0, BASE_BAUD, 0x3E8, 4, STD_COM_FLAGS },	/* ttyS2 */	\
 	{ 0, BASE_BAUD, 0x2E8, 3, STD_COM4_FLAGS },	/* ttyS3 */
+#endif
 
 #endif /* _ASM_X86_SERIAL_H */

helps. The problem with the legacy uart is that funny things happen once
we are in APIC mode and we still use ioport 0x3f8. git bisect recommends
to revert commit

|commit 4539c24fe4f92c09ee668ef959d3e8180df619b9
|Author: Stephen Warren <swarren@nvidia.com>
|Date:   Tue May 17 16:12:36 2011 -0600
| 
|    tty/serial: Add explicit PORT_TEGRA type

This also does the job. With it removed I see:
| Refined TSC clocksource calibration: 1200.000 MHz.
| Switching to clocksource tsc
| Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
| serial8250: ttyS0 at MMIO 0xdffe0200 (irq = 4) is a XScale
| 0000:01:0b.0: ttyS0 at MMIO 0xdffe0200 (irq = 38) is a XScale

I'm little worried that it seems somehow that I have two uarts at
0xdffe0200 and IRQ4 which is evil.

Any recomendations on that? Should we declare SERIAL_PORT_DFNS via
x86_ops or is the PORT_TEGRA regression obvious?

Sebastian
