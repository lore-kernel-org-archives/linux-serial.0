From: Peter Hurley <peter@hurleysoftware.com>
Subject: [PATCH v4 24/24] n_tty: Queue buffer work on any available cpu
Date: Sat, 15 Jun 2013 09:14:36 -0400
Message-ID: <1371302076-4688-25-git-send-email-peter@hurleysoftware.com>
References: <1366039168-8510-1-git-send-email-peter@hurleysoftware.com>
 <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1371302076-4688-1-git-send-email-peter@hurleysoftware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>, Peter Hurley <peter@hurleysoftware.com>
List-Id: linux-serial@vger.kernel.org

Scheduling buffer work on the same cpu as the read() thread
limits the parallelism now possible between the receive_buf path
and the n_tty_read() path.

Signed-off-by: Peter Hurley <peter@hurleysoftware.com>
---
 drivers/tty/n_tty.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 072e52f..2321d6a 100644
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
