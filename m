From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2] serial: core: Fix crashes while echoing when closing
Date: Sun, 12 Jul 2015 21:05:26 -0400
Message-ID: <1436749526-5664-1-git-send-email-peter@hurleysoftware.com>
References: <1436747943-4059-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1436747943-4059-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.cz>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Robert Elliott <elliott@hp.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

While closing, new rx data may be received after the input buffers
have been flushed but before stop_rx() halts receiving [1]. The
new data might not be processed by flush_to_ldisc() until after
uart_shutdown() and normal input processing is re-enabled (ie.,
tty->closing = 0). The race is outlined below:

CPU 0                         | CPU 1
                              |
uart_close()                  |
   tty_port_close_start()     |
      tty->closing = 1        |
      tty_ldisc_flush()       |
                              | => IRQ
                              |   while (LSR & data ready)
                              |      uart_insert_char()
                              |   tty_flip_buffer_push()
                              | <= EOI
   stop_rx()                  |   .
   uart_shutdown()            |   .
      free xmit.buf           |   .
   tty_port_tty_set(NULL)     |   .
   tty->closing = 0           |   .
                              | flush_to_ldisc()
                              |   n_tty_receive_buf_common()
                              |      __receive_buf()
                              |         ...
                              |         commit_echoes()
                              |            uart_flush_chars()
                              |               __uart_start()
                              | ** OOPS on port.tty deref **
   tty_ldisc_flush()          |

Input processing must be prevented from echoing (tty->closing = 1)
until _after_ the input buffers have been flushed again at the end
of uart_close().

[1] In fact, some input may actually be buffered _after_ stop_rx()
since the rx interrupt may have already triggered but not yet been
handled when stop_rx() disables rx interrupts.

Fixes: 2e758910832d ("serial: core: Flush ldisc after dropping port
mutex in uart_close()")
Reported-by: Robert Elliott <elliott@hp.com>
Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---

v2: Fixed Robert Elliott's email address

 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 7ae1592..f368520 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1418,7 +1418,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	mutex_lock(&port->mutex);
 	uart_shutdown(tty, state);
 	tty_port_tty_set(port, NULL);
-	tty->closing = 0;
+
 	spin_lock_irqsave(&port->lock, flags);
 
 	if (port->blocked_open) {
@@ -1444,6 +1444,7 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 	mutex_unlock(&port->mutex);
 
 	tty_ldisc_flush(tty);
+	tty->closing = 0;
 }
 
 static void uart_wait_until_sent(struct tty_struct *tty, int timeout)
-- 
2.4.5
