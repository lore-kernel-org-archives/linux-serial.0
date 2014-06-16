From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 12/22] tty: serial: Fix termios/port flags mismatch
Date: Mon, 16 Jun 2014 09:17:09 -0400
Message-ID: <1402924639-5164-13-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Uart port drivers may reconfigure termios settings based on available
hardware support; set/clear ASYNC_CTS_FLOW and ASYNC_CHECK_CD _after_
calling the port driver's .set_termios method.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c8879ce..f64cf45 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -443,6 +443,7 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 		return;
 
 	termios = &tty->termios;
+	uport->ops->set_termios(uport, termios, old_termios);
 
 	/*
 	 * Set flags based on termios cflag
@@ -456,8 +457,6 @@ static void uart_change_speed(struct tty_struct *tty, struct uart_state *state,
 		clear_bit(ASYNCB_CHECK_CD, &port->flags);
 	else
 		set_bit(ASYNCB_CHECK_CD, &port->flags);
-
-	uport->ops->set_termios(uport, termios, old_termios);
 }
 
 static inline int __uart_put_char(struct uart_port *port,
@@ -1270,6 +1269,8 @@ static void uart_set_termios(struct tty_struct *tty,
 	}
 
 	uart_change_speed(tty, state, old_termios);
+	/* reload cflag from termios; port driver may have overriden flags */
+	cflag = tty->termios.c_cflag;
 
 	/* Handle transition to B0 status */
 	if ((old_termios->c_cflag & CBAUD) && !(cflag & CBAUD))
-- 
2.0.0
