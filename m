From: Shubhrajyoti D <shubhrajyoti@ti.com>
Subject: [PATCH 5/5] OMAP : serial : Check for error in get_context_loss_count
Date: Mon, 16 Jan 2012 15:52:40 +0530
Message-ID: <1326709360-26020-6-git-send-email-shubhrajyoti@ti.com>
References: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:54564 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754029Ab2APKW7 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Mon, 16 Jan 2012 05:22:59 -0500
In-Reply-To: <1326709360-26020-1-git-send-email-shubhrajyoti@ti.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Shubhrajyoti D <shubhrajyoti@ti.com>

In serial_omap_runtime_resume in case of errors returned by
get_context_loss_count print a warning and do a restore.

Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
---
 drivers/tty/serial/omap-serial.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
index 8c6f137..e1c1a0f 100644
--- a/drivers/tty/serial/omap-serial.c
+++ b/drivers/tty/serial/omap-serial.c
@@ -1602,10 +1602,16 @@ static int serial_omap_runtime_resume(struct device *dev)
 
 	if (up) {
 		if (pdata->get_context_loss_count) {
-			u32 loss_cnt = pdata->get_context_loss_count(dev);
+			int loss_cnt = pdata->get_context_loss_count(dev);
 
-			if (up->context_loss_cnt != loss_cnt)
+			if (loss_cnt < 0) {
+				dev_err(dev,
+					"get_context_loss_count failed : %d\n",
+					loss_cnt);
 				serial_omap_restore_context(up);
+			} else if (up->context_loss_cnt != loss_cnt) {
+				serial_omap_restore_context(up);
+			}
 		}
 
 		/* Errata i291 */
-- 
1.7.1

