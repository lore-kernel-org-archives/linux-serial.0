From: Barry Song <Barry.Song@csr.com>
Subject: [PATCH v2] serial: sirf: only use lookup table to set baudrate when ioclk=150MHz
Date: Wed, 16 Jan 2013 14:49:27 +0800
Message-ID: <1358318967-25958-1-git-send-email-Barry.Song@csr.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cluster-g.mailcontrol.com ([208.87.233.190]:39929 "EHLO
	cluster-g.mailcontrol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752251Ab3APGuy (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Jan 2013 01:50:54 -0500
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: alan@linux.intel.com, gregkh@linuxfoundation.org
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, workgroup.linux@csr.com, Barry Song <Baohua.Song@csr.com>, Russell King <linux@arm.linux.org.uk>

From: Barry Song <Baohua.Song@csr.com>

The fast lookup table to set baudrate is only right when ioclk
is 150MHz. for most platforms, ioclk is 150MHz, but some boards
might set ioclk to other frequency.

so re-calc the clk_div_reg when ioclk is not 150MHz. this patch
also gets clk in probe and puts it in remove.

Signed-off-by: Barry Song <Baohua.Song@csr.com>
Cc: Russell King <linux@arm.linux.org.uk>
---
 -v2:
 1. Get the clock at probe or port initialization time. Save that pointer
 according to Russell King's feedback;
 2. rebase to tty/tty-next as this one has been applied:
 serial: sirf: add support for new SiRFmarco SMP SoC
 http://git.kernel.org/?p=linux/kernel/git/gregkh/tty.git;h=5425e0

 drivers/tty/serial/sirfsoc_uart.c |   28 +++++++++++++++++++++-------
 drivers/tty/serial/sirfsoc_uart.h |    1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/sirfsoc_uart.c b/drivers/tty/serial/sirfsoc_uart.c
index 8f3d6c0..6bbfe99 100644
--- a/drivers/tty/serial/sirfsoc_uart.c
+++ b/drivers/tty/serial/sirfsoc_uart.c
@@ -357,7 +357,6 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 				       struct ktermios *old)
 {
 	struct sirfsoc_uart_port *sirfport = to_sirfport(port);
-	unsigned long	ioclk_rate;
 	unsigned long	config_reg = 0;
 	unsigned long	baud_rate;
 	unsigned long	setted_baud;
@@ -369,7 +368,6 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 	int		threshold_div;
 	int		temp;
 
-	ioclk_rate = 150000000;
 	switch (termios->c_cflag & CSIZE) {
 	default:
 	case CS8:
@@ -425,14 +423,17 @@ static void sirfsoc_uart_set_termios(struct uart_port *port,
 			sirfsoc_uart_disable_ms(port);
 	}
 
-	/* common rate: fast calculation */
-	for (ic = 0; ic < SIRF_BAUD_RATE_SUPPORT_NR; ic++)
-		if (baud_rate == baudrate_to_regv[ic].baud_rate)
-			clk_div_reg = baudrate_to_regv[ic].reg_val;
+	if (port->uartclk == 150000000) {
+		/* common rate: fast calculation */
+		for (ic = 0; ic < SIRF_BAUD_RATE_SUPPORT_NR; ic++)
+			if (baud_rate == baudrate_to_regv[ic].baud_rate)
+				clk_div_reg = baudrate_to_regv[ic].reg_val;
+	}
+
 	setted_baud = baud_rate;
 	/* arbitary rate setting */
 	if (unlikely(clk_div_reg == 0))
-		clk_div_reg = sirfsoc_calc_sample_div(baud_rate, ioclk_rate,
+		clk_div_reg = sirfsoc_calc_sample_div(baud_rate, port->uartclk,
 								&setted_baud);
 	wr_regl(port, SIRFUART_DIVISOR, clk_div_reg);
 
@@ -691,6 +692,14 @@ int sirfsoc_uart_probe(struct platform_device *pdev)
 			goto err;
 	}
 
+	sirfport->clk = clk_get(&pdev->dev, NULL);
+	if (IS_ERR(sirfport->clk)) {
+		ret = PTR_ERR(sirfport->clk);
+		goto clk_err;
+	}
+	clk_prepare_enable(sirfport->clk);
+	port->uartclk = clk_get_rate(sirfport->clk);
+
 	port->ops = &sirfsoc_uart_ops;
 	spin_lock_init(&port->lock);
 
@@ -704,6 +713,9 @@ int sirfsoc_uart_probe(struct platform_device *pdev)
 	return 0;
 
 port_err:
+	clk_disable_unprepare(sirfport->clk);
+	clk_put(sirfport->clk);
+clk_err:
 	platform_set_drvdata(pdev, NULL);
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
@@ -718,6 +730,8 @@ static int sirfsoc_uart_remove(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 	if (sirfport->hw_flow_ctrl)
 		pinctrl_put(sirfport->p);
+	clk_disable_unprepare(sirfport->clk);
+	clk_put(sirfport->clk);
 	uart_remove_one_port(&sirfsoc_uart_drv, port);
 	return 0;
 }
diff --git a/drivers/tty/serial/sirfsoc_uart.h b/drivers/tty/serial/sirfsoc_uart.h
index 6431640..85328ba 100644
--- a/drivers/tty/serial/sirfsoc_uart.h
+++ b/drivers/tty/serial/sirfsoc_uart.h
@@ -163,6 +163,7 @@ struct sirfsoc_uart_port {
 
 	struct uart_port		port;
 	struct pinctrl			*p;
+	struct clk			*clk;
 };
 
 /* Hardware Flow Control */
-- 
1.7.5.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
