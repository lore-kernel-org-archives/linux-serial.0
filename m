From: Sean Young <sean@mess.org>
Subject: [PATCH 1/2] 8250_pnp: merge into 8250 module so pnp probe can done first
Date: Thu,  6 Sep 2012 23:20:31 +0100
Message-ID: <1b56181b1656bab96823c683f4a778327ebfda45.1346969721.git.sean@mess.org>
References: <cover.1346969721.git.sean@mess.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from pequod.mess.org ([93.97.41.153]:43600 "EHLO pequod.mess.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751579Ab2IFWUe (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 6 Sep 2012 18:20:34 -0400
In-Reply-To: <cover.1346969721.git.sean@mess.org>
In-Reply-To: <cover.1346969721.git.sean@mess.org>
References: <cover.1346969721.git.sean@mess.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org
Cc: =?UTF-8?q?David=20H=C3=A4rdeman?= <david@hardeman.nu>, Mauro Carvalho Chehab <mchehab@redhat.com>

We first poke around and guess where the serial ports are and then check
pnp. If there is a non-standard configuration then this might not work;
if there is an IR device in pnp then we should not attempt to probe it.

Signed-off-by: Sean Young <sean@mess.org>
---
 drivers/tty/serial/8250/8250.c     | 31 ++++++++++++++++++-------------
 drivers/tty/serial/8250/8250.h     |  9 +++++++++
 drivers/tty/serial/8250/8250_pnp.c | 11 +++--------
 drivers/tty/serial/8250/Kconfig    | 16 ++++++++--------
 drivers/tty/serial/8250/Makefile   |  5 +++--
 5 files changed, 41 insertions(+), 31 deletions(-)

diff --git a/drivers/tty/serial/8250/8250.c b/drivers/tty/serial/8250/8250.c
index 44f52c6..bc25874 100644
--- a/drivers/tty/serial/8250/8250.c
+++ b/drivers/tty/serial/8250/8250.c
@@ -2672,6 +2672,9 @@ static void __init serial8250_isa_init_ports(void)
 		return;
 	first = 0;
 
+	if (nr_uarts > UART_NR)
+		nr_uarts = UART_NR;
+
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
 		struct uart_port *port = &up->port;
@@ -2681,6 +2684,7 @@ static void __init serial8250_isa_init_ports(void)
 
 		init_timer(&up->timer);
 		up->timer.function = serial8250_timeout;
+		up->cur_iotype = 0xFF;
 
 		/*
 		 * ALPHA_KLUDGE_MCR needs to be killed.
@@ -2732,13 +2736,9 @@ serial8250_register_ports(struct uart_driver *drv, struct device *dev)
 
 	for (i = 0; i < nr_uarts; i++) {
 		struct uart_8250_port *up = &serial8250_ports[i];
-		up->cur_iotype = 0xFF;
-	}
 
-	serial8250_isa_init_ports();
-
-	for (i = 0; i < nr_uarts; i++) {
-		struct uart_8250_port *up = &serial8250_ports[i];
+		if (up->port.dev)
+			continue;
 
 		up->port.dev = dev;
 
@@ -2863,9 +2863,6 @@ static struct console serial8250_console = {
 
 static int __init serial8250_console_init(void)
 {
-	if (nr_uarts > UART_NR)
-		nr_uarts = UART_NR;
-
 	serial8250_isa_init_ports();
 	register_console(&serial8250_console);
 	return 0;
@@ -3148,7 +3145,8 @@ int serial8250_register_8250_port(struct uart_8250_port *up)
 
 	uart = serial8250_find_match_or_unused(&up->port);
 	if (uart) {
-		uart_remove_one_port(&serial8250_reg, &uart->port);
+		if (uart->port.dev)
+			uart_remove_one_port(&serial8250_reg, &uart->port);
 
 		uart->port.iobase       = up->port.iobase;
 		uart->port.membase      = up->port.membase;
@@ -3232,8 +3230,7 @@ static int __init serial8250_init(void)
 {
 	int ret;
 
-	if (nr_uarts > UART_NR)
-		nr_uarts = UART_NR;
+	serial8250_isa_init_ports();
 
 	printk(KERN_INFO "Serial: 8250/16550 driver, "
 		"%d ports, IRQ sharing %sabled\n", nr_uarts,
@@ -3248,11 +3245,15 @@ static int __init serial8250_init(void)
 	if (ret)
 		goto out;
 
+	ret = serial8250_pnp_init();
+	if (ret)
+		goto unreg_uart_drv;
+
 	serial8250_isa_devs = platform_device_alloc("serial8250",
 						    PLAT8250_DEV_LEGACY);
 	if (!serial8250_isa_devs) {
 		ret = -ENOMEM;
-		goto unreg_uart_drv;
+		goto unreg_pnp;
 	}
 
 	ret = platform_device_add(serial8250_isa_devs);
@@ -3268,6 +3269,8 @@ static int __init serial8250_init(void)
 	platform_device_del(serial8250_isa_devs);
 put_dev:
 	platform_device_put(serial8250_isa_devs);
+unreg_pnp:
+	serial8250_pnp_exit();
 unreg_uart_drv:
 #ifdef CONFIG_SPARC
 	sunserial_unregister_minors(&serial8250_reg, UART_NR);
@@ -3292,6 +3295,8 @@ static void __exit serial8250_exit(void)
 	platform_driver_unregister(&serial8250_isa_driver);
 	platform_device_unregister(isa_dev);
 
+	serial8250_pnp_exit();
+
 #ifdef CONFIG_SPARC
 	sunserial_unregister_minors(&serial8250_reg, UART_NR);
 #else
diff --git a/drivers/tty/serial/8250/8250.h b/drivers/tty/serial/8250/8250.h
index 0c5e908..5a76f9c 100644
--- a/drivers/tty/serial/8250/8250.h
+++ b/drivers/tty/serial/8250/8250.h
@@ -97,3 +97,12 @@ static inline void serial_dl_write(struct uart_8250_port *up, int value)
 #else
 #define ALPHA_KLUDGE_MCR 0
 #endif
+
+#ifdef CONFIG_SERIAL_8250_PNP
+int serial8250_pnp_init(void);
+void serial8250_pnp_exit(void);
+#else
+static inline int serial8250_pnp_init(void) { return 0; }
+static inline void serial8250_pnp_exit(void) { }
+#endif
+
diff --git a/drivers/tty/serial/8250/8250_pnp.c b/drivers/tty/serial/8250/8250_pnp.c
index fde5aa6..28bf830 100644
--- a/drivers/tty/serial/8250/8250_pnp.c
+++ b/drivers/tty/serial/8250/8250_pnp.c
@@ -1,5 +1,5 @@
 /*
- *  Probe module for 8250/16550-type ISAPNP serial ports.
+ *  Probe for 8250/16550-type ISAPNP serial ports.
  *
  *  Based on drivers/char/serial.c, by Linus Torvalds, Theodore Ts'o.
  *
@@ -507,18 +507,13 @@ static struct pnp_driver serial_pnp_driver = {
 	.id_table	= pnp_dev_table,
 };
 
-static int __init serial8250_pnp_init(void)
+int serial8250_pnp_init(void)
 {
 	return pnp_register_driver(&serial_pnp_driver);
 }
 
-static void __exit serial8250_pnp_exit(void)
+void serial8250_pnp_exit(void)
 {
 	pnp_unregister_driver(&serial_pnp_driver);
 }
 
-module_init(serial8250_pnp_init);
-module_exit(serial8250_pnp_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Generic 8250/16x50 PnP serial driver");
diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
index a27dd05..f3d283f 100644
--- a/drivers/tty/serial/8250/Kconfig
+++ b/drivers/tty/serial/8250/Kconfig
@@ -33,6 +33,14 @@ config SERIAL_8250
 	  Most people will say Y or M here, so that they can use serial mice,
 	  modems and similar devices connecting to the standard serial ports.
 
+config SERIAL_8250_PNP
+	bool "8250/16550 PNP device support" if EXPERT
+	depends on SERIAL_8250 && PNP
+	default y
+	---help---
+	  This builds standard PNP serial support. You may be able to
+	  disable this feature if you only need legacy serial support.
+
 config SERIAL_8250_CONSOLE
 	bool "Console on 8250/16550 and compatible serial port"
 	depends on SERIAL_8250=y
@@ -85,14 +93,6 @@ config SERIAL_8250_PCI
 	  disable this feature if you only need legacy serial support.
 	  Saves about 9K.
 
-config SERIAL_8250_PNP
-	tristate "8250/16550 PNP device support" if EXPERT
-	depends on SERIAL_8250 && PNP
-	default SERIAL_8250
-	help
-	  This builds standard PNP serial support. You may be able to
-	  disable this feature if you only need legacy serial support.
-
 config SERIAL_8250_HP300
 	tristate
 	depends on SERIAL_8250 && HP300
diff --git a/drivers/tty/serial/8250/Makefile b/drivers/tty/serial/8250/Makefile
index d7533c7..108fe7f 100644
--- a/drivers/tty/serial/8250/Makefile
+++ b/drivers/tty/serial/8250/Makefile
@@ -2,8 +2,9 @@
 # Makefile for the 8250 serial device drivers.
 #
 
-obj-$(CONFIG_SERIAL_8250)		+= 8250.o
-obj-$(CONFIG_SERIAL_8250_PNP)		+= 8250_pnp.o
+obj-$(CONFIG_SERIAL_8250)		+= 8250_core.o
+8250_core-y				:= 8250.o
+8250_core-$(CONFIG_SERIAL_8250_PNP)	+= 8250_pnp.o
 obj-$(CONFIG_SERIAL_8250_GSC)		+= 8250_gsc.o
 obj-$(CONFIG_SERIAL_8250_PCI)		+= 8250_pci.o
 obj-$(CONFIG_SERIAL_8250_HP300)		+= 8250_hp300.o
-- 
1.7.11.4

