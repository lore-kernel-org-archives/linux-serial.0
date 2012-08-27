From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: [PATCH 1/2] tty: serial: imx: console write routing is unsafe on SMP
Date: Mon, 27 Aug 2012 09:36:51 +0200
Message-ID: <1346053012-25686-2-git-send-email-dirk.behme@de.bosch.com>
References: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from smtp2-v.fe.bosch.de ([139.15.237.6]:59416 "EHLO
	smtp2-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888Ab2H0HhE (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 27 Aug 2012 03:37:04 -0400
Received: from vsmta13.fe.internet.bosch.com (unknown [10.4.98.30])
	by imta23.fe.bosch.de (Postfix) with ESMTP id 74D8528C01F4
	for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 09:37:01 +0200 (CEST)
Received: from localhost (vsgw1.fe.internet.bosch.com [10.4.98.15])
	by vsmta13.fe.internet.bosch.com (Postfix) with SMTP id 76220384030A
	for <linux-serial@vger.kernel.org>; Mon, 27 Aug 2012 09:37:01 +0200 (CEST)
In-Reply-To: <1346053012-25686-1-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Cc: Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel@pengutronix.de, Xinyu Chen <xinyu.chen@freescale.com>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>

From: Xinyu Chen <xinyu.chen@freescale.com>

The console feature's write routing is unsafe on SMP with
the startup/shutdown call.

There could be several consumers of the console
* the kernel printk
* the init process using /dev/kmsg to call printk to show log
* shell, which open /dev/console and write with sys_write()

The shell goes into the normal uart open/write routing,
but the other two go into the console operations.
The open routing calls imx serial startup, which will write USR1/2
register without any lock and critical with imx_console_write call.

Add a spin_lock for startup/shutdown/console_write routing.

This patch is a port from Freescale's Android kernel.

Signed-off-by: Xinyu Chen <xinyu.chen@freescale.com>
Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
CC: Shawn Guo <shawn.guo@linaro.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
---
 drivers/tty/serial/imx.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index d5c689d..908178f 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -754,6 +754,7 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	/*
 	 * Finally, clear and enable interrupts
 	 */
@@ -807,7 +808,6 @@ static int imx_startup(struct uart_port *port)
 	/*
 	 * Enable modem status interrupts
 	 */
-	spin_lock_irqsave(&sport->port.lock,flags);
 	imx_enable_ms(&sport->port);
 	spin_unlock_irqrestore(&sport->port.lock,flags);
 
@@ -837,10 +837,13 @@ static void imx_shutdown(struct uart_port *port)
 {
 	struct imx_port *sport = (struct imx_port *)port;
 	unsigned long temp;
+	unsigned long flags;
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR2);
 	temp &= ~(UCR2_TXEN);
 	writel(temp, sport->port.membase + UCR2);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 
 	if (USE_IRDA(sport)) {
 		struct imxuart_platform_data *pdata;
@@ -869,12 +872,14 @@ static void imx_shutdown(struct uart_port *port)
 	 * Disable all interrupts, port and break condition.
 	 */
 
+	spin_lock_irqsave(&sport->port.lock, flags);
 	temp = readl(sport->port.membase + UCR1);
 	temp &= ~(UCR1_TXMPTYEN | UCR1_RRDYEN | UCR1_RTSDEN | UCR1_UARTEN);
 	if (USE_IRDA(sport))
 		temp &= ~(UCR1_IREN);
 
 	writel(temp, sport->port.membase + UCR1);
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 static void
@@ -1217,6 +1222,9 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	struct imx_port *sport = imx_ports[co->index];
 	struct imx_port_ucrs old_ucr;
 	unsigned int ucr1;
+	unsigned long flags;
+
+	spin_lock_irqsave(&sport->port.lock, flags);
 
 	/*
 	 *	First, save UCR1/2/3 and then disable interrupts
@@ -1242,6 +1250,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
 
 	imx_port_ucrs_restore(&sport->port, &old_ucr);
+
+	spin_unlock_irqrestore(&sport->port.lock, flags);
 }
 
 /*
-- 
1.7.0.4

