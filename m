From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Subject: [PATCH v5 3/3] serial: 8250_dw: add fractional divisor support
Date: Wed, 11 Jul 2018 15:11:11 +0800
Message-ID: <20180711151111.6f417020@xhacker.debian>
References: <20180710110942.5b0a016e@xhacker.debian>
        <20180710111516.13b8c570@xhacker.debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180710111516.13b8c570@xhacker.debian>
Sender: linux-kernel-owner@vger.kernel.org
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

For Synopsys DesignWare 8250 uart which version >= 4.00a, there's a
valid divisor latch fraction register. The fractional divisor width is
4bits ~ 6bits.

Now the preparation is done, it's easy to add the feature support.
This patch firstly tries to get the fractional divisor width during
probe, then setups dw specific get_divisor() and set_divisor() hook.

Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
---
 drivers/tty/serial/8250/8250_dw.c | 45 +++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index fa8a00e8c9c6..5a60c4814d62 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -31,6 +31,7 @@
 
 /* Offsets for the DesignWare specific registers */
 #define DW_UART_USR	0x1f /* UART Status Register */
+#define DW_UART_DLF	0xc0 /* Divisor Latch Fraction Register */
 #define DW_UART_CPR	0xf4 /* Component Parameter Register */
 #define DW_UART_UCV	0xf8 /* UART Component Version */
 
@@ -55,6 +56,7 @@
 
 struct dw8250_data {
 	u8			usr_reg;
+	u8			dlf_size;
 	int			line;
 	int			msr_mask_on;
 	int			msr_mask_off;
@@ -366,6 +368,37 @@ static bool dw8250_idma_filter(struct dma_chan *chan, void *param)
 	return param == chan->device->dev->parent;
 }
 
+/*
+ * divisor = div(I) + div(F)
+ * "I" means integer, "F" means fractional
+ * quot = div(I) = clk / (16 * baud)
+ * frac = div(F) * 2^dlf_size
+ *
+ * let rem = clk % (16 * baud)
+ * we have: div(F) * (16 * baud) = rem
+ * so frac = 2^dlf_size * rem / (16 * baud) = (rem << dlf_size) / (16 * baud)
+ */
+static unsigned int dw8250_get_divisor(struct uart_port *p,
+				       unsigned int baud,
+				       unsigned int *frac)
+{
+	unsigned int quot, rem, base_baud = baud * 16;
+	struct dw8250_data *d = p->private_data;
+
+	quot = p->uartclk / base_baud;
+	rem = p->uartclk % base_baud;
+	*frac = DIV_ROUND_CLOSEST(rem << d->dlf_size, base_baud);
+
+	return quot;
+}
+
+static void dw8250_set_divisor(struct uart_port *p, unsigned int baud,
+			       unsigned int quot, unsigned int quot_frac)
+{
+	dw8250_writel_ext(p, DW_UART_DLF, quot_frac);
+	serial8250_do_set_divisor(p, baud, quot, quot_frac);
+}
+
 static void dw8250_quirks(struct uart_port *p, struct dw8250_data *data)
 {
 	if (p->dev->of_node) {
@@ -426,6 +459,18 @@ static void dw8250_setup_port(struct uart_port *p)
 	dev_dbg(p->dev, "Designware UART version %c.%c%c\n",
 		(reg >> 24) & 0xff, (reg >> 16) & 0xff, (reg >> 8) & 0xff);
 
+	dw8250_writel_ext(p, DW_UART_DLF, ~0U);
+	reg = dw8250_readl_ext(p, DW_UART_DLF);
+	dw8250_writel_ext(p, DW_UART_DLF, 0);
+
+	if (reg) {
+		struct dw8250_data *d = p->private_data;
+
+		d->dlf_size = fls(reg);
+		p->get_divisor = dw8250_get_divisor;
+		p->set_divisor = dw8250_set_divisor;
+	}
+
 	reg = dw8250_readl_ext(p, DW_UART_CPR);
 	if (!reg)
 		return;
-- 
2.18.0
