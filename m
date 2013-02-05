From: Fabio Estevam <fabio.estevam@freescale.com>
Subject: [PATCH] serial: imx: Move imx_port_ucrs_save/restore under CONFIG_CONSOLE_POLL
Date: Tue, 5 Feb 2013 16:12:31 -0200
Message-ID: <1360087951-22787-1-git-send-email-fabio.estevam@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from co9ehsobe001.messaging.microsoft.com ([207.46.163.24]:21861
	"EHLO co9outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756212Ab3BESMj (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 5 Feb 2013 13:12:39 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: s.hauer@pengutronix.de, linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

If CONFIG_CONSOLE_POLL is not defined, the following build warning happens:

drivers/tty/serial/imx.c:274:13: warning: 'imx_port_ucrs_save' defined but not used [-Wunused-function]
drivers/tty/serial/imx.c:283:13: warning: 'imx_port_ucrs_restore' defined but not used [-Wunused-function]

Move imx_port_ucrs_saver/restore under CONFIG_CONSOLE_POLL ifdef block to fix it.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a220f77..a657f96 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -269,27 +269,6 @@ static inline int is_imx21_uart(struct imx_port *sport)
 }
 
 /*
- * Save and restore functions for UCR1, UCR2 and UCR3 registers
- */
-static void imx_port_ucrs_save(struct uart_port *port,
-			       struct imx_port_ucrs *ucr)
-{
-	/* save control registers */
-	ucr->ucr1 = readl(port->membase + UCR1);
-	ucr->ucr2 = readl(port->membase + UCR2);
-	ucr->ucr3 = readl(port->membase + UCR3);
-}
-
-static void imx_port_ucrs_restore(struct uart_port *port,
-				  struct imx_port_ucrs *ucr)
-{
-	/* restore control registers */
-	writel(ucr->ucr1, port->membase + UCR1);
-	writel(ucr->ucr2, port->membase + UCR2);
-	writel(ucr->ucr3, port->membase + UCR3);
-}
-
-/*
  * Handle any change of modem status signal since we were last called.
  */
 static void imx_mctrl_check(struct imx_port *sport)
@@ -1103,6 +1082,27 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
+/*
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
 static int imx_poll_get_char(struct uart_port *port)
 {
 	struct imx_port_ucrs old_ucr;
-- 
1.7.9.5


