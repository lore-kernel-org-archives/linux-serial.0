Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 211D8C433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E488361417
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhEEJUc (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:41380 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232336AbhEEJU2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D9F36B26A;
        Wed,  5 May 2021 09:19:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 07/35] n_tty: make n_tty_receive_char_special return void
Date:   Wed,  5 May 2021 11:19:00 +0200
Message-Id: <20210505091928.22010-8-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous patch, noone cares about the return value of
n_tty_receive_char_special. ldata->lnext is checked instead.

So switch return type of n_tty_receive_char_special to void.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 27 +++++++++++----------------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index d40844b7a4fb..b8f981499465 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1260,12 +1260,8 @@ n_tty_receive_signal_char(struct tty_struct *tty, int signal, unsigned char c)
  *	n_tty_receive_buf()/producer path:
  *		caller holds non-exclusive termios_rwsem
  *		publishes canon_head if canonical mode is active
- *
- *	Returns 1 if LNEXT was received, else returns 0
  */
-
-static int
-n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1273,24 +1269,24 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		if (c == START_CHAR(tty)) {
 			start_tty(tty);
 			process_echoes(tty);
-			return 0;
+			return;
 		}
 		if (c == STOP_CHAR(tty)) {
 			stop_tty(tty);
-			return 0;
+			return;
 		}
 	}
 
 	if (L_ISIG(tty)) {
 		if (c == INTR_CHAR(tty)) {
 			n_tty_receive_signal_char(tty, SIGINT, c);
-			return 0;
+			return;
 		} else if (c == QUIT_CHAR(tty)) {
 			n_tty_receive_signal_char(tty, SIGQUIT, c);
-			return 0;
+			return;
 		} else if (c == SUSP_CHAR(tty)) {
 			n_tty_receive_signal_char(tty, SIGTSTP, c);
-			return 0;
+			return;
 		}
 	}
 
@@ -1301,7 +1297,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 
 	if (c == '\r') {
 		if (I_IGNCR(tty))
-			return 0;
+			return;
 		if (I_ICRNL(tty))
 			c = '\n';
 	} else if (c == '\n' && I_INLCR(tty))
@@ -1312,7 +1308,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		    (c == WERASE_CHAR(tty) && L_IEXTEN(tty))) {
 			eraser(c, tty);
 			commit_echoes(tty);
-			return 0;
+			return;
 		}
 		if (c == LNEXT_CHAR(tty) && L_IEXTEN(tty)) {
 			ldata->lnext = 1;
@@ -1324,7 +1320,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 					commit_echoes(tty);
 				}
 			}
-			return 1;
+			return;
 		}
 		if (c == REPRINT_CHAR(tty) && L_ECHO(tty) && L_IEXTEN(tty)) {
 			size_t tail = ldata->canon_head;
@@ -1337,7 +1333,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 				tail++;
 			}
 			commit_echoes(tty);
-			return 0;
+			return;
 		}
 		if (c == '\n') {
 			if (L_ECHO(tty) || L_ECHONL(tty)) {
@@ -1375,7 +1371,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 			smp_store_release(&ldata->canon_head, ldata->read_head);
 			kill_fasync(&tty->fasync, SIGIO, POLL_IN);
 			wake_up_interruptible_poll(&tty->read_wait, EPOLLIN);
-			return 0;
+			return;
 		}
 	}
 
@@ -1397,7 +1393,6 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 		put_tty_queue(c, ldata);
 
 	put_tty_queue(c, ldata);
-	return 0;
 }
 
 static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
-- 
2.31.1

