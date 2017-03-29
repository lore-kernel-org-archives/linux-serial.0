From: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
Subject: [PATCHv2] serial: 8250_dw: Minor code cleanup
Date: Wed, 29 Mar 2017 20:37:16 +0200
Message-ID: <20170329183716.5881-1-oliver@schinagl.nl>
Reply-To: oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sunxi+bncBDC2JNWXZAJBBZP557DAKGQESUNRWAY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Jiri Slaby <jslaby-IBi9RG/b67k@public.gmane.org>
Cc: dev-3kdeTeqwOZ9EV1b7eY7vFQ@public.gmane.org, Kefeng Wang <wangkefeng.wang-hv44wF8Li93QT0dZR+AlfA@public.gmane.org>, Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Heikki Krogerus <heikki.krogerus-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Jason Uy <jason.uy-dY08KVG/lbpWk0Htik3J/w@public.gmane.org>, Douglas Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ed Blake <ed.blake-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, linux-serial-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
List-Id: linux-serial@vger.kernel.org

Some very minor code cleanups, such as including the bitops header for
DW_UART_MCR_SIRE, use the BIT() macro as suggested by checkpatch and
removed a white space to match other invocations.

Signed-off-by: Olliver Schinagl <oliver-dxLnbx3+1qmEVqv0pETR8A@public.gmane.org>
---
Changes since v1:
  Split up these non-code changing changes into a separate patch.

 drivers/tty/serial/8250/8250_dw.c | 23 ++++++++++++-----------
 1 file changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/serial/8250/8250_dw.c b/drivers/tty/serial/8250/8250_dw.c
index e65808c482f1..56aded887771 100644
--- a/drivers/tty/serial/8250/8250_dw.c
+++ b/drivers/tty/serial/8250/8250_dw.c
@@ -13,6 +13,7 @@
  * LCR is written whilst busy.  If it is, then a busy detect interrupt is
  * raised, the LCR needs to be rewritten and the uart status register read.
  */
+#include <linux/bitops.h>
 #include <linux/device.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -39,16 +40,16 @@
 
 /* Component Parameter Register bits */
 #define DW_UART_CPR_ABP_DATA_WIDTH	(3 << 0)
-#define DW_UART_CPR_AFCE_MODE		(1 << 4)
-#define DW_UART_CPR_THRE_MODE		(1 << 5)
-#define DW_UART_CPR_SIR_MODE		(1 << 6)
-#define DW_UART_CPR_SIR_LP_MODE		(1 << 7)
-#define DW_UART_CPR_ADDITIONAL_FEATURES	(1 << 8)
-#define DW_UART_CPR_FIFO_ACCESS		(1 << 9)
-#define DW_UART_CPR_FIFO_STAT		(1 << 10)
-#define DW_UART_CPR_SHADOW		(1 << 11)
-#define DW_UART_CPR_ENCODED_PARMS	(1 << 12)
-#define DW_UART_CPR_DMA_EXTRA		(1 << 13)
+#define DW_UART_CPR_AFCE_MODE		BIT(4)
+#define DW_UART_CPR_THRE_MODE		BIT(5)
+#define DW_UART_CPR_SIR_MODE		BIT(6)
+#define DW_UART_CPR_SIR_LP_MODE		BIT(7)
+#define DW_UART_CPR_ADDITIONAL_FEATURES	BIT(8)
+#define DW_UART_CPR_FIFO_ACCESS		BIT(9)
+#define DW_UART_CPR_FIFO_STAT		BIT(10)
+#define DW_UART_CPR_SHADOW		BIT(11)
+#define DW_UART_CPR_ENCODED_PARMS	BIT(12)
+#define DW_UART_CPR_DMA_EXTRA		BIT(13)
 #define DW_UART_CPR_FIFO_MODE		(0xff << 16)
 /* Helper for fifo size calculation */
 #define DW_UART_CPR_FIFO_SIZE(a)	(((a >> 16) & 0xff) * 16)
@@ -222,7 +223,7 @@ static int dw8250_handle_irq(struct uart_port *p)
 		status = p->serial_in(p, UART_LSR);
 
 		if (!(status & (UART_LSR_DR | UART_LSR_BI)))
-			(void) p->serial_in(p, UART_RX);
+			(void)p->serial_in(p, UART_RX);
 
 		spin_unlock_irqrestore(&p->lock, flags);
 	}
-- 
2.11.0
