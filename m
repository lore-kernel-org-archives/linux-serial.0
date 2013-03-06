From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/7] n_tty: Untangle read completion variables
Date: Wed,  6 Mar 2013 08:38:23 -0500
Message-ID: <1362577105-19757-6-git-send-email-peter@hurleysoftware.com>
References: <1362577105-19757-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout01.c08.mtsvc.net ([205.186.168.189]:50371 "EHLO
	mailout01.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757939Ab3CFNjC (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Wed, 6 Mar 2013 08:39:02 -0500
In-Reply-To: <1362577105-19757-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>


Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 3fd657b..b2f621f 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1814,20 +1814,16 @@ do_it_again:
 	minimum = time = 0;
 	timeout = MAX_SCHEDULE_TIMEOUT;
 	if (!ldata->icanon) {
-		time = (HZ / 10) * TIME_CHAR(tty);
 		minimum = MIN_CHAR(tty);
 		if (minimum) {
+			time = (HZ / 10) * TIME_CHAR(tty);
 			if (time)
 				ldata->minimum_to_wake = 1;
 			else if (!waitqueue_active(&tty->read_wait) ||
 				 (ldata->minimum_to_wake > minimum))
 				ldata->minimum_to_wake = minimum;
 		} else {
-			timeout = 0;
-			if (time) {
-				timeout = time;
-				time = 0;
-			}
+			timeout = (HZ / 10) * TIME_CHAR(tty);
 			ldata->minimum_to_wake = minimum = 1;
 		}
 	}
-- 
1.8.1.2

