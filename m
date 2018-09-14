From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] serial: cpm_uart: return immediately from console poll
Date: Fri, 14 Sep 2018 10:32:50 +0000 (UTC)
Message-ID: <379467c33068e86235272401edfe60a57f2130bb.1536883882.git.christophe.leroy@c-s.fr>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, stable@vger.kernel.org, Jason Wessel <jason.wessel@windriver.com>
List-Id: linux-serial@vger.kernel.org

kgdb expects poll function to return immediately and
returning NO_POLL_CHAR when no character is available.

Fixes: f5316b4aea024 ("kgdb,8250,pl011: Return immediately from console poll")
Cc: Jason Wessel <jason.wessel@windriver.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 drivers/tty/serial/cpm_uart/cpm_uart_core.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/serial/cpm_uart/cpm_uart_core.c b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
index cd3f3fc4e0a5..280acc4dfa90 100644
--- a/drivers/tty/serial/cpm_uart/cpm_uart_core.c
+++ b/drivers/tty/serial/cpm_uart/cpm_uart_core.c
@@ -1093,8 +1093,8 @@ static int poll_wait_key(char *obuf, struct uart_cpm_port *pinfo)
 	/* Get the address of the host memory buffer.
 	 */
 	bdp = pinfo->rx_cur;
-	while (bdp->cbd_sc & BD_SC_EMPTY)
-		;
+	if (bdp->cbd_sc & BD_SC_EMPTY)
+		return NO_POLL_CHAR;
 
 	/* If the buffer address is in the CPM DPRAM, don't
 	 * convert it.
@@ -1129,7 +1129,11 @@ static int cpm_get_poll_char(struct uart_port *port)
 		poll_chars = 0;
 	}
 	if (poll_chars <= 0) {
-		poll_chars = poll_wait_key(poll_buf, pinfo);
+		int ret = poll_wait_key(poll_buf, pinfo);
+
+		if (ret == NO_POLL_CHAR)
+			return ret;
+		poll_chars = ret;
 		pollp = poll_buf;
 	}
 	poll_chars--;
-- 
2.13.3
