From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4/4] tty: Remove ancient hardpps()
Date: Wed,  6 Feb 2013 10:55:16 -0500
Message-ID: <1360166116-30797-5-git-send-email-peter@hurleysoftware.com>
References: <20130204010303.24971.qmail@science.horizon.com>
 <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:42219 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757517Ab3BFP5F (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 10:57:05 -0500
In-Reply-To: <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: George Spelvin <linux@horizon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rodolfo Giometti <giometti@enneenne.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

hardpps() functionality is provided through the N_PPS line
discipline now. The new function signature was added in commit
025b40ab (2011-01-12). There was no previous macro or
function hardpps(), at least since before the initial commit of
v2.6.12 in 2005. It's unlikely this code has been compiled since.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/amiserial.c          | 5 -----
 drivers/tty/serial/serial_core.c | 5 -----
 2 files changed, 10 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 4c7d701..fc70034 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -393,11 +393,6 @@ static void check_modem_status(struct serial_state *info)
 			icount->dsr++;
 		if (dstatus & SER_DCD) {
 			icount->dcd++;
-#ifdef CONFIG_HARD_PPS
-			if ((port->flags & ASYNC_HARDPPS_CD) &&
-			    !(status & SER_DCD))
-				hardpps();
-#endif
 		}
 		if (dstatus & SER_CTS)
 			icount->cts++;
diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 457f1a6..b96b1f7 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2730,11 +2730,6 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 
 	uport->icount.dcd++;
 
-#ifdef CONFIG_HARD_PPS
-	if ((uport->flags & UPF_HARDPPS_CD) && status)
-		hardpps();
-#endif
-
 	if (tty) {
 		ld = tty_ldisc_ref(tty);
 		if (ld && ld->ops->dcd_change)
-- 
1.8.1.2

