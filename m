From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 4/7] tty: Remove ancient hardpps()
Date: Wed, 6 Feb 2013 10:55:16 -0500
Message-ID: <2aba49d2906f76130c836b97d7e965bbecba2192.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36260 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946101Ab3BHJQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:37 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

hardpps() functionality is provided through the N_PPS line
discipline now. The new function signature was added in commit
025b40ab (2011-01-12). There was no previous macro or
function hardpps(), at least since before the initial commit of
v2.6.12 in 2005. It's unlikely this code has been compiled since.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/tty/amiserial.c          | 5 -----
 drivers/tty/serial/serial_core.c | 4 ----
 2 files changed, 9 deletions(-)

diff --git a/drivers/tty/amiserial.c b/drivers/tty/amiserial.c
index 9d7d00c..ba2e09e 100644
--- a/drivers/tty/amiserial.c
+++ b/drivers/tty/amiserial.c
@@ -394,11 +394,6 @@ static void check_modem_status(struct serial_state *info)
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
index b3a204b..02be179 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -2726,10 +2726,6 @@ void uart_handle_dcd_change(struct uart_port *uport, unsigned int status)
 	}
 
 	uport->icount.dcd++;
-#ifdef CONFIG_HARD_PPS
-	if ((uport->flags & UPF_HARDPPS_CD) && status)
-		hardpps();
-#endif
 
 	if (port->flags & ASYNC_CHECK_CD) {
 		if (status)
-- 
1.8.1.2

