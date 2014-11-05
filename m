From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 2/5] serial: core: Claim port mutex for set_ldisc()
Date: Wed,  5 Nov 2014 13:11:42 -0500
Message-ID: <1415211105-16668-3-git-send-email-peter@hurleysoftware.com>
References: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1415211105-16668-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Nicolas Ferre <nicolas.ferre@atmel.com>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Three UART drivers (8250, atmel & amba-pl010) enable modem status
interrupts if the line discipline is changed to N_PPS. However,
the uart port flags may only be safely modified while holding the
port mutex.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 1a2d90f..5209eaa 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1245,8 +1245,11 @@ static void uart_set_ldisc(struct tty_struct *tty)
 	struct uart_state *state = tty->driver_data;
 	struct uart_port *uport = state->uart_port;
 
-	if (uport->ops->set_ldisc)
+	if (uport->ops->set_ldisc) {
+		mutex_lock(&state->port.mutex);
 		uport->ops->set_ldisc(uport, tty->termios.c_line);
+		mutex_unlock(&state->port.mutex);
+	}
 }
 
 static void uart_set_termios(struct tty_struct *tty,
-- 
2.1.3
