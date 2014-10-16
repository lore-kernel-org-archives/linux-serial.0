From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH -next 09/10] serial: core: Remove extra locking in uart_write()
Date: Thu, 16 Oct 2014 16:54:26 -0400
Message-ID: <1413492867-20679-10-git-send-email-peter@hurleysoftware.com>
References: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1413492867-20679-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

uart_start() only claims the port->lock to call __uart_start(),
which does the actual processing. Eliminate the extra acquire/release
in uart_write(); call __uart_start() directly with port->lock already
held.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index e04ae58..6a3571e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -537,9 +537,10 @@ static int uart_write(struct tty_struct *tty,
 		count -= c;
 		ret += c;
 	}
+
+	__uart_start(tty);
 	spin_unlock_irqrestore(&port->lock, flags);
 
-	uart_start(tty);
 	return ret;
 }
 
-- 
2.1.1
