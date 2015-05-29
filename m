From: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
Subject: [PATCH 2/3] tty: serial: fsl_lpuart: remove RTS/CTS control from
 set/get_mctrl
Date: Fri, 29 May 2015 13:35:53 +0530
Message-ID: <1432886754-30115-3-git-send-email-bhuvanchandra.dv@toradex.com>
References: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1432886754-30115-1-git-send-email-bhuvanchandra.dv@toradex.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org
Cc: devicetree@vger.kernel.org, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, stefan@agner.ch, bhuvanchandra.dv@gmail.com, kernel@pengutronix.de, shawn.guo@linaro.org, jslaby@suse.cz, linux-arm-kernel@lists.infradead.org, Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
List-Id: linux-serial@vger.kernel.org

The LPUART does not provide manual control of RTS/CTS signals,
those can only be controlled by the hardware directly. Therefore
manual control of those signals through mctrl can not be provided.
The current implementation enables/disables the automatic control,
which is not what mctrl should do, hence remove the incorrect
implementation.

Signed-off-by: Bhuvanchandra DV <bhuvanchandra.dv@toradex.com>
---
 drivers/tty/serial/fsl_lpuart.c | 56 ++++++++---------------------------------
 1 file changed, 10 insertions(+), 46 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 08ce76f..357f623 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -822,64 +822,28 @@ static unsigned int lpuart32_tx_empty(struct uart_port *port)
 
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
+	return TIOCM_CAR | TIOCM_CTS | TIOCM_DSR;
 }
 
 static unsigned int lpuart32_get_mctrl(struct uart_port *port)
 {
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
+    /*
+     * CTS/RTS can _only_ be handled
+     * automatically by the hardware.
+     */
 }
 
 static void lpuart32_set_mctrl(struct uart_port *port, unsigned int mctrl)
 {
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
-- 
2.1.0
