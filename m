From: Anton Vorontsov <anton.vorontsov@linaro.org>
Subject: [PATCH 06/11] tty/serial/amba-pl011: Quiesce interrupts in poll_get_char
Date: Thu, 13 Sep 2012 08:03:30 -0700
Message-ID: <1347548615-18227-6-git-send-email-anton.vorontsov@linaro.org>
References: <20120913150133.GA16238@lizard>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:53115 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758157Ab2IMPGk (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 13 Sep 2012 11:06:40 -0400
Received: by pbbrr13 with SMTP id rr13so4090760pbb.19
        for <linux-serial@vger.kernel.org>; Thu, 13 Sep 2012 08:06:39 -0700 (PDT)
In-Reply-To: <20120913150133.GA16238@lizard>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Russell King <linux@arm.linux.org.uk>, Jason Wessel <jason.wessel@windriver.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alan Cox <alan@linux.intel.com>
Cc: =?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, Colin Cross <ccross@android.com>, Brian Swetland <swetland@google.com>, John Stultz <john.stultz@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linaro-kernel@lists.linaro.org, patches@linaro.org, kernel-team@android.com, kgdb-bugreport@lists.sourceforge.net, linux-serial@vger.kernel.org

We need to quiesce interrupts in the poll_get_char routine, otherwise,
if used with KGDB NMI debugger, we'll keep reentering the NMI.

Quiescing interrupts is pretty straightforward, except for TXIM
interrupt. The interrupt has "ready to transmit" meaning, so it's
almost always raised, and the only way to silence it is to mask it. But
that's OK, ops->start_tx will unmask it.

Signed-off-by: Anton Vorontsov <anton.vorontsov@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 45137e4..459f8ba 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1284,11 +1284,40 @@ static void pl011_break_ctl(struct uart_port *port, int break_state)
 }
 
 #ifdef CONFIG_CONSOLE_POLL
+
+static void pl011_quiesce_irqs(struct uart_port *port)
+{
+	struct uart_amba_port *uap = (struct uart_amba_port *)port;
+	unsigned char __iomem *regs = uap->port.membase;
+
+	writew(readw(regs + UART011_MIS), regs + UART011_ICR);
+	/*
+	 * There is no way to clear TXIM as this is "ready to transmit IRQ", so
+	 * we simply mask it. start_tx() will unmask it.
+	 *
+	 * Note we can race with start_tx(), and if the race happens, the
+	 * polling user might get another interrupt just after we clear it.
+	 * But it should be OK and can happen even w/o the race, e.g.
+	 * controller immediately got some new data and raised the IRQ.
+	 *
+	 * And whoever uses polling routines assumes that it manages the device
+	 * (including tx queue), so we're also fine with start_tx()'s caller
+	 * side.
+	 */
+	writew(readw(regs + UART011_IMSC) & ~UART011_TXIM, regs + UART011_IMSC);
+}
+
 static int pl011_get_poll_char(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
 	unsigned int status;
 
+	/*
+	 * The caller might need IRQs lowered, e.g. if used with KDB NMI
+	 * debugger.
+	 */
+	pl011_quiesce_irqs(port);
+
 	status = readw(uap->port.membase + UART01x_FR);
 	if (status & UART01x_FR_RXFE)
 		return NO_POLL_CHAR;
-- 
1.7.11.5

