From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH v2 1/2] 8250: allow platforms to override PM hook.
Date: Sat, 25 Sep 2010 15:13:45 +0200
Message-ID: <1285420426-8510-1-git-send-email-manuel.lauss@googlemail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:52207 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753874Ab0IYNNx (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sat, 25 Sep 2010 09:13:53 -0400
Received: by fxm3 with SMTP id 3so1162658fxm.19
        for <linux-serial@vger.kernel.org>; Sat, 25 Sep 2010 06:13:51 -0700 (PDT)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Greg KH <greg@kroah.com>, Manuel Lauss <manuel.lauss@googlemail.com>

Add a hook for platforms to specify custom pm methods.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/serial/8250.c       |   27 ++++++++++++++++-----------
 include/linux/serial_8250.h |    4 ++++
 include/linux/serial_core.h |    2 ++
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/serial/8250.c b/drivers/serial/8250.c
index 24110f6..d5a2f00 100644
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
@@ -2440,16 +2434,24 @@ serial8250_set_ldisc(struct uart_port *port, int new)
 		port->flags &= ~UPF_HARDPPS_CD;
 }
 
-static void
-serial8250_pm(struct uart_port *port, unsigned int state,
-	      unsigned int oldstate)
+
+void serial8250_do_pm(struct uart_port *port, unsigned int state,
+		      unsigned int oldstate)
 {
 	struct uart_8250_port *p = (struct uart_8250_port *)port;
 
 	serial8250_set_sleep(p, state != 0);
+}
+EXPORT_SYMBOL(serial8250_do_pm);
 
-	if (p->pm)
-		p->pm(port, state, oldstate);
+static void
+serial8250_pm(struct uart_port *port, unsigned int state,
+	      unsigned int oldstate)
+{
+	if (port->pm)
+		port->pm(port, state, oldstate);
+	else
+		serial8250_do_pm(port, state, oldstate);
 }
 
 static unsigned int serial8250_port_size(struct uart_8250_port *pt)
@@ -3010,6 +3012,7 @@ static int __devinit serial8250_probe(struct platform_device *dev)
 		port.serial_in		= p->serial_in;
 		port.serial_out		= p->serial_out;
 		port.set_termios	= p->set_termios;
+		port.pm			= p->pm;
 		port.dev		= &dev->dev;
 		port.irqflags		|= irqflag;
 		ret = serial8250_register_port(&port);
@@ -3176,6 +3179,8 @@ int serial8250_register_port(struct uart_port *port)
 		/*  Possibly override set_termios call */
 		if (port->set_termios)
 			uart->port.set_termios = port->set_termios;
+		if (port->pm)
+			uart->port.pm = port->pm;
 
 		ret = uart_add_one_port(&serial8250_reg, &uart->port);
 		if (ret == 0)
diff --git a/include/linux/serial_8250.h b/include/linux/serial_8250.h
index 7638dea..bf9c2bd 100644
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
@@ -76,5 +78,7 @@ extern int serial8250_find_port_for_earlycon(void);
 extern int setup_early_serial8250_console(char *cmdline);
 extern void serial8250_do_set_termios(struct uart_port *port,
 		struct ktermios *termios, struct ktermios *old);
+extern void serial8250_do_pm(struct uart_port *port, unsigned int state,
+			     unsigned int oldstate);
 
 #endif
diff --git a/include/linux/serial_core.h b/include/linux/serial_core.h
index 563e234..632a16b 100644
--- a/include/linux/serial_core.h
+++ b/include/linux/serial_core.h
@@ -289,6 +289,8 @@ struct uart_port {
 	void			(*set_termios)(struct uart_port *,
 				               struct ktermios *new,
 				               struct ktermios *old);
+	void			(*pm)(struct uart_port *, unsigned int state,
+				      unsigned int old);
 	unsigned int		irq;			/* irq number */
 	unsigned long		irqflags;		/* irq flags  */
 	unsigned int		uartclk;		/* base uart clock */
-- 
1.7.3

