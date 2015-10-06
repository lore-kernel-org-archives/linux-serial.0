From: Noam Camus <noamc@ezchip.com>
Subject: [v6] serial: 8250_dw: Add support for big-endian MMIO accesses
Date: Tue, 6 Oct 2015 09:39:50 +0300
Message-ID: <1444113590-19722-2-git-send-email-noamc@ezchip.com>
References: <1440493029-28760-2-git-send-email-noamc@ezchip.com>
 <1444113590-19722-1-git-send-email-noamc@ezchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1444113590-19722-1-git-send-email-noamc@ezchip.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: gregkh@linuxfoundation.org, jslaby@suse.com, peter@hurleysoftware.com, fransklaver@gmail.com, Alexey.Brodkin@synopsys.com, vgupta@synopsys.com, Noam Camus <noamc@ezchip.com>
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
 drivers/tty/serial/8250/8250_dw.c |   72 ++++++++++++++++++++++++++++++++----
 1 files changed, 64 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index 06324f1..2cb62cf 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -63,6 +63,9 @@ struct dw8250_data {
 	struct clk		*pclk;
 	struct reset_control	*rst;
 	struct uart_8250_dma	dma;
+	unsigned int		(*serial_in)(const void __iomem *addr);
+	void			(*serial_out)(unsigned int value,
+					      void __iomem *addr);
 };
 
 #define BYT_PRV_CLK			0x800
@@ -156,9 +159,9 @@ static void dw8250_serial_outq(struct uart_port *p, int offset, int value)
 }
 #endif /* CONFIG_64BIT */
 
-static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
+static void dw8250_check_LCR(struct uart_port *p, int offset, int value)
 {
-	writel(value, p->membase + (offset << p->regshift));
+	struct dw8250_data *d = p->private_data;
 
 	/* Make sure LCR write wasn't ignored */
 	if (offset == UART_LCR) {
@@ -168,7 +171,8 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 			if ((value & ~UART_LCR_SPAR) == (lcr & ~UART_LCR_SPAR))
 				return;
 			dw8250_force_idle(p);
-			writel(value, p->membase + (UART_LCR << p->regshift));
+			d->serial_out(value,
+				      p->membase + (UART_LCR << p->regshift));
 		}
 		/*
 		 * FIXME: this deadlocks if port->lock is already held
@@ -177,6 +181,22 @@ static void dw8250_serial_out32(struct uart_port *p, int offset, int value)
 	}
 }
 
+static void _dw8250_serial_out32(unsigned int value, void __iomem *addr)
+{
+	writel(value, addr);
+}
+
+static unsigned int _dw8250_serial_in32(const void __iomem *addr)
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
@@ -184,6 +204,29 @@ static unsigned int dw8250_serial_in32(struct uart_port *p, int offset)
 	return dw8250_modify_msr(p, offset, value);
 }
 
+static void _dw8250_serial_out32be(unsigned int value, void __iomem *addr)
+{
+	iowrite32be(value, addr);
+}
+
+static unsigned int _dw8250_serial_in32be(const void __iomem *addr)
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
@@ -252,7 +295,8 @@ static bool dw8250_dma_filter(struct dma_chan *chan, void *param)
 static void dw8250_setup_port(struct uart_8250_port *up)
 {
 	struct uart_port	*p = &up->port;
-	u32			reg = readl(p->membase + DW_UART_UCV);
+	struct dw8250_data	*d = p->private_data;
+	u32			reg = d->serial_in(p->membase + DW_UART_UCV);
 
 	/*
 	 * If the Component Version Register returns zero, we know that
@@ -264,7 +308,7 @@ static void dw8250_setup_port(struct uart_8250_port *up)
 	dev_dbg_ratelimited(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
-	reg = readl(p->membase + DW_UART_CPR);
+	reg = d->serial_in(p->membase + DW_UART_CPR);
 	if (!reg)
 		return;
 
@@ -305,9 +349,19 @@ static int dw8250_probe_of(struct uart_port *p,
 		case 1:
 			break;
 		case 4:
-			p->iotype = UPIO_MEM32;
-			p->serial_in = dw8250_serial_in32;
-			p->serial_out = dw8250_serial_out32;
+			p->iotype = of_device_is_big_endian(np) ?
+				    UPIO_MEM32BE : UPIO_MEM32;
+			if (p->iotype == UPIO_MEM32) {
+				p->serial_in = dw8250_serial_in32;
+				p->serial_out = dw8250_serial_out32;
+				data->serial_in = _dw8250_serial_in32;
+				data->serial_out = _dw8250_serial_out32;
+			} else {
+				p->serial_in = dw8250_serial_in32be;
+				p->serial_out = dw8250_serial_out32be;
+				data->serial_in = _dw8250_serial_in32be;
+				data->serial_out = _dw8250_serial_out32be;
+			}
 			break;
 		default:
 			dev_err(p->dev, "unsupported reg-io-width (%u)\n", val);
@@ -487,6 +541,8 @@ static int dw8250_probe(struct platform_device *pdev)
 	data->dma.rx_param = data;
 	data->dma.tx_param = data;
 	data->dma.fn = dw8250_dma_filter;
+	data->serial_in = _dw8250_serial_in32;
+	data->serial_out = _dw8250_serial_out32;
 
 	uart.port.iotype = UPIO_MEM;
 	uart.port.serial_in = dw8250_serial_in;
-- 
1.7.1
