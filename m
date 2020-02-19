Return-Path: <SRS0=V5ud=4H=vger.kernel.org=linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F43DC34022
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1435208E4
	for <linux-serial@archiver.kernel.org>; Wed, 19 Feb 2020 08:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgBSIlY (ORCPT
        <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 19 Feb 2020 03:41:24 -0500
Received: from mx2.suse.de ([195.135.220.15]:44300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726672AbgBSIlX (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 19 Feb 2020 03:41:23 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9590AAF33;
        Wed, 19 Feb 2020 08:41:21 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 08/24] n_hdlc: invert conditions in n_hdlc_tty_close and n_hdlc_tty_poll
Date:   Wed, 19 Feb 2020 09:41:02 +0100
Message-Id: <20200219084118.26491-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200219084118.26491-1-jslaby@suse.cz>
References: <20200219084118.26491-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-serial-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

This makes the functions return immediatelly on invalid state. And we
can push the indent of the later code one level left.

Pass "-w" to "git show" to see we are changing only the conditions (and
whitespace).

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_hdlc.c | 72 +++++++++++++++++++++++---------------------
 1 file changed, 38 insertions(+), 34 deletions(-)

diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
index 07ba42badd7a..e40561caa450 100644
--- a/drivers/tty/n_hdlc.c
+++ b/drivers/tty/n_hdlc.c
@@ -258,24 +258,25 @@ static void n_hdlc_tty_close(struct tty_struct *tty)
 {
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 
-	if (n_hdlc != NULL) {
-		if (n_hdlc->magic != HDLC_MAGIC) {
-			printk (KERN_WARNING"n_hdlc: trying to close unopened tty!\n");
-			return;
-		}
+	if (!n_hdlc)
+		return;
+
+	if (n_hdlc->magic != HDLC_MAGIC) {
+		printk(KERN_WARNING "n_hdlc: trying to close unopened tty!\n");
+		return;
+	}
 #if defined(TTY_NO_WRITE_SPLIT)
-		clear_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
+	clear_bit(TTY_NO_WRITE_SPLIT,&tty->flags);
 #endif
-		tty->disc_data = NULL;
-		if (tty == n_hdlc->backup_tty)
-			n_hdlc->backup_tty = NULL;
-		if (tty != n_hdlc->tty)
-			return;
-		if (n_hdlc->backup_tty) {
-			n_hdlc->tty = n_hdlc->backup_tty;
-		} else {
-			n_hdlc_release (n_hdlc);
-		}
+	tty->disc_data = NULL;
+	if (tty == n_hdlc->backup_tty)
+		n_hdlc->backup_tty = NULL;
+	if (tty != n_hdlc->tty)
+		return;
+	if (n_hdlc->backup_tty) {
+		n_hdlc->tty = n_hdlc->backup_tty;
+	} else {
+		n_hdlc_release (n_hdlc);
 	}
 }	/* end of n_hdlc_tty_close() */
 
@@ -737,24 +738,27 @@ static __poll_t n_hdlc_tty_poll(struct tty_struct *tty, struct file *filp,
 	struct n_hdlc *n_hdlc = tty2n_hdlc (tty);
 	__poll_t mask = 0;
 
-	if (n_hdlc && n_hdlc->magic == HDLC_MAGIC && tty == n_hdlc->tty) {
-		/* queue current process into any wait queue that */
-		/* may awaken in the future (read and write) */
-
-		poll_wait(filp, &tty->read_wait, wait);
-		poll_wait(filp, &tty->write_wait, wait);
-
-		/* set bits for operations that won't block */
-		if (!list_empty(&n_hdlc->rx_buf_list.list))
-			mask |= EPOLLIN | EPOLLRDNORM;	/* readable */
-		if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
-			mask |= EPOLLHUP;
-		if (tty_hung_up_p(filp))
-			mask |= EPOLLHUP;
-		if (!tty_is_writelocked(tty) &&
-				!list_empty(&n_hdlc->tx_free_buf_list.list))
-			mask |= EPOLLOUT | EPOLLWRNORM;	/* writable */
-	}
+	if (!n_hdlc || n_hdlc->magic != HDLC_MAGIC || tty != n_hdlc->tty)
+		return 0;
+
+	/*
+	 * queue the current process into any wait queue that may awaken in the
+	 * future (read and write)
+	 */
+	poll_wait(filp, &tty->read_wait, wait);
+	poll_wait(filp, &tty->write_wait, wait);
+
+	/* set bits for operations that won't block */
+	if (!list_empty(&n_hdlc->rx_buf_list.list))
+		mask |= EPOLLIN | EPOLLRDNORM;	/* readable */
+	if (test_bit(TTY_OTHER_CLOSED, &tty->flags))
+		mask |= EPOLLHUP;
+	if (tty_hung_up_p(filp))
+		mask |= EPOLLHUP;
+	if (!tty_is_writelocked(tty) &&
+			!list_empty(&n_hdlc->tx_free_buf_list.list))
+		mask |= EPOLLOUT | EPOLLWRNORM;	/* writable */
+
 	return mask;
 }	/* end of n_hdlc_tty_poll() */
 
-- 
2.25.0

