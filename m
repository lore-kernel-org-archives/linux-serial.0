From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] serial: do not call ->pm() on initialization for
 console port
Date: Fri, 19 Oct 2007 01:42:48 +0900 (JST)
Message-ID: <20071019.014248.126760868.anemo@mba.ocn.ne.jp>
References: <20071019.011355.39154656.anemo@mba.ocn.ne.jp>
	<20071018161827.GB16244@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mba.ocn.ne.jp ([122.1.235.107]:63309 "EHLO smtp.mba.ocn.ne.jp"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756776AbXJRQlC (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 18 Oct 2007 12:41:02 -0400
In-Reply-To: <20071018161827.GB16244@flint.arm.linux.org.uk>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, akpm@linux-foundation.org

On Thu, 18 Oct 2007 17:18:27 +0100, Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> > Attached patch fixes this problem.  Is this a right way?
> > If not, I will fix the serial_txx9 driver to skip the initialization in
> > ->pm() if oldstate was -1.
> 
> I'll have to investigate further to refresh myself with what's going
> on here, but your patch looks wrong.

Thanks.  JFYI, here is some patches I tried before changing
serial_core.  Both fixes the serial console problem.

Patch 1:

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 6846a6c..7ad2192 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -657,7 +657,15 @@ static void
 serial_txx9_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
-	if (state == 0)
+	/*
+	 * If oldstate was -1 this is called from
+	 * uart_configure_port().  In this case do not initialize the
+	 * port now, because the port was already initialized (for
+	 * non-console port) or should not be initialized here (for
+	 * console port).  If we initialized the port here we lose
+	 * serial console settings.
+	 */
+	if (state == 0 && oldstate != -1)
 		serial_txx9_initialize(port);
 }


Patch 2:

diff --git a/drivers/serial/serial_txx9.c b/drivers/serial/serial_txx9.c
index 6846a6c..167c3a7 100644
--- a/drivers/serial/serial_txx9.c
+++ b/drivers/serial/serial_txx9.c
@@ -657,6 +657,15 @@ static void
 serial_txx9_pm(struct uart_port *port, unsigned int state,
 	      unsigned int oldstate)
 {
+	/*
+	 * If oldstate was -1 this is called from
+	 * uart_configure_port().  If we initialized the port here we
+	 * lose serial console settings.
+	 */
+#ifdef CONFIG_SERIAL_TXX9_CONSOLE
+	if (port->line == port->cons->index && oldstate == -1)
+		return;
+#endif
 	if (state == 0)
 		serial_txx9_initialize(port);
 }
@@ -742,12 +751,7 @@ static void serial_txx9_config_port(struct uart_port *port, int uflags)
 		return;
 	port->type = PORT_TXX9;
 	up->port.fifosize = TXX9_SIO_TX_FIFO;
-
-#ifdef CONFIG_SERIAL_TXX9_CONSOLE
-	if (up->port.line == up->port.cons->index)
-		return;
-#endif
-	serial_txx9_initialize(port);
+	/* This port will be initialized in subsequent serial_txx9_pm() */
 }
 
 static const char *


Hope these patches help your refreshing.

---
Atsushi Nemoto
