From: Barry Song <21cnbao@gmail.com>
Subject: [PATCH 2/3] uart: sirf: provide pm entries of uart_ops
Date: Fri,  3 Jan 2014 15:44:07 +0800
Message-ID: <1388735048-16093-2-git-send-email-21cnbao@gmail.com>
References: <1388735048-16093-1-git-send-email-21cnbao@gmail.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:40506 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750802AbaACHow (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 3 Jan 2014 02:44:52 -0500
Received: by mail-pa0-f51.google.com with SMTP id fa1so15513898pad.38
        for <linux-serial@vger.kernel.org>; Thu, 02 Jan 2014 23:44:52 -0800 (PST)
In-Reply-To: <1388735048-16093-1-git-send-email-21cnbao@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, workgroup.linux@csr.com, Qipan Li <Qipan.Li@csr.com>, Barry Song <Baohua.Song@csr.com>

From: Qipan Li <Qipan.Li@csr.com>

this patch provides PM entry of uart_ops, then drop clk enable and
disable because serial core will do it.

the patch also fixes the issue that uart hang in resume caused by
not-enabled clock.

Signed-off-by: Qipan Li <Qipan.Li@csr.com>
Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 drivers/tty/serial/sirfsoc_uart.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 6fea79b..a6c38ab 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -1033,6 +1033,16 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	spin_unlock_irqrestore(&port->lock, flags);
 }
 
+static void sirfsoc_uart_pm(struct uart_port *port, unsigned int state,
+			      unsigned int oldstate)
+{
+	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
+	if (!state)
+		clk_prepare_enable(sirfport->clk);
+	else
+		clk_disable_unprepare(sirfport->clk);
+}
+
 static unsigned int sirfsoc_uart_init_tx_dma(struct uart_port *port)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
@@ -1264,6 +1274,7 @@ static struct uart_ops sirfsoc_uart_ops = {
 	.startup	= sirfsoc_uart_startup,
 	.shutdown	= sirfsoc_uart_shutdown,
 	.set_termios	= sirfsoc_uart_set_termios,
+	.pm		= sirfsoc_uart_pm,
 	.type		= sirfsoc_uart_type,
 	.release_port	= sirfsoc_uart_release_port,
 	.request_port	= sirfsoc_uart_request_port,
@@ -1486,7 +1497,6 @@ usp_no_flow_control:
 		ret = PTR_ERR(sirfport->clk);
 		goto err;
 	}
-	clk_prepare_enable(sirfport->clk);
 	port->uartclk = clk_get_rate(sirfport->clk);
 
 	port->ops = &sirfsoc_uart_ops;
@@ -1502,7 +1512,6 @@ usp_no_flow_control:
 	return 0;
 
 port_err:
-	clk_disable_unprepare(sirfport->clk);
 	clk_put(sirfport->clk);
 err:
 	return ret;
@@ -1512,7 +1521,6 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 {
 	struct sirfsoc_uart_port *sirfport = platform_get_drvdata(pdev);
 	struct uart_port *port = &sirfport->port;
-	clk_disable_unprepare(sirfport->clk);
 	clk_put(sirfport->clk);
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
 	return 0;
-- 
1.7.5.4

