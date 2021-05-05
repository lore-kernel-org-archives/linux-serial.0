Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A06C43461
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACDF1613F9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232383AbhEEJUb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41292 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhEEJU1 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 54548B25F;
        Wed,  5 May 2021 09:19:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 04/35] n_tty: drop n_tty_receive_buf_fast
Date:   Wed,  5 May 2021 11:18:57 +0200
Message-Id: <20210505091928.22010-5-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous patches, n_tty_receive_buf_standard and
n_tty_receive_buf_fast differ only in handling of tty line and input
controls. Unlike n_tty_receive_buf_fast, n_tty_receive_buf_standard
handles them all (I_ISTRIP, I_IUCLC, L_IEXTEN, L_EXTPROC, and I_PARMRK).

So remove n_tty_receive_buf_fast and let n_tty_receive_buf_standard do
the handling. Actually most of the tests are only moved from
__receive_buf to n_tty_receive_buf_standard.

Again, the code duplication is not worth the theoretical speedup.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 36 +++---------------------------------
 1 file changed, 3 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 0adc79bae839..5d83fb5412fd 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1530,9 +1530,8 @@ n_tty_receive_buf_closing(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
-static void
-n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
-			  char *fp, int count)
+static void n_tty_receive_buf_standard(struct tty_struct *tty,
+		const unsigned char *cp, char *fp, int count)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 	char flag = TTY_NORMAL;
@@ -1564,32 +1563,6 @@ n_tty_receive_buf_standard(struct tty_struct *tty, const unsigned char *cp,
 	}
 }
 
-static void
-n_tty_receive_buf_fast(struct tty_struct *tty, const unsigned char *cp,
-		       char *fp, int count)
-{
-	struct n_tty_data *ldata = tty->disc_data;
-	char flag = TTY_NORMAL;
-
-	while (count--) {
-		if (fp)
-			flag = *fp++;
-		if (likely(flag == TTY_NORMAL)) {
-			unsigned char c = *cp++;
-
-			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char(tty, c, false);
-			else if (n_tty_receive_char_special(tty, c) && count) {
-				if (fp)
-					flag = *fp++;
-				n_tty_receive_char_lnext(tty, *cp++, flag);
-				count--;
-			}
-		} else
-			n_tty_receive_char_flagged(tty, *cp++, flag);
-	}
-}
-
 static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			  char *fp, int count)
 {
@@ -1612,10 +1585,7 @@ static void __receive_buf(struct tty_struct *tty, const unsigned char *cp,
 			count--;
 		}
 
-		if (!preops && !I_PARMRK(tty))
-			n_tty_receive_buf_fast(tty, cp, fp, count);
-		else
-			n_tty_receive_buf_standard(tty, cp, fp, count);
+		n_tty_receive_buf_standard(tty, cp, fp, count);
 
 		flush_echoes(tty);
 		if (tty->ops->flush_chars)
-- 
2.31.1

