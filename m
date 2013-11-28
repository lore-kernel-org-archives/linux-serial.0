From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Subject: [PATCH 02/16] serial: sh-sci: Remove unused GPIO request code
Date: Thu, 28 Nov 2013 22:43:16 +0100
Message-ID: <1385675010-26904-3-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from perceval.ideasonboard.com ([95.142.166.194]:35260 "EHLO
	perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750859Ab3K1Vn3 (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Thu, 28 Nov 2013 16:43:29 -0500
In-Reply-To: <1385675010-26904-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-sh@vger.kernel.org
Cc: linux-serial@vger.kernel.org

The driver requests at initialization time GPIOs passed through platform
data. No platform makes use of this feature, remove it.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 drivers/tty/serial/sh-sci.c | 67 ---------------------------------------------
 include/linux/serial_sci.h  | 12 --------
 2 files changed, 79 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 475b364..e75ead0 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -32,7 +32,6 @@
 #include <linux/dma-mapping.h>
 #include <linux/err.h>
 #include <linux/errno.h>
-#include <linux/gpio.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioport.h>
@@ -97,7 +96,6 @@ struct sci_port {
 
 	int			irqs[SCIx_NR_IRQS];
 	char			*irqstr[SCIx_NR_IRQS];
-	char			*gpiostr[SCIx_NR_FNS];
 
 	struct dma_chan			*chan_tx;
 	struct dma_chan			*chan_rx;
@@ -1167,67 +1165,6 @@ static void sci_free_irq(struct sci_port *port)
 	}
 }
 
-static const char *sci_gpio_names[SCIx_NR_FNS] = {
-	"sck", "rxd", "txd", "cts", "rts",
-};
-
-static const char *sci_gpio_str(unsigned int index)
-{
-	return sci_gpio_names[index];
-}
-
-static void sci_init_gpios(struct sci_port *port)
-{
-	struct uart_port *up = &port->port;
-	int i;
-
-	if (!port->cfg)
-		return;
-
-	for (i = 0; i < SCIx_NR_FNS; i++) {
-		const char *desc;
-		int ret;
-
-		if (!port->cfg->gpios[i])
-			continue;
-
-		desc = sci_gpio_str(i);
-
-		port->gpiostr[i] = kasprintf(GFP_KERNEL, "%s:%s",
-					     dev_name(up->dev), desc);
-
-		/*
-		 * If we've failed the allocation, we can still continue
-		 * on with a NULL string.
-		 */
-		if (!port->gpiostr[i])
-			dev_notice(up->dev, "%s string allocation failure\n",
-				   desc);
-
-		ret = gpio_request(port->cfg->gpios[i], port->gpiostr[i]);
-		if (unlikely(ret != 0)) {
-			dev_notice(up->dev, "failed %s gpio request\n", desc);
-
-			/*
-			 * If we can't get the GPIO for whatever reason,
-			 * no point in keeping the verbose string around.
-			 */
-			kfree(port->gpiostr[i]);
-		}
-	}
-}
-
-static void sci_free_gpios(struct sci_port *port)
-{
-	int i;
-
-	for (i = 0; i < SCIx_NR_FNS; i++)
-		if (port->cfg->gpios[i]) {
-			gpio_free(port->cfg->gpios[i]);
-			kfree(port->gpiostr[i]);
-		}
-}
-
 static unsigned int sci_tx_empty(struct uart_port *port)
 {
 	unsigned short status = serial_port_in(port, SCxSR);
@@ -2244,8 +2181,6 @@ static int sci_init_single(struct platform_device *dev,
 
 		port->dev = &dev->dev;
 
-		sci_init_gpios(sci_port);
-
 		pm_runtime_enable(&dev->dev);
 	}
 
@@ -2302,8 +2237,6 @@ static int sci_init_single(struct platform_device *dev,
 
 static void sci_cleanup_single(struct sci_port *port)
 {
-	sci_free_gpios(port);
-
 	clk_put(port->iclk);
 	clk_put(port->fclk);
 
diff --git a/include/linux/serial_sci.h b/include/linux/serial_sci.h
index 2c8e9c1..3d5d878 100644
--- a/include/linux/serial_sci.h
+++ b/include/linux/serial_sci.h
@@ -58,17 +58,6 @@ enum {
 /* HSSRR HSCIF */
 #define HSCIF_SRE	0x8000
 
-/* Offsets into the sci_port->gpios array */
-enum {
-	SCIx_SCK,
-	SCIx_RXD,
-	SCIx_TXD,
-	SCIx_CTS,
-	SCIx_RTS,
-
-	SCIx_NR_FNS,
-};
-
 enum {
 	SCIx_PROBE_REGTYPE,
 
@@ -115,7 +104,6 @@ struct plat_sci_port_ops {
  * Platform device specific platform_data struct
  */
 struct plat_sci_port {
-	unsigned int	gpios[SCIx_NR_FNS];	/* SCK, RXD, TXD, CTS, RTS */
 	unsigned int	type;			/* SCI / SCIF / IRDA / HSCIF */
 	upf_t		flags;			/* UPF_* flags */
 	unsigned long	capabilities;		/* Port features/capabilities */
-- 
1.8.3.2

