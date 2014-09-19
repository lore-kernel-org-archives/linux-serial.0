From: Andre Przywara <andre.przywara@arm.com>
Subject: [RFC PATCH 05/10] drivers: PL011: refactor pl011_probe()
Date: Fri, 19 Sep 2014 13:21:18 +0100
Message-ID: <1411129283-17219-6-git-send-email-andre.przywara@arm.com>
References: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from cam-admin0.cambridge.arm.com ([217.140.96.50]:36075 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756141AbaISMWI (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 19 Sep 2014 08:22:08 -0400
In-Reply-To: <1411129283-17219-1-git-send-email-andre.przywara@arm.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: rob.herring@linaro.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>

Currently the pl011_probe() function is relying on some AMBA IDs
and a device tree node to initialize the driver and a port.
Both features are not necessarily required for the driver:
- we lack AMBA IDs in the ARM SBSA generic UART and
- we lack a DT node in ACPI systems.
So lets refactor the function to ease later reuse.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c |   90 ++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 9219127..457a8d90 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2159,13 +2159,10 @@ static void pl011_unregister_port(struct uart_amba_port *uap)
 		uart_unregister_driver(&amba_reg);
 }
 
-
-static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
+static int pl011_allocate_port(struct device *dev, struct uart_amba_port **_uap)
 {
 	struct uart_amba_port *uap;
-	struct vendor_data *vendor = id->data;
-	void __iomem *base;
-	int i, ret;
+	int i;
 
 	for (i = 0; i < ARRAY_SIZE(amba_ports); i++)
 		if (amba_ports[i] == NULL)
@@ -2174,47 +2171,50 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (i == ARRAY_SIZE(amba_ports))
 		return -EBUSY;
 
-	uap = devm_kzalloc(&dev->dev, sizeof(struct uart_amba_port),
-			   GFP_KERNEL);
+	uap = devm_kzalloc(dev, sizeof(struct uart_amba_port), GFP_KERNEL);
 	if (uap == NULL)
 		return -ENOMEM;
 
-	i = pl011_probe_dt_alias(i, &dev->dev);
+	if (_uap)
+		*_uap = uap;
+
+	return i;
+}
 
-	base = devm_ioremap(&dev->dev, dev->res.start,
-			    resource_size(&dev->res));
+static int pl011_setup_port(struct device *dev, struct uart_amba_port *uap,
+			    struct resource *mmiobase, int index)
+{
+	void __iomem *base;
+
+	base = devm_ioremap_resource(dev, mmiobase);
 	if (!base)
 		return -ENOMEM;
 
-	uap->clk = devm_clk_get(&dev->dev, NULL);
-	if (IS_ERR(uap->clk))
-		return PTR_ERR(uap->clk);
+	index = pl011_probe_dt_alias(index, dev);
 
-	uap->vendor = vendor;
-	uap->lcrh_rx = vendor->lcrh_rx;
-	uap->lcrh_tx = vendor->lcrh_tx;
 	uap->old_cr = 0;
-	uap->fifosize = vendor->get_fifosize(dev);
-	uap->port.dev = &dev->dev;
-	uap->port.mapbase = dev->res.start;
+	uap->port.dev = dev;
+	uap->port.mapbase = mmiobase->start;
 	uap->port.membase = base;
 	uap->port.iotype = UPIO_MEM;
-	uap->port.irq = dev->irq[0];
 	uap->port.fifosize = uap->fifosize;
-	uap->port.ops = &amba_pl011_pops;
 	uap->port.flags = UPF_BOOT_AUTOCONF;
-	uap->port.line = i;
-	pl011_dma_probe(&dev->dev, uap);
+	uap->port.line = index;
 
-	/* Ensure interrupts from this UART are masked and cleared */
-	writew(0, uap->port.membase + UART011_IMSC);
-	writew(0xffff, uap->port.membase + UART011_ICR);
+	pl011_dma_probe(dev, uap);
 
-	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
+	amba_ports[index] = uap;
 
-	amba_ports[i] = uap;
+	return 0;
+}
 
-	amba_set_drvdata(dev, uap);
+static int pl011_register_port(struct uart_amba_port *uap)
+{
+	int ret;
+
+	/* Ensure interrupts from this UART are masked and cleared */
+	writew(0, uap->port.membase + UART011_IMSC);
+	writew(0xffff, uap->port.membase + UART011_ICR);
 
 	if (!amba_reg.state) {
 		ret = uart_register_driver(&amba_reg);
@@ -2231,6 +2231,38 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	return ret;
 }
 
+static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
+{
+	struct uart_amba_port *uap;
+	struct vendor_data *vendor = id->data;
+	int portnr, ret;
+
+	portnr = pl011_allocate_port(&dev->dev, &uap);
+	if (portnr < 0)
+		return portnr;
+
+	uap->clk = devm_clk_get(&dev->dev, NULL);
+	if (IS_ERR(uap->clk))
+		return PTR_ERR(uap->clk);
+
+	uap->vendor = vendor;
+	uap->lcrh_rx = vendor->lcrh_rx;
+	uap->lcrh_tx = vendor->lcrh_tx;
+	uap->fifosize = vendor->get_fifosize(dev);
+	uap->port.irq = dev->irq[0];
+	uap->port.ops = &amba_pl011_pops;
+
+	snprintf(uap->type, sizeof(uap->type), "PL011 rev%u", amba_rev(dev));
+
+	ret = pl011_setup_port(&dev->dev, uap, &dev->res, portnr);
+	if (ret)
+		return ret;
+
+	amba_set_drvdata(dev, uap);
+
+	return pl011_register_port(uap);
+}
+
 static int pl011_remove(struct amba_device *dev)
 {
 	struct uart_amba_port *uap = amba_get_drvdata(dev);
-- 
1.7.9.5

