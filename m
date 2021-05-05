Return-Path: <linux-serial-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B647BC43462
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D724613E9
	for <linux-serial@archiver.kernel.org>; Wed,  5 May 2021 09:19:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbhEEJUb (ORCPT <rfc822;linux-serial@archiver.kernel.org>);
        Wed, 5 May 2021 05:20:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:41350 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232335AbhEEJU2 (ORCPT <rfc822;linux-serial@vger.kernel.org>);
        Wed, 5 May 2021 05:20:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 81D03B260;
        Wed,  5 May 2021 09:19:30 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 05/35] n_tty: drop parmrk_dbl from n_tty_receive_char
Date:   Wed,  5 May 2021 11:18:58 +0200
Message-Id: <20210505091928.22010-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210505091928.22010-1-jslaby@suse.cz>
References: <20210505091928.22010-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-serial.vger.kernel.org>
X-Mailing-List: linux-serial@vger.kernel.org

After the previous cleanup patches, parmrk_dbl parameter is always true
-- I_PARMRK is checked only in n_tty_receive_char now. So remove
parmrk_dbl completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 drivers/tty/n_tty.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
index 5d83fb5412fd..f0db3f41df83 100644
--- a/drivers/tty/n_tty.c
+++ b/drivers/tty/n_tty.c
@@ -1400,8 +1400,7 @@ n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
 	return 0;
 }
 
-static void n_tty_receive_char(struct tty_struct *tty, unsigned char c,
-		bool parmrk_dbl)
+static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
 {
 	struct n_tty_data *ldata = tty->disc_data;
 
@@ -1418,7 +1417,7 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c,
 		commit_echoes(tty);
 	}
 	/* PARMRK doubling check */
-	if (parmrk_dbl && c == (unsigned char) '\377' && I_PARMRK(tty))
+	if (c == (unsigned char) '\377' && I_PARMRK(tty))
 		put_tty_queue(c, ldata);
 	put_tty_queue(c, ldata);
 }
@@ -1474,7 +1473,7 @@ n_tty_receive_char_lnext(struct tty_struct *tty, unsigned char c, char flag)
 			c &= 0x7f;
 		if (I_IUCLC(tty) && L_IEXTEN(tty))
 			c = tolower(c);
-		n_tty_receive_char(tty, c, true);
+		n_tty_receive_char(tty, c);
 	} else
 		n_tty_receive_char_flagged(tty, c, flag);
 }
@@ -1551,7 +1550,7 @@ static void n_tty_receive_buf_standard(struct tty_struct *tty,
 				continue;
 			}
 			if (!test_bit(c, ldata->char_map))
-				n_tty_receive_char(tty, c, true);
+				n_tty_receive_char(tty, c);
 			else if (n_tty_receive_char_special(tty, c) && count) {
 				if (fp)
 					flag = *fp++;
-- 
2.31.1

