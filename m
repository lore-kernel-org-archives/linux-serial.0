From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 3/7] pps: Don't crash the machine when exiting will do
Date: Wed, 6 Feb 2013 10:55:14 -0500
Message-ID: <f5ba7e8bb23bc25b94b267c08aed911be4f47b4c.1360307140.git.linux@horizon.com>
References: <cover.1360307140.git.linux@horizon.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from science.horizon.com ([71.41.210.146]:36261 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1946102Ab3BHJQh (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Fri, 8 Feb 2013 04:16:37 -0500
In-Reply-To: <cover.1360307140.git.linux@horizon.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org, peter@hurleysoftware.com
Cc: linux@horizon.com, linux-kernel@vger.kernel.org, giometti@linux.it

PPS is not really the must-have subsystem that warrants crashing
the machine if the ldisc interface is broken.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
Signed-off-by: George Spelvin <linux@horizon.com>
---
 drivers/pps/clients/pps-ldisc.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/pps/clients/pps-ldisc.c b/drivers/pps/clients/pps-ldisc.c
index 27d7ca1..e5a702a 100644
--- a/drivers/pps/clients/pps-ldisc.c
+++ b/drivers/pps/clients/pps-ldisc.c
@@ -25,6 +25,7 @@
 #include <linux/serial_core.h>
 #include <linux/tty.h>
 #include <linux/pps_kernel.h>
+#include <linux/bug.h>
 
 #define PPS_TTY_MAGIC		0x0001
 
@@ -35,7 +36,12 @@ static void pps_tty_dcd_change(struct tty_struct *tty, unsigned int status)
 
 	pps_get_ts(&ts);
 
-	BUG_ON(pps == NULL);
+	/*
+	 * This should never fail, but the ldisc locking is very
+	 * convoluted, so don't crash just in case.
+	 */
+	if (WARN_ON_ONCE(pps == NULL))
+		return;
 
 	/* Now do the PPS event report */
 	pps_event(pps, &ts, status ? PPS_CAPTUREASSERT :
-- 
1.8.1.2

