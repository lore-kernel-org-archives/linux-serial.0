From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH 2/3]  serial: amba-pl011: complete support to ZTE uart
Date: Mon, 15 Feb 2016 20:13:13 +0800
Message-ID: <1455538393-7038-2-git-send-email-jun.nie@linaro.org>
References: <1455538393-7038-1-git-send-email-jun.nie@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1455538393-7038-1-git-send-email-jun.nie@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: andre.przywara@arm.com, timur@codeaurora.org, linux@arm.linux.org.uk, graeme.gregory@linaro.org, peter@hurleysoftware.com, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org, shawn.guo@linaro.org
Cc: jason.liu@linaro.org, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Complete support to ZTE uart with adding specific registers
mask.

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
 drivers/tty/serial/amba-pl011.c | 70 ++++++++++++++++++++++++++++++++++-------
 include/linux/amba/serial.h     |  4 +++
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index f52a243..72ae785 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -97,6 +97,10 @@ struct vendor_data {
 	const u16		*reg_offset;
 	const struct uart_ops	*uart_pops;
 	unsigned int		ifls;
+	unsigned int		fr_busy;
+	unsigned int		fr_dsr;
+	unsigned int		fr_cts;
+	unsigned int		fr_ri;
 	bool			access_32b;
 	bool			oversampling;
 	bool			dma_threshold;
@@ -115,6 +119,10 @@ static unsigned int get_fifosize_arm(struct amba_device *dev)
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
@@ -130,6 +138,10 @@ static unsigned int get_fifosize_sbsa(struct amba_device *dev)
 
 static struct vendor_data vendor_sbsa = {
 	.reg_offset		= pl011_std_offsets,
+	.fr_busy		= UART01x_FR_BUSY,
+	.fr_dsr			= UART01x_FR_DSR,
+	.fr_cts			= UART01x_FR_CTS,
+	.fr_ri			= UART011_FR_RI,
 	.uart_pops		= &sbsa_uart_pops,
 	.oversampling		= false,
 	.dma_threshold		= false,
@@ -174,6 +186,10 @@ static unsigned int get_fifosize_st(struct amba_device *dev)
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
@@ -198,12 +214,26 @@ static const u16 pl011_zte_offsets[REG_ARRAY_SIZE] = {
 	[REG_DMACR] = ZX_UART011_DMACR,
 };
 
+static unsigned int get_fifosize_zte(struct amba_device *dev)
+{
+	return 16;
+}
+
 static struct vendor_data vendor_zte __maybe_unused = {
 	.reg_offset		= pl011_zte_offsets,
 	.uart_pops		= &amba_pl011_pops,
 	.access_32b		= true,
 	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
-	.get_fifosize		= get_fifosize_arm,
+	.fr_busy		= ZX_UART01x_FR_BUSY,
+	.fr_dsr			= ZX_UART01x_FR_DSR,
+	.fr_cts			= ZX_UART01x_FR_CTS,
+	.fr_ri			= ZX_UART011_FR_RI,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= false,
+	.fixed_options		= false,
+	.get_fifosize		= get_fifosize_zte,
 };
 
 /* Deals with DMA transactions */
@@ -248,6 +278,10 @@ struct uart_amba_port {
 	unsigned int		im;		/* interrupt mask */
 	unsigned int		old_status;
 	unsigned int		fifosize;	/* vendor-specific */
+	unsigned int		fr_busy;        /* vendor-specific */
+	unsigned int		fr_dsr;		/* vendor-specific */
+	unsigned int		fr_cts;         /* vendor-specific */
+	unsigned int		fr_ri;		/* vendor-specific */
 	unsigned int		old_cr;		/* state during shutdown */
 	bool			autorts;
 	unsigned int		fixed_baud;	/* vendor-set fixed baud rate */
@@ -1178,7 +1212,7 @@ static void pl011_dma_shutdown(struct uart_amba_port *uap)
 		return;
 
 	/* Disable RX and TX DMA */
-	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, REG_FR) & uap->fr_busy)
 		cpu_relax();
 
 	spin_lock_irq(&uap->port.lock);
@@ -1427,11 +1461,11 @@ static void pl011_modem_status(struct uart_amba_port *uap)
 	if (delta & UART01x_FR_DCD)
 		uart_handle_dcd_change(&uap->port, status & UART01x_FR_DCD);
 
-	if (delta & UART01x_FR_DSR)
+	if (delta & uap->fr_dsr)
 		uap->port.icount.dsr++;
 
-	if (delta & UART01x_FR_CTS)
-		uart_handle_cts_change(&uap->port, status & UART01x_FR_CTS);
+	if (delta & uap->fr_cts)
+		uart_handle_cts_change(&uap->port, status & uap->fr_cts);
 
 	wake_up_interruptible(&uap->port.state->port.delta_msr_wait);
 }
