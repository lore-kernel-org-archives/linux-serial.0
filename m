From: Yi Zhang <yizhang@marvell.com>
Subject: [PATCH] serial: pxa: fine-tune clk useage
Date: Wed, 23 Jan 2013 09:52:25 +0800
Message-ID: <1358905945-8276-1-git-send-email-yizhang@marvell.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from na3sys009aog135.obsmtp.com ([74.125.149.84]:45494 "EHLO
	na3sys009aog135.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752908Ab3AWByU (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 22 Jan 2013 20:54:20 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, greg@kroah.com
Cc: yizhang.mrvl@gmail.com, linux-serial@vger.kernel.org, Yi Zhang <yizhang@marvell.com>

1) add clk_enable/disable in serial_pxa_console_write()
2) add clk_prepare() to follow common clock driver

Signed-off-by: Yi Zhang <yizhang@marvell.com>
---
 drivers/tty/serial/pxa.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
index a67f9e1..05f504e 100644
--- a/drivers/tty/serial/pxa.c
+++ b/drivers/tty/serial/pxa.c
@@ -672,7 +672,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	unsigned long flags;
 	int locked = 1;
 
-
+	clk_enable(up->clk);
 	local_irq_save(flags);
 	if (up->port.sysrq)
 		locked = 0;
@@ -699,6 +699,7 @@ serial_pxa_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock(&up->port.lock);
 	local_irq_restore(flags);
+	clk_disable(up->clk);
 
 }
 
@@ -896,6 +897,12 @@ static int serial_pxa_probe(struct platform_device *dev)
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
@@ -927,6 +934,7 @@ static int serial_pxa_probe(struct platform_device *dev)
 	return 0;
 
  err_clk:
+	clk_unprepare(sport->clk);
 	clk_put(sport->clk);
  err_free:
 	kfree(sport);
@@ -940,6 +948,8 @@ static int serial_pxa_remove(struct platform_device *dev)
 	platform_set_drvdata(dev, NULL);
 
 	uart_remove_one_port(&serial_pxa_reg, &sport->port);
+
+	clk_unprepare(sport->clk);
 	clk_put(sport->clk);
 	kfree(sport);
 
-- 
1.7.0.4

