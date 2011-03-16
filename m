From: Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 71/76] tty_audit: fix tty_audit_add_data live lock on audit disabled
Date: Wed, 16 Mar 2011 14:12:41 -0700
Message-ID: <1300309966-5745-71-git-send-email-gregkh@suse.de>
References: <20110316205746.GA2938@kroah.com>
 <1300309966-5745-1-git-send-email-gregkh@suse.de>
Return-path: <linux-serial-owner@vger.kernel.org>
Received: from kroah.org ([198.145.64.141]:32946 "EHLO coco.kroah.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755011Ab1CPVPi (ORCPT <rfc822;linux-serial@vger.kernel.org>);
	Wed, 16 Mar 2011 17:15:38 -0400
In-Reply-To: <1300309966-5745-1-git-send-email-gregkh@suse.de>
Sender: linux-serial-owner@vger.kernel.org
List-Id: linux-serial@vger.kernel.org
To: linux-serial@vger.kernel.org
Cc: Xiaotian Feng <dfeng@redhat.com>, Greg Kroah-Hartman <gregkh@suse.de>

From: Xiaotian Feng <dfeng@redhat.com>

The current tty_audit_add_data code:

        do {
                size_t run;

                run = N_TTY_BUF_SIZE - buf->valid;
                if (run > size)
                        run = size;
                memcpy(buf->data + buf->valid, data, run);
                buf->valid += run;
                data += run;
                size -= run;
                if (buf->valid == N_TTY_BUF_SIZE)
                        tty_audit_buf_push_current(buf);
        } while (size != 0);

If the current buffer is full, kernel will then call tty_audit_buf_push_current
to empty the buffer. But if we disabled audit at the same time, tty_audit_buf_push()
returns immediately if audit_enabled is zero.  Without emptying the buffer.
With obvious effect on tty_audit_add_data() that ends up spinning in that loop,
copying 0 bytes at each iteration and attempting to push each time without any effect.
Holding the lock all along.

Suggested-by: Alexander Viro <aviro@redhat.com>
Signed-off-by: Xiaotian Feng <dfeng@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/tty/tty_audit.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/tty_audit.c b/drivers/tty/tty_audit.c
index f64582b..7c58669 100644
--- a/drivers/tty/tty_audit.c
+++ b/drivers/tty/tty_audit.c
@@ -95,8 +95,10 @@ static void tty_audit_buf_push(struct task_struct *tsk, uid_t loginuid,
 {
 	if (buf->valid == 0)
 		return;
-	if (audit_enabled == 0)
+	if (audit_enabled == 0) {
+		buf->valid = 0;
 		return;
+	}
 	tty_audit_log("tty", tsk, loginuid, sessionid, buf->major, buf->minor,
 		      buf->data, buf->valid);
 	buf->valid = 0;
-- 
1.7.4.1

