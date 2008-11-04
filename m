From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: [RFC/PATCH] 8250: Allow platform to register PM hook
Date: Tue,  4 Nov 2008 10:15:47 -0800
Message-ID: <1225822547-14016-1-git-send-email-khilman@deeprootsystems.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.29]:31899 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753161AbYKDSXz (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 4 Nov 2008 13:23:55 -0500
Received: by yx-out-2324.google.com with SMTP id 8so1239896yxm.1
        for <linux-serial@vger.kernel.org>; Tue, 04 Nov 2008 10:23:54 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Kevin Hilman <khilman@deeprootsystems.com>

Allow platform code to register a PM hook with the 8250 driver.  This
enables platform specific code to be run for suspend/resume events.

Since the per-port PM hook is local to the 8250 driver ('struct
uart_port' doesn't have a PM hook) I pass the pm hook from the
platform probe via serial8250_register_port().

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 drivers/serial/8250.c       |    7 +++++--
 include/linux/serial_8250.h |    7 ++++++-
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 9ccc563..63abe49 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -2762,7 +2762,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.dev		= &dev->dev;
 		if (share_irqs)
 			port.flags |= UPF_SHARE_IRQ;
-		ret = serial8250_register_port(&port);
+		ret = serial8250_register_port(&port, p->pm);
 		if (ret < 0) {
 			dev_err(&dev->dev, "unable to register port at index %d "
 				"(IO%lx MEM%llx IRQ%d): %d\n", i,
@@ -2886,7 +2886,9 @@ static struct uart_8250_port *serial8250_find_match_or_unused(struct uart_port *
  *
  *	On success the port is ready to use and the line number is returned.
  */
-int serial8250_register_port(struct uart_port *port)
+int serial8250_register_port(struct uart_port *port,
+			     void (*pm)(struct uart_port *, unsigned int state,
+					unsigned int oldstate))
 {
 	struct uart_8250_port *uart;
 	int ret = -ENOSPC;
@@ -2910,6 +2912,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->pm = pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 3d37c94..97723c5 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -28,6 +28,9 @@ struct plat_serial8250_port {
 	unsigned char	iotype;		/* UPIO_* */
 	unsigned char	hub6;
 	upf_t		flags;		/* UPF_* flags */
+
+	void		(*pm)(struct uart_port *, unsigned int state,
+			      unsigned int oldstate);
 };
 
 /*
@@ -57,7 +60,9 @@ enum {
  */
 struct uart_port;
 
-int serial8250_register_port(struct uart_port *);
+int serial8250_register_port(struct uart_port *,
+			     void (*pm)(struct uart_port *, unsigned int state,
+					unsigned int oldstate));
 void serial8250_unregister_port(int line);
 void serial8250_suspend_port(int line);
 void serial8250_resume_port(int line);
-- 
1.6.0.3

