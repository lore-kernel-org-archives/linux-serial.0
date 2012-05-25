From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 11/15] serial: mxs-auart: Use clk_prepare_enable/clk_disable_unprepare
Date: Fri, 25 May 2012 20:14:52 -0300
Message-ID: <1337987696-31728-11-git-send-email-festevam@gmail.com>
References: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-vb0-f46.google.com ([209.85.212.46]:44508 "EHLO
	mail-vb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932546Ab2EYXPf (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 25 May 2012 19:15:35 -0400
Received: by mail-vb0-f46.google.com with SMTP id ff1so1025024vbb.19
        for <linux-serial@vger.kernel.org>; Fri, 25 May 2012 16:15:35 -0700 (PDT)
In-Reply-To: <1337987696-31728-1-git-send-email-festevam@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: kernel@pengutronix.de
Cc: shawn.guo@freescale.com, Fabio Estevam <fabio.estevam@freescale.com>, Alan Cox <alan@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Prepare the clock before enabling it.

Cc: Alan Cox <alan@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: <linux-serial@vger.kernel.org>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index ec56d83..c109642 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -552,7 +552,7 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	s = auart_port[co->index];
 	port = &s->port;
 
-	clk_enable(s->clk);
+	clk_prepare_enable(s->clk);
 
 	/* First save the CR then disable the interrupts */
 	old_ctrl2 = readl(port->membase + AUART_CTRL2);
@@ -578,7 +578,7 @@ auart_console_write(struct console *co, const char *str, unsigned int count)
 	writel(old_ctrl0, port->membase + AUART_CTRL0);
 	writel(old_ctrl2, port->membase + AUART_CTRL2);
 
-	clk_disable(s->clk);
+	clk_disable_unprepare(s->clk);
 }
 
 static void __init
-- 
1.7.1

