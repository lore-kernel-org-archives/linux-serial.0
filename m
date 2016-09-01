From: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
Subject: [PATCH v3 1/1] Allowing UART DMA to be configured on i.MX53
Date: Thu,  1 Sep 2016 11:30:46 +0200
Message-ID: <1472722246-20618-1-git-send-email-fabien.lahoudere@collabora.co.uk>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Martyn Welch <martyn.welch@collabora.co.uk>, Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
List-Id: linux-serial@vger.kernel.org

From: Martyn Welch <martyn.welch@collabora.co.uk>

The UART DMA was only being configured on i.MX6Q compatible devices. We
know that the DMA also works for i.MX53 devices, so enable uart DMA for
imx53 and let the device tree to configure if DMA should be used or not.

Signed-off-by: Martyn Welch <martyn.welch@collabora.co.uk>
Signed-off-by: Fabien Lahoudere <fabien.lahoudere@collabora.co.uk>
---
 drivers/tty/serial/imx.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index 08ccfe1..1c9315a 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -190,6 +190,7 @@
 enum imx_uart_type {
 	IMX1_UART,
 	IMX21_UART,
+	IMX53_UART,
 	IMX6Q_UART,
 };
 
@@ -247,6 +248,10 @@ static struct imx_uart_data imx_uart_devdata[] = {
 		.uts_reg = IMX21_UTS,
 		.devtype = IMX21_UART,
 	},
+	[IMX53_UART] = {
+		.uts_reg = IMX21_UTS,
+		.devtype = IMX53_UART,
+	},
 	[IMX6Q_UART] = {
 		.uts_reg = IMX21_UTS,
 		.devtype = IMX6Q_UART,
@@ -261,6 +266,9 @@ static const struct platform_device_id imx_uart_devtype[] = {
 		.name = "imx21-uart",
 		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX21_UART],
 	}, {
+		.name = "imx53-uart",
+		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX53_UART],
+	}, {
 		.name = "imx6q-uart",
 		.driver_data = (kernel_ulong_t) &imx_uart_devdata[IMX6Q_UART],
 	}, {
@@ -271,6 +279,7 @@ MODULE_DEVICE_TABLE(platform, imx_uart_devtype);
 
 static const struct of_device_id imx_uart_dt_ids[] = {
 	{ .compatible = "fsl,imx6q-uart", .data = &imx_uart_devdata[IMX6Q_UART], },
+	{ .compatible = "fsl,imx53-uart", .data = &imx_uart_devdata[IMX53_UART], },
 	{ .compatible = "fsl,imx1-uart", .data = &imx_uart_devdata[IMX1_UART], },
 	{ .compatible = "fsl,imx21-uart", .data = &imx_uart_devdata[IMX21_UART], },
 	{ /* sentinel */ }
@@ -292,6 +301,11 @@ static inline int is_imx21_uart(struct imx_port *sport)
 	return sport->devdata->devtype == IMX21_UART;
 }
 
+static inline int is_imx53_uart(struct imx_port *sport)
+{
+	return sport->devdata->devtype == IMX53_UART;
+}
+
 static inline int is_imx6q_uart(struct imx_port *sport)
 {
 	return sport->devdata->devtype == IMX6Q_UART;
@@ -1254,8 +1268,7 @@ static int imx_startup(struct uart_port *port)
 	writel(temp & ~UCR4_DREN, sport->port.membase + UCR4);
 
 	/* Can we enable the DMA support? */
-	if (is_imx6q_uart(sport) && !uart_console(port) &&
-	    !sport->dma_is_inited)
+	if (!uart_console(port) && !sport->dma_is_inited)
 		imx_uart_dma_init(sport);
 
 	spin_lock_irqsave(&sport->port.lock, flags);
-- 
2.1.4
