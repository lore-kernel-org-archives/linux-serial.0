From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 12/26] serial: core: Unwrap tertiary assignment in uart_handle_dcd_change()
Date: Tue,  2 Sep 2014 17:39:21 -0400
Message-ID: <1409693975-1028-13-git-send-email-peter@hurleysoftware.com>
References: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1409693975-1028-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Prepare for spin lock assertion; move non-trivial assignment into
function body.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/serial/serial_core.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 11c8fe6..732d386 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2736,12 +2736,15 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 {
 	struct tty_port *port = &uport->state->port;
 	struct tty_struct *tty = port->tty;
-	struct tty_ldisc *ld = tty ? tty_ldisc_ref(tty) : NULL;
+	struct tty_ldisc *ld;
 
-	if (ld) {
-		if (ld->ops->dcd_change)
-			ld->ops->dcd_change(tty, status);
-		tty_ldisc_deref(ld);
+	if (tty) {
+		ld = tty_ldisc_ref(tty);
+		if (ld) {
+			if (ld->ops->dcd_change)
+				ld->ops->dcd_change(tty, status);
+			tty_ldisc_deref(ld);
+		}
 	}
 
 	uport->icount.dcd++;
-- 
2.1.0
