From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH REPOST] serial/amba-pl011: Unconditionally poll for FIFO space
 before each TX char
Date: Thu, 21 May 2015 16:37:49 +0100
Message-ID: <1432222669-20117-1-git-send-email-Dave.Martin@arm.com>
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
To: linux-serial@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Russell King <linux@arm.linux.org.uk>, =?UTF-8?q?Jakub=20Kici=C5=84ski?= <moorray3@wp.pl>, Andre Przywara <Andre.Przywara@arm.com>, Andrew Jackson <Andrew.Jackson@arm.com>, Graeme Gregory <gg@slimlogic.co.uk>, popcorn mix <popcornmix@gmail.com>, Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Commit 734745caeb9f155ab58918834a8c70e83fa6afd3 serial/amba-pl011:
(Activate TX IRQ passively) introduces a race which causes the driver
sometimes to attempt to write a character to the TX FIFO when the FIFO
is already full.

The PL011 does not guarantee its behaviour when the FIFO is overfilled.
In practice, this can cause duplicate and/or dropped characters to be
output on the wire.  The problem is common enough to be readily
observable on the ARM Juno platform when the PL011 UART is used as
the console and DMA is not in use.

This patch fixes this problem by always polling for space before each
character is written to the FIFO.

This will be amended to a less brute-force approach in a later commit,
but this patch should help ensure correct behaviour for now.

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

The patch is based on torvalds/master (v4.1-rc4-11-g1113cdf)

Please consider applying it for v4.1.  Without it, we have a
significant functional regression compared with v4.0.


I've been testing this for a couple of weeks on ARM Juno and it appears
sound; any further testing by other people is still encouraged.

*Note*
This will cause a conflict with tty-next because it pulls forward
some changes made by commit 1e84d22 (serial/amba-pl011: Refactor and
simplify TX FIFO handling).

The correct resolution is to take amba-pl011.c from tty-next.

Cheers
---Dave


 drivers/tty/serial/amba-pl011.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6f5a072..763eb20 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1249,20 +1249,19 @@ __acquires(&uap->port.lock)
 
 /*
  * Transmit a character
- * There must be at least one free entry in the TX FIFO to accept the char.
  *
- * Returns true if the FIFO might have space in it afterwards;
- * returns false if the FIFO definitely became full.
+ * Returns true if the character was successfully queued to the FIFO.
+ * Returns false otherwise.
  */
 static bool pl011_tx_char(struct uart_amba_port *uap, unsigned char c)
 {
+	if (readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF)
+		return false; /* unable to transmit character */
+
 	writew(c, uap->port.membase + UART01x_DR);
 	uap->port.icount.tx++;
 
-	if (likely(uap->tx_irq_seen > 1))
-		return true;
-
-	return !(readw(uap->port.membase + UART01x_FR) & UART01x_FR_TXFF);
+	return true;
 }
 
 static bool pl011_tx_chars(struct uart_amba_port *uap)
@@ -1296,7 +1295,8 @@ static bool pl011_tx_chars(struct uart_amba_port *uap)
 		return false;
 
 	if (uap->port.x_char) {
-		pl011_tx_char(uap, uap->port.x_char);
+		if (!pl011_tx_char(uap, uap->port.x_char))
+			goto done;
 		uap->port.x_char = 0;
 		--count;
 	}
-- 
1.7.10.4
