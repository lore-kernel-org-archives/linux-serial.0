From: Jon Medhurst <tixy@linaro.org>
Subject: [PATCH 2/3] serial: amba-pl011: factor out code for writing LCR_H
 register
Date: Tue, 10 Dec 2013 10:18:59 +0000
Message-ID: <1386670740-16914-3-git-send-email-tixy@linaro.org>
References: <1386670740-16914-1-git-send-email-tixy@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1386670740-16914-1-git-send-email-tixy@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

The code to cope with a split tx/rx LCR_H register is non-trivial
so put it into it's own function to avoid duplication.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   39 +++++++++++++++++----------------------
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index a0dfb86..8ec1729 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1513,6 +1513,21 @@ static int pl011_hwinit(struct uart_port *port)
 	return retval;
 }
 
+static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
+{
+	writew(lcr_h, uap->port.membase + uap->lcrh_rx);
+	if (uap->lcrh_rx != uap->lcrh_tx) {
+		int i;
+		/*
+		 * Wait 10 PCLKs before writing LCRH_TX register,
+		 * to get this delay write read only register 10 times
+		 */
+		for (i = 0; i < 10; ++i)
+			writew(0xff, uap->port.membase + UART011_MIS);
+		writew(lcr_h, uap->port.membase + uap->lcrh_tx);
+	}
+}
+
 static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
@@ -1543,17 +1558,7 @@ static int pl011_startup(struct uart_port *port)
 	writew(cr, uap->port.membase + UART011_CR);
 	writew(0, uap->port.membase + UART011_FBRD);
 	writew(1, uap->port.membase + UART011_IBRD);
-	writew(0, uap->port.membase + uap->lcrh_rx);
-	if (uap->lcrh_tx != uap->lcrh_rx) {
-		int i;
-		/*
-		 * Wait 10 PCLKs before writing LCRH_TX register,
-		 * to get this delay write read only register 10 times
-		 */
-		for (i = 0; i < 10; ++i)
-			writew(0xff, uap->port.membase + UART011_MIS);
-		writew(0, uap->port.membase + uap->lcrh_tx);
-	}
+	pl011_write_lcr_h(uap, 0);
 	writew(0, uap->port.membase + UART01x_DR);
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
 		barrier();
@@ -1803,17 +1808,7 @@ pl011_set_termios(struct uart_port *port, struct ktermios *termios,
 	 * UART011_FBRD & UART011_IBRD.
 	 * ----------^----------^----------^----------^-----
 	 */
-	writew(lcr_h, port->membase + uap->lcrh_rx);
-	if (uap->lcrh_rx != uap->lcrh_tx) {
-		int i;
-		/*
-		 * Wait 10 PCLKs before writing LCRH_TX register,
-		 * to get this delay write read only register 10 times
-		 */
-		for (i = 0; i < 10; ++i)
-			writew(0xff, uap->port.membase + UART011_MIS);
-		writew(lcr_h, port->membase + uap->lcrh_tx);
-	}
+	pl011_write_lcr_h(uap, lcr_h);
 	writew(old_cr, port->membase + UART011_CR);
 
 	spin_unlock_irqrestore(&port->lock, flags);
-- 
1.7.10.4
