From: Yoshihiro Kaneko <ykaneko0929@gmail.com>
Subject: [PATCH/RFC] serial: sh-sci: Remove schedule_work in sci_dma_rx_complete
Date: Thu, 30 Apr 2015 02:07:36 +0900
Message-ID: <1430327256-8545-1-git-send-email-ykaneko0929@gmail.com>
Return-path: <linux-sh-owner@vger.kernel.org>
Sender: linux-sh-owner@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>, linux-sh@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

From: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>

This patch calls work_fn_rx() directly so that the driver can avoid
executing of next sci_dma_rx_complete() before work_fn_rx() completes.

Signed-off-by: Kazuya Mizuguchi <kazuya.mizuguchi.ks@renesas.com>
Signed-off-by: Yoshihiro Kaneko <ykaneko0929@gmail.com>
---

This patch is based on the tty-next branch of Greg Kroah-Hartman's tty
tree.

 drivers/tty/serial/sh-sci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index e7d6566..664ae78 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -126,6 +126,9 @@ struct sci_port {
 static void sci_start_tx(struct uart_port *port);
 static void sci_stop_tx(struct uart_port *port);
 static void sci_start_rx(struct uart_port *port);
+#ifdef CONFIG_SERIAL_SH_SCI_DMA
+static void work_fn_rx(struct work_struct *work);
+#endif
 
 #define SCI_NPORTS CONFIG_SERIAL_SH_SCI_NR_UARTS
 
@@ -1341,7 +1344,7 @@ static void sci_dma_rx_complete(void *arg)
 	if (count)
 		tty_flip_buffer_push(&port->state->port);
 
-	schedule_work(&s->work_rx);
+	work_fn_rx(&s->work_rx);
 }
 
 static void sci_rx_dma_release(struct sci_port *s, bool enable_pio)
-- 
1.9.1

