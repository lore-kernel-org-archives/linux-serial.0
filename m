From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 1/2] 8250: allow platform uarts to install PM callback.
Date: Tue, 23 Feb 2010 19:22:26 +0100
Message-ID: <1266949347-12024-2-git-send-email-manuel.lauss@gmail.com>
References: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f209.google.com ([209.85.218.209]:45868 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751990Ab0BWSVh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 23 Feb 2010 13:21:37 -0500
Received: by bwz1 with SMTP id 1so1240320bwz.21
        for <linux-serial@vger.kernel.org>; Tue, 23 Feb 2010 10:21:35 -0800 (PST)
In-Reply-To: <1266949347-12024-1-git-send-email-manuel.lauss@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Linux Serial <linux-serial@vger.kernel.org>
Cc: Linux-MIPS <linux-mips@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>

The 8250 UART driver provides rudimentary UART PM support and
a callback for systems to do more sophisticated power management.
However, there is no way yet for platform_device uarts to assign
something this internal callback.

This patch adds a callback to struct plat_serial8250_port and a
function to register this callback with 8250 driver internals.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 drivers/serial/8250.c       |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h |    6 ++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index a81ff7b..7802266 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2966,7 +2966,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.serial_out		= p->serial_out;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port_with_pm(&port, p->pm);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -3078,8 +3078,10 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
 }
 
 /**
- *	serial8250_register_port - register a serial port
+ *	serial8250_register_port_with_pm - register a serial port and its
+ *					   power management callback.
  *	@port: serial port template
+ *	@pm:   PM callback for this port, can be NULL.
  *
  *	Configure the serial port specified by the request. If the
  *	port exists and is in use, it is hung up and unregistered
@@ -3090,7 +3092,9 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+int serial8250_register_port_with_pm(struct uart_port *port,
+	void(*pm)(struct uart_port *port, unsigned int state,
+		  unsigned int old))
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -3115,6 +3119,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->pm		= pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
@@ -3140,6 +3145,26 @@ int serial8250_register_port(struct uart_port *port)
 
 	return ret;
 }
+EXPORT_SYMBOL(serial8250_register_port_with_pm);
+
+/**
+ *	serial8250_register_port - register a serial port
+ *	@port: serial port template
+ *
+ *	Configure the serial port specified by the request. If the
+ *	port exists and is in use, it is hung up and unregistered
+ *	first.
+ *
+ *	The port is then probed and if necessary the IRQ is autodetected
+ *	If this fails an error is returned.
+ *
+ *	On success the port is ready to use and the line number is returned.
+ */
+int serial8250_register_port(struct uart_port *port)
+{
+	return serial8250_register_port_with_pm(port, NULL);
+}
+
 EXPORT_SYMBOL(serial8250_register_port);
 
 /**
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index fb46aba..25cc3fb 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -14,6 +14,9 @@
 #include <linux/serial_core.h>
 #include <linux/platform_device.h>
 
+typedef void(*plat8250_pm_func_t)(struct uart_port *port, unsigned int state,
+				  unsigned int old_state);
+
 /*
  * This is the platform device platform_data structure
  */
@@ -32,6 +35,8 @@ struct plat_serial8250_port {
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	void 		(*pm)(struct uart_port *port, unsigned int state,
+			      unsigned int old_state);
 };
 
 /*
@@ -62,6 +67,7 @@ enum {
 struct uart_port;
 
 int serial8250_register_port(struct uart_port *);
+int serial8250_register_port_with_pm(struct uart_port *, plat8250_pm_func_t);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
1.7.0

