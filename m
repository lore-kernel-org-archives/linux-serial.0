Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A973CC433ED
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71B2D613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232373AbhEEJUa (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:41280 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232269AbhEEJU1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 279F8B25B;
        Wed,  5 May 2021 09:19:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 03/35] n_tty: remove n_tty_receive_char_fast
Date:   Wed,  5 May 2021 11:18:56 +0200
Message-Id: <20210505091928.22010-4-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

n_tty_receive_char_fast is a copy of n_tty_receive_char with one
exception: PARMRK is not doubled in the former. Unify these two and
double PARMRK depending on a newly added parameter (bool parmrk_dbl).

I don't think the theoretical speedup is worth the code duplication.
Which is directly connected with maintenance burden.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 32 ++++++--------------------------
 1 file changed, 6 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0a8c9440f5d2..0adc79bae839 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1400,8 +1400,8 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 	return 0;
 }
 
-static inline void
-n_tty_receive_char(struct tty_struct *tty, unsigned char c)
+static void n_tty_receive_char(struct tty_struct *tty, unsigned char c,
+		bool parmrk_dbl)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1418,31 +1418,11 @@ n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 		commit_echoes(tty);
 	}
 	/* PARMRK doubling check */
-	if (c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (parmrk_dbl && c == (unsigned char) '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
 
-static inline void
-n_tty_receive_char_fast(struct tty_struct *tty, unsigned char c)
-{
-	struct n_tty_data *ldata = tty->disc_data;
-
-	if (tty->stopped && !tty->flow_stopped && I_IXON(tty) && I_IXANY(tty)) {
-		start_tty(tty);
-		process_echoes(tty);
-	}
-	if (L_ECHO(tty)) {
-		finish_erasing(ldata);
-		/* Record the column of first canon char. */
-		if (ldata->canon_head == ldata->read_head)
-			echo_set_canon_col(ldata);
-		echo_char(c, tty);
-		commit_echoes(tty);
-	}
-	put_tty_queue(c, ldata);
-}
-
 static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
 {
 	if (I_ISTRIP(tty))
@@ -1494,7 +1474,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 			c &= 0x7f;
 		if (I_IUCLC(tty) && L_IEXTEN(tty))
 			c = tolower(c);
-		n_tty_receive_char(tty, c);
+		n_tty_receive_char(tty, c, true);
 	} else
 		n_tty_receive_char_flagged(tty, c, flag);
 }
@@ -1572,7 +1552,7 @@ n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
 				continue;
 			}
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char(tty, c);
+				n_tty_receive_char(tty, c, true);
 			else if (n_tty_receive_char_special(tty, c) && count) {
 				if (fp)
 					flag = *fp++;
@@ -1598,7 +1578,7 @@ n_tty_receive_buf_fast(struct tty_struct *tty, const unsigned char *cp,
 			unsigned char c = *cp++;
 
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char_fast(tty, c);
+				n_tty_receive_char(tty, c, false);
 			else if (n_tty_receive_char_special(tty, c) && count) {
 				if (fp)
 					flag = *fp++;
-- 
2.31.1

