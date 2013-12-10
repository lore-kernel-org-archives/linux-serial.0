From: Jon Medhurst <tixy@linaro.org>
Subject: [PATCH 3/3] serial: amba-pl011: preseserve hardware settings during
 initialisation
Date: Tue, 10 Dec 2013 10:19:00 +0000
Message-ID: <1386670740-16914-4-git-send-email-tixy@linaro.org>
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

During initialisation, a UART may already be in use for a console, so
take care to preserve things like baud rate and data format to avoid
corrupting console output.

Signed-off-by: Jon Medhurst <tixy@linaro.org>
---
 drivers/tty/serial/amba-pl011.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 8ec1729..7012ef3 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1531,7 +1531,7 @@ static void pl011_write_lcr_h(struct uart_amba_port *uap, unsigned int lcr_h)
 static int pl011_startup(struct uart_port *port)
 {
 	struct uart_amba_port *uap = (struct uart_amba_port *)port;
-	unsigned int cr;
+	unsigned int cr, lcr_h, fbrd, ibrd;
 	int retval;
 
 	retval = pl011_hwinit(port);
@@ -1550,10 +1550,16 @@ static int pl011_startup(struct uart_port *port)
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
 	/*
-	 * Provoke TX FIFO interrupt into asserting.
+	 * Provoke TX FIFO interrupt into asserting. Taking care to preserve
+	 * baud rate and data format specified by FBRD, IBRD and LCRH as the
+	 * UART may already be in use as a console.
 	 */
 	spin_lock_irq(&uap->port.lock);
 
+	fbrd = readw(uap->port.membase + UART011_FBRD);
+	ibrd = readw(uap->port.membase + UART011_IBRD);
+	lcr_h = readw(uap->port.membase + uap->lcrh_rx);
+
 	cr = UART01x_CR_UARTEN | UART011_CR_TXE | UART011_CR_LBE;
 	writew(cr, uap->port.membase + UART011_CR);
 	writew(0, uap->port.membase + UART011_FBRD);
@@ -1563,6 +1569,10 @@ static int pl011_startup(struct uart_port *port)
 	while (readw(uap->port.membase + UART01x_FR) & UART01x_FR_BUSY)
 		barrier();
 
+	writew(fbrd, uap->port.membase + UART011_FBRD);
+	writew(ibrd, uap->port.membase + UART011_IBRD);
+	pl011_write_lcr_h(uap, lcr_h);
+
 	/* restore RTS and DTR */
 	cr = uap->old_cr & (UART011_CR_RTS | UART011_CR_DTR);
 	cr |= UART01x_CR_UARTEN | UART011_CR_RXE | UART011_CR_TXE;
-- 
1.7.10.4
