From: Gabor Juhos <juhosg@openwrt.org>
Subject: [PATCH v2] tty: ar933x_uart: use the clk API to get the uart clock
Date: Wed, 28 Aug 2013 10:09:28 +0200
Message-ID: <1377677368-2920-1-git-send-email-juhosg@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arrakis.dune.hu ([78.24.191.176]:59704 "EHLO arrakis.dune.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752345Ab3H1IJf (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 28 Aug 2013 04:09:35 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, Gabor Juhos <juhosg@openwrt.org>

The AR933x UARTs are only used on the Atheros AR933x
SoCs. The base clock frequency of the UART is passed
to the driver via platform data. The SoC support code
implements the generic clock API, and the clock rate
can be retrieved via that.

Update the code to get the clock rate via the generic
clock API instead of using the platform data.

Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
---
Changes since v1:
  - rebased against the tty-next branch of the
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tree
---
 drivers/tty/serial/Kconfig       |    2 +-
 drivers/tty/serial/ar933x_uart.c |   35 ++++++++++++++++++++++++++---------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
index f136248..3c598e3 100644
--- a/drivers/tty/serial/Kconfig
+++ b/drivers/tty/serial/Kconfig
@@ -1402,7 +1402,7 @@ config SERIAL_XILINX_PS_UART_CONSOLE
 
 config SERIAL_AR933X
 	bool "AR933X serial port support"
-	depends on SOC_AR933X
+	depends on HAVE_CLK && SOC_AR933X
 	select SERIAL_CORE
 	help
 	  If you have an Atheros AR933X SOC based board and want to use the
diff --git a/drivers/tty/serial/ar933x_uart.c b/drivers/tty/serial/ar933x_uart.c
index a712a3f..17d4bfc 100644
--- a/drivers/tty/serial/ar933x_uart.c
+++ b/drivers/tty/serial/ar933x_uart.c
@@ -24,11 +24,11 @@
 #include <linux/slab.h>
 #include <linux/io.h>
 #include <linux/irq.h>
+#include <linux/clk.h>
 
 #include <asm/div64.h>
 
 #include <asm/mach-ath79/ar933x_uart.h>
-#include <asm/mach-ath79/ar933x_uart_platform.h>
 
 #define DRIVER_NAME "ar933x-uart"
 
@@ -47,6 +47,7 @@ struct ar933x_uart_port {
 	unsigned int		ier;	/* shadow Interrupt Enable Register */
 	unsigned int		min_baud;
 	unsigned int		max_baud;
+	struct clk		*clk;
 };
 
 static inline unsigned int ar933x_uart_read(struct ar933x_uart_port *up,
@@ -620,7 +621,6 @@ static struct uart_driver ar933x_uart_driver = {
 
 static int ar933x_uart_probe(struct platform_device *pdev)
 {
-	struct ar933x_uart_platform_data *pdata;
 	struct ar933x_uart_port *up;
 	struct uart_port *port;
 	struct resource *mem_res;
@@ -629,10 +629,6 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	int id;
 	int ret;
 
-	pdata = dev_get_platdata(&pdev->dev);
-	if (!pdata)
-		return -EINVAL;
-
 	id = pdev->id;
 	if (id == -1)
 		id = 0;
@@ -651,6 +647,12 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	if (!up)
 		return -ENOMEM;
 
+	up->clk = devm_clk_get(&pdev->dev, "uart");
+	if (IS_ERR(up->clk)) {
+		dev_err(&pdev->dev, "unable to get UART clock\n");
+		return PTR_ERR(up->clk);
+	}
+
 	port = &up->port;
 
 	mem_res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
@@ -658,13 +660,22 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 	if (IS_ERR(port->membase))
 		return PTR_ERR(port->membase);
 
+	ret = clk_prepare_enable(up->clk);
+	if (ret)
+		return ret;
+
+	port->uartclk = clk_get_rate(up->clk);
+	if (!port->uartclk) {
+		ret = -EINVAL;
+		goto err_disable_clk;
+	}
+
 	port->mapbase = mem_res->start;
 	port->line = id;
 	port->irq = irq_res->start;
 	port->dev = &pdev->dev;
 	port->type = PORT_AR933X;
 	port->iotype = UPIO_MEM32;
-	port->uartclk = pdata->uartclk;
 
 	port->regshift = 2;
 	port->fifosize = AR933X_UART_FIFO_SIZE;
@@ -680,10 +691,14 @@ static int ar933x_uart_probe(struct platform_device *pdev)
 
 	ret = uart_add_one_port(&ar933x_uart_driver, &up->port);
 	if (ret)
-		return ret;
+		goto err_disable_clk;
 
 	platform_set_drvdata(pdev, up);
 	return 0;
+
+err_disable_clk:
+	clk_disable_unprepare(up->clk);
+	return ret;
 }
 
 static int ar933x_uart_remove(struct platform_device *pdev)
@@ -692,8 +707,10 @@ static int ar933x_uart_remove(struct platform_device *pdev)
 
 	up = platform_get_drvdata(pdev);
 
-	if (up)
+	if (up) {
 		uart_remove_one_port(&ar933x_uart_driver, &up->port);
+		clk_disable_unprepare(up->clk);
+	}
 
 	return 0;
 }
-- 
1.7.10
