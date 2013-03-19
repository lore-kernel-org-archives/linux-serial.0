From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH 5/7] n_tty: Untangle read completion variables
Date: Tue, 19 Mar 2013 10:26:56 -0400
Message-ID: <1363703218-32333-2-git-send-email-peter@hurleysoftware.com>
References: <20130319141017.GB24900@kroah.com>
 <1363703218-32333-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363703218-32333-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jiri Slaby <jslaby@suse.cz>, linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org


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
