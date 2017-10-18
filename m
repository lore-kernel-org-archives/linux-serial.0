From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 1/3] tty: amba-pl011: earlycon: Switch to relaxed I/O
Date: Wed, 18 Oct 2017 15:14:46 +0100
Message-ID: <1508336088-3948-2-git-send-email-Dave.Martin@arm.com>
References: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1508336088-3948-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Andre Przywara <andre.przywara@arm.com>, Stephen Boyd <sboyd@codeaurora.org>, Russell King <linux@armlinux.org.uk>, Andy Gross <andy.gross@linaro.org>, linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Bhupinder Thakur <bhupinder.thakur@linaro.org>
List-Id: linux-serial@vger.kernel.org

The current pl011 earlycon implementation uses the regular I/O
accessors, but this is unnecessary because the architecture
enforces ordering of accesses to the same device anyway.

Using relaxed I/O brings the added bonus that the generic pl011
helpers can be used instead of having to open-code: this allows
some duplicate logic to be unified.

This patch does some refactoring so that pl011_{read,write,
tx_empty}() are split into a frontend that does the same thing as
before, and a backend __* that can be used with a uart_port that
has no corresponding uart_amba_port structure yet (i.e., the
earlycon scenario).

__pl011_tx_empty() can now be used in place of an open-coded poll
that differs between the generic and qdf2400_e44 earlycon
implementations, because __pl011_tx_empty() handles the necessary
quirkage transparently.

Moving to relaxed I/O loses wmb() semantics at the start of an
earlycon write, and this may be important for some debugging
scenarios, so an explicit wmb() is inserted at the start of each
earlycon write implementation.

Because qdf2400_e44 only supports 32-bit I/O, this patch also
explicitly sets port->iotype == UPIO_MEM32 so that __pl011_{write,
read}() use the correct I/O size.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 69 ++++++++++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 111e6a9..fd9e08c 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -300,26 +300,38 @@ static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
 	return uap->reg_offset[reg];
 }
 
-static unsigned int pl011_read(const struct uart_amba_port *uap,
-	unsigned int reg)
+static unsigned int __pl011_read(const struct uart_port *port,
+	const u16 *reg_offset, unsigned int reg)
 {
-	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
+	void __iomem *addr = port->membase + reg_offset[reg];
 
-	return (uap->port.iotype == UPIO_MEM32) ?
+	return (port->iotype == UPIO_MEM32) ?
 		readl_relaxed(addr) : readw_relaxed(addr);
 }
 
-static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
+static unsigned int pl011_read(const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	void __iomem *addr = uap->port.membase + pl011_reg_to_offset(uap, reg);
+	return __pl011_read(&uap->port, uap->reg_offset, reg);
+}
 
-	if (uap->port.iotype == UPIO_MEM32)
+static void __pl011_write(unsigned int val, const struct uart_port *port,
+	const u16 *reg_offset, unsigned int reg)
+{
+	void __iomem *addr = port->membase + reg_offset[reg];
+
+	if (port->iotype == UPIO_MEM32)
 		writel_relaxed(val, addr);
 	else
 		writew_relaxed(val, addr);
 }
 
+static void pl011_write(unsigned int val, const struct uart_amba_port *uap,
+	unsigned int reg)
+{
+	__pl011_write(val, &uap->port, uap->reg_offset, reg);
+}
+
 /*
  * Reads up to 256 characters from the FIFO or until it's empty and
  * inserts them into the TTY layer. Returns the number of characters
@@ -1537,16 +1549,23 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 	return IRQ_RETVAL(handled);
 }
 
-static unsigned int pl011_tx_empty(struct uart_port *port)
+static unsigned int __pl011_tx_empty(struct uart_port *port,
+	const u16 *reg_offset, const struct vendor_data *vendor)
 {
-	struct uart_amba_port *uap =
-	    container_of(port, struct uart_amba_port, port);
+	unsigned int status = __pl011_read(port, reg_offset, REG_FR);
 
 	/* Allow feature register bits to be inverted to work around errata */
-	unsigned int status = pl011_read(uap, REG_FR) ^ uap->vendor->inv_fr;
+	status ^= vendor->inv_fr;
+	status &= vendor->fr_busy | UART01x_FR_TXFF;
+	return status ? 0 : TIOCSER_TEMT;
+}
 
-	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
-							0 : TIOCSER_TEMT;
+static unsigned int pl011_tx_empty(struct uart_port *port)
+{
+	struct uart_amba_port *uap =
+	    container_of(port, struct uart_amba_port, port);
+
+	return __pl011_tx_empty(port, uap->reg_offset, uap->vendor);
 }
 
 static unsigned int pl011_get_mctrl(struct uart_port *port)
@@ -2419,10 +2438,13 @@ static struct console amba_console = {
 
 static void qdf2400_e44_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+	const struct vendor_data *vendor = &vendor_qdt_qdf2400_e44;
+	const u16 *reg_offset = vendor->reg_offset;
+
+	while (__pl011_read(port, reg_offset, REG_FR) & UART01x_FR_TXFF)
 		cpu_relax();
-	writel(c, port->membase + UART01x_DR);
-	while (!(readl(port->membase + UART01x_FR) & UART011_FR_TXFE))
+	__pl011_write(c, port, reg_offset, REG_DR);
+	while (!__pl011_tx_empty(port, reg_offset, vendor))
 		cpu_relax();
 }
 
@@ -2430,18 +2452,19 @@ static void qdf2400_e44_early_write(struct console *con, const char *s, unsigned
 {
 	struct earlycon_device *dev = con->data;
 
+	wmb();
 	uart_console_write(&dev->port, s, n, qdf2400_e44_putc);
 }
 
 static void pl011_putc(struct uart_port *port, int c)
 {
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
+	const struct vendor_data *vendor = &vendor_arm;
+	const u16 *reg_offset = vendor->reg_offset;
+
+	while (__pl011_read(port, reg_offset, REG_FR) & UART01x_FR_TXFF)
 		cpu_relax();
-	if (port->iotype == UPIO_MEM32)
-		writel(c, port->membase + UART01x_DR);
-	else
-		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+	__pl011_write(c, port, reg_offset, REG_DR);
+	while (!__pl011_tx_empty(port, reg_offset, vendor))
 		cpu_relax();
 }
 
@@ -2449,6 +2472,7 @@ static void pl011_early_write(struct console *con, const char *s, unsigned n)
 {
 	struct earlycon_device *dev = con->data;
 
+	wmb();
 	uart_console_write(&dev->port, s, n, pl011_putc);
 }
 
@@ -2494,6 +2518,7 @@ qdf2400_e44_early_console_setup(struct earlycon_device *device,
 	if (!device->port.membase)
 		return -ENODEV;
 
+	device->port.iotype = UPIO_MEM32;
 	device->con->write = qdf2400_e44_early_write;
 	return 0;
 }
-- 
2.1.4
