From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH v2] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Tue, 30 Jan 2018 17:49:35 +0000
Message-ID: <1517334575-4698-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-arm-kernel@lists.infradead.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org, Russell King <linux@armlinux.org.uk>
List-Id: linux-serial@vger.kernel.org

Commit 9b96fbacda34 ("serial: PL011: clear pending interrupts")
clears the RX and receive timeout interrupts on pl011 startup, to
avoid a screaming-interrupt scenario that can occur when the
firmware or bootloader leaves these interrupts asserted.

This has been noted as an issue when running Linux on qemu [1].

Unfortunately, the above fix seems to lead to potential
misbehaviour if the RX FIFO interrupt is asserted _non_ spuriously
on driver startup, if the RX FIFO is also already full to the
trigger level.

Clearing the RX FIFO interrupt does not change the FIFO fill level.
In this scenario, because the interrupt is now clear and because
the FIFO is already full to the trigger level, no new assertion of
the RX FIFO interrupt can occur unless the FIFO is drained back
below the trigger level.  This never occurs because the pl011
driver is waiting for an RX FIFO interrupt to tell it that there is
something to read, and does not read the FIFO at all until that
interrupt occurs.

Thus, simply clearing "spurious" interrupts on startup may be
misguided, since there is no way to be sure that the interrupts are
truly spurious, and things can go wrong if they are not.

This patch attempts to handle (suspected) spurious interrupts more
robustly, by allowing the interrupt(s) to fire but quenching the
scream.

pl011_int() runs and attempts to drain the FIFO anyway just as if
the interrupts were real.  If the FIFO is already empty, great.  To
avoid a screaming spurious interrupt, the RX FIFO and timeout
interrupts are now explicitly cleared in between committing to
drain the RX FIFO and actually draining it.  We do not have to
worry about lost interrupts here, because we are effectively in
polled mode inside pl011_int() until the RX FIFO becomes empty:

  * A new char received before the RX FIFO is fully drained will be
    drained out synchronously by pl011_int() along with the other
    chars already pending.  A new char received after the RX FIFO
    is drained will result in correct RX FIFO interrupt assertion,
    because emptying the RX FIFO guarantees that the RX FIFO /
    timeout interrupt state machines are back in a sane state.

  * A new RX timeout before the RX FIFO is fully drained is no
    problem, because pl011_int() has already committed to emptying
    the FIFO at this point, guaranteeing that no stray chars will
    be left behind.  A new RX timeout after the RX FIFO is fully
    drained will result in correct interrupt assertion.

This patch does not attempt to address the case where the RX FIFO
fills faster than it can be drained: that is a pathological
condition that is beyond the scope of the driver to work around.
Users cannot expect this to work unless they enable hardware flow
control.

[1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Reported-by: Wei Xu <xuwei5@hisilicon.com>
Cc: Wei Xu <xuwei5@hisilicon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 9b96fbacda34 ("serial: PL011: clear pending interrupts")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Wei, are you happy for me to add your Tested-by?

Keeping this as RFC, since I'm still not sure about possible side-
effects.  I'll wait a bit to see if anyone else can test the patch
or has comments.

Changes since RFC v1:

Requested by Wei Xu:

  * Also don't clear those interrupts in pl011_hwinit(), which can
    probably trigger the same issue.
---
 drivers/tty/serial/amba-pl011.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 04af8de..dd6c285 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1492,9 +1492,7 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 		do {
 			check_apply_cts_event_workaround(uap);
 
-			pl011_write(status & ~(UART011_TXIS|UART011_RTIS|
-					       UART011_RXIS),
-				    uap, REG_ICR);
+			pl011_write(status & ~UART011_TXIS, uap, REG_ICR);
 
 			if (status & (UART011_RTIS|UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
@@ -1674,9 +1672,8 @@ static int pl011_hwinit(struct uart_port *port)
 
 	uap->port.uartclk = clk_get_rate(uap->clk);
 
-	/* Clear pending error and receive interrupts */
-	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS |
-		    UART011_FEIS | UART011_RTIS | UART011_RXIS,
+	/* Clear pending error interrupts */
+	pl011_write(UART011_OEIS | UART011_BEIS | UART011_PEIS | UART011_FEIS,
 		    uap, REG_ICR);
 
 	/*
@@ -1733,8 +1730,6 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 {
 	spin_lock_irq(&uap->port.lock);
 
-	/* Clear out any spuriously appearing RX interrupts */
-	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
-- 
2.1.4
