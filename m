From: Benjamin Krill <ben@codiert.org>
Subject: [PATCH] Fix wrong register read address and add interrupt acknowledge.
Date: Tue, 5 May 2009 21:11:16 +0200
Message-ID: <20090505191116.GA7267@codiert.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org>
Content-Disposition: inline
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
Sender: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@ozlabs.org
To: linuxppc-dev@ozlabs.org, linux-serial@vger.kernel.org
Cc: arnd@arndb.de
List-Id: linux-serial@vger.kernel.org

The receive interrupt routine checks the wrong register if the
receive fifo is empty. Further an explicit interrupt acknowledge
write is introduced. In some circumstances another interrupt was
issued.

Signed-off-by: Benjamin Krill <ben@codiert.org>
---
 drivers/serial/nwpserial.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/serial/nwpserial.c b/drivers/serial/nwpserial.c
index 32f3eaf..9e150b1 100644
--- a/drivers/serial/nwpserial.c
+++ b/drivers/serial/nwpserial.c
@@ -145,11 +145,13 @@ static irqreturn_t nwpserial_interrupt(int irq, void *dev_id)
 		ch = dcr_read(up->dcr_host, UART_RX);
 		if (up->port.ignore_status_mask != NWPSERIAL_STATUS_RXVALID)
 			tty_insert_flip_char(tty, ch, TTY_NORMAL);
-	} while (dcr_read(up->dcr_host, UART_RX) & UART_LSR_DR);
+	} while (dcr_read(up->dcr_host, UART_LSR) & UART_LSR_DR);

 	tty_flip_buffer_push(tty);
 	ret = IRQ_HANDLED;

+	/* clear interrupt */
+	dcr_write(up->dcr_host, UART_IIR, 1);
 out:
 	spin_unlock(&up->port.lock);
 	return ret;
--
1.5.4.5
