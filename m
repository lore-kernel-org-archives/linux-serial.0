From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH 05/10] drivers: PL011: refactor pl011_probe()
Date: Fri, 16 Jan 2015 17:23:01 +0000
Message-ID: <1421428986-11300-6-git-send-email-andre.przywara@arm.com>
References: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1421428986-11300-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux@arm.linux.org.uk, gregkh@linuxfoundation.org, jslaby@suse.cz
Cc: linux-arm-kernel@lists.infradead.org, rob.herring@linaro.org, arnd@arndb.de, linux-serial@vger.kernel.org, Dave Martin <dave.martin@arm.com>
List-Id: linux-serial@vger.kernel.org

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
index 2153b98..e484551 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -2206,13 +2206,10 @@ static void pl011_unregister_port(struct uart_amba_port *uap)
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
@@ -2221,47 +2218,50 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
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
@@ -2278,6 +2278,38 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
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
