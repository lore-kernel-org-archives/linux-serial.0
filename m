From: Yi Zhang <yizhang@marvell.com>
Subject: [PATCH] serial: pxa: fix clk_prepare/unprepare misuse
Date: Tue, 22 Jan 2013 11:24:50 +0800
Message-ID: <1358825090-17577-1-git-send-email-yizhang@marvell.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog105.obsmtp.com ([74.125.149.75]:36212 "EHLO
	na3sys009aog105.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752912Ab3AVDZV (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 21 Jan 2013 22:25:21 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com
Cc: yizhang.mrvl@gmail.com, linux-serial@vger.kernel.org, Yi Zhang <yizhang@marvell.com>

1) serial_pxa_console_write() can be used in atomic context,
   so change clk_prepare_clk to clk_enable
2) add clk_prepare() to follow common clock driver

Signed-off-by: Yi Zhang <yizhang@marvell.com>
---
 drivers/tty/serial/pxa.c |   13 +++++++++++--
 1 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index 2764828..d5cbcf6 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -673,7 +673,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-	clk_prepare_enable(up->clk);
+	clk_enable(up->clk);
 
 	local_irq_save(flags);
 	if (up->port.sysrq)
@@ -702,7 +702,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
 
-	clk_disable_unprepare(up->clk);
+	clk_disable(up->clk);
 }
 
 #ifdef CONFIG_CONSOLE_POLL
@@ -899,6 +899,12 @@ static int serial_pxa_probe(struct platform_device *dev)
 		goto err_free;
 	}
 
+	ret = clk_prepare(sport->clk);
+	if (ret) {
+		clk_put(sport->clk);
+		goto err_free;
+	}
+
 	sport->port.type = PORT_PXA;
 	sport->port.iotype = UPIO_MEM;
 	sport->port.mapbase = mmres->start;
@@ -930,6 +936,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	return 0;
 
  err_clk:
+	clk_unprepare(sport->clk);
 	clk_put(sport->clk);
  err_free:
 	kfree(sport);
@@ -943,6 +950,8 @@ static int serial_pxa_remove(struct platform_device *dev)
 	platform_set_drvdata(dev, NULL);
 
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
+
+	clk_unprepare(sport->clk);
 	clk_put(sport->clk);
 	kfree(sport);
 
-- 
1.7.0.4

