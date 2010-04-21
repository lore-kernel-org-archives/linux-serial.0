From: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: [PATCH] serial/imx: only parse for iomem resources once
Date: Wed, 21 Apr 2010 16:33:58 +0800
Message-ID: <1271838838.643120.804272014834.1.gpush@pororo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:38001 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752971Ab0DUIeL (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 21 Apr 2010 04:34:11 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <kernel@pengutronix.de>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Currently, the iomem resources are parsed in serial_imx_probe, then
again in imx_request_port and imx_release_port.

This change uses the imx_port data to retrieve the start and size of the
memory region, rather than re-parsing the resources through
platform_get_resource.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
 drivers/serial/imx.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index e579d7a..7de6bf7 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -192,6 +192,7 @@ struct imx_port {
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
+	unsigned long		mapsize;
 };
 
 #ifdef CONFIG_IRDA
@@ -945,11 +946,8 @@ static const char *imx_type(struct uart_port *port)
  */
 static void imx_release_port(struct uart_port *port)
 {
-	struct platform_device *pdev = to_platform_device(port->dev);
-	struct resource *mmres;
-
-	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	release_mem_region(mmres->start, mmres->end - mmres->start + 1);
+	struct imx_port *imx_port = container_of(port, struct imx_port, port);
+	release_mem_region(imx_port->port.mapbase, imx_port->mapsize);
 }
 
 /*
@@ -957,15 +955,10 @@ static void imx_release_port(struct uart_port *port)
  */
 static int imx_request_port(struct uart_port *port)
 {
-	struct platform_device *pdev = to_platform_device(port->dev);
-	struct resource *mmres;
+	struct imx_port *imx_port = container_of(port, struct imx_port, port);
 	void *ret;
 
-	mmres = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	if (!mmres)
-		return -ENODEV;
-
-	ret = request_mem_region(mmres->start, mmres->end - mmres->start + 1,
+	ret = request_mem_region(imx_port->port.mapbase, imx_port->mapsize,
 			"imx-uart");
 
 	return  ret ? 0 : -EBUSY;
@@ -1245,6 +1238,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
 	sport->port.membase = base;
+	sport->mapsize = res->end - res->start + 1;
 	sport->port.type = PORT_IMX,
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = platform_get_irq(pdev, 0);
