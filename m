From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH] tty: pl011: Avoid spuriously stuck-off interrupts
Date: Fri, 27 Apr 2018 11:05:45 +0100
Message-ID: <1524823545-11309-2-git-send-email-Dave.Martin@arm.com>
References: <1524823545-11309-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1524823545-11309-1-git-send-email-Dave.Martin@arm.com>
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Ciro Santilli <ciro.santilli@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Russell King <linux@armlinux.org.uk>, Wei Xu <xuwei5@hisilicon.com>, linux-serial@vger.kernel.org
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

This patch instead clears the interrupt condition by draining the
RX FIFO during UART startup, after clearing any potentially
spurious interrupt.  This should ensure that an interrupt will
definitely be asserted if the RX FIFO subsequently becomes
sufficiently full.

The drain is done at the point of enabling interrupts only.  This
means that it will occur any time the UART is newly opened through
the tty layer.  It will not apply to polled-mode use of the UART by
kgdboc: since that scenario cannot use interrupts by design, this
should not matter.  kgdboc will interact badly with "normal" use of
the UART in any case: this patch makes no attempt to paper over
such issues.

This patch does not attempt to address the case where the RX FIFO
fills faster than it can be drained: that is a pathological
hardware design problem that is beyond the scope of the driver to
work around.

[1] [Qemu-devel] [Qemu-arm] [PATCH] pl011: do not put into fifo
before enabled the interruption
https://lists.gnu.org/archive/html/qemu-devel/2018-01/msg06446.html

Reported-by: Wei Xu <xuwei5@hisilicon.com>
Cc: Russell King <linux@armlinux.org.uk>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Fixes: 9b96fbacda34 ("serial: PL011: clear pending interrupts")
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
Tested-by: Andrew Jones <drjones@redhat.com>
Reviewed-by: Andrew Jones <drjones@redhat.com>
---
 drivers/tty/serial/amba-pl011.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 4b40a5b..a6ccb85 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1731,6 +1731,16 @@ static void pl011_enable_interrupts(struct uart_amba_port *uap)
 
 	/* Clear out any spuriously appearing RX interrupts */
 	pl011_write(UART011_RTIS | UART011_RXIS, uap, REG_ICR);
+
+	/*
+	 * RXIS is asserted only when the RX FIFO transitions from below
+	 * to above the trigger threshold.  If the RX FIFO is already
+	 * full to the threshold this can't happen and RXIS will now be
+	 * stuck off.  Drain the RX FIFO explicitly to fix this:
+	 */
+	while (!(pl011_read(uap, REG_FR) & UART01x_FR_RXFE))
+		pl011_read(uap, REG_DR);
+
 	uap->im = UART011_RTIM;
 	if (!pl011_dma_rx_running(uap))
 		uap->im |= UART011_RXIM;
-- 
2.1.4
