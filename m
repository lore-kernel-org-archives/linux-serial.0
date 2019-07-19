From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 1/2] serial: pl011: Fix dropping of TX chars due to irq
 race
Date: Fri, 19 Jul 2019 14:35:24 +0100
Message-ID: <1563543325-12463-2-git-send-email-Dave.Martin@arm.com>
References: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1563543325-12463-1-git-send-email-Dave.Martin@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: linux-serial@vger.kernel.org
Cc: Russell King <linux@arm.linux.org.uk>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Phil Elwell <phil@raspberrypi.org>, linux-rpi-kernel@lists.infradead.org, Jiri Slaby <jslaby@suse.com>, Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

When serial_core pushes some new TX chars via a call to
pl011_start_tx(), it can race with irqs triggered by ongoing
transmission.

Normally the port lock protects against this kind of thing, but
temporary releasing of the lock during calls from pl011_int() to
pl011_{,dma_}rx_chars() allows pl011_start_tx() to race.

For performance reasons, pl011_tx_chars(, true) always assumes that
the TX FIFO interrupt trigger condition holds, i.e., the FIFO is
empty to the trigger threshold.  This means that we can write chars
to fill the FIFO back up without the expense of polling the FIFO
fill status.  However, this assumes that no data is written to the
FIFO in the meantime by other code: this is where the race with
pl011_start_tx_pio() breaks things.

Reorder pl011_int() so that no code releases the port lock in
between reading the interrupt status bits and calling
pl011_tx_chars().  This ensures that TXIS in the fetched status
accurately reflects the state of the TX FIFO, and ensures that
there is no race to fill the FIFO.

Fixes: 1e84d22322ce ("serial/amba-pl011: Refactor and simplify TX FIFO handling")
Reported-by: Phil Elwell <phil@raspberrypi.org>
Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---
 drivers/tty/serial/amba-pl011.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 89ade21..e24bbc0 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1492,6 +1492,13 @@ static irqreturn_t pl011_int(int irq, void *dev_id)
 					       UART011_RXIS),
 				    uap, REG_ICR);
 
+			/*
+			 * Don't unlock uap->port.lock before here:
+			 * Stale TXIS status can lead to a FIFO overfill.
+			 */
+			if (status & UART011_TXIS)
+				pl011_tx_chars(uap, true);
+
 			if (status & (UART011_RTIS|UART011_RXIS)) {
 				if (pl011_dma_rx_running(uap))
 					pl011_dma_rx_irq(uap);
-- 
2.1.4
