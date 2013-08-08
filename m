From: John Crispin <blogic@openwrt.org>
Subject: [PATCH 2/2] serial: MIPS: lantiq: make driver use pinctrl
Date: Thu,  8 Aug 2013 15:31:27 +0200
Message-ID: <1375968687-8704-2-git-send-email-blogic@openwrt.org>
References: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from nbd.name ([46.4.11.11]:42763 "EHLO nbd.name"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757835Ab3HHNif (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Thu, 8 Aug 2013 09:38:35 -0400
In-Reply-To: <1375968687-8704-1-git-send-email-blogic@openwrt.org>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-mips@linux-mips.org, Thomas Langer <thomas.langer@lantiq.com>

From: Thomas Langer <thomas.langer@lantiq.com>

Add use of devm_pinctrl_get_select_default to active default pinctrl settings.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Acked-by: John Crispin <blogic@openwrt.org>
---
 drivers/tty/serial/lantiq.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index ce1ea35..0dcaf3a 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -37,6 +37,8 @@
 #include <linux/io.h>
 #include <linux/clk.h>
 #include <linux/gpio.h>
+#include <linux/pinctrl/consumer.h>
+#include <linux/err.h>
 
 #include <lantiq_soc.h>
 
@@ -681,6 +683,7 @@ lqasc_probe(struct platform_device *pdev)
 	struct ltq_uart_port *ltq_port;
 	struct uart_port *port;
 	struct resource *mmres, irqres[3];
+	struct pinctrl *pinctrl;
 	int line = 0;
 	int ret;
 
@@ -719,6 +722,10 @@ lqasc_probe(struct platform_device *pdev)
 	port->irq	= irqres[0].start;
 	port->mapbase	= mmres->start;
 
+	pinctrl = devm_pinctrl_get_select_default(&pdev->dev);
+	if (IS_ERR(pinctrl))
+		dev_warn(&pdev->dev, "pins are not configured from the driver\n");
+
 	ltq_port->fpiclk = clk_get_fpi();
 	if (IS_ERR(ltq_port->fpiclk)) {
 		pr_err("failed to get fpi clk\n");
-- 
1.7.10.4

