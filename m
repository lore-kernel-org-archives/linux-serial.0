From: Art Haas <ahaas@airmail.net>
Subject: [PATCH] C99 initializers for drivers/serial
Date: Mon, 18 Nov 2002 11:32:16 -0600
Sender: linux-serial-owner@vger.kernel.org
Message-ID: <20021118173216.GN4228@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-serial-owner@vger.kernel.org>
Content-Disposition: inline
List-Id: linux-serial@vger.kernel.org
To: Theodore Ts'o <tytso@mit.edu>, linux-serial@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>

Hi.

Here's a set of patches that switch drivers/serial to use C99
initializers. The patches are against 2.5.48.

Art Haas

--- linux-2.5.48/drivers/serial/68328serial.c.old	2002-11-11 07:14:48.000000000 -0600
+++ linux-2.5.48/drivers/serial/68328serial.c	2002-11-18 01:09:28.000000000 -0600
@@ -1682,12 +1682,12 @@
 
 
 static struct console m68328_driver = {
-	name:		"ttyS",
-	write:		m68328_console_write,
-	device:		m68328_console_device,
-	setup:		m68328_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttyS",
+	.write		= m68328_console_write,
+	.device		= m68328_console_device,
+	.setup		= m68328_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 
--- linux-2.5.48/drivers/serial/68360serial.c.old	2002-11-11 07:14:48.000000000 -0600
+++ linux-2.5.48/drivers/serial/68360serial.c	2002-11-18 01:09:28.000000000 -0600
@@ -2566,13 +2566,13 @@
 
 
 struct console sercons = {
- 	name:		"ttyS",
- 	write:		serial_console_write,
- 	device:		serial_console_device,
- 	wait_key:	serial_console_wait_key,
- 	setup:		serial_console_setup,
- 	flags:		CON_PRINTBUFFER,
- 	index:		CONFIG_SERIAL_CONSOLE_PORT, 
+ 	.name		= "ttyS",
+ 	.write		= serial_console_write,
+ 	.device		= serial_console_device,
+ 	.wait_key	= serial_console_wait_key,
+ 	.setup		= serial_console_setup,
+ 	.flags		= CON_PRINTBUFFER,
+ 	.index		= CONFIG_SERIAL_CONSOLE_PORT, 
 };
 
 
--- linux-2.5.48/drivers/serial/8250_gsc.c.old	2002-11-05 09:33:46.000000000 -0600
+++ linux-2.5.48/drivers/serial/8250_gsc.c	2002-11-18 01:09:28.000000000 -0600
@@ -112,15 +112,15 @@
 MODULE_DEVICE_TABLE(parisc, serial_tbl);
 
 static struct parisc_driver serial1_driver = {
-	name:		"Serial RS232",
-	id_table:	serial1_tbl,
-	probe:		serial_init_chip,
+	.name		= "Serial RS232",
+	.id_table	= serial1_tbl,
+	.probe		= serial_init_chip,
 };
 
 static struct parisc_driver serial_driver = {
-	name:		"Serial RS232",
-	id_table:	serial_tbl,
-	probe:		serial_init_chip,
+	.name		= "Serial RS232",
+	.id_table	= serial_tbl,
+	.probe		= serial_init_chip,
 };
 
 int __init probe_serial_gsc(void)
--- linux-2.5.48/drivers/serial/mcfserial.c.old	2002-11-11 07:14:48.000000000 -0600
+++ linux-2.5.48/drivers/serial/mcfserial.c	2002-11-18 01:09:28.000000000 -0600
@@ -1853,12 +1853,12 @@
  */
 
 struct console mcfrs_console = {
-	name:		"ttyS",
-	write:		mcfrs_console_write,
-	device:		mcfrs_console_device,
-	setup:		mcfrs_console_setup,
-	flags:		CON_PRINTBUFFER,
-	index:		-1,
+	.name		= "ttyS",
+	.write		= mcfrs_console_write,
+	.device		= mcfrs_console_device,
+	.setup		= mcfrs_console_setup,
+	.flags		= CON_PRINTBUFFER,
+	.index		= -1,
 };
 
 void __init mcfrs_console_init(void)
--- linux-2.5.48/drivers/serial/nb85e_uart.c.old	2002-11-11 07:14:48.000000000 -0600
+++ linux-2.5.48/drivers/serial/nb85e_uart.c	2002-11-18 01:09:28.000000000 -0600
@@ -255,12 +255,12 @@
 
 static struct console nb85e_uart_cons =
 {
-    name:	"ttyS",
-    write:	nb85e_uart_cons_write,
-    device:	nb85e_uart_cons_device,
-    flags:	CON_PRINTBUFFER,
-    cflag:	NB85E_UART_INIT_CFLAGS,
-    index:	-1,
+    .name	= "ttyS",
+    .write	= nb85e_uart_cons_write,
+    .device	= nb85e_uart_cons_device,
+    .flags	= CON_PRINTBUFFER,
+    .cflag	= NB85E_UART_INIT_CFLAGS,
+    .index	= -1,
 };
 
 void nb85e_uart_cons_init (unsigned chan)
--- linux-2.5.48/drivers/serial/uart00.c.old	2002-11-11 07:14:48.000000000 -0600
+++ linux-2.5.48/drivers/serial/uart00.c	2002-11-18 07:56:48.000000000 -0600
@@ -731,9 +731,9 @@
 }
 
 struct pld_hotswap_ops uart00_pldhs_ops={
-	name: "uart00",
-	add_device: uart00_add_device,
-	remove_devices:uart00_remove_devices,
+	.name		= "uart00",
+	.add_device	= uart00_add_device,
+	.remove_devices	= uart00_remove_devices,
 };
 
 #endif
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
