From: Jeremy Kerr <jeremy.kerr@canonical.com>
Subject: [PATCH v2] serial/imx: only parse for iomem resources once
Date: Wed, 14 Jul 2010 16:42:58 +0800
Message-ID: <1279096978.487304.715979328697.1.gpush@pororo>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from ozlabs.org ([203.10.76.45]:35097 "EHLO ozlabs.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752257Ab0GNInH (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 14 Jul 2010 04:43:07 -0400
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Sascha Hauer <kernel@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org

Currently, the iomem resources are parsed in serial_imx_probe, then
again in imx_request_port and imx_release_port.

This change uses the imx_port data to retrieve the start and size of the
memory region, rather than re-parsing the resources through
platform_get_resource.

Signed-off-by: Jeremy Kerr <jeremy.kerr@canonical.com>

---
v2: use resource_size()

---
 drivers/serial/imx.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/drivers/serial/imx.c b/drivers/serial/imx.c
index eacb588..f72d7c2 100644
--- a/drivers/serial/imx.c
+++ b/drivers/serial/imx.c
@@ -194,6 +194,7 @@ struct imx_port {
 	unsigned int		irda_inv_tx:1;
 	unsigned short		trcv_delay; /* transceiver delay */
 	struct clk		*clk;
+	unsigned long		mapsize;
 };
 
 #ifdef CONFIG_IRDA
@@ -954,11 +955,8 @@ static const char *imx_type(struct uart_port *port)
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
@@ -966,15 +964,10 @@ static void imx_release_port(struct uart_port *port)
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
@@ -1254,6 +1247,7 @@ static int serial_imx_probe(struct platform_device *pdev)
 	sport->port.dev = &pdev->dev;
 	sport->port.mapbase = res->start;
 	sport->port.membase = base;
+	sport->mapsize = resource_size(res);
 	sport->port.type = PORT_IMX,
 	sport->port.iotype = UPIO_MEM;
 	sport->port.irq = platform_get_irq(pdev, 0);
