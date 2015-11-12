From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: [PATCH] serial: imx: fix clk_prepare/unprepare usage
Date: Thu, 12 Nov 2015 10:58:48 +0100
Message-ID: <1447322328-5171-1-git-send-email-marcus.folkesson@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Marcus Folkesson <marcus.folkesson@gmail.com>
List-Id: linux-serial@vger.kernel.org

clk_prepare/unprapare APIs are not allowed in atomic context, so
move prepare/unprepare to probe/remove and use clk_enable/disable
instead.

Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
---
 drivers/tty/serial/imx.c | 45 ++++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index fe3d41c..dcb4b6b 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -1106,12 +1106,12 @@ static int imx_startup(struct uart_port *port)
 	int retval, i;
 	unsigned long flags, temp;
 
-	retval = clk_prepare_enable(sport->clk_per);
+	retval = clk_enable(sport->clk_per);
 	if (retval)
 		return retval;
-	retval = clk_prepare_enable(sport->clk_ipg);
+	retval = clk_enable(sport->clk_ipg);
 	if (retval) {
-		clk_disable_unprepare(sport->clk_per);
+		clk_disable(sport->clk_per);
 		return retval;
 	}
 
@@ -1223,8 +1223,8 @@ static void imx_shutdown(struct uart_port *port)
 	writel(temp, sport->port.membase + UCR1);
 	spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_per);
-	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable(sport->clk_per);
+	clk_disable(sport->clk_ipg);
 }
 
 static void imx_flush_buffer(struct uart_port *port)
@@ -1496,12 +1496,12 @@ static int imx_poll_init(struct uart_port *port)
 	unsigned long temp;
 	int retval;
 
-	retval = clk_prepare_enable(sport->clk_ipg);
+	retval = clk_enable(sport->clk_ipg);
 	if (retval)
 		return retval;
-	retval = clk_prepare_enable(sport->clk_per);
+	retval = clk_enable(sport->clk_per);
 	if (retval)
-		clk_disable_unprepare(sport->clk_ipg);
+		clk_disable(sport->clk_ipg);
 
 	imx_setup_ufcr(sport, 0);
 
@@ -1631,12 +1631,12 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	int locked = 1;
 	int retval;
 
-	retval = clk_prepare_enable(sport->clk_per);
+	retval = clk_enable(sport->clk_per);
 	if (retval)
 		return;
-	retval = clk_prepare_enable(sport->clk_ipg);
+	retval = clk_enable(sport->clk_ipg);
 	if (retval) {
-		clk_disable_unprepare(sport->clk_per);
+		clk_disable(sport->clk_per);
 		return;
 	}
 
@@ -1675,8 +1675,8 @@ imx_console_write(struct console *co, const char *s, unsigned int count)
 	if (locked)
 		spin_unlock_irqrestore(&sport->port.lock, flags);
 
-	clk_disable_unprepare(sport->clk_ipg);
-	clk_disable_unprepare(sport->clk_per);
+	clk_disable(sport->clk_ipg);
+	clk_disable(sport->clk_per);
 }
 
 /*
@@ -1764,7 +1764,7 @@ imx_console_setup(struct console *co, char *options)
 		return -ENODEV;
 
 	/* For setting the registers, we only need to enable the ipg clock. */
-	retval = clk_prepare_enable(sport->clk_ipg);
+	retval = clk_enable(sport->clk_ipg);
 	if (retval)
 		goto error_console;
 
@@ -1777,7 +1777,7 @@ imx_console_setup(struct console *co, char *options)
 
 	retval = uart_set_options(&sport->port, co, baud, parity, bits, flow);
 
-	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable(sport->clk_ipg);
 
 error_console:
 	return retval;
@@ -1915,18 +1915,27 @@ static int serial_imx_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "failed to get ipg clk: %d\n", ret);
 		return ret;
 	}
+	ret = clk_prepare(sport->clk_ipg);
+	if (ret)
+		return ret;
 
 	sport->clk_per = devm_clk_get(&pdev->dev, "per");
 	if (IS_ERR(sport->clk_per)) {
 		ret = PTR_ERR(sport->clk_per);
 		dev_err(&pdev->dev, "failed to get per clk: %d\n", ret);
+		clk_unprepare(sport->clk_ipg);
+		return ret;
+	}
+	ret = clk_prepare(sport->clk_per);
+	if (ret) {
+		clk_unprepare(sport->clk_ipg);
 		return ret;
 	}
 
 	sport->port.uartclk = clk_get_rate(sport->clk_per);
 
 	/* For register access, we only need to enable the ipg clock. */
-	ret = clk_prepare_enable(sport->clk_ipg);
+	ret = clk_enable(sport->clk_ipg);
 	if (ret)
 		return ret;
 
@@ -1936,7 +1945,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 		 UCR1_TXMPTYEN | UCR1_RTSDEN);
 	writel_relaxed(reg, sport->port.membase + UCR1);
 
-	clk_disable_unprepare(sport->clk_ipg);
+	clk_disable(sport->clk_ipg);
 
 	/*
 	 * Allocate the IRQ(s) i.MX1 has three interrupts whereas later
@@ -1969,6 +1978,8 @@ static int serial_imx_probe(struct platform_device *pdev)
 static int serial_imx_remove(struct platform_device *pdev)
 {
 	struct imx_port *sport = platform_get_drvdata(pdev);
+	clk_unprepare(sport->clk_ipg);
+	clk_unprepare(sport->clk_per);
 
 	return uart_remove_one_port(&imx_reg, &sport->port);
 }
-- 
1.9.1
