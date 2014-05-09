From: dean_jenkins@mentor.com
Subject: [PATCH 3/5] serial: imx: avoid spinlock recursion deadlock
Date: Fri,  9 May 2014 16:19:46 +0100
Message-ID: <1399648788-26061-4-git-send-email-dean_jenkins@mentor.com>
References: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1399648788-26061-1-git-send-email-dean_jenkins@mentor.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: gregkh@linuxfoundation.org, linux-serial@vger.kernel.org
Cc: dirk.behme@de.bosch.com, s.hauer@pengutronix.de, dean_jenkins@mentor.com, b32955@freescale.com, linux-arm-kernel@lists.infradead.org, shawn.guo@freescale.com
List-Id: linux-serial@vger.kernel.org

From: Andy Lowe <andy_lowe@mentor.com>

The following deadlock has been observed:

imx_int() {
  imx_txint() {
    spin_lock_irqsave(&sport->port.lock,flags);
    /* ^^^uart_port spinlock taken in imx_txint */
    imx_transmit_buffer() {
      uart_write_wakeup(&sport->port) {
        tty_wakeup() {
          hci_uart_tty_wakeup() {
            hci_uart_tx_wakeup() {
              uart_write() {
                spin_lock_irqsave(&port->lock, flags);
                /* ^^^deadlock here when spinlock is taken again */
                  .
                  .
                  .
                spin_unlock_irqrestore(&port->lock, flags);
              }
            }
          }
        }
      }
    }
    spin_unlock_irqrestore(&sport->port.lock,flags);
  }
}

To correct this call uart_write_wakeup() at the end of imx_txint() after
the uart_port spinlock is unlocked.

Signed-off-by: Andy Lowe <andy_lowe@mentor.com>
Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
---
 drivers/tty/serial/imx.c |    7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
index abe31ad..cc79706 100644
--- a/drivers/tty/serial/imx.c
+++ b/drivers/tty/serial/imx.c
@@ -636,8 +636,13 @@ static irqreturn_t imx_txint(int irq, void *dev_id)
 
 	imx_transmit_buffer(sport);
 
-	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
+	if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS) {
+		spin_unlock_irqrestore(&sport->port.lock, flags);
 		uart_write_wakeup(&sport->port);
+	} else
+		spin_unlock_irqrestore(&sport->port.lock, flags);
+
+	return IRQ_HANDLED;
 
 out:
 	spin_unlock_irqrestore(&sport->port.lock, flags);
-- 
1.7.9.5
