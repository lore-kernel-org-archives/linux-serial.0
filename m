From: Noam Camus <noamc@ezchip.com>
Subject: [PATCH-v8] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Sun, 18 Oct 2015 12:01:48 +0300
Message-ID: <1445158908-9610-1-git-send-email-noamc@ezchip.com>
References: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc: jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, Noam Camus <noamc@ezchip.com>
List-Id: linux-serial@vger.kernel.org

From: Noam Camus <noamc@ezchip.com>

Add support for UPIO_MEM32BE in addition to UPIO_MEM32.
dw8250_serial_out32() extra functionality that is not part of
the 8250 core driver was moved to new function called
dw8250_check_LCR().

For big endian we use 2 new accessors similar to little endian,
called dw8250_serial_out32be() and dw8250_serial_in32be().
Both little and big endian accessors use dw8250_check_LCR()
for their dw8250_serial_out32{,be}().

In addition I added another 2 accessors inside private_data field of
uart_port. This second level accessors are set during probe in
private_data field of uart_port. Now any direct call to readl/writel
is replaced with those accessors which are endianness aware.

Last issue:
readl() for UCV and CPR will not work for port type UPIO_MEM32BE.
Instead we use the serial_in32() accessor which is initialized
properly according to endianness.

Signed-off-by: Noam Camus <noamc@ezchip.com>
---
V8 change:
rebase on tty-next head, no functional change.

V7 change:
Fix build warning due to redundant "const" qualifier at
_dw8250_serial_in32be() signature.

V6 change:
Adapt patch to latest version (nothing functional)

V5 change:
Two patches is now squashed into single one

V4 change
Remove patch for skipping looptest through DT option.
This is now handled in our simulator model.
Thanks to Vineet Gupta from Synopsys for his help.

We are left with 2 patches which adds BIG endian support.

V3 change:
Use second level accessors for big/little endian port.
The new accessors are now pointed from uart_port->private_data
These accessors are initialized during driver probe().
Driver shouldn't access directly to readl/writel but to
these new second level accessors (first level is at uart_port).
e.g. at dw8250_check_LCR() and dw8250_setup_port() I replaced such
direct calls.

V2 changes:
1) better description for each commit.
2) adding to CC list the device tree maintainer.
3) rename dw8250_check_control() --> dw8250_check_LCR().
4) remove bad patch of "add UPF_FIXED_TYPE to flags".

 drivers/tty/serial/8250/8250_dw.c |   73 +++++++++++++++++++++++++++++++++----
 1 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index a0cdbf3..880f712 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -63,6 +63,9 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 	struct uart_8250_dma	dma;
+	unsigned int		(*serial_in)(void __iomem *addr);
+	void			(*serial_out)(unsigned int value,
+					      void __iomem *addr);
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
@@ -159,9 +162,9 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 }
 #endif /* CONFIG_64BIT */
 
-static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
+static void dw8250_check_LCR(struct uart_port *p, int offset, int value)
 {
-	writel(value, p->membase + (offset << p->regshift));
+	struct dw8250_data *d = p->private_data;
 
 	/* Make sure LCR write wasn't ignored */
 	if (offset == UART_LCR) {
@@ -171,7 +174,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
-			writel(value, p->membase + (UART_LCR << p->regshift));
+			d->serial_out(value,
+				      p->membase + (UART_LCR << p->regshift));
 		}
 		/*
 		 * FIXME: this deadlocks if port->lock is already held
@@ -180,6 +184,22 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 	}
 }
 
+static void _dw8250_serial_out32(unsigned int value, void __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static unsigned int _dw8250_serial_in32(void __iomem *addr)
+{
+	return readl(addr);
+}
+
+static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
+{
+	writel(value, p->membase + (offset << p->regshift));
+	dw8250_check_LCR(p, offset, value);
+}
+
 static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 {
 	unsigned int value = readl(p->membase + (offset << p->regshift));
@@ -187,6 +207,29 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 	return dw8250_modify_msr(p, offset, value);
 }
 
+static void _dw8250_serial_out32be(unsigned int value, void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
+
+static unsigned int _dw8250_serial_in32be(void __iomem *addr)
+{
+	return ioread32be(addr);
+}
+
+static void dw8250_serial_out32be(struct uart_port *p, int offset, int value)
+{
+	iowrite32be(value, p->membase + (offset << p->regshift));
+	dw8250_check_LCR(p, offset, value);
+}
+
+static unsigned int dw8250_serial_in32be(struct uart_port *p, int offset)
+{
+	unsigned int value = ioread32be(p->membase + (offset << p->regshift));
+
+	return dw8250_modify_msr(p, offset, value);
+}
+
 static int dw8250_handle_irq(struct uart_port *p)
 {
 	struct dw8250_data *d = p->private_data;
@@ -307,20 +350,21 @@ static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 static void dw8250_setup_port(struct uart_port *p)
 {
 	struct uart_8250_port *up = up_to_u8250p(p);
+	struct dw8250_data *d = p->private_data;
 	u32 reg;
 
 	/*
 	 * If the Component Version Register returns zero, we know that
 	 * ADDITIONAL_FEATURES are not enabled. No need to go any further.
 	 */
-	reg = readl(p->membase + DW_UART_UCV);
+	reg = d->serial_in(p->membase + DW_UART_UCV);
 	if (!reg)
 		return;
 
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
-	reg = readl(p->membase + DW_UART_CPR);
+	reg = d->serial_in(p->membase + DW_UART_CPR);
 	if (!reg)
 		return;
 
@@ -390,9 +434,19 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	err = device_property_read_u32(p->dev, "reg-io-width", &val);
 	if (!err && val == 4) {
-		p->iotype = UPIO_MEM32;
-		p->serial_in = dw8250_serial_in32;
-		p->serial_out = dw8250_serial_out32;
+		p->iotype = of_device_is_big_endian(p->dev->of_node) ?
+			    UPIO_MEM32BE : UPIO_MEM32;
+		if (p->iotype == UPIO_MEM32) {
+			p->serial_in = dw8250_serial_in32;
+			p->serial_out = dw8250_serial_out32;
+			data->serial_in = _dw8250_serial_in32;
+			data->serial_out = _dw8250_serial_out32;
+		} else {
+			p->serial_in = dw8250_serial_in32be;
+			p->serial_out = dw8250_serial_out32be;
+			data->serial_in = _dw8250_serial_in32be;
+			data->serial_out = _dw8250_serial_out32be;
+		}
 	}
 
 	if (device_property_read_bool(p->dev, "dcd-override")) {
@@ -466,6 +520,9 @@ static int dw8250_probe(struct platform_device *pdev)
 
 	dw8250_quirks(p, data);
 
+	data->serial_in = _dw8250_serial_in32;
+	data->serial_out = _dw8250_serial_out32;
+
 	/* If the Busy Functionality is not implemented, don't handle it */
 	if (data->uart_16550_compatible) {
 		p->serial_out = NULL;
-- 
1.7.1
