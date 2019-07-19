From: Dave Martin <Dave.Martin@arm.com>
Subject: [RFC PATCH 2/2] serial: pl011: Don't bother pushing more TX data
 while TX irq is active
Date: Fri, 19 Jul 2019 14:35:25 +0100
Message-ID: <1563543325-12463-3-git-send-email-Dave.Martin@arm.com>
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

When the TX irq is active, writing chars to the TX FIFO from
anywhere except pl011_int() is pointless: the UART is already busy,
and new chars will be picked up by pl011_int() as soon as there is
FIFO space.

To reduce the scope for surprises, bail out of pl011_start_tx_pio()
without attempting to write to the FIFO or start TX DMA if the TX FIFO
interrupt is already in use.

This should also avoid pointless overhead in some situations.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>

---

Please test both with and without this patch.

I believe with the previous patch in place, this patch is not strictly
necessary.  However, if the UART is actively transmitting in the
background already, it does make sense not to waste time trying polling
the FIFO fill status or setting up DMA etc.
---
 drivers/tty/serial/amba-pl011.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index e24bbc0..f28935a 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1318,6 +1318,10 @@ static void pl011_start_tx(struct uart_port *port)
 	struct uart_amba_port *uap =
 	    container_of(port, struct uart_amba_port, port);
 
+	/* It's pointless to kick the UART if it's already transmitting... */
+	if (uap->im & UART011_TXIM)
+		return;
+
 	if (!pl011_dma_tx_start(uap))
 		pl011_start_tx_pio(uap);
 }
-- 
2.1.4
