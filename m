From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 1/2] 8250: pm callback for platform uarts
Date: Sat, 28 Aug 2010 13:32:08 +0200
Message-ID: <1282995129-22291-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43296 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752918Ab0H1LcR (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 28 Aug 2010 07:32:17 -0400
Received: by bwz11 with SMTP id 11so2570180bwz.19
        for <linux-serial@vger.kernel.org>; Sat, 28 Aug 2010 04:32:15 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, Manuel Lauss <manuel.lauss@googlemail.com>

The 8250 driver provides in its uart_ops a pm callback which in turn
handles 8250 pm and, if it exists, calls a private callback.
However there's no way for platform 8250 devices to assign anything
to this callback.

This patch adds a new pm field to the plat_8250_port and uart_port
structures and modifies the 8250 pm callback to call the platform
method before powering up and after powering down (if the platform
is capable of cutting power/clks to the block).

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/serial/8250.c       |   15 +++++++--------
 include/linux/serial_8250.h |    2 ++
 include/linux/serial_core.h |    2 ++
 3 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 24110f6..06606d2 100644
--- a/drivers/serial/8250.c
+++ b/drivers/serial/8250.c
@@ -154,12 +154,6 @@ struct uart_8250_port {
 	unsigned char		lsr_saved_flags;
 #define MSR_SAVE_FLAGS UART_MSR_ANY_DELTA
 	unsigned char		msr_saved_flags;
-
-	/*
-	 * We provide a per-port pm hook.
-	 */
-	void			(*pm)(struct uart_port *port,
-				      unsigned int state, unsigned int old);
 };
 
 struct irq_info {
@@ -2446,10 +2440,13 @@ serial8250_pm(struct uart_port *port, unsigned int state,
 {
 	struct uart_8250_port *p = (struct uart_8250_port *)port;
 
+	if ((p->port.pm) && (state == 0))	/* power up: call platform first */
+		p->port.pm(port, state, oldstate);
+
 	serial8250_set_sleep(p, state != 0);
 
-	if (p->pm)
-		p->pm(port, state, oldstate);
+	if ((p->port.pm) && (state != 0))	/* power down */
+		p->port.pm(port, state, oldstate);
 }
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
@@ -3010,6 +3007,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
 		port.set_termios	= p->set_termios;
+		port.pm			= p->pm;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
 		ret = serial8250_register_port(&port);
@@ -3161,6 +3159,7 @@ int serial8250_register_port(struct uart_port *port)
 		uart->port.flags        = port->flags | UPF_BOOT_AUTOCONF;
 		uart->port.mapbase      = port->mapbase;
 		uart->port.private_data = port->private_data;
+		uart->port.pm		= port->pm;
 		if (port->dev)
 			uart->port.dev = port->dev;
 
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 7638dea..ce3af06 100644
--- a/include/linux/serial_8250.h
+++ b/include/linux/serial_8250.h
@@ -35,6 +35,8 @@ struct plat_serial8250_port {
 	void		(*set_termios)(struct uart_port *,
 			               struct ktermios *new,
 			               struct ktermios *old);
+	void		(*pm)(struct uart_port *, unsigned int state,
+			      unsigned old);
 };
 
 /*
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 3c2ad99..b361e17 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -288,6 +288,8 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	void			(*pm)(struct uart_port *, unsigned int state,
+				      unsigned int old);
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
-- 
1.7.2.2

