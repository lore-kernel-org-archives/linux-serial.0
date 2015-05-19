From: Dave Martin <Dave.Martin@arm.com>
Subject: [PATCH] serial/amba-pl011: Fix mismerge between v4.1-rc4 and tty-next
Date: Tue, 19 May 2015 11:51:14 +0100
Message-ID: <1432032674-22167-1-git-send-email-Dave.Martin@arm.com>
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

In commit 02730d3c053a9af1d402e1c8dc8bbbc5a1340406
(Merge 4.1-rc4 into tty-next), git mismerged some lines,
reintroducing a reference to the removed field
uart_amba_port.tx_irq_seen.  This causes a build failure.

This patch removes the mismerged lines, restoring the code to what
was in tty-next (which was the intention).

Signed-off-by: Dave Martin <Dave.Martin@arm.com>
---

This patch is based on tty-next commit
02730d3c053a9af1d402e1c8dc8bbbc5a1340406 (Merge 4.1-rc4 into tty-next).

Without it, amba-pl011.c won't build.

 drivers/tty/serial/amba-pl011.c |    3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/amba-pl011.c b/drivers/tty/serial/amba-pl011.c
index 6fabc05..f5bd842 100644
--- a/drivers/tty/serial/amba-pl011.c
+++ b/drivers/tty/serial/amba-pl011.c
@@ -1578,9 +1578,6 @@ static int pl011_startup(struct uart_port *port)
 
 	writew(uap->vendor->ifls, uap->port.membase + UART011_IFLS);
 
-	/* Assume that TX IRQ doesn't work until we see one: */
-	uap->tx_irq_seen = 0;
-
 	spin_lock_irq(&uap->port.lock);
 
 	/* restore RTS and DTR */
-- 
1.7.10.4
