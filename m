From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 05/26] serial: core: Remove unsafe x_char optimization
Date: Tue,  2 Sep 2014 17:39:14 -0400
Message-ID: <1409693975-1028-6-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

uart_unthrottle() attempts to avoid sending START and the previous
x_char if the previous x_char has not yet been sent. However, this
optimization could leave the sender in a throttled state; for example,
if the sender is throttled and this unthrottle coincides with a manual
tcflow(TCION) from user-space, then neither START would be sent.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a68bff0..11c8fe6 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -643,12 +643,8 @@ static void uart_unthrottle(struct tty_struct *tty)
 		mask &= ~port->flags;
 	}
 
-	if (mask & UPF_SOFT_FLOW) {
-		if (port->x_char)
-			port->x_char = 0;
-		else
-			uart_send_xchar(tty, START_CHAR(tty));
-	}
+	if (mask & UPF_SOFT_FLOW)
+		uart_send_xchar(tty, START_CHAR(tty));
 
 	if (mask & UPF_HARD_FLOW)
 		uart_set_mctrl(port, TIOCM_RTS);
-- 
2.1.0
