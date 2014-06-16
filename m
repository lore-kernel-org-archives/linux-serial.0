From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 19/22] serial: Style fix
Date: Mon, 16 Jun 2014 09:17:16 -0400
Message-ID: <1402924639-5164-20-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Unwrap if() conditional; no functional change.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e97653e..f13a769 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1278,8 +1278,7 @@ static void uart_set_termios(struct tty_struct *tty,
 	/* Handle transition away from B0 status */
 	else if (!(old_termios->c_cflag & CBAUD) && (cflag & CBAUD)) {
 		unsigned int mask = TIOCM_DTR;
-		if (!(cflag & CRTSCTS) ||
-		    !test_bit(TTY_THROTTLED, &tty->flags))
+		if (!(cflag & CRTSCTS) || !test_bit(TTY_THROTTLED, &tty->flags))
 			mask |= TIOCM_RTS;
 		uart_set_mctrl(uport, mask);
 	}
-- 
2.0.0
