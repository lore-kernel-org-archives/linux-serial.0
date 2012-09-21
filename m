From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [RFC 3/3] ARM/AVR32: get rid of serial_at91.h
Date: Fri, 21 Sep 2012 10:36:48 +0100
Message-ID: <E1TEzfE-000780-1t@rmk-PC.arm.linux.org.uk>
References: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from caramon.arm.linux.org.uk ([78.32.30.218]:37297 "EHLO
	caramon.arm.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757111Ab2IUJgy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 21 Sep 2012 05:36:54 -0400
In-Reply-To: <20120921093530.GB31374@n2100.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, linux-usb@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>

The definitions provided by serial_at91.h are only used by the
atmel_serial driver, and the function that uses it is never called
from anywhere in the kernel.  Therefore, these definitions are unused
and/or obsolete, and can be removed.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/include/asm/mach/serial_at91.h   |   33 -----------------------------
 arch/avr32/include/asm/mach/serial_at91.h |   33 -----------------------------
 drivers/tty/serial/atmel_serial.c         |   18 ---------------
 3 files changed, 0 insertions(+), 84 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
 delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h

diff --git a/arch/arm/include/asm/mach/serial_at91.h b/arch/arm/include/asm/mach/serial_at91.h
deleted file mode 100644
index ea6d063..0000000
--- a/arch/arm/include/asm/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  arch/arm/include/asm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct atmel_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void atmel_register_uart_fns(struct atmel_port_fns *fns);
-#else
-#define atmel_register_uart_fns(fns) do { } while (0)
-#endif
-
-
diff --git a/arch/avr32/include/asm/mach/serial_at91.h b/arch/avr32/include/asm/mach/serial_at91.h
deleted file mode 100644
index 55b317a..0000000
--- a/arch/avr32/include/asm/mach/serial_at91.h
+++ /dev/null
@@ -1,33 +0,0 @@
-/*
- *  linux/include/asm-arm/mach/serial_at91.h
- *
- *  Based on serial_sa1100.h  by Nicolas Pitre
- *
- *  Copyright (C) 2002 ATMEL Rousset
- *
- *  Low level machine dependent UART functions.
- */
-
-struct uart_port;
-
-/*
- * This is a temporary structure for registering these
- * functions; it is intended to be discarded after boot.
- */
-struct atmel_port_fns {
-	void	(*set_mctrl)(struct uart_port *, u_int);
-	u_int	(*get_mctrl)(struct uart_port *);
-	void	(*enable_ms)(struct uart_port *);
-	void	(*pm)(struct uart_port *, u_int, u_int);
-	int	(*set_wake)(struct uart_port *, u_int);
-	int	(*open)(struct uart_port *);
-	void	(*close)(struct uart_port *);
-};
-
-#if defined(CONFIG_SERIAL_ATMEL)
-void atmel_register_uart_fns(struct atmel_port_fns *fns);
-#else
-#define atmel_register_uart_fns(fns) do { } while (0)
-#endif
-
-
diff --git a/drivers/tty/serial/atmel_serial.c b/drivers/tty/serial/atmel_serial.c
index 3d7e1ee..a6134c9 100644
--- a/drivers/tty/serial/atmel_serial.c
+++ b/drivers/tty/serial/atmel_serial.c
@@ -43,7 +43,6 @@
 #include <asm/io.h>
 #include <asm/ioctls.h>
 
-#include <asm/mach/serial_at91.h>
 #include <mach/board.h>
 
 #ifdef CONFIG_ARM
@@ -1513,23 +1512,6 @@ static void __devinit atmel_init_port(struct atmel_uart_port *atmel_port,
 	}
 }
 
-/*
- * Register board-specific modem-control line handlers.
- */
-void __init atmel_register_uart_fns(struct atmel_port_fns *fns)
-{
-	if (fns->enable_ms)
-		atmel_pops.enable_ms = fns->enable_ms;
-	if (fns->get_mctrl)
-		atmel_pops.get_mctrl = fns->get_mctrl;
-	if (fns->set_mctrl)
-		atmel_pops.set_mctrl = fns->set_mctrl;
-	atmel_open_hook		= fns->open;
-	atmel_close_hook	= fns->close;
-	atmel_pops.pm		= fns->pm;
-	atmel_pops.set_wake	= fns->set_wake;
-}
-
 struct platform_device *atmel_default_console_device;	/* the serial console device */
 
 #ifdef CONFIG_SERIAL_ATMEL_CONSOLE
-- 
1.7.4.4

