From: Soren Brinkmann <soren.brinkmann@xilinx.com>
Subject: [PATCH LINUX v4 12/13] tty: xuartps: Improve sysrq handling
Date: Sat, 5 Dec 2015 20:39:28 -0800
Message-ID: <1449376769-13369-13-git-send-email-soren.brinkmann@xilinx.com>
References: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1449376769-13369-1-git-send-email-soren.brinkmann@xilinx.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: Moritz Fischer <moritz.fischer@ettus.com>, Peter Hurley <peter@hurleysoftware.com>, Michal Simek <michal.simek@xilinx.com>, linux-kernel@vger.kernel.org, Soren Brinkmann <soren.brinkmann@xilinx.com>, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-serial@vger.kernel.org

Handling magic sysrq included dropping a lock to avoid a deadlock that
happened when cdns_uart_console_write tried to acquire a lock in the
from the sysrq code path. By making the acquisition of the lock in
cdns_uart_console_write depending on port->sysrq, cdns_uart_handle_rx can be
simplified to simply call uart_handle_sysrq.

Suggested-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v4:
 - added this patch
---
 drivers/tty/serial/xilinx_uartps.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 7afab0c36528..3b8d15fa5959 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -221,20 +221,8 @@ static void cdns_uart_handle_rx(struct uart_port *port, unsigned int isrstatus)
 				continue;
 		}
 
-#ifdef SUPPORT_SYSRQ
-		/*
-		 * uart_handle_sysrq_char() doesn't work if
-		 * spinlocked, for some reason
-		 */
-		 if (port->sysrq) {
-			spin_unlock(&port->lock);
-			if (uart_handle_sysrq_char(port, data)) {
-				spin_lock(&port->lock);
-				continue;
-			}
-			spin_lock(&port->lock);
-		}
-#endif
+		if (uart_handle_sysrq_char(port, data))
+			continue;
 
 		port->icount.rx++;
 
@@ -1121,7 +1109,9 @@ static void cdns_uart_console_write(struct console *co, const char *s,
 	unsigned int imr, ctrl;
 	int locked = 1;
 
-	if (oops_in_progress)
+	if (port->sysrq)
+		locked = 0;
+	else if (oops_in_progress)
 		locked = spin_trylock_irqsave(&port->lock, flags);
 	else
 		spin_lock_irqsave(&port->lock, flags);
-- 
2.6.3.3.g9bb996a
