From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] Revert "serial: imx: Move imx_port_ucrs_save/restore under CONFIG_CONSOLE_POLL"
Date: Wed,  6 Feb 2013 19:00:02 -0200
Message-ID: <1360184403-4891-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-gh0-f172.google.com ([209.85.160.172]:34914 "EHLO
	mail-gh0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757465Ab3BFVHV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 16:07:21 -0500
Received: by mail-gh0-f172.google.com with SMTP id z22so480884ghb.3
        for <linux-serial@vger.kernel.org>; Wed, 06 Feb 2013 13:07:20 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>>

This reverts commit cdc8da3998dcc50cee2f81904c16ebdbd7ec2cee.

In my attempt to fix a build warning on arm randconfig a build error on 
imx_v6_v7_defconfig was introduced, so revert it for now.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/imx.c |   42 +++++++++++++++++++++---------------------
 1 file changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index a657f96..a220f77 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -269,6 +269,27 @@ static inline int is_imx21_uart(struct imx_port *sport)
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
@@ -1082,27 +1103,6 @@ imx_verify_port(struct uart_port *port, struct serial_struct *ser)
 }
 
 #if defined(CONFIG_CONSOLE_POLL)
-/*
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
 static int imx_poll_get_char(struct uart_port *port)
 {
 	struct imx_port_ucrs old_ucr;
-- 
1.7.9.5

