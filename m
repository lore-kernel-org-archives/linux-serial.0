From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 1/8] serial: core: Fold __uart_put_char() into caller
Date: Sun, 10 Jan 2016 20:23:55 -0800
Message-ID: <1452486242-7297-2-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

uart_put_char() is the required interface; manually inline
__uart_put_char().

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3698ada..048b175 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -483,12 +483,15 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 	spin_unlock_irq(&uport->lock);
 }
 
-static inline int __uart_put_char(struct uart_port *port,
-				struct circ_buf *circ, unsigned char c)
+static int uart_put_char(struct tty_struct *tty, unsigned char c)
 {
+	struct uart_state *state = tty->driver_data;
+	struct uart_port *port = state->uart_port;
+	struct circ_buf *circ;
 	unsigned long flags;
 	int ret = 0;
 
+	circ = &state->xmit;
 	if (!circ->buf)
 		return 0;
 
@@ -502,13 +505,6 @@ static inline int __uart_put_char(struct uart_port *port,
 	return ret;
 }
 
-static int uart_put_char(struct tty_struct *tty, unsigned char ch)
-{
-	struct uart_state *state = tty->driver_data;
-
-	return __uart_put_char(state->uart_port, &state->xmit, ch);
-}
-
 static void uart_flush_chars(struct tty_struct *tty)
 {
 	uart_start(tty);
-- 
2.7.0
