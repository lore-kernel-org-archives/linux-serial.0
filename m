From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v2 8/8] serial: core: Perform RTS signalling before soft flow ctrl
Date: Sun, 10 Jan 2016 20:24:02 -0800
Message-ID: <1452486242-7297-9-git-send-email-peter@hurleysoftware.com>
References: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452486242-7297-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

When throttling, time is of the essence; try RTS signalling before
soft flow control, which will take longer.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 3031982..0baa231 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -641,11 +641,11 @@ static void uart_throttle(struct tty_struct *tty)
 		mask &= ~port->status;
 	}
 
-	if (mask & UPSTAT_AUTOXOFF)
-		uart_send_xchar(tty, STOP_CHAR(tty));
-
 	if (mask & UPSTAT_AUTORTS)
 		uart_clear_mctrl(port, TIOCM_RTS);
+
+	if (mask & UPSTAT_AUTOXOFF)
+		uart_send_xchar(tty, STOP_CHAR(tty));
 }
 
 static void uart_unthrottle(struct tty_struct *tty)
@@ -664,11 +664,11 @@ static void uart_unthrottle(struct tty_struct *tty)
 		mask &= ~port->status;
 	}
 
-	if (mask & UPSTAT_AUTOXOFF)
-		uart_send_xchar(tty, START_CHAR(tty));
-
 	if (mask & UPSTAT_AUTORTS)
 		uart_set_mctrl(port, TIOCM_RTS);
+
+	if (mask & UPSTAT_AUTOXOFF)
+		uart_send_xchar(tty, START_CHAR(tty));
 }
 
 static void uart_get_info(struct tty_port *port, struct serial_struct *retinfo)
-- 
2.7.0
