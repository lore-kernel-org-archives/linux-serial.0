From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH 2/2] serial: 8250_dw: add fractional divisor support
Date: Mon, 2 Jul 2018 18:06:48 +0800
Message-ID: <20180702180648.039dcee3@xhacker.debian>
References: <20180702180428.331b36c5@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702180428.331b36c5@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

Now the preparation is done, it's easy to add the feature support.
This patch firstly checks the component version during probe, if
version >= 4.00a, then calculates the fractional divisor width, then
setups dw specific get_divisor() and set_divisor() hook.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_dw.c | 54 +++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index aff04f1de3a5..367a73507c5e 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -31,9 +31,12 @@
 
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
+#define DW_FRAC_MIN_VERS		0x3430302A
+
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
 #define DW_UART_CPR_AFCE_MODE		(1 << 4)
@@ -65,6 +68,7 @@ struct dw8250_data {
 
 	unsigned int		skip_autocfg:1;
 	unsigned int		uart_16550_compatible:1;
+	unsigned int		dlf_size:3;
 };
 
 static inline int dw8250_modify_msr(struct uart_port *p, int offset, int value)
@@ -351,6 +355,34 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * For version >= 4.00a, the dw uarts have a valid divisor latch fraction
+ * register. Calculate divisor with extra 4bits ~ 6bits fractional portion.
+ */
+static unsigned int dw8250_get_divisor(struct uart_8250_port *up,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot;
+	struct uart_port *p = &up->port;
+	struct dw8250_data *d = p->private_data;
+
+	quot = DIV_ROUND_CLOSEST(p->uartclk << (d->dlf_size - 4), baud);
+	*frac = quot & (~0U >> (32 - d->dlf_size));
+
+	return quot >> d->dlf_size;
+}
+
+static void dw8250_set_divisor(struct uart_8250_port *up, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	struct uart_port *p = &up->port;
+
+	serial_port_out(p, DW_UART_DLF >> p->regshift, quot_frac);
+	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
+	serial_dl_write(up, quot);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -414,6 +446,28 @@ static void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	/*
+	 * For version >= 4.00a, the dw uarts have a valid divisor latch
+	 * fraction register. Calculate the fractional divisor width.
+	 */
+	if (reg >= DW_FRAC_MIN_VERS) {
+		struct dw8250_data *d = p->private_data;
+
+		if (p->iotype == UPIO_MEM32BE) {
+			iowrite32be(~0U, p->membase + DW_UART_DLF);
+			reg = ioread32be(p->membase + DW_UART_DLF);
+		} else {
+			writel(~0U, p->membase + DW_UART_DLF);
+			reg = readl(p->membase + DW_UART_DLF);
+		}
+		d->dlf_size = fls(reg);
+
+		if (d->dlf_size) {
+			up->get_divisor = dw8250_get_divisor;
+			up->set_divisor = dw8250_set_divisor;
+		}
+	}
+
 	if (p->iotype == UPIO_MEM32BE)
 		reg = ioread32be(p->membase + DW_UART_CPR);
 	else
-- 
2.18.0
