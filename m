From: David Howells <dhowells@redhat.com>
Subject: Early serial port problems
Date: Wed, 02 Mar 2005 14:19:05 +0000
Message-ID: <5895.1109773145@redhat.com>
Received: from mx1.redhat.com ([66.187.233.31]:54716 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262300AbVCBOTZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 2 Mar 2005 09:19:25 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+serial@arm.linux.org.uk
Cc: linux-serial@vger.kernel.org


Hi Russell,

I've got a couple of problems with registering serial ports with
early_serial_setup() on my FRV board with 2.6.11:

 (1) If I have no gdbstub compiled in, I try to register both serial ports
     early, but only ttyS0 works. The kernel knows both serial ports are there;
     both are mentioned in the boot console logs, both can be seen in
     /proc/tty/driver/serial, and both can be opened. However, all operations
     on ttyS0 give EIO.

     If either port is registered by itself then it works. I've changed the
     definitions in arch/frv/kernel/setup.c from what's in the standard kernel
     to include line IDs:

	static struct uart_port __initdata __frv_uart0 = {
		.uartclk		= 0,
		.membase		= (char *) UART0_BASE,
		.irq			= IRQ_CPU_UART0,
		.regshift		= 3,
		.iotype			= UPIO_MEM,
		.flags			= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 -->		.line			= 0,
	};

	static struct uart_port __initdata __frv_uart1 = {
		.uartclk		= 0,
		.membase		= (char *) UART1_BASE,
		.irq			= IRQ_CPU_UART1,
		.regshift		= 3,
		.iotype			= UPIO_MEM,
		.flags			= UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,
 -->		.line			= 1,
	};

     Note that .uartclk is set by the code rather than being compiled in.

 (2) The boot console log lines for the serial ports and the proc tty listing
     show an address of 0 because __frv_uart0.mapbase and __frv_uart1.mapbase
     aren't set:

	Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
	ttyS0 at MMIO 0x0 (irq = 1) is a 16550A
	ttyS1 at MMIO 0x0 (irq = 2) is a 16550A
	io scheduler noop registered

     If I set .mapbase as well as .membase before calling early_serial_setup(),
     then I see the kernel console output appear, but userspace can't access
     the serial ports, and the serial driver doesn't record the existence of
     the ports in the console log:

	Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing enabled
	io scheduler noop registered

     Adding in UPF_IOREMAP makes no difference.

     Unsetting .membase and just leaving .mapbase set and UPF_IOREMAP set means
     that you don't even get kernel console output, though the kernel still
     boots.

I wonder if (1) is related to (2).

Is there anything you can suggest?

David
