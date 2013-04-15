From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v3 24/24] n_tty: Queue buffer work on any available cpu
Date: Mon, 15 Apr 2013 11:19:28 -0400
Message-ID: <1366039168-8510-25-git-send-email-peter@hurleysoftware.com>
References: <1363724513-15604-1-git-send-email-peter@hurleysoftware.com>
 <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from mailout02.c08.mtsvc.net ([205.186.168.190]:45887 "EHLO
	mailout02.c08.mtsvc.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932848Ab3DOPcp (ORCPT
	<rfc822;linux-serial@vger.kernel.org>);
	Mon, 15 Apr 2013 11:32:45 -0400
In-Reply-To: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>

Scheduling buffer work on the same cpu as the read() thread
limits the parallelism now possible between the receive_buf path
and the n_tty_read() path.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5211de2..4dbb558 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -198,7 +198,7 @@ static void n_tty_set_room(struct tty_struct *tty)
 		 */
 		WARN_RATELIMIT(test_bit(TTY_LDISC_HALTED, &tty->flags),
 			       "scheduling buffer work for halted ldisc\n");
-		schedule_work(&tty->port->buf.work);
+		queue_work(system_unbound_wq, &tty->port->buf.work);
 	}
 }
 
-- 
1.8.1.2

