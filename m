From: Gyorgy Jeney <nog.lkml@gmail.com>
Subject: [patch][rfc] 8250_early: Too early for ioremap
Date: Sun, 1 Jan 2006 16:12:21 +0100
Message-ID: <221e0ff70601010712l3ee799c0n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.203]:9689 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932227AbWAAPMW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Jan 2006 10:12:22 -0500
Received: by xproxy.gmail.com with SMTP id s14so1479633wxc
        for <linux-serial@vger.kernel.org>; Sun, 01 Jan 2006 07:12:21 -0800 (PST)
Content-Disposition: inline
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc: linux-kernel@vger.kernel.org, rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org

From: Gyorgy Jeney

Let the individual architectures define the function to use to remap the mmio-
range that will be used by the 8250_early driver.  This is needed because, the
default, ioremap() is non-functional when the 8250_early driver initialises.

Signed-off-by: Gyorgy Jeney <nog.lkml@gmail.com>

---

The 8250_early driver gets used early in the boot process, when the full-blown
ioremap() function is still unavailible.  The logical looking solution would be
to simply s/ioremap/bt_ioremap/, s/iounmap/bt_iounmap/ but the only port in the
2.6.14 kernel that has that function is i386.  Those functions look pretty
generic so perhaps they could be moved to mm/bootmem.c or something but they
rely on fixmap to be availibe which is only availible on 9 out of 25 archs.
The best I could come up with is the attached "hack".

Since the mmio code does appear in 8250_early I'm guessing that it works for
someone out there, which means this change is wrong..  How do I get 8250_early
to use MMIO cleanly?

nog.

--- drivers/serial/8250_early.c	2005-10-28 02:02:08.000000000 +0200
+++ ../../linux-2.6.14/drivers/serial/8250_early.c	2006-01-01
14:40:28.000000000 +0100
@@ -34,6 +34,7 @@
 #include <linux/serial.h>
 #include <asm/io.h>
 #include <asm/serial.h>
+#include <linux/serial_8250.h>

 struct early_uart_device {
 	struct uart_port port;
@@ -148,7 +149,7 @@ static int __init parse_options(struct e
 	if (!strncmp(options, "mmio,", 5)) {
 		port->iotype = UPIO_MEM;
 		port->mapbase = simple_strtoul(options + 5, &options, 0);
-		port->membase = ioremap(port->mapbase, mapsize);
+		port->membase = early_8250_ioremap(port->mapbase, mapsize);
 		if (!port->membase) {
 			printk(KERN_ERR "%s: Couldn't ioremap 0x%lx\n",
 				__FUNCTION__, port->mapbase);
@@ -248,7 +249,7 @@ static int __init early_uart_console_swi

 	unregister_console(&early_uart_console);
 	if (mmio)
-		iounmap(port->membase);
+		early_8250_iounmap(port->membase, 64);

 	return 0;
 }
--- include/linux/serial_8250.h	2005-10-28 02:02:08.000000000 +0200
+++ ../../linux-2.6.14/include/linux/serial_8250.h	2006-01-01
14:42:39.000000000 +0100
@@ -57,4 +57,16 @@ void serial8250_unregister_port(int line
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);

+/*
+ * Default ioremapping functions to use in the 8250_early driver.  Individual
+ * architechtures may override these in include/asm/serial.h (to something more
+ * sane like bt_io{re,un}map).
+ */
+#ifndef early_8250_ioremap
+#define early_8250_ioremap(addr, len)	ioremap(addr, len)
+#endif
+#ifndef early_8250_iounmap
+#define early_8250_iounmap(addr, len)	iounmap(addr)
+#endif
+
 #endif
