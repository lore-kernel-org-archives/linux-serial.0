From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] serial: bfin_uart: Convert timers to use timer_setup()
Date: Tue, 24 Oct 2017 02:59:31 -0700
Message-ID: <20171024095931.GA67812@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>, adi-buildroot-devel@lists.sourceforge.net, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-serial@vger.kernel.org

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.com>
Cc: adi-buildroot-devel@lists.sourceforge.net
Cc: linux-serial@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/tty/serial/bfin_uart.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/serial/bfin_uart.c b/drivers/tty/serial/bfin_uart.c
index 293ecbb00684..de5262a46b62 100644
--- a/drivers/tty/serial/bfin_uart.c
+++ b/drivers/tty/serial/bfin_uart.c
@@ -456,8 +456,9 @@ static void bfin_serial_dma_rx_chars(struct bfin_serial_port *uart)
 	tty_flip_buffer_push(&uart->port.state->port);
 }
 
-void bfin_serial_rx_dma_timeout(struct bfin_serial_port *uart)
+void bfin_serial_rx_dma_timeout(struct timer_list *t)
 {
+	struct bfin_serial_port *uart = from_timer(uart, t, rx_dma_timer);
 	int x_pos, pos;
 	unsigned long flags;
 
@@ -624,8 +625,6 @@ static int bfin_serial_startup(struct uart_port *port)
 	set_dma_start_addr(uart->rx_dma_channel, (unsigned long)uart->rx_dma_buf.buf);
 	enable_dma(uart->rx_dma_channel);
 
-	uart->rx_dma_timer.data = (unsigned long)(uart);
-	uart->rx_dma_timer.function = (void *)bfin_serial_rx_dma_timeout;
 	uart->rx_dma_timer.expires = jiffies + DMA_RX_FLUSH_JIFFIES;
 	add_timer(&(uart->rx_dma_timer));
 #else
@@ -1316,7 +1315,7 @@ static int bfin_serial_probe(struct platform_device *pdev)
 		}
 		uart->rx_dma_channel = res->start;
 
-		init_timer(&(uart->rx_dma_timer));
+		timer_setup(&uart->rx_dma_timer, bfin_serial_rx_dma_timeout, 0);
 #endif
 
 #if defined(SERIAL_BFIN_CTSRTS) || \
-- 
2.7.4


-- 
Kees Cook
Pixel Security
