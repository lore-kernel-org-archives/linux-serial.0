From: Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] serial: sh-sci: Fix race condition causing garbage during shutdown
Date: Tue, 25 Apr 2017 20:15:35 +0200
Message-ID: <1493144135-898-1-git-send-email-geert+renesas@glider.be>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, Richard Genoud <richard.genoud@gmail.com>, Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, linux-serial@vger.kernel.org, linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>
List-Id: linux-serial@vger.kernel.org

If DMA is enabled and used, a burst of old data may be seen on the
serial console during "poweroff" or "reboot".  uart_flush_buffer()
clears the circular buffer, but sci_port.tx_dma_len is not reset.
This leads to a circular buffer overflow, dumping (UART_XMIT_SIZE -
sci_port.tx_dma_len) bytes.

To fix this, add a .flush_buffer() callback that resets
sci_port.tx_dma_len.

Inspired by commit 31ca2c63fdc0aee7 ("tty/serial: atmel: fix race
condition (TX+DMA)").

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
A big thanks to Richard!
I had no idea what was happening here, until I saw his patch passing by
in a stable backport.

In v4.3 and older, the field is called sg_len_tx.
---
 drivers/tty/serial/sh-sci.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/sh-sci.c b/drivers/tty/serial/sh-sci.c
index 9a47cc4f16a2798f..a15739202d6c75f2 100644
--- a/drivers/tty/serial/sh-sci.c
+++ b/drivers/tty/serial/sh-sci.c
@@ -1545,7 +1545,16 @@ static void sci_free_dma(struct uart_port *port)
 	if (s->chan_rx)
 		sci_rx_dma_release(s, false);
 }
-#else
+
+static void sci_flush_buffer(struct uart_port *port)
+{
+	/*
+	 * In uart_flush_buffer(), the xmit circular buffer has just been
+	 * cleared, so we have to reset tx_dma_len accordingly.
+	 */
+	to_sci_port(port)->tx_dma_len = 0;
+}
+#else /* !CONFIG_SERIAL_SH_SCI_DMA */
 static inline void sci_request_dma(struct uart_port *port)
 {
 }
@@ -1553,7 +1562,9 @@ static inline void sci_request_dma(struct uart_port *port)
 static inline void sci_free_dma(struct uart_port *port)
 {
 }
-#endif
+
+#define sci_flush_buffer	NULL
+#endif /* !CONFIG_SERIAL_SH_SCI_DMA */
 
 static irqreturn_t sci_rx_interrupt(int irq, void *ptr)
 {
@@ -2566,6 +2577,7 @@ static const struct uart_ops sci_uart_ops = {
 	.break_ctl	= sci_break_ctl,
 	.startup	= sci_startup,
 	.shutdown	= sci_shutdown,
+	.flush_buffer	= sci_flush_buffer,
 	.set_termios	= sci_set_termios,
 	.pm		= sci_pm,
 	.type		= sci_type,
-- 
2.7.4
