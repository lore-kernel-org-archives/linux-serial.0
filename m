From: Dirk Behme <dirk.behme@googlemail.com>
Subject: [PATCH 1/2 v2] imx: Add save/restore functions for UART control regs
Date: Thu, 22 Dec 2011 09:57:52 +0100
Message-ID: <1324544273-9820-1-git-send-email-dirk.behme@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:56237 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab1LVI6S (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 22 Dec 2011 03:58:18 -0500
Received: by eekc4 with SMTP id c4so8231865eek.19
        for <linux-serial@vger.kernel.org>; Thu, 22 Dec 2011 00:58:17 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org
Cc: Dirk Behme <dirk.behme@gmail.com>, Saleem Abdulrasool <compnerd@compnerd.org>, Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>, Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>, linux-serial@vger.kernel.org, Alan Cox <alan@linux.intel.com>

Factor out the uart save/restore functionality instead of
having the same code several times in the driver.

Signed-off-by: Dirk Behme <dirk.behme@gmail.com>
CC: Saleem Abdulrasool <compnerd@compnerd.org>
CC: Sascha Hauer <s.hauer@pengutronix.de>
CC: Fabio Estevam <festevam@gmail.com>
CC: Uwe Kleine-Koenig <u.kleine-koenig@pengutronix.de>
CC: linux-serial@vger.kernel.org
CC: Alan Cox <alan@linux.intel.com>
---
Changes in v2:
* Rename imx_console_mode/restore() to imx_port_ucrs_save/restore()
* Introduce struct imx_port_ucrs
* Add Alan Cox to CC

 drivers/tty/serial/imx.c |   43 +++++++++++++++++++++++++++++++++++--------
 1 files changed, 35 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 163fc90..3daa008 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -207,6 +207,12 @@ struct imx_port {
 	struct imx_uart_data	*devdata;
 };
 
+struct imx_port_ucrs {
+	unsigned int	ucr1;
+	unsigned int	ucr2;
+	unsigned int	ucr3;
+};
+
 #ifdef CONFIG_IRDA
 #define USE_IRDA(sport)	((sport)->use_irda)
 #else
@@ -260,6 +266,27 @@ static inline int is_imx21_uart(struct imx_port *sport)
 }
 
 /*
+ * Save and restore functions for UCR1, UCR2 and UCR3 registers
+ */
+static void imx_port_ucrs_save(struct uart_port *port,
+			       struct imx_port_ucrs *ucr)
+{
+	/* save control registers */
+	ucr->ucr1 = readl(port->membase + UCR1);
+	ucr->ucr2 = readl(port->membase + UCR2);
+	ucr->ucr3 = readl(port->membase + UCR3);
+}
+
+static void imx_port_ucrs_restore(struct uart_port *port,
+				  struct imx_port_ucrs *ucr)
+{
+	/* restore control registers */
+	writel(ucr->ucr1, port->membase + UCR1);
+	writel(ucr->ucr2, port->membase + UCR2);
+	writel(ucr->ucr3, port->membase + UCR3);
+}
+
+/*
  * Handle any change of modem status signal since we were last called.
  */
 static void imx_mctrl_check(struct imx_port *sport)
@@ -1118,13 +1145,14 @@ static void
 imx_console_write(struct console *co, const char *s, unsigned int count)
 {
 	struct imx_port *sport = imx_ports[co->index];
-	unsigned int old_ucr1, old_ucr2, ucr1;
+	struct imx_port_ucrs old_ucr;
+	unsigned int ucr1;
 
 	/*
-	 *	First, save UCR1/2 and then disable interrupts
+	 *	First, save UCR1/2/3 and then disable interrupts
 	 */
-	ucr1 = old_ucr1 = readl(sport->port.membase + UCR1);
-	old_ucr2 = readl(sport->port.membase + UCR2);
+	imx_port_ucrs_save(&sport->port, &old_ucr);
+	ucr1 = old_ucr.ucr1;
 
 	if (is_imx1_uart(sport))
 		ucr1 |= IMX1_UCR1_UARTCLKEN;
@@ -1133,18 +1161,17 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 
 	writel(ucr1, sport->port.membase + UCR1);
 
-	writel(old_ucr2 | UCR2_TXEN, sport->port.membase + UCR2);
+	writel(old_ucr.ucr2 | UCR2_TXEN, sport->port.membase + UCR2);
 
 	uart_console_write(&sport->port, s, count, imx_console_putchar);
 
 	/*
 	 *	Finally, wait for transmitter to become empty
-	 *	and restore UCR1/2
+	 *	and restore UCR1/2/3
 	 */
 	while (!(readl(sport->port.membase + USR2) & USR2_TXDC));
 
-	writel(old_ucr1, sport->port.membase + UCR1);
-	writel(old_ucr2, sport->port.membase + UCR2);
+	imx_port_ucrs_restore(&sport->port, &old_ucr);
 }
 
 /*
-- 
1.7.7.4

