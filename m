From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] tty: serial: mxs-auart: Check the return value from clk_prepare_enable()
Date: Mon,  2 Dec 2013 01:17:58 -0200
Message-ID: <1385954278-24321-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-qe0-f48.google.com ([209.85.128.48]:56219 "EHLO
	mail-qe0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752608Ab3LBDSX (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Sun, 1 Dec 2013 22:18:23 -0500
Received: by mail-qe0-f48.google.com with SMTP id gc15so12655132qeb.7
        for <linux-serial@vger.kernel.org>; Sun, 01 Dec 2013 19:18:22 -0800 (PST)
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

From: Fabio Estevam <fabio.estevam@freescale.com>

clk_prepare_enable() may fail, so let's check its return value and propagate it
in the case of error.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index d8b6fee..aa97fd8 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -734,9 +734,12 @@ static void mxs_auart_reset(struct uart_port *u)
 
 static int mxs_auart_startup(struct uart_port *u)
 {
+	int ret;
 	struct mxs_auart_port *s = to_auart_port(u);
 
-	clk_prepare_enable(s->clk);
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
 
 	writel(AUART_CTRL0_CLKGATE, u->membase + AUART_CTRL0_CLR);
 
@@ -957,7 +960,9 @@ auart_console_setup(struct console *co, char *options)
 	if (!s)
 		return -ENODEV;
 
-	clk_prepare_enable(s->clk);
+	ret = clk_prepare_enable(s->clk);
+	if (ret)
+		return ret;
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);
-- 
1.8.1.2

