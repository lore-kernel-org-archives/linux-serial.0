From: Baolin Wang <baolin.wang@linaro.org>
Subject: [PATCH v2 2/5] serial: sprd: Use readable macros instead of magic number
Date: Mon, 17 Sep 2018 11:33:41 -0700
Message-ID: <feaa6d1c76b64cbd9e538c892bd2dbe53ec99e33.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
In-Reply-To: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
References: <96e34fdadaf3f354f5d8e0d2895508e7c7918839.1537208449.git.baolin.wang@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, jslaby@suse.com
Cc: orsonzhai@gmail.com, baolin.wang@linaro.org, zhang.lyra@gmail.com, broonie@kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

Define readable macros instead of magic number to make code more readable.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
Acked-by: Chunyan Zhang <chunyan.zhang@spreadtrum.com>
---
Changes from v1:
 - Add acked tag from Chunyan.
---
 drivers/tty/serial/sprd_serial.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/sprd_serial.c b/drivers/tty/serial/sprd_serial.c
index 1b0e3fb..e18d8af 100644
--- a/drivers/tty/serial/sprd_serial.c
+++ b/drivers/tty/serial/sprd_serial.c
@@ -45,6 +45,8 @@
 
 /* data number in TX and RX fifo */
 #define SPRD_STS1		0x000C
+#define SPRD_RX_FIFO_CNT_MASK	GENMASK(7, 0)
+#define SPRD_TX_FIFO_CNT_MASK	GENMASK(15, 8)
 
 /* interrupt enable register and its BITs */
 #define SPRD_IEN		0x0010
@@ -82,11 +84,15 @@
 /* fifo threshold register */
 #define SPRD_CTL2		0x0020
 #define THLD_TX_EMPTY	0x40
+#define THLD_TX_EMPTY_SHIFT	8
 #define THLD_RX_FULL	0x40
 
 /* config baud rate register */
 #define SPRD_CLKD0		0x0024
+#define SPRD_CLKD0_MASK		GENMASK(15, 0)
 #define SPRD_CLKD1		0x0028
+#define SPRD_CLKD1_MASK		GENMASK(20, 16)
+#define SPRD_CLKD1_SHIFT	16
 
 /* interrupt mask status register */
 #define SPRD_IMSR			0x002C
@@ -115,7 +121,7 @@ static inline void serial_out(struct uart_port *port, int offset, int value)
 
 static unsigned int sprd_tx_empty(struct uart_port *port)
 {
-	if (serial_in(port, SPRD_STS1) & 0xff00)
+	if (serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		return 0;
 	else
 		return TIOCSER_TEMT;
@@ -213,7 +219,8 @@ static inline void sprd_rx(struct uart_port *port)
 	struct tty_port *tty = &port->state->port;
 	unsigned int ch, flag, lsr, max_count = SPRD_TIMEOUT;
 
-	while ((serial_in(port, SPRD_STS1) & 0x00ff) && max_count--) {
+	while ((serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK) &&
+	       max_count--) {
 		lsr = serial_in(port, SPRD_LSR);
 		ch = serial_in(port, SPRD_RXD);
 		flag = TTY_NORMAL;
@@ -303,16 +310,17 @@ static int sprd_startup(struct uart_port *port)
 	struct sprd_uart_port *sp;
 	unsigned long flags;
 
-	serial_out(port, SPRD_CTL2, ((THLD_TX_EMPTY << 8) | THLD_RX_FULL));
+	serial_out(port, SPRD_CTL2,
+		   THLD_TX_EMPTY << THLD_TX_EMPTY_SHIFT | THLD_RX_FULL);
 
 	/* clear rx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0x00ff)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_RX_FIFO_CNT_MASK)
 		serial_in(port, SPRD_RXD);
 
 	/* clear tx fifo */
 	timeout = SPRD_TIMEOUT;
-	while (timeout-- && serial_in(port, SPRD_STS1) & 0xff00)
+	while (timeout-- && serial_in(port, SPRD_STS1) & SPRD_TX_FIFO_CNT_MASK)
 		cpu_relax();
 
 	/* clear interrupt */
@@ -433,10 +441,11 @@ static void sprd_set_termios(struct uart_port *port,
 	}
 
 	/* clock divider bit0~bit15 */
-	serial_out(port, SPRD_CLKD0, quot & 0xffff);
+	serial_out(port, SPRD_CLKD0, quot & SPRD_CLKD0_MASK);
 
 	/* clock divider bit16~bit20 */
-	serial_out(port, SPRD_CLKD1, (quot & 0x1f0000) >> 16);
+	serial_out(port, SPRD_CLKD1,
+		   (quot & SPRD_CLKD1_MASK) >> SPRD_CLKD1_SHIFT);
 	serial_out(port, SPRD_LCR, lcr);
 	fc |= RX_TOUT_THLD_DEF | RX_HFC_THLD_DEF;
 	serial_out(port, SPRD_CTL1, fc);
@@ -510,7 +519,7 @@ static void wait_for_xmitr(struct uart_port *port)
 		if (--tmout == 0)
 			break;
 		udelay(1);
-	} while (status & 0xff00);
+	} while (status & SPRD_TX_FIFO_CNT_MASK);
 }
 
 static void sprd_console_putchar(struct uart_port *port, int ch)
-- 
1.9.1
