From: Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 1/2] 8250: allow platform uarts to install PM callback.
Date: Wed, 25 Mar 2009 18:55:11 +0100
Message-ID: <1238003712-17521-2-git-send-email-mano@roarinelk.homelinux.net>
References: <1238003712-17521-1-git-send-email-mano@roarinelk.homelinux.net>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f169.google.com ([209.85.218.169]:61960 "EHLO
	mail-bw0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763306AbZCYRzR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 25 Mar 2009 13:55:17 -0400
Received: by bwz17 with SMTP id 17so155258bwz.37
        for <linux-serial@vger.kernel.org>; Wed, 25 Mar 2009 10:55:14 -0700 (PDT)
In-Reply-To: <1238003712-17521-1-git-send-email-mano@roarinelk.homelinux.net>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial <linux-serial@vger.kernel.org>
Cc: Manuel Lauss <mlau@msc-ge.com>, Manuel Lauss <mano@roarinelk.homelinux.net>

From: Manuel Lauss <mlau@msc-ge.com>

The 8250 UART driver provides rudimentary UART PM support and
a callback for systems to do more sophisticated power management.
However, there is no way yet for platform_device uarts to assign
something this internal callback.

This patch adds a callback to plat_serial8250_port and a function to
register this callback with 8250 driver internals.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 drivers/serial/8250.c       |   31 ++++++++++++++++++++++++++++---
 include/linux/serial_8250.h |    6 ++++++
 2 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index b4b3981..55bfd1d 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2933,7 +2933,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.dev		= &dev->dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port_with_pm(&port, p->pm);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -3045,8 +3045,10 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
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
@@ -3057,7 +3059,9 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
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
@@ -3081,6 +3085,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->pm		= pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
@@ -3106,6 +3111,26 @@ int serial8250_register_port(struct uart_port *port)
 
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
index d4d2a78..636ef27 100644
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
@@ -31,6 +34,8 @@ struct plat_serial8250_port {
 	unsigned int	type;		/* If UPF_FIXED_TYPE */
 	unsigned int	(*serial_in)(struct uart_port *, int);
 	void		(*serial_out)(struct uart_port *, int, int);
+	void 		(*pm)(struct uart_port *port, unsigned int state,
+			      unsigned int old_state);
 };
 
 /*
@@ -61,6 +66,7 @@ enum {
 struct uart_port;
 
 int serial8250_register_port(struct uart_port *);
+int serial8250_register_port_with_pm(struct uart_port *, plat8250_pm_func_t);
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
1.6.2

