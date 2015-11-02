From: Andre Przywara <andre.przywara@arm.com>
Subject: [PATCH DRAFT 2/2] drivers: serial: PL011: [DRAFT] implement register
 diverson for ZTE UART
Date: Mon,  2 Nov 2015 12:24:02 +0000
Message-ID: <1446467042-24494-3-git-send-email-andre.przywara@arm.com>
References: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1446467042-24494-1-git-send-email-andre.przywara@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Jun Nie <jun.nie@linaro.org>, Peter Hurley <peter@hurleysoftware.com>, Timur Tabi <timur@tabi.org>
Cc: Andrew.Jackson@arm.com, Russell King <linux@arm.linux.org.uk>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The ZTE UART looks very much like a PL011, but (among other things)
has its registers at different offsets.
Introduce a translation table which maps PL011 offsets to ZTE specific
offsets and use that when needed.
Additionally guard this translation with a CONFIG_ symbol to avoid
unnecessary churn when one is not in need of the ZTE UART.

This is a DRAFT to sketch a less intrusive approach than the previous
patchsets suggested.
It does not cover the differing flag bits yet and also lacks the whole
probing and wiring-up code.

This is based on code from Jun Nie <jun.nie@linaro.org>.

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/amba/serial.h     | 10 ++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index ef5d779..e90840b 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -81,6 +81,7 @@ struct vendor_data {
 	bool			cts_event_workaround;
 	bool			always_enabled;
 	bool			fixed_options;
+	int			*reg_table;
 
 	unsigned int (*get_fifosize)(struct amba_device *dev);
 };
@@ -127,6 +128,34 @@ static struct vendor_data vendor_st = {
 	.get_fifosize		= get_fifosize_st,
 };
 
+int reg_table_zte[] = {
+	[UART01x_DR]	= ZX_UART01x_DR,
+	[UART011_LCRH]	= ZX_UART011_LCRH_TX,
+	[UART011_CR]	= ZX_UART011_CR,
+	[UART01x_FR]	= ZX_UART01x_FR,
+	[UART011_ICR]	= ZX_UART011_ICR,
+	[UART011_IBRD]	= UART011_IBRD,
+	[UART011_FBRD]	= UART011_FBRD,
+	[UART011_IFLS]	= ZX_UART011_IFLS,
+	[UART011_IMSC]	= ZX_UART011_IMSC,
+	[UART011_RIS]	= ZX_UART011_RIS,
+	[UART011_MIS]	= ZX_UART011_MIS,
+	[UART011_DMACR]	= ZX_UART011_DMACR,
+};
+
+static struct vendor_data vendor_zte = {
+	.ifls			= UART011_IFLS_RX4_8|UART011_IFLS_TX4_8,
+	.lcrh_tx		= UART011_LCRH,
+	.lcrh_rx		= UART011_LCRH,
+	.oversampling		= false,
+	.dma_threshold		= false,
+	.cts_event_workaround	= false,
+	.always_enabled		= false,
+	.fixed_options		= false,
+	.get_fifosize		= get_fifosize_arm,
+	.reg_table		= reg_table_zte,
+};
+
 /* Deals with DMA transactions */
 
 struct pl011_sgbuf {
@@ -186,11 +215,19 @@ struct uart_amba_port {
 
 static unsigned int pl011_read(struct uart_amba_port *uap, int offset)
 {
+#ifdef CONFIG_SOC_ZX296702
+	if (uap->vendor->reg_table)
+		offset = uap->vendor->reg_table[offset];
+#endif
 	return readw(uap->port.membase + offset);
 }
 
 static void pl011_write(struct uart_amba_port *uap, int val, int offset)
 {
+#ifdef CONFIG_SOC_ZX296702
+	if (uap->vendor->reg_table)
+		offset = uap->vendor->reg_table[offset];
+#endif
 	writew(val, uap->port.membase + offset);
 }
 
diff --git a/include/linux/amba/serial.h b/include/linux/amba/serial.h
index 0ddb5c0..1c71b83 100644
--- a/include/linux/amba/serial.h
+++ b/include/linux/amba/serial.h
@@ -31,6 +31,7 @@
  *  UART Register Offsets.
  */
 #define UART01x_DR		0x00	/* Data read or written from the interface. */
+#define ZX_UART01x_DR		0x04	/* Different offset in the ZTE UART. */
 #define UART01x_RSR		0x04	/* Receive status register (Read). */
 #define UART01x_ECR		0x04	/* Error clear register (Write). */
 #define UART010_LCRH		0x08	/* Line control register, high byte. */
@@ -39,6 +40,7 @@
 #define ST_UART011_TIMEOUT	0x0C    /* Timeout period register. */
 #define UART010_LCRL		0x10	/* Line control register, low byte. */
 #define UART010_CR		0x14	/* Control register. */
+#define ZX_UART01x_FR		0x14	/* Different offset in the ZTE UART. */
 #define UART01x_FR		0x18	/* Flag register (Read only). */
 #define UART010_IIR		0x1C	/* Interrupt identification register (Read). */
 #define UART010_ICR		0x1C	/* Interrupt clear register (Write). */
@@ -48,14 +50,22 @@
 #define UART011_FBRD		0x28	/* Fractional baud rate divisor register. */
 #define UART011_LCRH		0x2c	/* Line control register. */
 #define ST_UART011_LCRH_TX	0x2c    /* Tx Line control register. */
+#define ZX_UART011_LCRH_TX	0x30    /* Different offset in the ZTE UART. */
 #define UART011_CR		0x30	/* Control register. */
 #define UART011_IFLS		0x34	/* Interrupt fifo level select. */
+#define ZX_UART011_CR		0x34	/* Different offset in the ZTE UART. */
+#define ZX_UART011_IFLS		0x38	/* Different offset in the ZTE UART. */
 #define UART011_IMSC		0x38	/* Interrupt mask. */
 #define UART011_RIS		0x3c	/* Raw interrupt status. */
 #define UART011_MIS		0x40	/* Masked interrupt status. */
+#define ZX_UART011_IMSC		0x40	/* Different offset in the ZTE UART. */
 #define UART011_ICR		0x44	/* Interrupt clear register. */
+#define ZX_UART011_RIS		0x44	/* Different offset in the ZTE UART. */
 #define UART011_DMACR		0x48	/* DMA control register. */
+#define ZX_UART011_MIS		0x48	/* Different offset in the ZTE UART. */
+#define ZX_UART011_ICR		0x4c	/* Different offset in the ZTE UART. */
 #define ST_UART011_XFCR		0x50	/* XON/XOFF control register. */
+#define ZX_UART011_DMACR	0x50	/* Different offset in the ZTE UART. */
 #define ST_UART011_XON1		0x54	/* XON1 register. */
 #define ST_UART011_XON2		0x58	/* XON2 register. */
 #define ST_UART011_XOFF1	0x5C	/* XON1 register. */
-- 
2.5.1
