From: Russell King <rmk+kernel@arm.linux.org.uk>
Subject: [PATCH 05/11] tty: amba-pl011: add register lookup table
Date: Tue, 03 Nov 2015 14:51:18 +0000
Message-ID: <E1Ztcve-0007CO-UO@rmk-PC.arm.linux.org.uk>
References: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20151103134349.GV8644@n2100.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Peter Hurley <peter@hurleysoftware.com>, Andre Przywara <andre.przywara@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Andrew.Jackson@arm.com, Timur Tabi <timur@tabi.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>, Jun Nie <jun.nie@linaro.org>
List-Id: linux-serial@vger.kernel.org

Add a register lookup table, which allows the register offsets to be
adjusted on a per-port basis.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/tty/serial/amba-pl011.c | 33 ++++++++++++++++++++++++-
 drivers/tty/serial/amba-pl011.h | 53 ++++++++++++++++++++++-------------------
 2 files changed, 60 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index b3a0956d8883..6269eb9907bd 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -73,6 +73,34 @@
 #define UART_DR_ERROR		(UART011_DR_OE|UART011_DR_BE|UART011_DR_PE|UART011_DR_FE)
 #define UART_DUMMY_DR_RX	(1 << 16)
 
+static u16 pl011_std_offsets[REG_ARRAY_SIZE] = {
+	[REG_DR] = UART01x_DR,
+	[REG_ST_DMAWM] = ST_UART011_DMAWM,
+	[REG_ST_TIMEOUT] = ST_UART011_TIMEOUT,
+	[REG_FR] = UART01x_FR,
+	[REG_ST_LCRH_RX] = ST_UART011_LCRH_RX,
+	[REG_IBRD] = UART011_IBRD,
+	[REG_FBRD] = UART011_FBRD,
+	[REG_LCRH] = UART011_LCRH,
+	[REG_ST_LCRH_TX] = ST_UART011_LCRH_TX,
+	[REG_CR] = UART011_CR,
+	[REG_IFLS] = UART011_IFLS,
+	[REG_IMSC] = UART011_IMSC,
+	[REG_RIS] = UART011_RIS,
+	[REG_MIS] = UART011_MIS,
+	[REG_ICR] = UART011_ICR,
+	[REG_DMACR] = UART011_DMACR,
+	[REG_ST_XFCR] = ST_UART011_XFCR,
+	[REG_ST_XON1] = ST_UART011_XON1,
+	[REG_ST_XON2] = ST_UART011_XON2,
+	[REG_ST_XOFF1] = ST_UART011_XOFF1,
+	[REG_ST_XOFF2] = ST_UART011_XOFF2,
+	[REG_ST_ITCR] = ST_UART011_ITCR,
+	[REG_ST_ITIP] = ST_UART011_ITIP,
+	[REG_ST_ABCR] = ST_UART011_ABCR,
+	[REG_ST_ABIMSC] = ST_UART011_ABIMSC,
+};
+
 /* There is by now at least one vendor with differing details, so handle it */
 struct vendor_data {
 	unsigned int		ifls;
@@ -164,6 +192,7 @@ struct pl011_dmatx_data {
  */
 struct uart_amba_port {
 	struct uart_port	port;
+	const u16		*reg_offset;
 	struct clk		*clk;
 	const struct vendor_data *vendor;
 	unsigned int		dmacr;		/* dma control reg */
@@ -189,7 +218,7 @@ struct uart_amba_port {
 static unsigned int pl011_reg_to_offset(const struct uart_amba_port *uap,
 	unsigned int reg)
 {
-	return reg;
+	return uap->reg_offset[reg];
 }
 
 static unsigned int pl011_read(const struct uart_amba_port *uap,
@@ -2397,6 +2426,7 @@ static int pl011_probe(struct amba_device *dev, const struct amba_id *id)
 	if (IS_ERR(uap->clk))
 		return PTR_ERR(uap->clk);
 
+	uap->reg_offset = pl011_std_offsets;
 	uap->vendor = vendor;
 	uap->lcrh_rx = vendor->lcrh_rx;
 	uap->lcrh_tx = vendor->lcrh_tx;
@@ -2478,6 +2508,7 @@ static int sbsa_uart_probe(struct platform_device *pdev)
 	if (!uap)
 		return -ENOMEM;
 
+	uap->reg_offset	= pl011_std_offsets;
 	uap->vendor	= &vendor_sbsa;
 	uap->fifosize	= 32;
 	uap->port.irq	= platform_get_irq(pdev, 0);
diff --git a/drivers/tty/serial/amba-pl011.h b/drivers/tty/serial/amba-pl011.h
index b7eb1bc2fab9..0c6756dba2fe 100644
--- a/drivers/tty/serial/amba-pl011.h
+++ b/drivers/tty/serial/amba-pl011.h
@@ -2,31 +2,34 @@
 #define AMBA_PL011_H
 
 enum {
-	REG_DR = UART01x_DR,
-	REG_ST_DMAWM = ST_UART011_DMAWM,
-	REG_ST_TIMEOUT = ST_UART011_TIMEOUT,
-	REG_FR = UART01x_FR,
-	REG_ST_LCRH_RX = ST_UART011_LCRH_RX,
-	REG_IBRD = UART011_IBRD,
-	REG_FBRD = UART011_FBRD,
-	REG_LCRH = UART011_LCRH,
-	REG_ST_LCRH_TX = ST_UART011_LCRH_TX,
-	REG_CR = UART011_CR,
-	REG_IFLS = UART011_IFLS,
-	REG_IMSC = UART011_IMSC,
-	REG_RIS = UART011_RIS,
-	REG_MIS = UART011_MIS,
-	REG_ICR = UART011_ICR,
-	REG_DMACR = UART011_DMACR,
-	REG_ST_XFCR = ST_UART011_XFCR,
-	REG_ST_XON1 = ST_UART011_XON1,
-	REG_ST_XON2 = ST_UART011_XON2,
-	REG_ST_XOFF1 = ST_UART011_XOFF1,
-	REG_ST_XOFF2 = ST_UART011_XOFF2,
-	REG_ST_ITCR = ST_UART011_ITCR,
-	REG_ST_ITIP = ST_UART011_ITIP,
-	REG_ST_ABCR = ST_UART011_ABCR,
-	REG_ST_ABIMSC = ST_UART011_ABIMSC,
+	REG_DR,
+	REG_ST_DMAWM,
+	REG_ST_TIMEOUT,
+	REG_FR,
+	REG_ST_LCRH_RX,
+	REG_IBRD,
+	REG_FBRD,
+	REG_LCRH,
+	REG_ST_LCRH_TX,
+	REG_CR,
+	REG_IFLS,
+	REG_IMSC,
+	REG_RIS,
+	REG_MIS,
+	REG_ICR,
+	REG_DMACR,
+	REG_ST_XFCR,
+	REG_ST_XON1,
+	REG_ST_XON2,
+	REG_ST_XOFF1,
+	REG_ST_XOFF2,
+	REG_ST_ITCR,
+	REG_ST_ITIP,
+	REG_ST_ABCR,
+	REG_ST_ABIMSC,
+
+	/* The size of the array - must be last */
+	REG_ARRAY_SIZE,
 };
 
 #endif
-- 
2.1.0
