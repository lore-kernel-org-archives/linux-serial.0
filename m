From: Huang Shijie <b32955@freescale.com>
Subject: [PATCH v3 1/3] serial: mxs-auart: distinguish the different SOCs
Date: Fri, 16 Nov 2012 16:03:52 +0800
Message-ID: <1353053034-10944-2-git-send-email-b32955@freescale.com>
References: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from va3ehsobe002.messaging.microsoft.com ([216.32.180.12]:49270
	"EHLO va3outboundpool.messaging.microsoft.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750980Ab2KPIoP (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 16 Nov 2012 03:44:15 -0500
In-Reply-To: <1353053034-10944-1-git-send-email-b32955@freescale.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux@arm.linux.org.uk, vinod.koul@intel.com, lauri.hintsala@bluegiga.com, Huang Shijie <b32955@freescale.com>

The current mxs-auart driver is used for both mx23 and mx28.

But in mx23, the DMA has a bug(see errata:2836). We can not add the
DMA support in mx23, but we can add DMA support to auart in mx28.

So in order to add the DMA support for the auart in mx28, we should
distinguish the distinguish SOCs.

This patch adds a new platform_device_id table and a inline function
is_imx28_auart() to distinguish the mx23 and mx28.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/tty/serial/mxs-auart.c |   42 ++++++++++++++++++++++++++++++++++-----
 1 files changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/mxs-auart.c b/drivers/tty/serial/mxs-auart.c
index 6db3baa..06d7271 100644
--- a/drivers/tty/serial/mxs-auart.c
+++ b/drivers/tty/serial/mxs-auart.c
@@ -114,11 +114,17 @@
 
 static struct uart_driver auart_driver;
 
+enum mxs_auart_type {
+	IMX23_AUART,
+	IMX28_AUART,
+};
+
 struct mxs_auart_port {
 	struct uart_port port;
 
 	unsigned int flags;
 	unsigned int ctrl;
+	enum mxs_auart_type devtype;
 
 	unsigned int irq;
 
@@ -126,6 +132,29 @@ struct mxs_auart_port {
 	struct device *dev;
 };
 
+static struct platform_device_id mxs_auart_devtype[] = {
+	{ .name = "mxs-auart-imx23", .driver_data = IMX23_AUART },
+	{ .name = "mxs-auart-imx28", .driver_data = IMX28_AUART },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(platform, mxs_auart_devtype);
+
+static struct of_device_id mxs_auart_dt_ids[] = {
+	{
+		.compatible = "fsl,imx28-auart",
+		.data = &mxs_auart_devtype[IMX28_AUART]
+	}, {
+		.compatible = "fsl,imx23-auart",
+		.data = &mxs_auart_devtype[IMX23_AUART]
+	}, { /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
+
+static inline int is_imx28_auart(struct mxs_auart_port *s)
+{
+	return s->devtype == IMX28_AUART;
+}
+
 static void mxs_auart_stop_tx(struct uart_port *u);
 
 #define to_auart_port(u) container_of(u, struct mxs_auart_port, port)
@@ -706,6 +735,8 @@ static int serial_mxs_probe_dt(struct mxs_auart_port *s,
 
 static int __devinit mxs_auart_probe(struct platform_device *pdev)
 {
+	const struct of_device_id *of_id =
+			of_match_device(mxs_auart_dt_ids, &pdev->dev);
 	struct mxs_auart_port *s;
 	u32 version;
 	int ret = 0;
@@ -730,6 +761,11 @@ static int __devinit mxs_auart_probe(struct platform_device *pdev)
 		goto out_free;
 	}
 
+	if (of_id) {
+		pdev->id_entry = of_id->data;
+		s->devtype = pdev->id_entry->driver_data;
+	}
+
 	s->clk = clk_get(&pdev->dev, NULL);
 	if (IS_ERR(s->clk)) {
 		ret = PTR_ERR(s->clk);
@@ -805,12 +841,6 @@ static int __devexit mxs_auart_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id mxs_auart_dt_ids[] = {
-	{ .compatible = "fsl,imx23-auart", },
-	{ /* sentinel */ }
-};
-MODULE_DEVICE_TABLE(of, mxs_auart_dt_ids);
-
 static struct platform_driver mxs_auart_driver = {
 	.probe = mxs_auart_probe,
 	.remove = __devexit_p(mxs_auart_remove),
-- 
1.7.0.4


