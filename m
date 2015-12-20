From: Wills Wang <wills.wang@live.com>
Subject: [PATCH v2] sc16is7xx: fix incorrect register bits macro
Date: Sun, 20 Dec 2015 12:55:23 +0800
Message-ID: <BLU436-SMTP8780F773CD9AE53BF764D6FFE30@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jringle@gridpoint.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc: Wills Wang <wills.wang@live.com>
List-Id: linux-serial@vger.kernel.org

In datasheet, Modem Status Register MSR[4-7] reflect the modem pins
CTS/DSR/RI/CD signal state.

Signed-off-by: Wills Wang <wills.wang@live.com>
---
 drivers/tty/serial/sc16is7xx.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/sc16is7xx.c b/drivers/tty/serial/sc16is7xx.c
index edb5305..9d18c24 100644
--- a/drivers/tty/serial/sc16is7xx.c
+++ b/drivers/tty/serial/sc16is7xx.c
@@ -196,14 +196,14 @@
 						  * or (IO6)
 						  * - only on 75x/76x
 						  */
-#define SC16IS7XX_MSR_CTS_BIT		(1 << 0) /* CTS */
-#define SC16IS7XX_MSR_DSR_BIT		(1 << 1) /* DSR (IO4)
+#define SC16IS7XX_MSR_CTS_BIT		(1 << 4) /* CTS */
+#define SC16IS7XX_MSR_DSR_BIT		(1 << 5) /* DSR (IO4)
 						  * - only on 75x/76x
 						  */
-#define SC16IS7XX_MSR_RI_BIT		(1 << 2) /* RI (IO7)
+#define SC16IS7XX_MSR_RI_BIT		(1 << 6) /* RI (IO7)
 						  * - only on 75x/76x
 						  */
-#define SC16IS7XX_MSR_CD_BIT		(1 << 3) /* CD (IO6)
+#define SC16IS7XX_MSR_CD_BIT		(1 << 7) /* CD (IO6)
 						  * - only on 75x/76x
 						  */
 #define SC16IS7XX_MSR_DELTA_MASK	0x0F     /* Any of the delta bits! */
@@ -240,7 +240,7 @@
 
 /* IOControl register bits (Only 750/760) */
 #define SC16IS7XX_IOCONTROL_LATCH_BIT	(1 << 0) /* Enable input latching */
-#define SC16IS7XX_IOCONTROL_GPIO_BIT	(1 << 1) /* Enable GPIO[7:4] */
+#define SC16IS7XX_IOCONTROL_MODEM_BIT	(1 << 1) /* Enable GPIO[7:4] as modem pins */
 #define SC16IS7XX_IOCONTROL_SRESET_BIT	(1 << 3) /* Software Reset */
 
 /* EFCR register bits */
@@ -674,7 +674,7 @@ static void sc16is7xx_port_irq(struct sc16is7xx_port *s, int portno)
 		case SC16IS7XX_IIR_CTSRTS_SRC:
 			msr = sc16is7xx_port_read(port, SC16IS7XX_MSR_REG);
 			uart_handle_cts_change(port,
-					       !!(msr & SC16IS7XX_MSR_CTS_BIT));
+					       !!(msr & SC16IS7XX_MSR_DCTS_BIT));
 			break;
 		case SC16IS7XX_IIR_THRI_SRC:
 			sc16is7xx_handle_tx(port);
-- 
1.9.1
