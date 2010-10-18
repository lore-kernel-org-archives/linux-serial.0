From: dirk.brandewie@gmail.com
Subject: [PATCH] serial: abstraction for 8250 legacy ports
Date: Mon, 18 Oct 2010 11:38:02 -0700
Message-ID: <6858904d0c5c5eb42bedf92a093817252dc85549.1287426968.git.dirk.brandewie@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:47903 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750848Ab0JRSZc (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 18 Oct 2010 14:25:32 -0400
Received: by gyg13 with SMTP id 13so631099gyg.19
        for <linux-serial@vger.kernel.org>; Mon, 18 Oct 2010 11:25:31 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.orglinux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, gregkh@suse.de, dirk.brandewie@gmail.com, sodaville@linutronix.de

From: Alan Cox <alan@linux.intel.com>

Not every platform that has generic legacy 8250 ports manages to have them
clocked the right way or without errata. Provide a generic interface to
allow platforms to override the default behaviour in a manner that dumps
the complexity in *their* code not the 8250 driver.

Signed-off-by: Alan Cox <alan@linux.intel.com>
Signed-off-by: Dirk Brandewie <dirk.brandewie@gmail.com>
---
 drivers/serial/8250.c       |   17 +++++++++++++++++
 include/linux/serial_8250.h |    4 ++++
 2 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 24110f6..feb595d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2674,6 +2674,16 @@ static struct uart_ops serial8250_pops = {
 
 static struct uart_8250_port serial8250_ports[UART_NR];
 
+static void (*serial8250_isa_config)(int port, struct uart_port *up,
+	unsigned short *capabilities);
+
+void serial8250_set_isa_configurator(
+	void (*v)(int port, struct uart_port *up, unsigned short *capabilities))
+{
+	serial8250_isa_config = v;
+}
+EXPORT_SYMBOL(serial8250_set_isa_configurator);
+
 static void __init serial8250_isa_init_ports(void)
 {
 	struct uart_8250_port *up;
@@ -2719,6 +2729,9 @@ static void __init serial8250_isa_init_ports(void)
 		up->port.regshift = old_serial_port[i].iomem_reg_shift;
 		set_io_from_upio(&up->port);
 		up->port.irqflags |= irqflag;
+		if (serial8250_isa_config != NULL)
+			serial8250_isa_config(i, &up->port, &up->capabilities);
+
 	}
 }
 
@@ -3177,6 +3190,10 @@ int serial8250_register_port(struct uart_port *port)
 		if (port->set_termios)
 			uart->port.set_termios = port->set_termios;
 
+		if (serial8250_isa_config != NULL)
+			serial8250_isa_config(0, &uart->port,
+					&uart->capabilities);
+
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
 			ret = uart->port.line;
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 7638dea..1214c4d 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -77,4 +77,8 @@ extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
 
+extern void serial8250_set_isa_configurator(void (*v)
+					(int port, struct uart_port *up,
+						unsigned short *capabilities));
+
 #endif
-- 
1.7.2.3

