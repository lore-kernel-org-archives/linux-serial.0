From: Shawn Guo <shawn.guo@linaro.org>
Subject: [PATCH v3 1/3] tty: amba-pl011: define flag register bits for ZTE
 device
Date: Fri,  8 Jul 2016 17:00:39 +0800
Message-ID: <1467968441-4056-2-git-send-email-shawn.guo@linaro.org>
References: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1467968441-4056-1-git-send-email-shawn.guo@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <linux@armlinux.org.uk>
Cc: Peter Hurley <peter@hurleysoftware.com>, Jason Liu <jason.liu@linaro.org>, Andre Przywara <andre.przywara@arm.com>, Timur Tabi <timur@codeaurora.org>, xie.baoyou@zte.com.cn, linux-serial@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

For some reason we do not really understand, ZTE hardware designers
choose to define PL011 Flag Register bit positions differently from
standard ones as below.

	Bit		Standard	ZTE
	-----------------------------------
	CTS		0		1
	DSR		1		3
	BUSY		3		8
	RI		8		0

Let's define these bits into vendor data and get ZTE PL011 supported
properly.

Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 45 ++++++++++++++++++++++++++++++++---------
 include/linux/amba/serial.h     |  9 +++++++++
 2 files changed, 44 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 1b7331e40d79..e09354e6bcb7 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -93,6 +93,10 @@ static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
 struct vendor_data {
 	const u16		*reg_offset;
 	unsigned int		ifls;
+	unsigned int		fr_busy;
+	unsigned int		fr_dsr;
+	unsigned int		fr_cts;
+	unsigned int		fr_ri;
 	bool			access_32b;
 	bool			oversampling;
 	bool			dma_threshold;
@@ -111,6 +115,10 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
 static struct vendor_data vendor_arm = {
 	.reg_offset		= pl011_std_offsets,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.fr_busy		= UART01x_FR_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
 	.oversampling		= false,
 	.dma_threshold		= false,
 	.cts_event_workaround	= false,
@@ -121,6 +129,10 @@ static struct vendor_data vendor_arm = {
 
 static struct vendor_data vendor_sbsa = {
 	.reg_offset		= pl011_std_offsets,
+	.fr_busy		= UART01x_FR_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
 	.access_32b		= true,
 	.oversampling		= false,
 	.dma_threshold		= false,
@@ -164,6 +176,10 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
 static struct vendor_data vendor_st = {
 	.reg_offset		= pl011_st_offsets,
 	.ifls			= UART011_IFLS_RX_HALF|UART011_IFLS_TX_HALF,
+	.fr_busy		= UART01x_FR_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
 	.oversampling		= true,
 	.dma_threshold		= true,
 	.cts_event_workaround	= true,
@@ -192,6 +208,10 @@ static struct vendor_data vendor_zte __maybe_unused = {
 	.reg_offset		= pl011_zte_offsets,
 	.access_32b		= true,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.fr_busy		= ZX_UART01x_FR_BUSY,
+	.fr_dsr			= ZX_UART01x_FR_DSR,
+	.fr_cts			= ZX_UART01x_FR_CTS,
+	.fr_ri			= ZX_UART011_FR_RI,
 	.get_fifosize		= get_fifosize_arm,
 };
 
@@ -1167,7 +1187,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		return;
 
 	/* Disable RX and TX DMA */
-	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
 		cpu_relax();
 
 	spin_lock_irq(&uap->port.lock);
@@ -1416,11 +1436,12 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 	if (delta & UART01x_FR_DCD)
 		uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
 
-	if (delta & UART01x_FR_DSR)
+	if (delta & uap->vendor->fr_dsr)
 		uap->port.icount.dsr++;
 
-	if (delta & UART01x_FR_CTS)
-		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
+	if (delta & uap->vendor->fr_cts)
+		uart_handle_cts_change(&uap->port,
+				       status & uap->vendor->fr_cts);
 
 	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }
@@ -1493,7 +1514,8 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int status = pl011_read(uap, REG_FR);
-	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
+	return status & (uap->vendor->fr_busy | UART01x_FR_TXFF) ?
+							0 : TIOCSER_TEMT;
 }
 
 static unsigned int pl011_get_mctrl(struct uart_port *port)
@@ -1508,9 +1530,9 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 		result |= tiocmbit
 
 	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
-	TIOCMBIT(UART01x_FR_DSR, TIOCM_DSR);
-	TIOCMBIT(UART01x_FR_CTS, TIOCM_CTS);
-	TIOCMBIT(UART011_FR_RI, TIOCM_RNG);
+	TIOCMBIT(uap->vendor->fr_dsr, TIOCM_DSR);
+	TIOCMBIT(uap->vendor->fr_cts, TIOCM_CTS);
+	TIOCMBIT(uap->vendor->fr_ri, TIOCM_RNG);
 #undef TIOCMBIT
 	return result;
 }
@@ -2191,7 +2213,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
-	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, REG_FR) & uap->vendor->fr_busy)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
@@ -2303,13 +2325,16 @@ static struct console amba_console = {
 
 static void pl011_putc(struct uart_port *port, int c)
 {
+	struct uart_amba_port *uap =
+		container_of(port, struct uart_amba_port, port);
+
 	while (readl(port->membase + UART01x_FR) & UART01x_FR_TXFF)
 		cpu_relax();
 	if (port->iotype == UPIO_MEM32)
 		writel(c, port->membase + UART01x_DR);
 	else
 		writeb(c, port->membase + UART01x_DR);
-	while (readl(port->membase + UART01x_FR) & UART01x_FR_BUSY)
+	while (readl(port->membase + UART01x_FR) & uap->vendor->fr_busy)
 		cpu_relax();
 }
 
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index d76a19ba2cff..ad0965e21a5e 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -104,6 +104,15 @@
 #define UART01x_FR_CTS 		0x001
 #define UART01x_FR_TMSK		(UART01x_FR_TXFF + UART01x_FR_BUSY)
 
+/*
+ * Some bits of Flag Register on ZTE device have different position from
+ * standard ones.
+ */
+#define ZX_UART01x_FR_BUSY	0x100
+#define ZX_UART01x_FR_DSR	0x008
+#define ZX_UART01x_FR_CTS	0x002
+#define ZX_UART011_FR_RI	0x001
+
 #define UART011_CR_CTSEN	0x8000	/* CTS hardware flow control */
 #define UART011_CR_RTSEN	0x4000	/* RTS hardware flow control */
 #define UART011_CR_OUT2		0x2000	/* OUT2 */
-- 
1.9.1
