From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH tty-next 21/22] serial: core: Remove superfluous ldisc flush from uart_close()
Date: Mon, 16 Jun 2014 09:17:18 -0400
Message-ID: <1402924639-5164-22-git-send-email-peter@hurleysoftware.com>
References: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1402924639-5164-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

The tty_ldisc_flush() after port hardware shutdown is unnecessary;
the ldisc flush was just performed before the hardware shutdown
in tty_port_close_start() and the ldisc will be released when
uart_close() returns (because the last port close implies the
last tty close).

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 212ee07..15212d7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1351,9 +1351,6 @@ static void uart_close(struct tty_struct *tty, struct file *filp)
 
 	mutex_lock(&port->mutex);
 	uart_shutdown(tty, state);
-
-	tty_ldisc_flush(tty);
-
 	tty_port_tty_set(port, NULL);
 	tty->closing = 0;
 	spin_lock_irqsave(&port->lock, flags);
-- 
2.0.0
