From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 2/4] pps: Don't crash the machine when exiting will do
Date: Wed,  6 Feb 2013 10:55:14 -0500
Message-ID: <1360166116-30797-3-git-send-email-peter@hurleysoftware.com>
References: <20130204010303.24971.qmail@science.horizon.com>
 <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout39.mail01.mtsvc.net ([216.70.64.83]:38034 "EHLO
	n12.mail01.mtsvc.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757330Ab3BFP5B (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Feb 2013 10:57:01 -0500
In-Reply-To: <1360166116-30797-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: George Spelvin <linux@horizon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rodolfo Giometti <giometti@enneenne.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>

PPS is not really the must-have subsystem that warrants crashing
the machine if the ldisc interface is broken.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/pps/clients/pps-ldisc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 27d7ca1..0b91d91 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/tty.h>
 #include <linux/pps_kernel.h>
+#include <linux/bug.h>
 
 #define PPS_TTY_MAGIC		0x0001
 
@@ -35,7 +36,8 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 
 	pps_get_ts(&ts);
 
-	BUG_ON(pps == NULL);
+	if (WARN_ON_ONCE(pps == NULL))
+		return;
 
 	/* Now do the PPS event report */
 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
-- 
1.8.1.2

