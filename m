From: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH V2 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control from set/get_mctrl
Date: Mon, 1 Jun 2015 10:51:06 +0530
Message-ID: <1433136067-20644-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1433136067-20644-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1433136067-20644-1-git-send-email-bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, stefan-XLVq0VzYD2Y@public.gmane.org, shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, jslaby-AlSwsSmVLrQ@public.gmane.org, moorray3-5tc4TXWwyLM@public.gmane.org, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhuvanchandra.dv-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

The LPUART does not provide manual control of RTS/CTS signals,
those can only be controlled by the hardware directly. Therefore
manual control of those signals through mctrl can not be provided.
The current implementation enables/disables the automatic control,
which is not what mctrl should do, hence remove the incorrect
implementation.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv-2KBjVHiyJgBBDgjK7y7TUQ@public.gmane.org>
---
 drivers/tty/serial/fsl_lpuart.c | 63 +++++------------------------------------
 1 file changed, 7 insertions(+), 56 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 08ce76f..532cfb7 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -822,64 +822,15 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
 static unsigned int lpuart_get_mctrl(struct uart_port *port)
 {
-	unsigned int temp = 0;
-	unsigned char reg;
-
-	reg = readb(port->membase + UARTMODEM);
-	if (reg & UARTMODEM_TXCTSE)
-		temp |= TIOCM_CTS;
-
-	if (reg & UARTMODEM_RXRTSE)
-		temp |= TIOCM_RTS;
-
-	return temp;
-}
-
-static unsigned int lpuart32_get_mctrl(struct uart_port *port)
-{
-	unsigned int temp = 0;
-	unsigned long reg;
-
-	reg = lpuart32_read(port->membase + UARTMODIR);
-	if (reg & UARTMODIR_TXCTSE)
-		temp |= TIOCM_CTS;
-
-	if (reg & UARTMODIR_RXRTSE)
-		temp |= TIOCM_RTS;
-
-	return temp;
+	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
 }
 
 static void lpuart_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
-	unsigned char temp;
-
-	temp = readb(port->membase + UARTMODEM) &
-			~(UARTMODEM_RXRTSE | UARTMODEM_TXCTSE);
-
-	if (mctrl & TIOCM_RTS)
-		temp |= UARTMODEM_RXRTSE;
-
-	if (mctrl & TIOCM_CTS)
-		temp |= UARTMODEM_TXCTSE;
-
-	writeb(temp, port->membase + UARTMODEM);
-}
-
-static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
-{
-	unsigned long temp;
-
-	temp = lpuart32_read(port->membase + UARTMODIR) &
-			~(UARTMODIR_RXRTSE | UARTMODIR_TXCTSE);
-
-	if (mctrl & TIOCM_RTS)
-		temp |= UARTMODIR_RXRTSE;
-
-	if (mctrl & TIOCM_CTS)
-		temp |= UARTMODIR_TXCTSE;
-
-	lpuart32_write(temp, port->membase + UARTMODIR);
+    /*
+     * CTS/RTS can _only_ be handled
+     * automatically by the hardware.
+     */
 }
 
 static void lpuart_break_ctl(struct uart_port *port, int break_state)
@@ -1515,8 +1466,8 @@ static struct uart_ops lpuart_pops = {
 
 static struct uart_ops lpuart32_pops = {
 	.tx_empty	= lpuart32_tx_empty,
-	.set_mctrl	= lpuart32_set_mctrl,
-	.get_mctrl	= lpuart32_get_mctrl,
+	.set_mctrl	= lpuart_set_mctrl,
+	.get_mctrl	= lpuart_get_mctrl,
 	.stop_tx	= lpuart32_stop_tx,
 	.start_tx	= lpuart32_start_tx,
 	.stop_rx	= lpuart32_stop_rx,
-- 
2.1.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