@@ -1504,7 +1538,7 @@ static unsigned int pl011_tx_empty(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 	unsigned int status = pl011_read(uap, REG_FR);
-	return status & (UART01x_FR_BUSY|UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
+	return status & (uap->fr_busy | UART01x_FR_TXFF) ? 0 : TIOCSER_TEMT;
 }
 
 static unsigned int pl011_get_mctrl(struct uart_port *port)
@@ -1519,9 +1553,9 @@ static unsigned int pl011_get_mctrl(struct uart_port *port)
 		result |= tiocmbit
 
 	TIOCMBIT(UART01x_FR_DCD, TIOCM_CAR);
-	TIOCMBIT(UART01x_FR_DSR, TIOCM_DSR);
-	TIOCMBIT(UART01x_FR_CTS, TIOCM_CTS);
-	TIOCMBIT(UART011_FR_RI, TIOCM_RNG);
+	TIOCMBIT(uap->fr_dsr, TIOCM_DSR);
+	TIOCMBIT(uap->fr_cts, TIOCM_CTS);
+	TIOCMBIT(uap->fr_ri, TIOCM_RNG);
 #undef TIOCMBIT
 	return result;
 }
@@ -2200,7 +2234,7 @@ pl011_console_write(struct console *co, const char *s, unsigned int count)
 	 *	Finally, wait for transmitter to become empty
 	 *	and restore the TCR
 	 */
-	while (pl011_read(uap, REG_FR) & UART01x_FR_BUSY)
+	while (pl011_read(uap, REG_FR) & uap->fr_busy)
 		cpu_relax();
 	if (!uap->vendor->always_enabled)
 		pl011_write(old_cr, uap, REG_CR);
@@ -2482,8 +2516,12 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 		return PTR_ERR(uap->clk);
 
 	uap->reg_offset = vendor->reg_offset;
-	uap->vendor = vendor;
-	uap->fifosize = vendor->get_fifosize(dev);
+	uap->vendor	= vendor;
+	uap->fifosize	= vendor->get_fifosize(dev);
+	uap->fr_busy	= vendor->fr_busy;
+	uap->fr_dsr	= vendor->fr_dsr;
+	uap->fr_cts	= vendor->fr_cts;
+	uap->fr_ri	= vendor->fr_ri;
 	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.irq = dev->irq[0];
 	uap->port.ops = &amba_pl011_pops;
@@ -2568,9 +2606,17 @@ static int pl011_uart_plat_probe(struct platform_device *pdev)
 	if (!uap)
 		return -ENOMEM;
 
+	uap->clk = devm_clk_get(&pdev->dev, NULL);
+	if (IS_ERR(uap->clk))
+		return PTR_ERR(uap->clk);
+
 	uap->vendor	= vendor;
 	uap->reg_offset	= vendor->reg_offset;
 	uap->fifosize	= vendor->get_fifosize(NULL);
+	uap->fr_busy	= vendor_sbsa.fr_busy;
+	uap->fr_dsr	= vendor_sbsa.fr_dsr;
+	uap->fr_cts	= vendor_sbsa.fr_cts;
+	uap->fr_ri	= vendor_sbsa.fr_ri;
 	uap->port.iotype = vendor->access_32b ? UPIO_MEM32 : UPIO_MEM;
 	uap->port.irq	= platform_get_irq(pdev, 0);
 	uap->port.ops	= vendor->uart_pops;
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index d76a19b..750f2ef 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -103,6 +103,10 @@
 #define UART01x_FR_DSR 		0x002
 #define UART01x_FR_CTS 		0x001
 #define UART01x_FR_TMSK		(UART01x_FR_TXFF + UART01x_FR_BUSY)
+#define ZX_UART01x_FR_BUSY	0x300
+#define ZX_UART01x_FR_DSR	0x008
+#define ZX_UART01x_FR_CTS	0x002
+#define ZX_UART011_FR_RI	0x001
 
 #define UART011_CR_CTSEN	0x8000	/* CTS hardware flow control */
 #define UART011_CR_RTSEN	0x4000	/* RTS hardware flow control */
-- 
1.9.1
