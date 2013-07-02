From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH 1/5] serial: imx: distinguish the imx6 uart from the others
Date: Tue, 2 Jul 2013 14:30:24 +0800
Message-ID: <1372746628-20092-2-git-send-email-b32955@freescale.com>
References: <1372746628-20092-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from [207.46.163.25] ([207.46.163.25]:35753 "EHLO
	co9outboundpool.messaging.microsoft.com" rhost-flags-FAIL-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S1752794Ab3GBG5z (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Tue, 2 Jul 2013 02:57:55 -0400
In-Reply-To: <1372746628-20092-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, shawn.guo@linaro.org, s.hauer@pengutronix.de, Huang Shijie <b32955@freescale.com>

We will add the DMA support for the imx uart. For the firmware's limit,
only the imx6 uart can supports the DMA.

This patch adds the necessary macro and helper to distinguish the imx6 uart
from the other imx uart.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 48bace0..d215fa9 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -187,6 +187,7 @@
 enum imx_uart_type {
 	IMX1_UART,
 	IMX21_UART,
+	IMX6_UART,
 };
 
 /* device type dependent stuff */
@@ -232,6 +233,10 @@ static struct imx_uart_data imx_uart_devdata[] = {
 		.uts_reg = IMX21_UTS,
 		.devtype = IMX21_UART,
 	},
+	[IMX6_UART] = {
+		.uts_reg = IMX21_UTS,
+		.devtype = IMX6_UART,
+	},
 };
 
 static struct platform_device_id imx_uart_devtype[] = {
@@ -242,6 +247,9 @@ static struct platform_device_id imx_uart_devtype[] = {
 		.name = "imx21-uart",
 		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
 	}, {
+		.name = "imx6-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6_UART],
+	}, {
 		/* sentinel */
 	}
 };
@@ -250,6 +258,7 @@ MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 static struct of_device_id imx_uart_dt_ids[] = {
 	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
 	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
+	{ .compatible = "fsl,imx6-uart", .data = &imx_uart_devdata[IMX6_UART], },
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, imx_uart_dt_ids);
@@ -269,6 +278,10 @@ static inline int is_imx21_uart(struct imx_port *sport)
 	return sport->devdata->devtype == IMX21_UART;
 }
 
+static inline int is_imx6_uart(struct imx_port *sport)
+{
+	return sport->devdata->devtype == IMX6_UART;
+}
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
@@ -801,7 +814,7 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
-	if (is_imx21_uart(sport)) {
+	if (is_imx21_uart(sport) || is_imx6_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 		temp |= IMX21_UCR3_RXDMUXSEL;
 		writel(temp, sport->port.membase + UCR3);
@@ -1044,7 +1057,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(num, sport->port.membase + UBIR);
 	writel(denom, sport->port.membase + UBMR);
 
-	if (is_imx21_uart(sport))
+	if (is_imx21_uart(sport) || is_imx6_uart(sport))
 		writel(sport->port.uartclk / div / 1000,
 				sport->port.membase + IMX21_ONEMS);
 
-- 
1.7.1


