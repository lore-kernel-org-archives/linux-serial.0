From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 20/26] serial: core: Use spin_lock_irq() in uart_set_termios()
Date: Tue,  2 Sep 2014 17:39:29 -0400
Message-ID: <1409693975-1028-21-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

uart_set_termios() is called with interrupts enabled; no need to
save and restore the interrupt state when taking the uart port lock.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95277a2..200fa8c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1244,7 +1244,6 @@ static void uart_set_termios(struct tty_struct *tty,
 {
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *uport = state->uart_port;
-	unsigned long flags;
 	unsigned int cflag = tty->termios.c_cflag;
 	unsigned int iflag_mask = IGNBRK|BRKINT|IGNPAR|PARMRK|INPCK;
 	bool sw_changed = false;
@@ -1298,19 +1297,19 @@ static void uart_set_termios(struct tty_struct *tty,
 
 	/* Handle turning off CRTSCTS */
 	if ((old_termios->c_cflag & CRTSCTS) && !(cflag & CRTSCTS)) {
-		spin_lock_irqsave(&uport->lock, flags);
+		spin_lock_irq(&uport->lock);
 		uport->hw_stopped = 0;
 		__uart_start(tty);
-		spin_unlock_irqrestore(&uport->lock, flags);
+		spin_unlock_irq(&uport->lock);
 	}
 	/* Handle turning on CRTSCTS */
 	else if (!(old_termios->c_cflag & CRTSCTS) && (cflag & CRTSCTS)) {
-		spin_lock_irqsave(&uport->lock, flags);
+		spin_lock_irq(&uport->lock);
 		if (!(uport->ops->get_mctrl(uport) & TIOCM_CTS)) {
 			uport->hw_stopped = 1;
 			uport->ops->stop_tx(uport);
 		}
-		spin_unlock_irqrestore(&uport->lock, flags);
+		spin_unlock_irq(&uport->lock);
 	}
 }
 
-- 
2.1.0
