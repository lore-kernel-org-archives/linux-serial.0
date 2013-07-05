From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v3 1/6] serial: imx: distinguish the imx6q uart from the others
Date: Fri, 5 Jul 2013 14:12:27 +0800
Message-ID: <1373004752-21302-2-git-send-email-b32955@freescale.com>
References: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from tx2ehsobe001.messaging.microsoft.com ([65.55.88.11]:41781 "EHLO
	tx2outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754338Ab3GEGjZ (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 5 Jul 2013 02:39:25 -0400
In-Reply-To: <1373004752-21302-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: shawn.guo@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Huang Shijie <b32955@freescale.com>

We will add the DMA support for the imx uart. For the firmware's limit,
only the imx6 serial chips (including the imx6q, imx6dl, imx6sl) can
support the DMA.

This patch adds the necessary macro and helper to distinguish the
imx6q uart from the other imx uart. Other chips can use the "fsl,imx6q-uart"
to enable the DMA support.

This patch also replaces the check "is_imx21_uart()" with "!is_imx1_uart()".

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/imx.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 48bace0..a9643ef 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -187,6 +187,7 @@
 enum imx_uart_type {
 	IMX1_UART,
 	IMX21_UART,
+	IMX6Q_UART,
 };
 
 /* device type dependent stuff */
@@ -232,6 +233,10 @@ static struct imx_uart_data imx_uart_devdata[] = {
 		.uts_reg = IMX21_UTS,
 		.devtype = IMX21_UART,
 	},
+	[IMX6Q_UART] = {
+		.uts_reg = IMX21_UTS,
+		.devtype = IMX6Q_UART,
+	},
 };
 
 static struct platform_device_id imx_uart_devtype[] = {
@@ -242,12 +247,16 @@ static struct platform_device_id imx_uart_devtype[] = {
 		.name = "imx21-uart",
 		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
 	}, {
+		.name = "imx6q-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6Q_UART],
+	}, {
 		/* sentinel */
 	}
 };
 MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 
 static struct of_device_id imx_uart_dt_ids[] = {
+	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
 	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
 	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
 	{ /* sentinel */ }
@@ -269,6 +278,10 @@ static inline int is_imx21_uart(struct imx_port *sport)
 	return sport->devdata->devtype == IMX21_UART;
 }
 
+static inline int is_imx6q_uart(struct imx_port *sport)
+{
+	return sport->devdata->devtype == IMX6Q_UART;
+}
 /*
  * Save and restore functions for UCR1, UCR2 and UCR3 registers
  */
@@ -801,7 +814,7 @@ static int imx_startup(struct uart_port *port)
 		}
 	}
 
-	if (is_imx21_uart(sport)) {
+	if (!is_imx1_uart(sport)) {
 		temp = readl(sport->port.membase + UCR3);
 		temp |= IMX21_UCR3_RXDMUXSEL;
 		writel(temp, sport->port.membase + UCR3);
@@ -1044,7 +1057,7 @@ imx_set_termios(struct uart_port *port, struct ktermios *termios,
 	writel(num, sport->port.membase + UBIR);
 	writel(denom, sport->port.membase + UBMR);
 
-	if (is_imx21_uart(sport))
+	if (!is_imx1_uart(sport))
 		writel(sport->port.uartclk / div / 1000,
 				sport->port.membase + IMX21_ONEMS);
 
-- 
1.7.1


